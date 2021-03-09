-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: database
-- Generation Time: Feb 27, 2021 at 12:04 PM
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
-- Stand-in structure for view `localidades_stats_status`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `localidades_stats_status`;
CREATE TABLE IF NOT EXISTS `localidades_stats_status` (
`id` int(11)
,`nombre` varchar(64)
,`total_solicitudes` bigint(21)
,`cupo` int(11)
,`cupo_restante` bigint(22)
,`status` varchar(12)
);

-- --------------------------------------------------------

--
-- Structure for view `localidades_stats_status`
--
DROP TABLE IF EXISTS `localidades_stats_status`;

DROP VIEW IF EXISTS `localidades_stats_status`;
CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `localidades_stats_status`  AS  select `localidades`.`id` AS `id`,`localidades`.`nombre` AS `nombre`,count(0) AS `total_solicitudes`,`localidades`.`cupo` AS `cupo`,(count(0) - `localidades`.`cupo`) AS `cupo_restante`,if(((count(0) - `localidades`.`cupo`) < 0),'','Cupo agotado') AS `status` from (`j_chronog3_forms7_datalog` `data` join `localidades`) where (json_unquote(json_extract(`data`.`data`,'$."7"')) = `localidades`.`id`) group by `localidades`.`id`,`localidades`.`nombre`,`localidades`.`cupo` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
