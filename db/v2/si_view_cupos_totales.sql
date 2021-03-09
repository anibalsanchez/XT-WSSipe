-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: database
-- Generation Time: Mar 01, 2021 at 11:13 AM
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
-- Stand-in structure for view `si_view_cupos_totales`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `si_view_cupos_totales`;
CREATE TABLE `si_view_cupos_totales` (
`grupo_id` int(11)
,`grupo_nombre` varchar(64)
,`cupo` int(11)
,`total_solicitudes` bigint(21)
,`cupo_restante` bigint(22)
,`status` varchar(12)
);

-- --------------------------------------------------------

--
-- Structure for view `si_view_cupos_totales`
--
DROP TABLE IF EXISTS `si_view_cupos_totales`;

DROP VIEW IF EXISTS `si_view_cupos_totales`;
CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `si_view_cupos_totales`  AS  select `si_grupos`.`id` AS `grupo_id`,`si_grupos`.`nombre` AS `grupo_nombre`,`si_cupos_total`.`cupo` AS `cupo`,`si_view_solicitudes_form_total`.`cantidad` AS `total_solicitudes`,(`si_cupos_total`.`cupo` - `si_view_solicitudes_form_total`.`cantidad`) AS `cupo_restante`,if(((`si_cupos_total`.`cupo` - `si_view_solicitudes_form_total`.`cantidad`) > 0),'','Cupo agotado') AS `status` from (((`si_cupos_total` join `si_grupos` on((`si_cupos_total`.`grupo_id` = `si_grupos`.`id`))) join `si_grupos_form` on((`si_grupos_form`.`grupo_id` = `si_grupos`.`id`))) join `si_view_solicitudes_form_total` on((`si_view_solicitudes_form_total`.`form_id` = `si_grupos_form`.`form_id`))) group by `si_grupos`.`id`,`si_grupos`.`nombre`,`si_cupos_total`.`cupo`,`si_view_solicitudes_form_total`.`cantidad` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
