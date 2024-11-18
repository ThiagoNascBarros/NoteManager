-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 18/11/2024 às 23:30
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `notemanager`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `alunos`
--

CREATE TABLE `alunos` (
  `id_aluno` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `matricula` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `alunos`
--

INSERT INTO `alunos` (`id_aluno`, `nome`, `matricula`) VALUES
(28, 'joao', ' 2024006'),
(29, 'Thiago', ' 2024008'),
(30, 'jose', ' 2024011'),
(31, 'Mauricio', ' 2024012'),
(32, 'Isabela', ' 2024013'),
(33, 'Isabelle', ' 2024014'),
(34, 'Vitor Aldivan', ' 2024015'),
(35, 'Nicole', ' 2024016'),
(36, 'Sabrina', ' 2024017'),
(37, 'Felipe', ' 2024018'),
(40, 'Pedro', ' 2024002');

-- --------------------------------------------------------

--
-- Estrutura para tabela `disciplinas`
--

CREATE TABLE `disciplinas` (
  `id_disciplina` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `disciplinas`
--

INSERT INTO `disciplinas` (`id_disciplina`, `nome`) VALUES
(1, 'Português'),
(2, 'Matemática'),
(3, 'Geografia'),
(4, 'História'),
(5, 'Ciências');

-- --------------------------------------------------------

--
-- Estrutura para tabela `notas`
--

CREATE TABLE `notas` (
  `id_nota` int(11) NOT NULL,
  `id_aluno` int(11) DEFAULT NULL,
  `id_disciplina` int(11) DEFAULT NULL,
  `nota` decimal(5,2) DEFAULT NULL,
  `periodo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `notas`
--

INSERT INTO `notas` (`id_nota`, `id_aluno`, `id_disciplina`, `nota`, `periodo`) VALUES
(136, 28, 1, 9.00, '1º Semestre'),
(137, 28, 2, 10.00, '1º Semestre'),
(138, 28, 3, 10.00, '1º Semestre'),
(139, 28, 4, 9.50, '1º Semestre'),
(140, 28, 5, 9.50, '1º Semestre'),
(141, 29, 1, 9.50, '1º Semestre'),
(142, 29, 2, 9.50, '1º Semestre'),
(143, 29, 3, 9.50, '1º Semestre'),
(144, 29, 4, 9.50, '1º Semestre'),
(145, 29, 5, 9.50, '1º Semestre'),
(146, 30, 1, 8.00, '1º Semestre'),
(147, 30, 2, 8.00, '1º Semestre'),
(148, 30, 3, 8.00, '1º Semestre'),
(149, 30, 4, 8.00, '1º Semestre'),
(150, 30, 5, 8.00, '1º Semestre'),
(151, 31, 1, 7.00, '1º Semestre'),
(152, 31, 2, 8.00, '1º Semestre'),
(153, 31, 3, 8.00, '1º Semestre'),
(154, 31, 4, 8.00, '1º Semestre'),
(155, 31, 5, 8.00, '1º Semestre'),
(156, 32, 1, 7.00, '1º Semestre'),
(157, 32, 2, 8.00, '1º Semestre'),
(158, 32, 3, 8.00, '1º Semestre'),
(159, 32, 4, 8.00, '1º Semestre'),
(160, 32, 5, 8.00, '1º Semestre'),
(161, 33, 1, 7.00, '1º Semestre'),
(162, 33, 2, 8.00, '1º Semestre'),
(163, 33, 3, 8.00, '1º Semestre'),
(164, 33, 4, 8.00, '1º Semestre'),
(165, 33, 5, 8.00, '1º Semestre'),
(166, 34, 1, 7.00, '1º Semestre'),
(167, 34, 2, 7.00, '1º Semestre'),
(168, 34, 3, 7.00, '1º Semestre'),
(169, 34, 4, 7.00, '1º Semestre'),
(170, 34, 5, 7.00, '1º Semestre'),
(171, 35, 1, 7.00, '1º Semestre'),
(172, 35, 2, 7.00, '1º Semestre'),
(173, 35, 3, 7.00, '1º Semestre'),
(174, 35, 4, 7.00, '1º Semestre'),
(175, 35, 5, 7.00, '1º Semestre'),
(176, 36, 1, 7.00, '1º Semestre'),
(177, 36, 2, 7.00, '1º Semestre'),
(178, 36, 3, 7.00, '1º Semestre'),
(179, 36, 4, 7.00, '1º Semestre'),
(180, 36, 5, 7.00, '1º Semestre'),
(181, 37, 1, 7.00, '1º Semestre'),
(182, 37, 2, 7.00, '1º Semestre'),
(183, 37, 3, 7.00, '1º Semestre'),
(184, 37, 4, 7.00, '1º Semestre'),
(185, 37, 5, 7.00, '1º Semestre'),
(196, 40, 1, 9.00, '1º Semestre'),
(197, 40, 2, 9.00, '1º Semestre'),
(198, 40, 3, 9.00, '1º Semestre'),
(199, 40, 4, 7.00, '1º Semestre'),
(200, 40, 5, 7.00, '1º Semestre');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `alunos`
--
ALTER TABLE `alunos`
  ADD PRIMARY KEY (`id_aluno`);

--
-- Índices de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  ADD PRIMARY KEY (`id_disciplina`);

--
-- Índices de tabela `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`id_nota`),
  ADD KEY `id_aluno` (`id_aluno`),
  ADD KEY `id_disciplina` (`id_disciplina`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alunos`
--
ALTER TABLE `alunos`
  MODIFY `id_aluno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  MODIFY `id_disciplina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `notas`
--
ALTER TABLE `notas`
  MODIFY `id_nota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=246;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`id_aluno`) REFERENCES `alunos` (`id_aluno`),
  ADD CONSTRAINT `notas_ibfk_2` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
