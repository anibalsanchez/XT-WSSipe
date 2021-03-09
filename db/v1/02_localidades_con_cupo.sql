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
-- Stand-in structure for view `localidades_con_cupo`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `localidades_con_cupo`;
CREATE TABLE IF NOT EXISTS `localidades_con_cupo` (
`id` int(11)
,`nombre` varchar(64)
);

-- --------------------------------------------------------

--
-- Structure for view `localidades_con_cupo`
--
DROP TABLE IF EXISTS `localidades_con_cupo`;

DROP VIEW IF EXISTS `localidades_con_cupo`;
CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `localidades_con_cupo`  AS  select `localidades_stats`.`id` AS `id`,`localidades_stats`.`nombre` AS `nombre` from `localidades_stats` where (`localidades_stats`.`cupo_restante` < 0) ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
