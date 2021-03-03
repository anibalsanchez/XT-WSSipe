<?php

/*
 * @package     XT Content Notify for K2
 *
 * @author      Extly, CB. <team@extly.com>
 * @copyright   Copyright (c)2012-2020 Extly, CB. All rights reserved.
 * @license     http://www.gnu.org/licenses/gpl-3.0.html  GNU/GPLv3
 *
 * @see         https://www.extly.com
 *
 * - Based on "Notify of K2 submission" Plugin by Joomkit Ltd for K2
 * - https://github.com/joomkit/joomlaK2notify
 *
 */

defined('_JEXEC') or die;

use Joomla\CMS\Http\HttpFactory as JHttpFactory;
use Joomla\CMS\Plugin\CMSPlugin;
use Joomla\Registry\Registry;
use RuntimeException;

/**
 * AjaxXtWsSipe plugin.
 *
 * @since    1.0
 */
class PlgAjaxXtWsSipe extends CMSPlugin
{
    const PLUGIN_NAME = 'xtwssipe';

    /**
     * Application object.
     *
     * @var CMSApplication
     *
     * @since  1.0
     */
    protected $app;

    /**
     * Database object.
     *
     * @var JDatabaseDriver
     *
     * @since  1.0
     */
    protected $db;

    /**
     * Affects constructor behavior. If true, language files will be loaded automatically.
     *
     * @var bool
     *
     * @since  1.0
     */
    protected $autoloadLanguage = true;

    public function __construct(&$subject, $config = [])
    {
        parent::__construct($subject, $config);

        $this->loggingOk = (bool) $this->params->get('logging_ok');
        $this->loggingError = (bool) $this->params->get('logging_error');
    }

    public function onAjaxXtWsSipe()
    {
        $this->username = $this->params->get('username');
        $this->password = $this->params->get('password');
        $this->certificate = $this->params->get('certificate');

        if (!$this->validApiCredentials()) {
            $this->logError('Invalid Api Credentials');

            return $this->invalidData();
        }

        $input = new JInputJson();

        $sessiontoken = JFactory::getSession()->getToken();
        $webToken = $input->get('web_token');

        if ($webToken !== $sessiontoken) {
            $this->logError('Token Invalido');

            return $this->invalidData();
        }

        $dni = $input->getUint('dni');
        $sexo = $input->getWord('sexo');
        $tramiteNro = $input->getUint('tramiteNro');

        if (!$this->validInput($dni, $sexo, $tramiteNro)) {
            return $this->invalidData();
        }

        $response = $this->getPersonaDni($dni, $sexo);

        if (empty($response)) {
            $this->logWarn(sprintf('Respuesta vacia (dni %s, sexo %s)', $dni, $sexo));

            return $this->invalidData();
        }

        $packet = json_decode($response);

        if (!$packet->resultadoWS->exito) {
            $this->logWarn(sprintf('Respuesta invalida (dni %s, sexo %s)', $dni, $sexo));

            return $this->invalidData();
        }

        if (!$this->check($packet, $dni, $sexo, $tramiteNro)) {
            return $this->invalidData();
        }

        $this->logInfo(sprintf('VALIDO (dni %s, sexo %s, tramite %s) Respuesta: %s', $dni, $sexo, $tramiteNro, json_encode($packet->personaInfo)));

        return $this->validData($packet, $this->sign());
    }

    private function invalidData()
    {
        return ['estado' => false];
    }

    private function validData($packet, $firma)
    {
        $dt = new DateTimeImmutable(
            $packet->personaInfo->fechaNacimiento,
            new DateTimeZone('America/Argentina/Buenos_Aires')
        );
        $fechaNacimiento = $dt->format('d/m/Y');

        return [
            'estado' => true,
            'nombre' => $packet->personaInfo->nombre,
            'apellido' => $packet->personaInfo->apellido,
            'fechaNacimiento' => $fechaNacimiento,
            'domicilio' => trim($this->calle.' '.$this->numero),
            // 'localidad' => $this->municipio,
            'firma' => $firma,
        ];
    }

    private function validApiCredentials()
    {
        return !empty($this->username) && !empty($this->password) && !empty($this->certificate);
    }

