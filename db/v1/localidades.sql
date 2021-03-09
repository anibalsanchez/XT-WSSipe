-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: database
-- Generation Time: Feb 27, 2021 at 11:03 AM
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
-- Table structure for table `localidades`
--

CREATE TABLE `localidades` (
  `id` int(11) NOT NULL,
  `nombre` varchar(64) NOT NULL,
  `cupo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `localidades`
--

INSERT INTO `localidades` VALUES(1, 'Albardón', 170);
INSERT INTO `localidades` VALUES(2, 'Angaco', 50);
INSERT INTO `localidades` VALUES(3, 'Calingasta', 60);
INSERT INTO `localidades` VALUES(4, 'Capital', 610);
INSERT INTO `localidades` VALUES(5, 'Caucete', 260);
INSERT INTO `localidades` VALUES(6, 'Chimbas', 620);
INSERT INTO `localidades` VALUES(7, 'Iglesia', 70);
INSERT INTO `localidades` VALUES(8, 'Jáchal', 140);
INSERT INTO `localidades` VALUES(9, '9 de Julio', 60);
INSERT INTO `localidades` VALUES(10, 'Pocito', 410);
INSERT INTO `localidades` VALUES(11, 'Rawson', 730);
INSERT INTO `localidades` VALUES(12, 'Rivadavia', 530);
INSERT INTO `localidades` VALUES(13, 'San Martín', 70);
INSERT INTO `localidades` VALUES(14, 'Santa Lucía', 320);
INSERT INTO `localidades` VALUES(15, 'Sarmiento', 150);
INSERT INTO `localidades` VALUES(16, 'Ullum', 40);
INSERT INTO `localidades` VALUES(17, 'Valle Fértil', 50);
INSERT INTO `localidades` VALUES(18, '25 de Mayo', 120);
INSERT INTO `localidades` VALUES(19, 'Zonda', 40);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `localidades`
--
ALTER TABLE `localidades`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `localidades`
--
ALTER TABLE `localidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
