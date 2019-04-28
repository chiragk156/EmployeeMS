-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2019 at 08:20 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs301_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `asst_reg`
--

CREATE TABLE `asst_reg` (
  `staffID` varchar(20) NOT NULL,
  `dept` varchar(30) NOT NULL,
  `startdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `asst_reg`
--

INSERT INTO `asst_reg` (`staffID`, `dept`, `startdate`) VALUES
('4', 'Accounts', '2019-04-01'),
('5', 'Establishment Office', '2019-04-01'),
('6', 'Purchase', '2019-04-26');

-- --------------------------------------------------------

--
-- Table structure for table `asst_reg_hist`
--

CREATE TABLE `asst_reg_hist` (
  `staffID` varchar(20) NOT NULL,
  `dept` varchar(30) NOT NULL,
  `startdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `crossfac`
--

CREATE TABLE `crossfac` (
  `facultyID` varchar(20) NOT NULL,
  `role` varchar(30) NOT NULL,
  `startdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `crossfac`
--

INSERT INTO `crossfac` (`facultyID`, `role`, `startdate`) VALUES
('8', 'Asso_dean_fac', '2019-04-08'),
('7', 'dean_fac', '2019-04-14'),
('13', 'director', '2019-04-14');

-- --------------------------------------------------------

--
-- Table structure for table `crossfac_hist`
--

CREATE TABLE `crossfac_hist` (
  `facultyID` varchar(20) NOT NULL,
  `role` varchar(30) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `crossstaff`
--

CREATE TABLE `crossstaff` (
  `staffID` varchar(20) NOT NULL,
  `id` varchar(20) NOT NULL,
  `startdate` date NOT NULL,
  `role` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `crossstaff`
--

INSERT INTO `crossstaff` (`staffID`, `id`, `startdate`, `role`) VALUES
('8', '1', '2019-04-14', 'deansecy'),
('9', '2', '2019-04-14', 'deptsecy'),
('10', '3', '2019-04-14', 'reg');

-- --------------------------------------------------------

--
-- Table structure for table `crossstaff_hist`
--

CREATE TABLE `crossstaff_hist` (
  `staffID` varchar(20) NOT NULL,
  `id` varchar(20) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date NOT NULL,
  `role` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `deansecy`
--

CREATE TABLE `deansecy` (
  `crossstaffID` varchar(20) NOT NULL,
  `dean` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `deansecy`
--

INSERT INTO `deansecy` (`crossstaffID`, `dean`) VALUES
('1', 'Asso_dean_fac');

-- --------------------------------------------------------

--
-- Table structure for table `deptsecy`
--

CREATE TABLE `deptsecy` (
  `dept` varchar(30) NOT NULL,
  `crossstaffID` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `deptsecy`
--

INSERT INTO `deptsecy` (`dept`, `crossstaffID`) VALUES
('CSE', '2');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `id` varchar(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `DOJ` date NOT NULL,
  `GOE` int(11) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `DOL` date DEFAULT NULL,
  `remaningLeaves` int(11) DEFAULT NULL,
  `dept` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`id`, `name`, `email`, `DOJ`, `GOE`, `DOB`, `DOL`, `remaningLeaves`, `dept`) VALUES
('1', 'CSK', 'csk@gmail.com', '2019-04-01', 1, '2016-12-01', NULL, 48, 'CSE'),
('13', 'director', 'dir@rpr', '2018-04-10', 4, NULL, NULL, 0, 'ME'),
('2', 'EE_fac', 'csk@gmail.com', '2018-12-03', 1, '0000-00-00', NULL, 45, 'EE'),
('3', 'ME_fac', 'csk@gmail.com', '2019-02-04', 1, '0000-00-00', NULL, 45, 'ME'),
('4', 'HodCS', 'abc@gmail.com', '2019-03-11', NULL, NULL, NULL, 48, 'CSE'),
('5', 'HodEE', 'ee@gmail.com', '2019-03-12', NULL, NULL, NULL, 48, 'EE'),
('6', 'HodME', 'me1@gmail.com', '2019-04-01', NULL, NULL, NULL, 50, 'ME'),
('7', 'Chirag Khurana', 'Chirag@khurana.com', '2019-04-01', 1, '2018-09-03', NULL, 20, 'CSE'),
('8', 'Mahesh', 'mahesh@iitrpr.ac.in', '2017-03-01', 3, '2015-02-11', NULL, 3, 'EE');

-- --------------------------------------------------------

--
-- Table structure for table `facultydept`
--

CREATE TABLE `facultydept` (
  `name` varchar(30) NOT NULL,
  `address` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `facultydept`
--

INSERT INTO `facultydept` (`name`, `address`) VALUES
('CSE', 'CSE Block, IIT Ropar'),
('EE', 'EE Block, IIT Ropar'),
('ME', 'ME Block, IIT Ropar');

-- --------------------------------------------------------

--
-- Table structure for table `faculty_application`
--

CREATE TABLE `faculty_application` (
  `id` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `faculty_id` varchar(20) NOT NULL,
  `noofdays` int(11) DEFAULT NULL,
  `start` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `faculty_application`
--

INSERT INTO `faculty_application` (`id`, `status`, `ts`, `faculty_id`, `noofdays`, `start`) VALUES
(1, '6', '2019-04-26 12:40:41', '1', 1, '2019-04-30'),
(2, '3', '2019-04-26 12:40:41', '1', 1, '2019-04-30'),
(4, '6', '2019-04-27 05:24:24', '4', 2, '2019-04-29'),
(5, '6', '2019-04-27 07:24:09', '2', 2, '2019-04-29'),
(7, '6', '2019-04-27 07:35:45', '13', 2, '2019-04-29'),
(8, '6', '2019-04-27 08:15:03', '3', 2, '2019-04-29'),
(9, 'reject', '2019-04-27 08:20:14', '2', 1, '2019-04-29'),
(10, 'reject', '2019-04-27 08:27:24', '2', 1, '2019-04-29'),
(11, 'reject', '2019-04-27 09:18:13', '3', 1, '2019-04-29'),
(12, 'reject', '2019-04-27 09:24:57', '5', 1, '2019-04-29'),
(13, '6', '2019-04-27 09:26:25', '5', 2, '2019-04-30'),
(14, '6', '2019-04-27 11:28:36', '3', 2, '2019-04-29'),
(15, '6', '2019-04-27 11:34:00', '3', 1, '2019-04-30'),
(16, '7', '2019-04-27 11:40:02', '4', 2, '2019-05-20');

-- --------------------------------------------------------

--
-- Table structure for table `faculty_bonus`
--

CREATE TABLE `faculty_bonus` (
  `month` int(10) NOT NULL,
  `year` int(5) NOT NULL,
  `percent` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `faculty_comments`
--

CREATE TABLE `faculty_comments` (
  `id` int(11) NOT NULL,
  `comment` varchar(100) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `path_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `faculty_comments`
--

INSERT INTO `faculty_comments` (`id`, `comment`, `application_id`, `ts`, `path_id`) VALUES
(1, 'Fever', 1, '2019-04-26 12:57:36', '1'),
(2, 'Party', 2, '2019-04-26 12:57:36', '1'),
(3, 'fine', 2, '2019-04-26 14:55:58', '2'),
(4, 'fine', 1, '2019-04-26 14:57:54', '2'),
(5, 'ok', 1, '2019-04-26 15:02:15', '3'),
(6, 'ok', 2, '2019-04-27 04:40:01', '3'),
(7, 'ok', 1, '2019-04-27 04:41:52', '4'),
(8, 'ok', 1, '2019-04-27 04:52:22', '5'),
(9, 'fine', 1, '2019-04-27 04:55:23', '5'),
(10, 'fine', 1, '2019-04-27 04:55:45', '5'),
(11, 'fine', 1, '2019-04-27 04:58:36', '6'),
(12, 'fever', 4, '2019-04-27 05:24:25', '2'),
(13, 'ok', 4, '2019-04-27 05:25:00', '3'),
(14, 'ok', 4, '2019-04-27 05:25:23', '4'),
(15, 'ok', 4, '2019-04-27 05:28:11', '5'),
(16, 'ok', 4, '2019-04-27 05:29:07', '6'),
(17, 'fever', 5, '2019-04-27 07:24:09', '1'),
(18, 'ok', 5, '2019-04-27 07:24:39', '2'),
(20, 'fine', 5, '2019-04-27 07:25:57', '3'),
(21, 'ok', 5, '2019-04-27 07:26:19', '4'),
(22, 'ok', 5, '2019-04-27 07:26:44', '5'),
(23, 'ok', 5, '2019-04-27 07:27:06', '6'),
(24, 'Party', 7, '2019-04-27 07:35:45', '7'),
(25, 'ok', 7, '2019-04-27 07:55:03', '5'),
(26, 'ok', 7, '2019-04-27 07:55:34', '6'),
(27, 'fever', 8, '2019-04-27 08:15:04', '1'),
(28, 'ok', 8, '2019-04-27 08:16:09', '2'),
(29, 'ok', 8, '2019-04-27 08:18:18', '3'),
(30, 'ok', 8, '2019-04-27 08:18:39', '4'),
(31, 'ok', 8, '2019-04-27 08:18:58', '5'),
(32, 'ok', 8, '2019-04-27 08:19:17', '6'),
(33, 'Party', 9, '2019-04-27 08:20:15', '1'),
(34, 'Party', 10, '2019-04-27 08:27:24', '1'),
(35, 'Not Allowed', 10, '2019-04-27 08:27:42', 'reject'),
(36, 'Party', 11, '2019-04-27 09:18:14', '1'),
(37, 'Party', 12, '2019-04-27 09:24:57', '8'),
(38, 'ok', 12, '2019-04-27 09:25:50', 'reject'),
(39, 'sick', 13, '2019-04-27 09:26:25', '8'),
(40, 'fine', 13, '2019-04-27 09:26:46', '7'),
(41, 'ok', 13, '2019-04-27 09:27:20', '5'),
(42, 'ok', 13, '2019-04-27 09:27:39', '6'),
(43, 'Not Allowed', 11, '2019-04-27 11:28:14', 'reject'),
(44, 'fever', 14, '2019-04-27 11:28:36', '1'),
(45, 'ok', 14, '2019-04-27 11:29:07', '2'),
(46, 'ok', 14, '2019-04-27 11:29:27', '3'),
(47, 'ok', 14, '2019-04-27 11:29:45', '4'),
(48, 'ok', 14, '2019-04-27 11:30:13', '5'),
(49, 'ok', 14, '2019-04-27 11:30:49', '6'),
(50, 'fever', 15, '2019-04-27 11:34:00', '1'),
(51, 'ok', 15, '2019-04-27 11:34:17', '2'),
(52, 'ok', 15, '2019-04-27 11:34:46', '4'),
(53, 'ok', 15, '2019-04-27 11:35:27', '5'),
(54, 'ok', 15, '2019-04-27 11:35:43', '6'),
(55, 'sick', 16, '2019-04-27 11:40:02', '8'),
(56, 'ok', 16, '2019-04-27 11:40:21', '7');

-- --------------------------------------------------------

--
-- Table structure for table `faculty_pay_matrix`
--

CREATE TABLE `faculty_pay_matrix` (
  `goe` int(20) NOT NULL,
  `experience` int(20) NOT NULL,
  `salary` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `faculty_pay_matrix`
--

INSERT INTO `faculty_pay_matrix` (`goe`, `experience`, `salary`) VALUES
(1, 0, 5000),
(1, 1, 10000);

-- --------------------------------------------------------

--
-- Table structure for table `fac_payslip`
--

CREATE TABLE `fac_payslip` (
  `id` int(11) DEFAULT NULL,
  `facultyID` varchar(20) NOT NULL,
  `month` int(11) NOT NULL,
  `YEAR` int(11) NOT NULL,
  `GOE` int(11) DEFAULT NULL,
  `salary` float DEFAULT NULL,
  `bonus` float DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fac_payslip`
--

INSERT INTO `fac_payslip` (`id`, `facultyID`, `month`, `YEAR`, `GOE`, `salary`, `bonus`, `status`) VALUES
(1234, '1', 1, 2019, 1, 5000, 0, 'approved'),
(1234, '1', 2, 2019, 1, 5000, 0, 'approved'),
(1234, '3', 1, 2019, 1, 5000, 0, 'approved');

-- --------------------------------------------------------

--
-- Table structure for table `hod`
--

CREATE TABLE `hod` (
  `facultyID` varchar(20) NOT NULL,
  `dept` varchar(30) NOT NULL,
  `startdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hod`
--

INSERT INTO `hod` (`facultyID`, `dept`, `startdate`) VALUES
('4', 'CSE', '2019-04-26'),
('5', 'EE', '2019-04-26'),
('6', 'ME', '2019-04-26');

-- --------------------------------------------------------

--
-- Table structure for table `hod_hist`
--

CREATE TABLE `hod_hist` (
  `facultyID` varchar(20) NOT NULL,
  `dept` varchar(30) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`username`, `password`) VALUES
('director', 'director'),
('fac1', 'fac1'),
('fac2', 'fac2'),
('fac3', 'fac3'),
('fac4', 'fac4'),
('fac5', 'fac5'),
('fac6', 'fac6'),
('fac7', 'fac7'),
('fac8', 'fac8'),
('staff1', 'staff1'),
('staff2', 'staff2'),
('staff3', 'staff3'),
('staff4', 'staff4'),
('staff5', 'staff5'),
('staff6', 'staff6'),
('staff8', 'staff8'),
('staff9', 'staff9');

-- --------------------------------------------------------

--
-- Table structure for table `login_faculty`
--

CREATE TABLE `login_faculty` (
  `username` varchar(50) NOT NULL,
  `facultyID` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `login_faculty`
--

INSERT INTO `login_faculty` (`username`, `facultyID`) VALUES
('fac1', '1'),
('director', '13'),
('fac2', '2'),
('fac3', '3'),
('fac4', '4'),
('fac5', '5'),
('fac6', '6'),
('fac7', '7'),
('fac8', '8');

-- --------------------------------------------------------

--
-- Table structure for table `login_staff`
--

CREATE TABLE `login_staff` (
  `username` varchar(50) NOT NULL,
  `staffID` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `login_staff`
--

INSERT INTO `login_staff` (`username`, `staffID`) VALUES
('staff1', '1'),
('staff2', '2'),
('staff3', '3'),
('staff4', '4'),
('staff5', '5'),
('staff6', '6'),
('staff8', '8'),
('staff9', '9');

-- --------------------------------------------------------

--
-- Table structure for table `path`
--

CREATE TABLE `path` (
  `id` varchar(20) NOT NULL,
  `predecessor` varchar(20) NOT NULL,
  `successor` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `path`
--

INSERT INTO `path` (`id`, `predecessor`, `successor`) VALUES
('1', 'faculty', 'hod'),
('2', 'hod', 'dean_fac'),
('3', 'Asso_dean_fac', 'dean_fac'),
('4', 'dean_fac', 'staffEO'),
('5', 'staffEO', 'asst_reg'),
('6', 'asst_reg', 'applicant'),
('7', 'director', 'staffEO'),
('8', 'HodDean', 'director'),
('reject', 'anybody', 'applicant');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` varchar(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `DOJ` date NOT NULL,
  `GOE` int(11) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `DOL` date DEFAULT NULL,
  `remaningLeaves` int(11) DEFAULT NULL,
  `dept` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `name`, `email`, `DOJ`, `GOE`, `DOB`, `DOL`, `remaningLeaves`, `dept`) VALUES
('1', 'a', 'a', '2019-04-01', 3, NULL, NULL, 40, 'Accounts'),
('10', 'Registrar', 'reg@iitrpr.ac.in', '2018-03-06', 3, NULL, NULL, 5, 'Establishment Office'),
('2', 'b', 'b', '2019-04-01', 3, NULL, NULL, 40, 'Establishment Office'),
('3', 'c', 'c', '2019-04-16', 3, NULL, NULL, 40, 'Purchase'),
('4', 'd', 'd', '2019-04-09', 3, NULL, NULL, 40, 'Accounts'),
('5', 'e', 'e', '2019-04-02', 3, NULL, NULL, 40, 'Establishment Office'),
('6', 'f', 'f', '2019-04-03', 3, NULL, NULL, 40, 'Purchase'),
('8', 'Staff1', 'staff1@iitrpr.ac.in', '2018-06-13', 1, '2017-01-04', NULL, 14, 'Accounts'),
('9', 'staff2', 'staff2@yahupoen.com', '2018-01-16', 2, '2017-08-09', NULL, 0, 'Purchase');

-- --------------------------------------------------------

--
-- Table structure for table `staffdept`
--

CREATE TABLE `staffdept` (
  `name` varchar(30) NOT NULL,
  `address` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `staffdept`
--

INSERT INTO `staffdept` (`name`, `address`) VALUES
('Accounts', 'NA'),
('Establishment Office', 'NA'),
('Purchase', 'NA');

-- --------------------------------------------------------

--
-- Table structure for table `staff_application`
--

CREATE TABLE `staff_application` (
  `id` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `staff_id` varchar(20) NOT NULL,
  `start` date DEFAULT NULL,
  `noofdays` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `staff_bonus`
--

CREATE TABLE `staff_bonus` (
  `month` varchar(10) NOT NULL,
  `year` varchar(5) NOT NULL,
  `percent` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `staff_comments`
--

CREATE TABLE `staff_comments` (
  `id` int(11) NOT NULL,
  `comment` varchar(100) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `path_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `staff_payslip`
--

CREATE TABLE `staff_payslip` (
  `id` int(11) DEFAULT NULL,
  `staffID` varchar(20) NOT NULL,
  `month` int(11) NOT NULL,
  `YEAR` int(11) NOT NULL,
  `GOE` int(11) DEFAULT NULL,
  `salary` float DEFAULT NULL,
  `bonus` float DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `staff_pay_matrix`
--

CREATE TABLE `staff_pay_matrix` (
  `goe` varchar(20) NOT NULL,
  `experience` varchar(20) NOT NULL,
  `salary` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asst_reg`
--
ALTER TABLE `asst_reg`
  ADD PRIMARY KEY (`dept`),
  ADD KEY `staffID` (`staffID`);

--
-- Indexes for table `asst_reg_hist`
--
ALTER TABLE `asst_reg_hist`
  ADD PRIMARY KEY (`dept`),
  ADD KEY `staffID` (`staffID`);

--
-- Indexes for table `crossfac`
--
ALTER TABLE `crossfac`
  ADD PRIMARY KEY (`role`),
  ADD KEY `facultyID` (`facultyID`);

--
-- Indexes for table `crossfac_hist`
--
ALTER TABLE `crossfac_hist`
  ADD PRIMARY KEY (`role`,`facultyID`,`startdate`),
  ADD KEY `facultyID` (`facultyID`);

--
-- Indexes for table `crossstaff`
--
ALTER TABLE `crossstaff`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staffID` (`staffID`);

--
-- Indexes for table `crossstaff_hist`
--
ALTER TABLE `crossstaff_hist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staffID` (`staffID`);

--
-- Indexes for table `deansecy`
--
ALTER TABLE `deansecy`
  ADD KEY `crossstaffID` (`crossstaffID`),
  ADD KEY `dean` (`dean`);

--
-- Indexes for table `deptsecy`
--
ALTER TABLE `deptsecy`
  ADD KEY `crossstaffID` (`crossstaffID`),
  ADD KEY `dept` (`dept`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dept` (`dept`);

--
-- Indexes for table `facultydept`
--
ALTER TABLE `facultydept`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `faculty_application`
--
ALTER TABLE `faculty_application`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faculty_id` (`faculty_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `faculty_bonus`
--
ALTER TABLE `faculty_bonus`
  ADD PRIMARY KEY (`month`,`year`);

--
-- Indexes for table `faculty_comments`
--
ALTER TABLE `faculty_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `application_id` (`application_id`),
  ADD KEY `path_id` (`path_id`);

--
-- Indexes for table `faculty_pay_matrix`
--
ALTER TABLE `faculty_pay_matrix`
  ADD PRIMARY KEY (`goe`,`experience`);

--
-- Indexes for table `fac_payslip`
--
ALTER TABLE `fac_payslip`
  ADD PRIMARY KEY (`facultyID`,`month`,`YEAR`);

--
-- Indexes for table `hod`
--
ALTER TABLE `hod`
  ADD PRIMARY KEY (`dept`),
  ADD KEY `facultyID` (`facultyID`);

--
-- Indexes for table `hod_hist`
--
ALTER TABLE `hod_hist`
  ADD PRIMARY KEY (`dept`,`facultyID`,`startdate`),
  ADD KEY `facultyID` (`facultyID`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `login_faculty`
--
ALTER TABLE `login_faculty`
  ADD PRIMARY KEY (`username`),
  ADD KEY `facultyID` (`facultyID`);

--
-- Indexes for table `login_staff`
--
ALTER TABLE `login_staff`
  ADD PRIMARY KEY (`username`),
  ADD KEY `staffID` (`staffID`);

--
-- Indexes for table `path`
--
ALTER TABLE `path`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dept` (`dept`);

--
-- Indexes for table `staffdept`
--
ALTER TABLE `staffdept`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `staff_application`
--
ALTER TABLE `staff_application`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `staff_bonus`
--
ALTER TABLE `staff_bonus`
  ADD PRIMARY KEY (`month`,`year`);

--
-- Indexes for table `staff_comments`
--
ALTER TABLE `staff_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `application_id` (`application_id`),
  ADD KEY `path_id` (`path_id`);

--
-- Indexes for table `staff_payslip`
--
ALTER TABLE `staff_payslip`
  ADD PRIMARY KEY (`staffID`,`month`,`YEAR`);

--
-- Indexes for table `staff_pay_matrix`
--
ALTER TABLE `staff_pay_matrix`
  ADD PRIMARY KEY (`goe`,`experience`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `faculty_application`
--
ALTER TABLE `faculty_application`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `faculty_comments`
--
ALTER TABLE `faculty_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `staff_application`
--
ALTER TABLE `staff_application`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff_comments`
--
ALTER TABLE `staff_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `asst_reg`
--
ALTER TABLE `asst_reg`
  ADD CONSTRAINT `asst_reg_ibfk_1` FOREIGN KEY (`staffID`) REFERENCES `staff` (`id`),
  ADD CONSTRAINT `asst_reg_ibfk_2` FOREIGN KEY (`dept`) REFERENCES `staffdept` (`name`);

--
-- Constraints for table `asst_reg_hist`
--
ALTER TABLE `asst_reg_hist`
  ADD CONSTRAINT `asst_reg_hist_ibfk_1` FOREIGN KEY (`staffID`) REFERENCES `staff` (`id`),
  ADD CONSTRAINT `asst_reg_hist_ibfk_2` FOREIGN KEY (`dept`) REFERENCES `staffdept` (`name`);

--
-- Constraints for table `crossfac`
--
ALTER TABLE `crossfac`
  ADD CONSTRAINT `crossfac_ibfk_1` FOREIGN KEY (`facultyID`) REFERENCES `faculty` (`id`);

--
-- Constraints for table `crossfac_hist`
--
ALTER TABLE `crossfac_hist`
  ADD CONSTRAINT `crossfac_hist_ibfk_1` FOREIGN KEY (`facultyID`) REFERENCES `faculty` (`id`);

--
-- Constraints for table `crossstaff`
--
ALTER TABLE `crossstaff`
  ADD CONSTRAINT `crossstaff_ibfk_1` FOREIGN KEY (`staffID`) REFERENCES `staff` (`id`);

--
-- Constraints for table `crossstaff_hist`
--
ALTER TABLE `crossstaff_hist`
  ADD CONSTRAINT `crossstaff_hist_ibfk_1` FOREIGN KEY (`staffID`) REFERENCES `staff` (`id`);

--
-- Constraints for table `deansecy`
--
ALTER TABLE `deansecy`
  ADD CONSTRAINT `deansecy_ibfk_1` FOREIGN KEY (`crossstaffID`) REFERENCES `crossstaff` (`id`),
  ADD CONSTRAINT `deansecy_ibfk_2` FOREIGN KEY (`dean`) REFERENCES `crossfac` (`role`);

--
-- Constraints for table `deptsecy`
--
ALTER TABLE `deptsecy`
  ADD CONSTRAINT `deptsecy_ibfk_1` FOREIGN KEY (`crossstaffID`) REFERENCES `crossstaff` (`id`),
  ADD CONSTRAINT `deptsecy_ibfk_2` FOREIGN KEY (`dept`) REFERENCES `facultydept` (`name`);

--
-- Constraints for table `faculty`
--
ALTER TABLE `faculty`
  ADD CONSTRAINT `faculty_ibfk_1` FOREIGN KEY (`dept`) REFERENCES `facultydept` (`name`);

--
-- Constraints for table `faculty_application`
--
ALTER TABLE `faculty_application`
  ADD CONSTRAINT `faculty_application_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`id`),
  ADD CONSTRAINT `faculty_application_ibfk_2` FOREIGN KEY (`status`) REFERENCES `path` (`id`);

--
-- Constraints for table `faculty_comments`
--
ALTER TABLE `faculty_comments`
  ADD CONSTRAINT `faculty_comments_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `faculty_application` (`id`),
  ADD CONSTRAINT `faculty_comments_ibfk_2` FOREIGN KEY (`path_id`) REFERENCES `path` (`id`);

--
-- Constraints for table `fac_payslip`
--
ALTER TABLE `fac_payslip`
  ADD CONSTRAINT `fac_payslip_ibfk_1` FOREIGN KEY (`facultyID`) REFERENCES `faculty` (`id`);

--
-- Constraints for table `hod`
--
ALTER TABLE `hod`
  ADD CONSTRAINT `hod_ibfk_1` FOREIGN KEY (`facultyID`) REFERENCES `faculty` (`id`),
  ADD CONSTRAINT `hod_ibfk_2` FOREIGN KEY (`dept`) REFERENCES `facultydept` (`name`);

--
-- Constraints for table `hod_hist`
--
ALTER TABLE `hod_hist`
  ADD CONSTRAINT `hod_hist_ibfk_1` FOREIGN KEY (`facultyID`) REFERENCES `faculty` (`id`),
  ADD CONSTRAINT `hod_hist_ibfk_2` FOREIGN KEY (`dept`) REFERENCES `facultydept` (`name`);

--
-- Constraints for table `login_faculty`
--
ALTER TABLE `login_faculty`
  ADD CONSTRAINT `login_faculty_ibfk_1` FOREIGN KEY (`username`) REFERENCES `login` (`username`),
  ADD CONSTRAINT `login_faculty_ibfk_2` FOREIGN KEY (`facultyID`) REFERENCES `faculty` (`id`);

--
-- Constraints for table `login_staff`
--
ALTER TABLE `login_staff`
  ADD CONSTRAINT `login_staff_ibfk_1` FOREIGN KEY (`username`) REFERENCES `login` (`username`),
  ADD CONSTRAINT `login_staff_ibfk_2` FOREIGN KEY (`staffID`) REFERENCES `staff` (`id`);

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`dept`) REFERENCES `staffdept` (`name`);

--
-- Constraints for table `staff_application`
--
ALTER TABLE `staff_application`
  ADD CONSTRAINT `staff_application_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`),
  ADD CONSTRAINT `staff_application_ibfk_2` FOREIGN KEY (`status`) REFERENCES `path` (`id`);

--
-- Constraints for table `staff_comments`
--
ALTER TABLE `staff_comments`
  ADD CONSTRAINT `staff_comments_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `staff_application` (`id`),
  ADD CONSTRAINT `staff_comments_ibfk_2` FOREIGN KEY (`path_id`) REFERENCES `path` (`id`);

--
-- Constraints for table `staff_payslip`
--
ALTER TABLE `staff_payslip`
  ADD CONSTRAINT `staff_payslip_ibfk_1` FOREIGN KEY (`staffID`) REFERENCES `staff` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
