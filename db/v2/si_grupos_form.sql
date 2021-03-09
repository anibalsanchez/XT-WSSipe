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
-- Table structure for table `si_grupos_form`
--

DROP TABLE IF EXISTS `si_grupos_form`;
CREATE TABLE `si_grupos_form` (
  `id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL,
  `grupo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `si_grupos_form`
--

INSERT INTO `si_grupos_form` VALUES(1, 1, 1);
INSERT INTO `si_grupos_form` VALUES(2, 7, 3);
INSERT INTO `si_grupos_form` VALUES(3, 8, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `si_grupos_form`
--
ALTER TABLE `si_grupos_form`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_grupos_form_form` (`form_id`),
  ADD KEY `fk_grupos_form_grupo` (`grupo_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `si_grupos_form`
--
ALTER TABLE `si_grupos_form`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `si_grupos_form`
--
ALTER TABLE `si_grupos_form`
  ADD CONSTRAINT `fk_grupos_form_form` FOREIGN KEY (`form_id`) REFERENCES `jos_chronog3_forms7` (`id`),
  ADD CONSTRAINT `fk_grupos_form_grupo` FOREIGN KEY (`grupo_id`) REFERENCES `si_grupos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


ALTER TABLE `si_grupos_form` DROP FOREIGN KEY `fk_grupos_form_form`;
