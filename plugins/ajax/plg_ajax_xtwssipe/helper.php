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

function xtWsSipeCheckSignature($value) {
    $xtwssipePlugin = JPluginHelper::getPlugin('ajax', 'xtwssipe');

    if (empty($xtwssipePlugin))
    {
        return false;
    }

    $params = json_decode($xtwssipePlugin->params);
    $certificate = $params->certificate;

    $sessiontoken = JFactory::getSession()->getToken();
    $sign = base64_encode(sha1($sessiontoken, $certificate));

    return $value === $sign;
}