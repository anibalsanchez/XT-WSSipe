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
-- Stand-in structure for view `si_view_solicitudes_form_total`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `si_view_solicitudes_form_total`;
CREATE TABLE `si_view_solicitudes_form_total` (
`form_id` int(11)
,`cantidad` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `si_view_solicitudes_form_total`
--
DROP TABLE IF EXISTS `si_view_solicitudes_form_total`;

DROP VIEW IF EXISTS `si_view_solicitudes_form_total`;
CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `si_view_solicitudes_form_total`  AS  select `si_grupos_form`.`form_id` AS `form_id`,count(`data`.`form_id`) AS `cantidad` from ((`si_grupos_form` join `si_cupos_total` on((`si_grupos_form`.`grupo_id` = `si_cupos_total`.`grupo_id`))) left join `jos_chronog3_forms7_datalog` `data` on((`si_grupos_form`.`form_id` = `data`.`form_id`))) group by `si_grupos_form`.`form_id` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
