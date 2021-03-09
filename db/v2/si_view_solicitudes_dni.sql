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
-- Stand-in structure for view `si_view_solicitudes_dni`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `si_view_solicitudes_dni`;
CREATE TABLE `si_view_solicitudes_dni` (
`aid` int(11)
,`DNI` longtext
);

-- --------------------------------------------------------

--
-- Structure for view `si_view_solicitudes_dni`
--
DROP TABLE IF EXISTS `si_view_solicitudes_dni`;

DROP VIEW IF EXISTS `si_view_solicitudes_dni`;
CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `si_view_solicitudes_dni`  AS  select `jos_chronog3_forms7_datalog`.`aid` AS `aid`,json_unquote(json_extract(`jos_chronog3_forms7_datalog`.`data`,'$."3"')) AS `DNI` from `jos_chronog3_forms7_datalog` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
