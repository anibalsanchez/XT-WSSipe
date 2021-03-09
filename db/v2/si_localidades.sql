-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: database
-- Generation Time: Mar 01, 2021 at 11:09 AM
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
-- Table structure for table `si_localidades`
--

DROP TABLE IF EXISTS `si_localidades`;
CREATE TABLE `si_localidades` (
  `id` int(11) NOT NULL,
  `nombre` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `si_localidades`
--

INSERT INTO `si_localidades` VALUES(1, 'Albardón');
INSERT INTO `si_localidades` VALUES(2, 'Angaco');
INSERT INTO `si_localidades` VALUES(3, 'Calingasta');
INSERT INTO `si_localidades` VALUES(4, 'Capital');
INSERT INTO `si_localidades` VALUES(5, 'Caucete');
INSERT INTO `si_localidades` VALUES(6, 'Chimbas');
INSERT INTO `si_localidades` VALUES(7, 'Iglesia');
INSERT INTO `si_localidades` VALUES(8, 'Jáchal');
INSERT INTO `si_localidades` VALUES(9, '9 de Julio');
INSERT INTO `si_localidades` VALUES(10, 'Pocito');
INSERT INTO `si_localidades` VALUES(11, 'Rawson');
INSERT INTO `si_localidades` VALUES(12, 'Rivadavia');
INSERT INTO `si_localidades` VALUES(13, 'San Martín');
INSERT INTO `si_localidades` VALUES(14, 'Santa Lucía');
INSERT INTO `si_localidades` VALUES(15, 'Sarmiento');
INSERT INTO `si_localidades` VALUES(16, 'Ullum');
INSERT INTO `si_localidades` VALUES(17, 'Valle Fértil');
INSERT INTO `si_localidades` VALUES(18, '25 de Mayo');
INSERT INTO `si_localidades` VALUES(19, 'Zonda');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `si_localidades`
--
ALTER TABLE `si_localidades`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `si_localidades`
--
ALTER TABLE `si_localidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
