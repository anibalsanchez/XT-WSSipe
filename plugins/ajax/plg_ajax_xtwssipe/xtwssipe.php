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

    public function onAjaxXtWsSipe()
    {
        $this->username = $this->params->get('username');
        $this->password = $this->params->get('password');
        $this->certificate = $this->params->get('certificate');

        if (!$this->validApiCredentials()) {
            $this->log('Invalid Api Credentials');

            return $this->invalidData();
        }

        $input = new JInputJson();
        $dni = $input->getUint('dni');
        $sexo = $input->getWord('sexo');
        $tramiteNro = $input->getUint('tramiteNro');

        if (!$this->validInput($dni, $sexo, $tramiteNro)) {
            return $this->invalidData();
        }

        $response = $this->getPersonaDni($dni, $sexo);

        if (empty($response)) {
            $this->log(sprintf('Respuesta vacia (dni %s, sexo %s)', $dni, $sexo));

            return $this->invalidData();
        }

        $packet = json_decode($response);

        if (!$packet->resultadoWS->exito) {
            $this->log(sprintf('Respuesta invalida (dni %s, sexo %s)', $dni, $sexo));

            return $this->invalidData();
        }

        if (!$this->check($packet, $dni, $sexo, $tramiteNro)) {
            $this->log(sprintf('Respuesta no verificada (dni %s, sexo %s, tramite %s)', $dni, $sexo, $tramiteNro));

            return $this->invalidData();
        }

        $this->log(sprintf('VALIDO (dni %s, sexo %s, tramite %s)', $dni, $sexo, $tramiteNro));

        return $this->validData($packet, $this->sign($dni));
    }

    private function invalidData()
    {
        return ['estado' => false];
    }

    private function validData($packet, $firma)
    {
        return [
            'estado' => true,
            'nombre' => $packet->personaInfo->nombre,
            'apellido' => $packet->personaInfo->apellido,
            'fechaNacimiento' => substr($packet->personaInfo->fechaNacimiento, 0, 10),
            'domicilio' => trim($this->calle.' '.$this->numero),
            'localidad' => $this->municipio,
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
            $this->log(sprintf('Invalid (dni %s, sexo %s, tramiteNro %s)', $dni, $sexo, $tramiteNro));

            return false;
        }

        if (!preg_match('/\d{7,8}/', $dni)) {
            $this->log(sprintf('Invalid (dni %s)', $dni));

            return false;
        }

        if (!is_numeric($tramiteNro)) {
            $this->log(sprintf('Invalid (tramiteNro %s)', $tramiteNro));

            return false;
        }

        if (!preg_match('/[MF]/', $sexo)) {
            $this->log(sprintf('Invalid (sexo %s)', $sexo));

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
                $this->log(sprintf('No reside en San Juan (dni %s, sexo %s)', $dni, $sexo));

                return false;
            }
        }

        if ($sexo !== $packet->personaInfo->sexo[0]) {
            $this->log(sprintf('Sexo incorrecto (dni %s, sexo %s)', $dni, $sexo));

            return false;
        }

        $idTramiteRenaper = ltrim($packet->personaInfo->idTramiteRenaper, '0');
        $tramiteNro = ltrim($tramiteNro, '0');

        if ($idTramiteRenaper !== $tramiteNro) {
            $this->log(sprintf('Trámite incorrecto (dni %s, sexo %s, tramite)', $dni, $sexo, $tramiteNro));

            return false;
        }

        $cuil = $packet->personaInfo->cuil;
        $personaInfoDni = ltrim(substr($cuil, 2, 8), '0');
        $dni = ltrim($dni, '0');

        if ($dni !== $personaInfoDni) {
            $this->log(sprintf('DNI incorrecto (dni %s, sexo %s)', $dni, $sexo));

            return false;
        }

        return true;
    }

    private function getPersonaDni($dni, $sexo)
    {
        $url = sprintf('https://soa.sanjuan.gob.ar/persona/dni/restv1?dni=%d&sexo=%s', $dni, $sexo);

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
            $this->log('getContents: '.$e->getMessage());

            return false;
        }

        return $content;
    }

    private function sign($dni)
    {
        return base64_encode(sha1($dni, $this->certificate));
    }

    private function log($mensaje, $status = null)
    {
        if (!(bool) $this->params->get('logging')) {
            return;
        }

        jimport('joomla.log.logger.formattedtext');

        if (!status) {
            $status = JLog::WARN;
        }

        $logger = new JLogLoggerFormattedtext([
            'text_file' => 'xt-logging.log',
        ]);
        $entry = new JLogEntry('XtWsSipe - '.$mensaje, $status);
        $logger->addEntry($entry);
    }
}
