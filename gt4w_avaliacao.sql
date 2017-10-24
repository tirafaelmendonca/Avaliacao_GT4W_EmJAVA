-- phpMyAdmin SQL Dump
-- version 4.5.3.1
-- http://www.phpmyadmin.net
--
-- Host: 186.202.152.237
-- Generation Time: 22-Out-2017 às 23:27
-- Versão do servidor: 5.6.35-81.0-log
-- PHP Version: 5.6.30-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gt4w_avaliacao`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `pessoa`
--

CREATE TABLE `pessoa` (
  `cod_pes` int(8) NOT NULL,
  `nome_pes` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `cpf_pes` varchar(11) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `data_pes` date NOT NULL,
  `peso_pes` int(6) NOT NULL,
  `uf_pes` varchar(30) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Extraindo dados da tabela `pessoa`
--

INSERT INTO `pessoa` (`cod_pes`, `nome_pes`, `cpf_pes`, `data_pes`, `peso_pes`, `uf_pes`) VALUES
(155, 'Rafael Ferreira MendonÃ§a', '07449235650', '1989-03-01', 96000, '08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pessoa`
--
ALTER TABLE `pessoa`
  ADD PRIMARY KEY (`cod_pes`),
  ADD UNIQUE KEY `cpf_pes` (`cpf_pes`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pessoa`
--
ALTER TABLE `pessoa`
  MODIFY `cod_pes` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
