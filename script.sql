-- MySQL Script generated by MySQL Workbench
-- Sat Jul  2 17:01:58 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categorias` (
  `cod_categoria` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`livros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`livros` (
  `isbn` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `ano_lancamento` DATE NOT NULL,
  `editora` VARCHAR(100) NOT NULL,
  `qtd_copias` INT NOT NULL,
  `categorias_cod_categoria` INT NOT NULL,
  PRIMARY KEY (`isbn`),
  INDEX `fk_livros_categorias1_idx` (`categorias_cod_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_livros_categorias1`
    FOREIGN KEY (`categorias_cod_categoria`)
    REFERENCES `mydb`.`categorias` (`cod_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`autores` (
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `nacionalidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`livros_has_autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`livros_has_autores` (
  `livros_isbn` INT NOT NULL,
  `autores_email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`livros_isbn`, `autores_email`),
  INDEX `fk_livros_has_autores_autores1_idx` (`autores_email` ASC) VISIBLE,
  INDEX `fk_livros_has_autores_livros_idx` (`livros_isbn` ASC) VISIBLE,
  CONSTRAINT `fk_livros_has_autores_livros`
    FOREIGN KEY (`livros_isbn`)
    REFERENCES `mydb`.`livros` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_livros_has_autores_autores1`
    FOREIGN KEY (`autores_email`)
    REFERENCES `mydb`.`autores` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  `login` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(32) NOT NULL,
  `tipo_usuario` ENUM('Administrador', 'Bibliotecário', 'Usuário') NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cursos` (
  `cod_curso` INT NOT NULL,
  `nome_curso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_curso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usr_level1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usr_level1` (
  `usuarios_id` INT NOT NULL,
  INDEX `fk_usr_level1_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  PRIMARY KEY (`usuarios_id`),
  CONSTRAINT `fk_usr_level1_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alunos` (
  `matricula` INT NOT NULL,
  `data_de_ingresso` DATETIME NOT NULL,
  `data_de_conclusao_prevista` DATETIME NOT NULL,
  `cursos_cod_curso` INT NOT NULL,
  `usr_level1_usuarios_id` INT NOT NULL,
  PRIMARY KEY (`matricula`),
  INDEX `fk_alunos_cursos1_idx` (`cursos_cod_curso` ASC) VISIBLE,
  INDEX `fk_alunos_usr_level11_idx` (`usr_level1_usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_alunos_cursos1`
    FOREIGN KEY (`cursos_cod_curso`)
    REFERENCES `mydb`.`cursos` (`cod_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alunos_usr_level11`
    FOREIGN KEY (`usr_level1_usuarios_id`)
    REFERENCES `mydb`.`usr_level1` (`usuarios_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`professores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`professores` (
  `mat_siape` INT NOT NULL,
  `regime_trabalho` ENUM('20h', '40h', 'DE') NOT NULL,
  `telefone_celular` VARCHAR(11) NOT NULL,
  `data_contratacao` DATETIME NULL,
  `cursos_cod_curso` INT NOT NULL,
  `usr_level1_usuarios_id` INT NOT NULL,
  PRIMARY KEY (`mat_siape`),
  INDEX `fk_professores_cursos1_idx` (`cursos_cod_curso` ASC) VISIBLE,
  INDEX `fk_professores_usr_level11_idx` (`usr_level1_usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_professores_cursos1`
    FOREIGN KEY (`cursos_cod_curso`)
    REFERENCES `mydb`.`cursos` (`cod_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professores_usr_level11`
    FOREIGN KEY (`usr_level1_usuarios_id`)
    REFERENCES `mydb`.`usr_level1` (`usuarios_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`funcionarios` (
  `matricula` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`matricula`),
  INDEX `fk_funcionarios_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_funcionarios_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telefones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefones` (
  `telefone` VARCHAR(11) NOT NULL,
  `funcionarios_matricula` INT NOT NULL,
  INDEX `fk_telefones_funcionarios1_idx` (`funcionarios_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_telefones_funcionarios1`
    FOREIGN KEY (`funcionarios_matricula`)
    REFERENCES `mydb`.`funcionarios` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios_reserva_livros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios_reserva_livros` (
  `usuarios_id` INT NOT NULL,
  `livros_isbn` INT NOT NULL,
  `data_reserva` DATE NOT NULL,
  `data_devolucao` DATE NULL,
  PRIMARY KEY (`usuarios_id`, `livros_isbn`),
  INDEX `fk_usuarios_has_livros_livros1_idx` (`livros_isbn` ASC) VISIBLE,
  INDEX `fk_usuarios_has_livros_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_has_livros_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_has_livros_livros1`
    FOREIGN KEY (`livros_isbn`)
    REFERENCES `mydb`.`livros` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telefones_alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefones_alunos` (
  `alunos_matricula` INT NOT NULL,
  `telefone_aluno` VARCHAR(45) NOT NULL,
  INDEX `fk_telefones_alunos_alunos1_idx` (`alunos_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_telefones_alunos_alunos1`
    FOREIGN KEY (`alunos_matricula`)
    REFERENCES `mydb`.`alunos` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`viewLivros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`viewLivros` (`titulo` INT, `ano_lancamento` INT, `editora` INT, `descricao` INT, `nome` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`viewProfessor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`viewProfessor` (`usr_level1_usuarios_id` INT, `id` INT, `nome` INT, `nome_curso` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`viewReservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`viewReservas` (`titulo` INT, `isbn` INT, `nome` INT, `data_reserva` INT, `data_devolucao` INT);

-- -----------------------------------------------------
-- View `mydb`.`viewLivros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`viewLivros`;
USE `mydb`;
CREATE  OR REPLACE VIEW `viewLivros` AS
    SELECT 
        l.titulo, l.ano_lancamento, l.editora, c.descricao, a.nome
    FROM
        livros l
            JOIN
        categorias c ON l.categorias_cod_categoria = c.cod_categoria
            JOIN
        livros_has_autores lha ON lha.livros_isbn = l.isbn
            JOIN
        autores a ON lha.autores_email = a.email
    ORDER BY c.cod_categoria , l.editora , l.ano_lancamento , a.nome;

-- -----------------------------------------------------
-- View `mydb`.`viewProfessor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`viewProfessor`;
USE `mydb`;
CREATE  OR REPLACE VIEW `viewProfessor` AS
    SELECT 
        p.usr_level1_usuarios_id, u.id, u.nome, c.nome_curso
    FROM
        professores p
            JOIN
        usuarios u ON u.id = p.usr_level1_usuarios_id
            JOIN
        cursos c ON p.cursos_cod_curso = c.cod_curso
    ORDER BY c.nome_curso;

-- -----------------------------------------------------
-- View `mydb`.`viewReservas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`viewReservas`;
USE `mydb`;
CREATE  OR REPLACE VIEW `viewReservas` AS
    SELECT 
        l.titulo, l.isbn, u.nome, ur.data_reserva, ur.data_devolucao
    FROM
        livros l
            JOIN
        usuarios_reserva_livros ur ON l.isbn = ur.livros_isbn
            JOIN
        usuarios u ON ur.usuarios_id = u.id;
USE `mydb`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`alunos_BEFORE_INSERT` BEFORE INSERT ON `alunos` FOR EACH ROW
BEGIN
	if(new.data_de_conclusao_prevista > current_timestamp())
		then 
		insert into 
			alunos(matricula, data_de_ingresso, data_de_conclusao_prevista, cursos_cod_curso, usr_level1_usuarios_id) 
			values(new.matricula, new.data_de_ingresso, new.data_de_conclusao_prevista, new.cursos_cod_curso, new.usr_level1_usuarios_id); 
    end if;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`categorias`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`categorias` (`cod_categoria`, `descricao`) VALUES (1, 'Livros para a disciplina de cálculo.');
INSERT INTO `mydb`.`categorias` (`cod_categoria`, `descricao`) VALUES (2, 'Livros para a disciplina de física.');
INSERT INTO `mydb`.`categorias` (`cod_categoria`, `descricao`) VALUES (3, 'Livros para programação.');
INSERT INTO `mydb`.`categorias` (`cod_categoria`, `descricao`) VALUES (4, 'Livros para a disciplina de redes.');
INSERT INTO `mydb`.`categorias` (`cod_categoria`, `descricao`) VALUES (5, 'Livros para a disciplina de dev web.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`livros`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`livros` (`isbn`, `titulo`, `ano_lancamento`, `editora`, `qtd_copias`, `categorias_cod_categoria`) VALUES (1, 'Cálculo Vol1', '2022-06-27', 'trilha', 20, 1);
INSERT INTO `mydb`.`livros` (`isbn`, `titulo`, `ano_lancamento`, `editora`, `qtd_copias`, `categorias_cod_categoria`) VALUES (2, 'Física Vol 1', '2022-06-27', 'ltc', 20, 2);
INSERT INTO `mydb`.`livros` (`isbn`, `titulo`, `ano_lancamento`, `editora`, `qtd_copias`, `categorias_cod_categoria`) VALUES (3, 'Padrões de projeto', '2022-06-27', 'bookman', 20, 3);
INSERT INTO `mydb`.`livros` (`isbn`, `titulo`, `ano_lancamento`, `editora`, `qtd_copias`, `categorias_cod_categoria`) VALUES (4, 'Comunicação de dados e redes de computadores', '2022-06-27', 'bookman', 20, 4);
INSERT INTO `mydb`.`livros` (`isbn`, `titulo`, `ano_lancamento`, `editora`, `qtd_copias`, `categorias_cod_categoria`) VALUES (5, 'Criação de Sites na era da Web 2.0', '2022-06-27', 'brasport', 20, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`autores`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`autores` (`nome`, `email`, `nacionalidade`) VALUES ('Halliday', 'livrosDeFisica@email.com', 'Estadunidense');
INSERT INTO `mydb`.`autores` (`nome`, `email`, `nacionalidade`) VALUES ('James Stewart', 'livrosDeCáculo@email.com', 'Indiano');
INSERT INTO `mydb`.`autores` (`nome`, `email`, `nacionalidade`) VALUES ('Ralph Johnson', 'livrosDeProgramação@email.com', 'Estadunidense');
INSERT INTO `mydb`.`autores` (`nome`, `email`, `nacionalidade`) VALUES ('Behrouz A. Forouzan', 'livrosDeRedes.email.com', 'Brasileira');
INSERT INTO `mydb`.`autores` (`nome`, `email`, `nacionalidade`) VALUES ('Diego Brito', 'livrosWeb@email.com', 'Brasileira');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`livros_has_autores`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`livros_has_autores` (`livros_isbn`, `autores_email`) VALUES (1, 'livrosDeFisica@email.com');
INSERT INTO `mydb`.`livros_has_autores` (`livros_isbn`, `autores_email`) VALUES (2, 'livrosDeCáculo@email.com');
INSERT INTO `mydb`.`livros_has_autores` (`livros_isbn`, `autores_email`) VALUES (3, 'livrosDeProgramação@email.com');
INSERT INTO `mydb`.`livros_has_autores` (`livros_isbn`, `autores_email`) VALUES (4, 'livrosDeRedes.email.com');
INSERT INTO `mydb`.`livros_has_autores` (`livros_isbn`, `autores_email`) VALUES (5, 'livrosWeb@email.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`usuarios`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`usuarios` (`id`, `nome`, `endereco`, `login`, `senha`, `tipo_usuario`) VALUES (1, 'Fernando', 'Rua professor', 'fernando@email.exemplo', '25d55ad283aa400af464c76d713c07ad', 'Usuário');
INSERT INTO `mydb`.`usuarios` (`id`, `nome`, `endereco`, `login`, `senha`, `tipo_usuario`) VALUES (2, 'Fischer', 'Rua professor', 'fischer@email.exemplo', '25d55ad283aa400af464c76d713c07ad', 'Usuário');
INSERT INTO `mydb`.`usuarios` (`id`, `nome`, `endereco`, `login`, `senha`, `tipo_usuario`) VALUES (3, 'Marcelo', 'Rua professor', 'marcelo@email.exemplo', '25d55ad283aa400af464c76d713c07ad', 'Usuário');
INSERT INTO `mydb`.`usuarios` (`id`, `nome`, `endereco`, `login`, `senha`, `tipo_usuario`) VALUES (4, 'Erick', 'Rua professor', 'erick@email.exemplo', '25d55ad283aa400af464c76d713c07ad', 'Usuário');
INSERT INTO `mydb`.`usuarios` (`id`, `nome`, `endereco`, `login`, `senha`, `tipo_usuario`) VALUES (5, 'Marcos', 'Rua Aluno', 'marcos@email.exemplo', '25d55ad283aa400af464c76d713c07ad', 'Usuário');
INSERT INTO `mydb`.`usuarios` (`id`, `nome`, `endereco`, `login`, `senha`, `tipo_usuario`) VALUES (6, 'Lucas', 'Rua Aluno', 'lucas@email.exemplo', '25d55ad283aa400af464c76d713c07ad', 'Usuário');
INSERT INTO `mydb`.`usuarios` (`id`, `nome`, `endereco`, `login`, `senha`, `tipo_usuario`) VALUES (7, 'Carlos', 'Rua Aluno', 'carlos@email.exemplo', '25d55ad283aa400af464c76d713c07ad', 'Usuário');
INSERT INTO `mydb`.`usuarios` (`id`, `nome`, `endereco`, `login`, `senha`, `tipo_usuario`) VALUES (8, 'João', 'Rua bibliotecário', 'joao@email.exemplo', '25d55ad283aa400af464c76d713c07ad', 'Bibliotecário');
INSERT INTO `mydb`.`usuarios` (`id`, `nome`, `endereco`, `login`, `senha`, `tipo_usuario`) VALUES (9, 'Maria', 'Rua admin', 'maria@email.exemplo', '25d55ad283aa400af464c76d713c07ad', 'Administrador');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`cursos`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`cursos` (`cod_curso`, `nome_curso`) VALUES (1, 'Engenharia da Computação');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`usr_level1`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`usr_level1` (`usuarios_id`) VALUES (1);
INSERT INTO `mydb`.`usr_level1` (`usuarios_id`) VALUES (2);
INSERT INTO `mydb`.`usr_level1` (`usuarios_id`) VALUES (3);
INSERT INTO `mydb`.`usr_level1` (`usuarios_id`) VALUES (4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`alunos`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`alunos` (`matricula`, `data_de_ingresso`, `data_de_conclusao_prevista`, `cursos_cod_curso`, `usr_level1_usuarios_id`) VALUES (1, '2022-06-27', '2024-06-28', 1, 5);
INSERT INTO `mydb`.`alunos` (`matricula`, `data_de_ingresso`, `data_de_conclusao_prevista`, `cursos_cod_curso`, `usr_level1_usuarios_id`) VALUES (2, '2022-06-27', '2024-06-28', 1, 6);
INSERT INTO `mydb`.`alunos` (`matricula`, `data_de_ingresso`, `data_de_conclusao_prevista`, `cursos_cod_curso`, `usr_level1_usuarios_id`) VALUES (3, '2022-06-27', '2024-06-28', 1, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`professores`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`professores` (`mat_siape`, `regime_trabalho`, `telefone_celular`, `data_contratacao`, `cursos_cod_curso`, `usr_level1_usuarios_id`) VALUES (1, '20h', '00000000000', '2022-06-27', 1, 1);
INSERT INTO `mydb`.`professores` (`mat_siape`, `regime_trabalho`, `telefone_celular`, `data_contratacao`, `cursos_cod_curso`, `usr_level1_usuarios_id`) VALUES (2, '40h', '00000000001', '2022-06-27', 1, 2);
INSERT INTO `mydb`.`professores` (`mat_siape`, `regime_trabalho`, `telefone_celular`, `data_contratacao`, `cursos_cod_curso`, `usr_level1_usuarios_id`) VALUES (3, 'DE', '00000000002', '2022-06-27', 1, 3);
INSERT INTO `mydb`.`professores` (`mat_siape`, `regime_trabalho`, `telefone_celular`, `data_contratacao`, `cursos_cod_curso`, `usr_level1_usuarios_id`) VALUES (4, '40h', '00000000003', '2022-06-27', 1, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`funcionarios`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`funcionarios` (`matricula`, `usuarios_id`) VALUES (1, 8);
INSERT INTO `mydb`.`funcionarios` (`matricula`, `usuarios_id`) VALUES (2, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`telefones`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`telefones` (`telefone`, `funcionarios_matricula`) VALUES ('00000000400', 1);
INSERT INTO `mydb`.`telefones` (`telefone`, `funcionarios_matricula`) VALUES ('00000005400', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`usuarios_reserva_livros`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`usuarios_reserva_livros` (`usuarios_id`, `livros_isbn`, `data_reserva`, `data_devolucao`) VALUES (9, 1, '2022-06-28', '2022-07-19');
INSERT INTO `mydb`.`usuarios_reserva_livros` (`usuarios_id`, `livros_isbn`, `data_reserva`, `data_devolucao`) VALUES (3, 2, '2022-06-28', '2022-07-28');
INSERT INTO `mydb`.`usuarios_reserva_livros` (`usuarios_id`, `livros_isbn`, `data_reserva`, `data_devolucao`) VALUES (4, 3, '2022-06-28', '2022-07-28');
INSERT INTO `mydb`.`usuarios_reserva_livros` (`usuarios_id`, `livros_isbn`, `data_reserva`, `data_devolucao`) VALUES (5, 4, '2022-06-28', '2022-07-13');
INSERT INTO `mydb`.`usuarios_reserva_livros` (`usuarios_id`, `livros_isbn`, `data_reserva`, `data_devolucao`) VALUES (6, 5, '2022-06-28', '2022-07-13');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`telefones_alunos`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`telefones_alunos` (`alunos_matricula`, `telefone_aluno`) VALUES (1, '00000000007');
INSERT INTO `mydb`.`telefones_alunos` (`alunos_matricula`, `telefone_aluno`) VALUES (1, '00000000008');
INSERT INTO `mydb`.`telefones_alunos` (`alunos_matricula`, `telefone_aluno`) VALUES (2, '00000000009');
INSERT INTO `mydb`.`telefones_alunos` (`alunos_matricula`, `telefone_aluno`) VALUES (3, '00000000010');

COMMIT;

