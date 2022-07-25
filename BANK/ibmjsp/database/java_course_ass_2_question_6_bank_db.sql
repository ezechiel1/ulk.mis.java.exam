-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 25, 2022 at 06:10 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `java_course_ass_2_question_6_bank_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `bank_account_transaction_cashin`
--

CREATE TABLE `bank_account_transaction_cashin` (
  `id` int(11) NOT NULL,
  `account_number` varchar(256) NOT NULL,
  `transaction_id` varchar(256) NOT NULL,
  `amount` double NOT NULL,
  `transaction_status` varchar(256) NOT NULL DEFAULT '',
  `transaction_datetime` varchar(256) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bank_account_transaction_cashin`
--

INSERT INTO `bank_account_transaction_cashin` (`id`, `account_number`, `transaction_id`, `amount`, `transaction_status`, `transaction_datetime`) VALUES
(6, '40080904040400', 'IBM_TrX_IN_0020220710113758', 1200, 'ACTIVE', '2022/07/10 11:37:58'),
(7, '40080904040400', 'IBM_TrX_IN_0020220710113805', 500, 'ACTIVE', '2022/07/10 11:38:05'),
(9, '40080904040400', 'IBM_TrX_IN_0020220710125701', 250, 'ACTIVE', '2022/07/10 12:57:01');

-- --------------------------------------------------------

--
-- Table structure for table `bank_account_transaction_cashout`
--

CREATE TABLE `bank_account_transaction_cashout` (
  `id` int(11) NOT NULL,
  `account_number` varchar(256) NOT NULL,
  `transaction_id` varchar(256) NOT NULL,
  `amount` double NOT NULL,
  `transaction_status` varchar(256) NOT NULL DEFAULT '',
  `transaction_datetime` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bank_account_transaction_cashout`
--

INSERT INTO `bank_account_transaction_cashout` (`id`, `account_number`, `transaction_id`, `amount`, `transaction_status`, `transaction_datetime`) VALUES
(1, '40080904040400', 'IBM_TrX_OUT_0020220710115148', 350, 'ACTIVE', '2022/07/10 11:51:48'),
(2, '40080904040400', 'IBM_TrX_OUT_0020220710125914', 400, 'ACTIVE', '2022/07/10 12:59:14'),
(3, '40080904040400', 'IBM_TrX_OUT_0020220710125933', 150, 'ACTIVE', '2022/07/10 12:59:33');

-- --------------------------------------------------------

--
-- Table structure for table `bank_admin`
--

CREATE TABLE `bank_admin` (
  `id` int(11) NOT NULL,
  `fname` varchar(256) NOT NULL,
  `lname` varchar(256) NOT NULL,
  `email` varchar(256) NOT NULL,
  `phone` varchar(256) NOT NULL,
  `address` varchar(256) NOT NULL,
  `password` varchar(256) NOT NULL,
  `status` varchar(256) NOT NULL DEFAULT 'ACTIVE',
  `c_date` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bank_admin`
--

INSERT INTO `bank_admin` (`id`, `fname`, `lname`, `email`, `phone`, `address`, `password`, `status`, `c_date`) VALUES
(1, 'Ezpk', 'Ezechiel', 'ezechielkalengya@gmail.com', '250784700763', 'Gisozi/Kibanza', 'ezechiel', 'ACTIVE', '2022-06-26 17:20:55'),
(4, 'Eloge', 'Kalengya', 'eloge@gmail.com', '+250794700764', 'Kigali', 'Eloge@2020', 'ACTIVE', '2022/07/10 12:32:04'),
(5, 'Esther', 'Muyisa ', 'estherkatungumuyisa7@gmail.com', '+250784700764', '+250784700764', 'Esther@2020', 'ACTIVE', '2022/07/10 12:36:44');

-- --------------------------------------------------------

--
-- Table structure for table `bank_customers_accounts`
--

CREATE TABLE `bank_customers_accounts` (
  `id` int(11) NOT NULL,
  `account_number` varchar(256) NOT NULL,
  `account_holder` varchar(256) NOT NULL,
  `account_type` varchar(256) NOT NULL,
  `account_order_number` int(11) NOT NULL DEFAULT 1,
  `account_email` varchar(256) NOT NULL DEFAULT '',
  `account_telephone` varchar(256) NOT NULL DEFAULT '',
  `account_balance` double NOT NULL DEFAULT 0,
  `creation_datetime` varchar(256) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bank_customers_accounts`
--

INSERT INTO `bank_customers_accounts` (`id`, `account_number`, `account_holder`, `account_type`, `account_order_number`, `account_email`, `account_telephone`, `account_balance`, `creation_datetime`) VALUES
(1, '4.0080904040408212E18', 'Ezechiel Kalengya', 'Current', 1, 'ezechielkalengya@gmail.com', '+250784700764', 0, '2022/07/10 08:30:27'),
(2, '40080904040400', 'Ezechiel Kalengya', 'Saving', 1, 'ezechielkalengya@gmail.com', '+250784700764', 1050, '2022/07/10 08:38:08'),
(3, '40080904040400234', 'Eloge Kalangya', 'Current', 2, 'elogekalengya@gmail.com', '+25078654567800', 0, '2022/07/10 09:50:43'),
(4, '40080904040400123', 'Erick Mathieux', 'Current', 2, 'eric@gmail.com', '078765456789', 0, '2022/07/10 09:59:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bank_account_transaction_cashin`
--
ALTER TABLE `bank_account_transaction_cashin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_account_transaction_cashout`
--
ALTER TABLE `bank_account_transaction_cashout`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_admin`
--
ALTER TABLE `bank_admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_customers_accounts`
--
ALTER TABLE `bank_customers_accounts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bank_account_transaction_cashin`
--
ALTER TABLE `bank_account_transaction_cashin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `bank_account_transaction_cashout`
--
ALTER TABLE `bank_account_transaction_cashout`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `bank_admin`
--
ALTER TABLE `bank_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bank_customers_accounts`
--
ALTER TABLE `bank_customers_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
