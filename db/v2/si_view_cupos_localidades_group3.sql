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
-- Stand-in structure for view `si_view_cupos_localidades_group3`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `si_view_cupos_localidades_group3`;
CREATE TABLE `si_view_cupos_localidades_group3` (
`id` int(11)
,`nombre` varchar(64)
,`cupo` int(11)
,`status` varchar(12)
);

-- --------------------------------------------------------

--
-- Structure for view `si_view_cupos_localidades_group3`
--
DROP TABLE IF EXISTS `si_view_cupos_localidades_group3`;

DROP VIEW IF EXISTS `si_view_cupos_localidades_group3`;
CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `si_view_cupos_localidades_group3`  AS  select `si_view_cupos_localidades`.`localidad_id` AS `id`,`si_view_cupos_localidades`.`localidad_nombre` AS `nombre`,`si_view_cupos_localidades`.`cupo` AS `cupo`,`si_view_cupos_localidades`.`status` AS `status` from `si_view_cupos_localidades` where (`si_view_cupos_localidades`.`grupo_id` = 3) order by `si_view_cupos_localidades`.`localidad_id` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
