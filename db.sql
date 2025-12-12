-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           12.0.2-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para dblivraria
CREATE DATABASE IF NOT EXISTS `dblivraria` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `dblivraria`;

-- Copiando estrutura para tabela dblivraria.avaliacoes
CREATE TABLE IF NOT EXISTS `avaliacoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `livro_id` int(11) NOT NULL,
  `nota` decimal(2,1) DEFAULT NULL CHECK (`nota` >= 0 and `nota` <= 5),
  `comentario` text DEFAULT NULL,
  `data_avaliacao` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `livro_id` (`livro_id`),
  CONSTRAINT `avaliacoes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`) ON DELETE CASCADE,
  CONSTRAINT `avaliacoes_ibfk_2` FOREIGN KEY (`livro_id`) REFERENCES `livros` (`livro_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela dblivraria.avaliacoes: ~4 rows (aproximadamente)
INSERT INTO `avaliacoes` (`id`, `usuario_id`, `livro_id`, `nota`, `comentario`, `data_avaliacao`) VALUES
	(3, 3, 2, 4.0, 'Excelente abordagem sobre tecnologia e negócios.', '2025-11-04 11:55:34'),
	(4, 1, 4, 5.0, 'Leitura obrigatória para todo desenvolvedor.', '2025-11-04 11:55:34'),
	(5, 2, 3, 3.5, 'Ideia interessante, mas um pouco confusa em alguns trechos.', '2025-11-04 11:55:34'),
	(6, 3, 5, 4.8, 'Um clássico atemporal, narrativa impecável.', '2025-11-04 11:55:34');

-- Copiando estrutura para tabela dblivraria.favoritos
CREATE TABLE IF NOT EXISTS `favoritos` (
  `favorito_id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `livro_id` int(11) NOT NULL,
  `data_favoritado` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`favorito_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `livro_id` (`livro_id`),
  CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`) ON DELETE CASCADE,
  CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`livro_id`) REFERENCES `livros` (`livro_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela dblivraria.favoritos: ~2 rows (aproximadamente)
INSERT INTO `favoritos` (`favorito_id`, `usuario_id`, `livro_id`, `data_favoritado`) VALUES
	(2, 1, 4, '2025-11-12 14:03:16');

-- Copiando estrutura para tabela dblivraria.livros
CREATE TABLE IF NOT EXISTS `livros` (
  `livro_id` int(11) NOT NULL DEFAULT 0,
  `titulo` varchar(255) DEFAULT NULL,
  `autor` varchar(255) DEFAULT NULL,
  `disponivel` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`livro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela dblivraria.livros: ~5 rows (aproximadamente)
INSERT INTO `livros` (`livro_id`, `titulo`, `autor`, `disponivel`) VALUES
	(0, 'Dom Casmurro', 'Machado de Assis', 1),
	(2, 'python para espertinhos', 'não sei oq colocar', 5),
	(3, 'c# para malditos', 'henrique cuidador de porco', 3),
	(4, 'como ler livros O livro', 'thayna adotadora de gato', 15),
	(5, 'como aprender a ler livros 2 o inimigo agora é outro', 'thayna adotadora de gato', 15);

-- Copiando estrutura para tabela dblivraria.reservas
CREATE TABLE IF NOT EXISTS `reservas` (
  `reserva_id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `livro_id` int(11) NOT NULL,
  `data_retirada` date NOT NULL,
  `data_devolucao` date NOT NULL,
  `confirmado_email` tinyint(1) DEFAULT 0,
  `criado_em` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`reserva_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `livro_id` (`livro_id`),
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`) ON DELETE CASCADE,
  CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`livro_id`) REFERENCES `livros` (`livro_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela dblivraria.reservas: ~2 rows (aproximadamente)
INSERT INTO `reservas` (`reserva_id`, `usuario_id`, `livro_id`, `data_retirada`, `data_devolucao`, `confirmado_email`, `criado_em`) VALUES
	(2, 2, 4, '2025-10-28', '2025-11-10', 0, '2025-11-12 13:50:08');

-- Copiando estrutura para tabela dblivraria.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `usuario_id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(100) NOT NULL,
  PRIMARY KEY (`usuario_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela dblivraria.usuarios: ~9 rows (aproximadamente)
INSERT INTO `usuarios` (`usuario_id`, `nome`, `email`, `senha`) VALUES
	(1, 'Vitor Lima', 'vitor.lima@email.com', '1234'),
	(2, 'Pedro Campos', 'pedro.campos@email.com', 'abcd'),
	(3, 'Pedro Gabriel', 'pedro.gabriel@email.com', 'senha123'),
	(4, 'Davi Guedes', 'davi.guedes@email.com', 'teste123'),
	(5, 'Matheus Lima', 'matheus.lima@email.com', '3210'),
	(6, 'bla', 'blabla@gmail.com', '123'),
	(7, 'bli', 'blibli@gmail.com', '456'),
	(8, 'vava', 'vava@gmail.com', '789'),
	(9, 'mimi', 'mi@gmail.com', '123'),
	(10, 'jiji', 'ji@gmail.com', '741');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
