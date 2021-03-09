-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: database
-- Generation Time: Mar 01, 2021 at 11:12 AM
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
-- Stand-in structure for view `si_view_cupos_localidades`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `si_view_cupos_localidades`;
CREATE TABLE `si_view_cupos_localidades` (
`grupo_id` int(11)
,`grupo_nombre` varchar(64)
,`localidad_id` int(11)
,`localidad_nombre` varchar(64)
,`cupo` int(11)
,`total_solicitudes` bigint(21)
,`cupo_restante` bigint(22)
,`status` varchar(12)
);

-- --------------------------------------------------------

--
-- Structure for view `si_view_cupos_localidades`
--
DROP TABLE IF EXISTS `si_view_cupos_localidades`;

DROP VIEW IF EXISTS `si_view_cupos_localidades`;
CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `si_view_cupos_localidades`  AS  select `si_grupos`.`id` AS `grupo_id`,`si_grupos`.`nombre` AS `grupo_nombre`,`si_localidades`.`id` AS `localidad_id`,`si_localidades`.`nombre` AS `localidad_nombre`,`si_cupos_localidad`.`cupo` AS `cupo`,`si_view_solicitudes_form_localidad`.`cantidad` AS `total_solicitudes`,(`si_cupos_localidad`.`cupo` - `si_view_solicitudes_form_localidad`.`cantidad`) AS `cupo_restante`,if(((`si_cupos_localidad`.`cupo` - `si_view_solicitudes_form_localidad`.`cantidad`) > 0),'','Cupo agotado') AS `status` from ((((`si_cupos_localidad` join `si_localidades` on((`si_localidades`.`id` = `si_cupos_localidad`.`localidad_id`))) join `si_grupos` on((`si_cupos_localidad`.`grupo_id` = `si_grupos`.`id`))) join `si_grupos_form` on((`si_grupos_form`.`grupo_id` = `si_grupos`.`id`))) join `si_view_solicitudes_form_localidad` on(((`si_view_solicitudes_form_localidad`.`form_id` = `si_grupos_form`.`form_id`) and (`si_view_solicitudes_form_localidad`.`localidad_id` = `si_cupos_localidad`.`localidad_id`)))) group by `si_grupos`.`id`,`si_grupos`.`nombre`,`si_localidades`.`id`,`si_localidades`.`nombre`,`si_cupos_localidad`.`cupo`,`si_view_solicitudes_form_localidad`.`cantidad` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