    private function validInput($dni, $sexo, $tramiteNro)
    {
        if (empty($dni) || empty($sexo) || empty($tramiteNro)) {
            $this->logWarn(sprintf('Datos Inválidos (dni %s, sexo %s, tramiteNro %s)', $dni, $sexo, $tramiteNro));

            return false;
        }

        if (!preg_match('/\d{7,8}/', $dni)) {
            $this->logWarn(sprintf('Datos Inválidos DNI (dni %s, sexo %s, tramiteNro %s)', $dni, $sexo, $tramiteNro));

            return false;
        }

        if (!is_numeric($tramiteNro)) {
            $this->logWarn(sprintf('Datos Inválidos Trámite (dni %s, sexo %s, tramiteNro %s)', $dni, $sexo, $tramiteNro));

            return false;
        }

        if (!preg_match('/[MF]/', $sexo)) {
            $this->logWarn(sprintf('Datos Inválidos Sexo (sexo %s)', $sexo));

            return false;
        }

        return true;
    }

    private function check($packet, $dni, $sexo, $tramiteNro)
    {
        if (isset($packet->personaInfo->domicilios->domicilio)) {
            $resideEnSanJuan = false;

            foreach ($packet->personaInfo->domicilios->domicilio as $domicilio) {
                if ('SAN_JUAN' === $domicilio->provincia || 'San Juan' === $domicilio->provincia) {
                    $resideEnSanJuan = true;

                    $this->calle = $domicilio->calle;
                    $this->numero = $domicilio->numero;
                    $this->municipio = $domicilio->municipio;
                }
            }

            if (!$resideEnSanJuan) {
                $this->logWarn(sprintf('No reside en San Juan (dni %s, sexo %s, respuesta %s)', $dni, $sexo, $domicilio->provincia));

                return false;
            }
        }

        if ($sexo !== $packet->personaInfo->sexo[0]) {
            $this->logWarn(sprintf('Sexo incorrecto (dni %s, sexo %s, respuesta %s)', $dni, $sexo, $packet->personaInfo->sexo[0]));

            return false;
        }

        $idTramiteRenaper = ltrim($packet->personaInfo->idTramiteRenaper, '0');
        $tramiteNro = ltrim($tramiteNro, '0');

        if ($idTramiteRenaper !== $tramiteNro) {
            $this->logWarn(sprintf('Trámite incorrecto (dni %s, sexo %s, tramite %s, respuesta %s)', $dni, $sexo, $tramiteNro, $idTramiteRenaper));

            return false;
        }

        $cuil = $packet->personaInfo->cuil;
        $personaInfoDni = ltrim(substr($cuil, 2, 8), '0');
        $dni = ltrim($dni, '0');

        if ($dni !== $personaInfoDni) {
            $this->logWarn(sprintf('DNI incorrecto (dni %s, sexo %s, respuesta)', $dni, $sexo, $personaInfoDni));

            return false;
        }

        return true;
    }

    private function getPersonaDni($dni, $sexo)
    {
        $url = sprintf('https://soa.sanjuan.gob.ar/persona/dni/restv1?dni=%d&sexo=%s', $dni, $sexo);
        $cacheKey = sha1($url);

        $cache = JFactory::getCache('plg_ajax_xtwssipe', 'callback');

        try {
            return $cache->get(
                function () use ($url) {
                    return $this->getContents($url, $this->username, $this->password);
                },
                false,
                'getPersonaDni-'.$cacheKey,
                false
            );
        } catch (\JCacheException $cacheException) {
            $this->logError('getPersonaDni: '.$cacheException->getMessage());
        }

        return $this->getContents($url, $this->username, $this->password);
    }

    private function getContents($url, $user, $password, $timeout = 20)
    {
        try {
            // Adding a valid user agent string, otherwise some feed-servers returning an error
            $options = new Registry([
                'userauth' => $user,
                'passwordauth' => $password,
            ]);

            $content = JHttpFactory::getHttp($options)->get($url, null, $timeout)->body;
        } catch (RuntimeException $e) {
            $this->logError('getContents: '.$e->getMessage());

            return false;
        }

        return $content;
    }

    private function sign()
    {
        $sessiontoken = JFactory::getSession()->getToken();

        return base64_encode(sha1($sessiontoken, $this->certificate));
    }

    private function logError($mensaje)
    {
        return $this->log($mensaje, JLog::ERROR);
    }

    private function logWarn($mensaje, $status = null)
    {
        return $this->log($mensaje, JLog::WARNING);
    }

    private function logInfo($mensaje, $status = null)
    {
        return $this->log($mensaje, JLog::INFO);
    }

    private function log($mensaje, $status)
    {
        if (!$this->loggingOk && !$this->loggingError) {
            return;
        }

        jimport('joomla.log.logger.formattedtext');

        $config = [
            'text_file' => JLog::INFO === $status ? 'xt-logging.log' : 'xt-logging-err.log',
        ];

        $logger = new JLogLoggerFormattedtext($config);
        $entry = new JLogEntry('XtWsSipe - '.$mensaje, $status);
        $logger->addEntry($entry);
    }
}
