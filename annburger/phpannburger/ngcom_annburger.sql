-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 13, 2022 at 02:40 PM
-- Server version: 10.3.32-MariaDB-cll-lve
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ngcom_annburger`
--

-- --------------------------------------------------------

--
-- Table structure for table `register_user`
--

CREATE TABLE `register_user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_password` varchar(40) NOT NULL,
  `user_regdate` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `user_otp` int(5) NOT NULL,
  `user_type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `register_user`
--

INSERT INTO `register_user` (`user_id`, `user_name`, `user_email`, `user_password`, `user_regdate`, `user_otp`, `user_type`) VALUES
(1, 'NG Ken', 'ng.ken.7503@gmail.com', 'f0073fa243057e7fb31fa57a7310ec6b08bd467b', '2021-12-04 09:08:35.094453', 26587, 'admin'),
(5, 'Ken', 'ng.kerong@gmail.com', '29f07e29799443aa8a97b0a7ad013560806876e6', '2021-12-04 13:57:37.502971', 31414, 'user'),
(7, 'NG KE RONG', 'ng.ken.7503@hotmail.com', 'f0073fa243057e7fb31fa57a7310ec6b08bd467b', '2021-12-05 10:15:23.978191', 41544, 'user'),
(8, 'Ng106121', 'ng.ken.2468@gmail.com', 'f0073fa243057e7fb31fa57a7310ec6b08bd467b', '2022-01-24 15:37:52.888991', 89728, 'user'),
(9, 'Superman', 'superman123.@hotmail.com', '3a28649e7fccb26243f451036057453ff723aa00', '2022-02-07 21:25:02.172279', 77806, 'user'),
(12, 'Batman', 'ng.ken.7503@gmail.com', '9cc9ad303fa63a6fa0ebbb0939b18064fab0acbc', '2022-02-11 14:11:49.323401', 66050, 'user'),
(13, 'Ketok', 'ketok34784@chatich.com', '46c0efdb66c3832e340dff9af02243253febd1ee', '2022-02-13 09:40:05.117647', 22694, 'user'),
(14, 'Ng Ke Rong', 'ng.ken.7503@gamil.com', '29f07e29799443aa8a97b0a7ad013560806876e6', '2022-02-13 13:30:39.144514', 68206, 'user'),
(15, 'Ketok1234', 'ketok34784@chatich.com', '46c0efdb66c3832e340dff9af02243253febd1ee', '2022-02-13 13:37:11.417122', 31285, 'user'),
(16, 'Pak Cik Ann', 'annburger@ng271063.com', '35f5e053ec20ec3b741408c670768e4ff05ab1c2', '2022-02-13 13:52:59.774363', 46843, 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order`
--

CREATE TABLE `tbl_order` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `user_email` varchar(30) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(30) NOT NULL,
  `product_qty` int(11) NOT NULL,
  `total_price` double NOT NULL,
  `payment_confirm` varchar(10) NOT NULL,
  `order_confirm` varchar(10) NOT NULL,
  `order_date` datetime(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_order`
--

INSERT INTO `tbl_order` (`order_id`, `user_id`, `user_name`, `user_email`, `product_id`, `product_name`, `product_qty`, `total_price`, `payment_confirm`, `order_confirm`, `order_date`) VALUES
(1, 9, 'Superman', 'superman123.@hotmail.com', 1, 'Burger', 1, 3, 'Done', 'None', '2022-02-12 19:09:16.417126'),
(4, 9, 'Superman', 'superman123.@hotmail.com', 4, 'Hotdog', 3, 6, 'Done', 'None', '2022-02-12 19:09:16.417126'),
(6, 9, 'Superman', 'superman123.@hotmail.com', 3, 'Beef Burger', 1, 4, 'Done', 'Done', '2022-02-13 00:16:00.062800'),
(9, 13, 'Ketok', 'ketok34784@chatich.com', 4, 'Spicy Hotdog', 3, 6, 'Done', 'None', '2022-02-13 09:42:53.842649'),
(11, 9, 'Superman', 'superman123.@hotmail.com', 2, 'Royal Chicken Burger', 3, 21, 'Done', 'Done', '2022-02-13 13:45:31.591138'),
(12, 9, 'Superman', 'superman123.@hotmail.com', 4, 'Spicy Hotdog', 2, 4, 'Done', 'None', '2022-02-13 12:48:57.632483'),
(13, 13, 'Ketok', 'ketok34784@chatich.com', 1, 'Burger', 2, 6, 'Done', 'None', '2022-02-13 13:42:10.431486'),
(14, 13, 'Ketok', 'ketok34784@chatich.com', 4, 'Spicy Hotdog', 3, 6, 'Done', 'None', '2022-02-13 13:42:10.431486');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_product`
--

CREATE TABLE `tbl_product` (
  `Product_ID` int(11) NOT NULL,
  `Product_Name` varchar(30) NOT NULL,
  `Product_Price` double NOT NULL,
  `Product_Detail` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_product`
--

INSERT INTO `tbl_product` (`Product_ID`, `Product_Name`, `Product_Price`, `Product_Detail`) VALUES
(1, 'Burger', 3, '1 piece patty and 1 slice lecture'),
(2, 'Royal Chicken Burger', 7, '1 piece crispy chicken patty, I slice lecture, 1 slice tomato and secret recipe sauce.'),
(3, 'Beef Burger', 4, '1 piece beef patty, 1 slice lecture and BBQ sauce.'),
(4, 'Spicy Hotdog', 2, '1 hotdog'),
(5, 'Royal Hotdog', 5, '1 slice lamb hotdog and secret recipe sauce'),
(7, 'Chicken patty', 1, 'Only patty');

-- --------------------------------------------------------

--
-- Table structure for table `user_order`
--

CREATE TABLE `user_order` (
  `order_no` int(11) NOT NULL,
  `user_email` varchar(30) NOT NULL,
  `amount` double NOT NULL,
  `date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_order`
--

INSERT INTO `user_order` (`order_no`, `user_email`, `amount`, `date`) VALUES
(10, 'superman123.@hotmail.com', 13, '2022-02-12 19:09:16.416243'),
(11, 'ketok34784@chatich.com', 6, '2022-02-13 09:42:53.841457'),
(12, 'superman123.@hotmail.com', 25, '2022-02-13 12:48:57.630255'),
(13, 'ketok34784@chatich.com', 12, '2022-02-13 13:42:10.427937');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `register_user`
--
ALTER TABLE `register_user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `tbl_order`
--
ALTER TABLE `tbl_order`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `tbl_product`
--
ALTER TABLE `tbl_product`
  ADD PRIMARY KEY (`Product_ID`);

--
-- Indexes for table `user_order`
--
ALTER TABLE `user_order`
  ADD PRIMARY KEY (`order_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `register_user`
--
ALTER TABLE `register_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tbl_order`
--
ALTER TABLE `tbl_order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tbl_product`
--
ALTER TABLE `tbl_product`
  MODIFY `Product_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_order`
--
ALTER TABLE `user_order`
  MODIFY `order_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
