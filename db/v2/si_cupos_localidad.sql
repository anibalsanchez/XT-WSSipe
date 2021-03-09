-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: database
-- Generation Time: Mar 01, 2021 at 11:11 AM
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
-- Table structure for table `si_cupos_localidad`
--

DROP TABLE IF EXISTS `si_cupos_localidad`;
CREATE TABLE `si_cupos_localidad` (
  `id` int(11) NOT NULL,
  `grupo_id` int(11) NOT NULL,
  `localidad_id` int(11) NOT NULL,
  `cupo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `si_cupos_localidad`
--

INSERT INTO `si_cupos_localidad` VALUES(1, 1, 1, 170);
INSERT INTO `si_cupos_localidad` VALUES(2, 1, 2, 50);
INSERT INTO `si_cupos_localidad` VALUES(3, 1, 3, 60);
INSERT INTO `si_cupos_localidad` VALUES(4, 1, 4, 610);
INSERT INTO `si_cupos_localidad` VALUES(5, 1, 5, 260);
INSERT INTO `si_cupos_localidad` VALUES(6, 1, 6, 620);
INSERT INTO `si_cupos_localidad` VALUES(7, 1, 7, 70);
INSERT INTO `si_cupos_localidad` VALUES(8, 1, 8, 140);
INSERT INTO `si_cupos_localidad` VALUES(9, 1, 9, 60);
INSERT INTO `si_cupos_localidad` VALUES(10, 1, 10, 410);
INSERT INTO `si_cupos_localidad` VALUES(11, 1, 11, 730);
INSERT INTO `si_cupos_localidad` VALUES(12, 1, 12, 530);
INSERT INTO `si_cupos_localidad` VALUES(13, 1, 13, 70);
INSERT INTO `si_cupos_localidad` VALUES(14, 1, 14, 320);
INSERT INTO `si_cupos_localidad` VALUES(15, 1, 15, 150);
INSERT INTO `si_cupos_localidad` VALUES(16, 1, 16, 40);
INSERT INTO `si_cupos_localidad` VALUES(17, 1, 17, 50);
INSERT INTO `si_cupos_localidad` VALUES(18, 1, 18, 120);
INSERT INTO `si_cupos_localidad` VALUES(19, 1, 19, 40);
INSERT INTO `si_cupos_localidad` VALUES(20, 3, 1, 1170);
INSERT INTO `si_cupos_localidad` VALUES(21, 3, 2, 150);
INSERT INTO `si_cupos_localidad` VALUES(22, 3, 3, 160);
INSERT INTO `si_cupos_localidad` VALUES(23, 3, 4, 1610);
INSERT INTO `si_cupos_localidad` VALUES(24, 3, 5, 1260);
INSERT INTO `si_cupos_localidad` VALUES(25, 3, 6, 1620);
INSERT INTO `si_cupos_localidad` VALUES(26, 3, 7, 170);
INSERT INTO `si_cupos_localidad` VALUES(27, 3, 8, 1140);
INSERT INTO `si_cupos_localidad` VALUES(28, 3, 9, 160);
INSERT INTO `si_cupos_localidad` VALUES(29, 3, 10, 1410);
INSERT INTO `si_cupos_localidad` VALUES(30, 3, 11, 1730);
INSERT INTO `si_cupos_localidad` VALUES(31, 3, 12, 1530);
INSERT INTO `si_cupos_localidad` VALUES(32, 3, 13, 170);
INSERT INTO `si_cupos_localidad` VALUES(33, 3, 14, 1320);
INSERT INTO `si_cupos_localidad` VALUES(34, 3, 15, 1150);
INSERT INTO `si_cupos_localidad` VALUES(35, 3, 16, 140);
INSERT INTO `si_cupos_localidad` VALUES(36, 3, 17, 150);
INSERT INTO `si_cupos_localidad` VALUES(37, 3, 18, 1120);
INSERT INTO `si_cupos_localidad` VALUES(38, 3, 19, 140);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `si_cupos_localidad`
--
ALTER TABLE `si_cupos_localidad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cupos_localidad_grupo` (`grupo_id`),
  ADD KEY `fk_cupos_localidad_localidad` (`localidad_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `si_cupos_localidad`
--
ALTER TABLE `si_cupos_localidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `si_cupos_localidad`
--
ALTER TABLE `si_cupos_localidad`
  ADD CONSTRAINT `fk_cupos_localidad_grupo` FOREIGN KEY (`grupo_id`) REFERENCES `si_grupos` (`id`),
  ADD CONSTRAINT `fk_cupos_localidad_localidad` FOREIGN KEY (`localidad_id`) REFERENCES `si_localidades` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
