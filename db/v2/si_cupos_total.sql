-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: database
-- Generation Time: Mar 01, 2021 at 11:10 AM
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
-- Table structure for table `si_cupos_total`
--

DROP TABLE IF EXISTS `si_cupos_total`;
CREATE TABLE `si_cupos_total` (
  `id` int(11) NOT NULL,
  `grupo_id` int(11) NOT NULL,
  `cupo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `si_cupos_total`
--

INSERT INTO `si_cupos_total` VALUES(1, 2, 8800);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `si_cupos_total`
--
ALTER TABLE `si_cupos_total`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cupos_grupo` (`grupo_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `si_cupos_total`
--
ALTER TABLE `si_cupos_total`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `si_cupos_total`
--
ALTER TABLE `si_cupos_total`
  ADD CONSTRAINT `fk_cupos_grupo` FOREIGN KEY (`grupo_id`) REFERENCES `si_grupos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
