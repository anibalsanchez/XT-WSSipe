-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: database
-- Generation Time: Mar 01, 2021 at 11:14 AM
-- Server version: 5.7.29
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vacunacionsidb`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `si_view_solicitudes_form_localidad`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `si_view_solicitudes_form_localidad`;
CREATE TABLE `si_view_solicitudes_form_localidad` (
`form_id` int(11)
,`localidad_id` int(11)
,`cantidad` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `si_view_solicitudes_form_localidad`
--
DROP TABLE IF EXISTS `si_view_solicitudes_form_localidad`;

DROP VIEW IF EXISTS `si_view_solicitudes_form_localidad`;
CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `si_view_solicitudes_form_localidad`  AS  select `si_grupos_form`.`form_id` AS `form_id`,`si_cupos_localidad`.`localidad_id` AS `localidad_id`,count(`data`.`aid`) AS `cantidad` from ((`si_grupos_form` join `si_cupos_localidad` on((`si_grupos_form`.`grupo_id` = `si_cupos_localidad`.`grupo_id`))) left join `jos_chronog3_forms7_datalog` `data` on(((`si_grupos_form`.`form_id` = `data`.`form_id`) and (`si_cupos_localidad`.`localidad_id` = json_unquote(json_extract(`data`.`data`,'$."7"')))))) group by `si_grupos_form`.`id`,`si_cupos_localidad`.`localidad_id` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
