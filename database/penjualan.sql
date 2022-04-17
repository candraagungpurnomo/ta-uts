-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 30, 2022 at 10:57 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penjualan`
--

-- --------------------------------------------------------

--
-- Table structure for table `agen`
--

CREATE TABLE `agen` (
  `id_agen` int(5) NOT NULL,
  `nama_agen` varchar(30) NOT NULL,
  `alamat` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `agen`
--

INSERT INTO `agen` (`id_agen`, `nama_agen`, `alamat`) VALUES
(1, 'Ayamku 1', 'dinus');

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `kd_brg` varchar(6) NOT NULL,
  `nm_brg` varchar(30) NOT NULL,
  `satuan` varchar(10) NOT NULL,
  `harga` double NOT NULL,
  `harga_beli` double NOT NULL,
  `stok` int(5) NOT NULL,
  `stok_min` int(5) NOT NULL,
  `gambar` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`kd_brg`, `nm_brg`, `satuan`, `harga`, `harga_beli`, `stok`, `stok_min`, `gambar`) VALUES
('B-0001', 'Ayam Guring', 'buah', 7000, 6500, 100, 1, NULL),
('B-0002', 'Roti', 'Buah', 1000, 1100, 100, 2, NULL),
('K003', 'Ayam Geprek', '1', 9000, 8000, 12, 8, NULL),
('K005', 'Nasi Goreng', '2', 9000, 6000, 10, 5, 'nasigoreng.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `djual`
--

CREATE TABLE `djual` (
  `no_nota` int(11) NOT NULL,
  `kd_brg` char(6) NOT NULL,
  `hrg_brg` double DEFAULT NULL,
  `jml_brg` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `djual`
--

INSERT INTO `djual` (`no_nota`, `kd_brg`, `hrg_brg`, `jml_brg`) VALUES
(1, 'B-0001', 7000, 5);

-- --------------------------------------------------------

--
-- Table structure for table `jual`
--

CREATE TABLE `jual` (
  `no_nota` int(11) NOT NULL,
  `id_agen` int(5) NOT NULL,
  `tgl_jual` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jual`
--

INSERT INTO `jual` (`no_nota`, `id_agen`, `tgl_jual`) VALUES
(1, 1, '2019-05-08 14:44:09');

-- --------------------------------------------------------

--
-- Table structure for table `kota`
--

CREATE TABLE `kota` (
  `id` int(11) NOT NULL,
  `kota` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kota`
--

INSERT INTO `kota` (`id`, `kota`) VALUES
(1, 'Semarang'),
(2, 'Demak'),
(3, 'Kendal'),
(4, 'Kudus'),
(5, 'Ungaran'),
(6, 'Jeporo');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `productid` int(11) NOT NULL,
  `pname` varchar(30) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productid`, `pname`, `price`) VALUES
(1, 'jagung', '1000.00'),
(2, 'jagung', '1000.00');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(4) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `name` varchar(30) NOT NULL,
  `password` varchar(32) NOT NULL,
  `hak_akses` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `user_id`, `name`, `password`, `hak_akses`) VALUES
(1, 'admin', 'paijo', '21232f297a57a5a743894a0e4a801fc3', 0);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vjual`
-- (See below for the actual view)
--
CREATE TABLE `vjual` (
`no_nota` int(11)
,`tgl_jual` datetime
,`id_agen` int(5)
,`nama_agen` varchar(30)
,`kd_brg` char(6)
,`nm_brg` varchar(30)
,`hrg_brg` double
,`jml_brg` int(5)
,`totjual` double
);

-- --------------------------------------------------------

--
-- Structure for view `vjual`
--
DROP TABLE IF EXISTS `vjual`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vjual`  AS   (select `d`.`no_nota` AS `no_nota`,`j`.`tgl_jual` AS `tgl_jual`,`j`.`id_agen` AS `id_agen`,`a`.`nama_agen` AS `nama_agen`,`d`.`kd_brg` AS `kd_brg`,`b`.`nm_brg` AS `nm_brg`,`d`.`hrg_brg` AS `hrg_brg`,`d`.`jml_brg` AS `jml_brg`,`d`.`hrg_brg` * `d`.`jml_brg` AS `totjual` from (((`djual` `d` join `jual` `j`) join `agen` `a`) join `barang` `b`) where `d`.`no_nota` = `j`.`no_nota` and `d`.`kd_brg` = `b`.`kd_brg` and `j`.`id_agen` = `a`.`id_agen`)  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agen`
--
ALTER TABLE `agen`
  ADD PRIMARY KEY (`id_agen`);

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`kd_brg`);

--
-- Indexes for table `djual`
--
ALTER TABLE `djual`
  ADD PRIMARY KEY (`no_nota`,`kd_brg`),
  ADD KEY `FK_djual` (`kd_brg`);

--
-- Indexes for table `jual`
--
ALTER TABLE `jual`
  ADD PRIMARY KEY (`no_nota`),
  ADD KEY `FK_jual2` (`id_agen`);

--
-- Indexes for table `kota`
--
ALTER TABLE `kota`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`productid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agen`
--
ALTER TABLE `agen`
  MODIFY `id_agen` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `kota`
--
ALTER TABLE `kota`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `productid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `djual`
--
ALTER TABLE `djual`
  ADD CONSTRAINT `FK_djual` FOREIGN KEY (`kd_brg`) REFERENCES `barang` (`kd_brg`),
  ADD CONSTRAINT `FK_djual1` FOREIGN KEY (`no_nota`) REFERENCES `jual` (`no_nota`);

--
-- Constraints for table `jual`
--
ALTER TABLE `jual`
  ADD CONSTRAINT `FK_jual2` FOREIGN KEY (`id_agen`) REFERENCES `agen` (`id_agen`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
