-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 13/11/2024 às 00:55
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
(1, 'Carlos Silva', '2024001'),
(2, 'Maria Oliveira', '2024002'),
(3, 'João Santos', '2024003'),
(4, 'Ana Pereira', '2024004'),
(6, 'Pedro', '	 2024006'),
(12, 'thiago', ' 2024005');

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
(1, 1, 1, 8.50, '1º Semestre'),
(2, 1, 2, 7.00, '1º Semestre'),
(3, 1, 3, 9.00, '1º Semestre'),
(4, 1, 4, 6.50, '1º Semestre'),
(5, 1, 5, 8.00, '1º Semestre'),
(6, 2, 1, 7.50, '1º Semestre'),
(7, 2, 2, 8.00, '1º Semestre'),
(8, 2, 3, 7.50, '1º Semestre'),
(9, 2, 4, 9.00, '1º Semestre'),
(10, 2, 5, 6.50, '1º Semestre'),
(11, 3, 1, 9.00, '1º Semestre'),
(12, 3, 2, 8.50, '1º Semestre'),
(13, 3, 3, 9.50, '1º Semestre'),
(14, 3, 4, 7.00, '1º Semestre'),
(15, 3, 5, 7.50, '1º Semestre'),
(16, 4, 1, 7.60, '1º Semestre'),
(17, 4, 2, 10.00, '1º Semestre'),
(18, 4, 3, 10.00, '1º Semestre'),
(19, 4, 4, 10.00, '1º Semestre'),
(20, 4, 5, 10.00, '1º Semestre'),
(26, 6, 1, 10.00, NULL),
(27, 6, 2, 10.00, NULL),
(28, 6, 3, 10.00, NULL),
(29, 6, 4, 10.00, NULL),
(30, 6, 5, 10.00, NULL),
(56, 12, 1, 10.00, NULL),
(57, 12, 2, 10.00, NULL),
(58, 12, 3, 10.00, NULL),
(59, 12, 4, 10.00, NULL),
(60, 12, 5, 10.00, NULL);

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
  MODIFY `id_aluno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  MODIFY `id_disciplina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `notas`
--
ALTER TABLE `notas`
  MODIFY `id_nota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

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
