-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 12, 2020 at 11:34 PM
-- Server version: 8.0.18
-- PHP Version: 7.1.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `reports_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `duplicated_reports`
--

CREATE TABLE `duplicated_reports` (
  `d_r_id` int(11) NOT NULL,
  `r_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  `hours` double NOT NULL,
  `date` varchar(10) COLLATE utf8_bin NOT NULL,
  `text` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `r_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  `date` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `start_date` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `end_date` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `hours` double NOT NULL,
  `text` text COLLATE utf8_bin NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `year_of_training` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `trainees`
--

CREATE TABLE `trainees` (
  `t_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  `type_training` varchar(130) COLLATE utf8_bin NOT NULL,
  `start_date` varchar(10) COLLATE utf8_bin NOT NULL,
  `end_date` varchar(10) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `trainees`
--

INSERT INTO `trainees` (`t_id`, `u_id`, `type_training`, `start_date`, `end_date`) VALUES
(0, 0, 'Fachinformatiker Anwendungsentwicklung', '01-07-2018', '29-07-2021');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `u_id` int(11) NOT NULL,
  `first_and_last_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `email` varchar(200) COLLATE utf8_bin NOT NULL,
  `birthday` varchar(10) COLLATE utf8_bin NOT NULL,
  `roll` int(11) NOT NULL DEFAULT '0',
  `is_new_user` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`u_id`, `first_and_last_name`, `email`, `birthday`, `roll`, `is_new_user`) VALUES
(0, 'Khalil Khalil', 'k.khalil@satzmedia.de', '30-01-1998', 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `duplicated_reports`
--
ALTER TABLE `duplicated_reports`
  ADD PRIMARY KEY (`d_r_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`r_id`);
ALTER TABLE `reports` ADD FULLTEXT KEY `text` (`text`);

--
-- Indexes for table `trainees`
--
ALTER TABLE `trainees`
  ADD PRIMARY KEY (`t_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`u_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `duplicated_reports`
--
ALTER TABLE `duplicated_reports`
  MODIFY `d_r_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `r_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2991;

--
-- AUTO_INCREMENT for table `trainees`
--
ALTER TABLE `trainees`
  MODIFY `t_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `u_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
