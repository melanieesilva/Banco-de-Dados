
CREATE DATABASE PapaPizzaria;
USE PapaPizzaria;

drop database papapizzaria;

CREATE TABLE Clientes (
	id_cliente int AUTO_INCREMENT PRIMARY KEY,
	nome_cliente varchar(255),
	email_cliente varchar(255),
	telefone_cliente varchar(15),
    endereco_cliente varchar(30),
    numero_endereco INT,
    bairro_cliente varchar(30),
    CEP_cliente varchar(9)
);

CREATE TABLE Fornecedor (
	id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
	cnpj_fornecedor VARCHAR (25) UNIQUE,
    nome_fornecedor VARCHAR (50),
    telefone VARCHAR (14),
    dt_cad DATE,
    email VARCHAR(100),
    whatsapp VARCHAR (14),
    descricao VARCHAR (100),
    endereco_fornecedor varchar(30),
    numero_endereco INT,
    bairro_fornecedor varchar(30),
    CEP_fornecedor varchar(9)
);

create table Filiais(
	id_filial int auto_increment primary key,
    nome_filial varchar(30),
    telefone varchar(14),
    endereco_filial  varchar(30),
    numero_endereco  int,
    bairro_filial varchar(30),
    CEP_filial varchar(9)
);

CREATE TABLE Funcionario (
	id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
	cpf_funcionario VARCHAR (14) UNIQUE,
    nome_funcionario VARCHAR (50),
    telefone VARCHAR (14),
    email VARCHAR(100),
    whatsapp VARCHAR (14),
    admissao DATE,
    cargo VARCHAR (30),
    filial_FK int,
    
    foreign key (filial_FK) references Filiais(id_filial)
);

CREATE TABLE Ingredientes (
	id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
	nome_ingrediente VARCHAR(30),
	quantidade_minima INT,
    quantidade_maxima INT,
    quantidade_atual INT,
    data_validade DATE,
    data_fabricacao DATE,
    fornecedor_id_FK INT,
    custo DECIMAL(10,2),
    FOREIGN KEY (fornecedor_id_FK) REFERENCES Fornecedor(id_fornecedor)
);

CREATE TABLE Pizzas (
	id_pizza int auto_increment PRIMARY KEY,
	nome_pizza varchar(255),
	ingredientes_pizza varchar(255),
	tamanho_pizza varchar(20),
    custo_pizza DECIMAL(10,2),
	valor_venda DECIMAL(10,2),
    data_fabricacao date,
    data_validade date
);

CREATE TABLE Acompanhamentos (
	id_acompanhamento INT AUTO_INCREMENT PRIMARY KEY,
    nome_acompanhamento VARCHAR (15),
    custo DECIMAL(10,2),
    valor_venda DECIMAL(10,2),
    quantidade_minima INT,
    quantidade_maxima INT,
    quantidade_atual INT,
    data_fabricacao DATE,
    data_validade DATE,
    descricao varchar(50),
    fornecedor_id_FK int,
    categoria_acompanhamento ENUM('Bebida','Sobremesa'),
    foreign key (fornecedor_id_FK) references Fornecedor(id_fornecedor)
);

CREATE TABLE Pedidos (
	id_pedido int AUTO_INCREMENT PRIMARY KEY,
	data_pedido date,
	hora_pedido time,
	cliente_id_FK int,
    tipo_entrega ENUM('Delivery','Estabelecimento','Retirada cliente'),
	endereco_entrega varchar(255),
	telefone_cliente varchar(15),
	valor_total decimal(10,2),
	status_pedido ENUM('Confirmado', 'Entregue', 'Em preparo', 'Cancelado'),
    forma_pagamento ENUM('Crédito','Débito','Dinheiro','Pix'),
    desconto DECIMAL(5, 2),

	FOREIGN KEY (cliente_id_FK) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Itens_Pedido (
	pedido_id_FK INT,
    pizza_id_FK INT,
    acompanhamento_id_FK INT,
    quantidade_pizza INT,
    quantidade_acompanhamento INT,
	hora_pedido time,
    subtotal DECIMAL(10,2),
    
    FOREIGN KEY (pedido_id_FK) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (pizza_id_FK) REFERENCES Pizzas(id_pizza),
    FOREIGN KEY (acompanhamento_id_FK) REFERENCES Acompanhamentos(id_acompanhamento)
);



-- INSERTS

-- CLIENTES
INSERT INTO clientes (nome_cliente, email_cliente, telefone_cliente, endereco_cliente, numero_endereco, bairro_cliente, CEP_cliente) 
VALUES ('Hélia Macedo', 'macedohelia21@gmail.com', '71-988779955', 'Rua Elisio Medrado', 12, 'Cajazeiras XI','84563-123'),
('Susana Kelly', 'kellysusana22@gmail.com', '71-985694232','Rua Edvaldo Brandão',45,'Pituba','65478-961'),
('Pedro Miguel', 'pedro.miguel@outlook.com', '71-988456325','Rua Maria Quitéria',90,'Rio Vermelho','15965-416'),
('Tabata Oliveira', 'tabata.o.silva@outlook.com', '71-995674523', 'Rua Lucas di Fiori',21,'Plataforma','88523-677'),
('Luiz Fernando', 'luiz.f189@hotmail.com', '72-987786589','Rua Dias D\'ávila',34,'Ibirapora','94756-485'),
('Daniela Dias', 'diasdaniela2@gmail.com', '72-995654523','Rua Edécio Fernando',27,'Ibirapora','37597-852');

-- FORNECEDORES
INSERT INTO fornecedor (cnpj_fornecedor, nome_fornecedor, telefone, dt_cad, email, whatsapp, descricao, endereco_fornecedor, numero_endereco, bairro_fornecedor, CEP_fornecedor) 
VALUES ('7489', 'Latte RA', '71-985469977', '2023-09-12', 'latte.ra.alimentos@comercial.com.br', '71-985469977', 'Fornecimento de laticínios gerais', 'Rua Miguel Pastoral', '12', 'Rio Vermelho', '7894-556'),
('7534', 'Coca-Cola', '71-988552233', '2023-09-12', 'cocacola@comercial.com.br', '71-988552233', 'Fornecimento de bebidas', 'Rua Jandiaí Rosa', '25', 'Pituba', '3578-664'),
('7987', 'Kibon', '71-988541233', '2022-05-10', 'kibon@comercial.com.br', '71-988541233', 'Fornecimento de sobremesas', 'Rua Rochas de São Bento', '74', 'Caminho das Árvores', '1269-988'),
('7889', 'WR Alimentos', '72-997412530', '2022-02-02', 'wr.alimentos@comercial.com.br', '72-997412530', 'Fornecimento de farinhas', 'Rua Mariaval Deodoro', '88', 'Jardins', '3546-555');

-- FILIAIS
INSERT INTO filiais (nome_filial, telefone, endereco_filial, numero_endereco, bairro_filial, CEP_filial) 
VALUES ('Papa Santa Helena', '71-988563256', 'Rua Maria Herdeira', '12', 'Pituba', '42357-885'),
('Papa Botafogo', '72-987513453', 'Rua Miguel Abrantes', '24', 'Ibirapora', '41586-323');

-- FUNCIONÁRIOS
INSERT INTO funcionario 
(cpf_funcionario, nome_funcionario, telefone, email, whatsapp, admissao, cargo, filial_FK) 
VALUES ('654.247.355-63', 'Juliana Mendes', '71-995987566', 'mendesjuliana@gmail.com', '71-995987566', '2023-09-02', 'Caixa', '1'),
('652.122.455-12', 'Marina Batista', '71-990928562', 'b.marina@outlook.com', '71-990928562', '2023-11-24', 'Pizzarolo', '1'),
('926.182.455-10', 'Kelly Furtado', '72-991329572', 'kelly.f.oliveira@outlook.com', '72-991329572', '2023-02-14', 'Gerente', '1'),
('152.557.105-08', 'Olga Tarcísio', '72-991710772', 'olga_tarcisio3@gmail.com', '72-991710772', '2023-08-22', 'Pizzarolo', '2'),
('212.132.975-22', 'Joel Marino', '71-998134662', 'marino_joel@hotmail.com', '71-998134662', '2023-08-22', 'Entregador', '2');

-- INGREDIENTES
INSERT INTO ingredientes (nome_ingrediente, quantidade_minima, quantidade_maxima, quantidade_atual, data_validade, data_fabricacao, fornecedor_id_FK, CUSTO) 
VALUES ('Queijo Parmesão', '0', '300', '60', '2023-12-09', '2023-01-19', '1', '4.50'),
('Molho de tomate', '0', '250', '200', '2023-12-09', '2023-02-20', '4', '4.80'),
('Tomate', '0', '80', '40', '2023-09-30', '2023-09-01', '1', '3.90'),
('Farinha de trigo', '0', '100', '80', '2024-02-14', '2023-02-14', '4', '4.80'), 
('Sal marinho', '0', '50', '20', '2023-10-11', '2023-09-11', '4', '5.50'),
('Ovo', '0', '40', '20', '2023-10-14', '2023-09-14', '4', '20.59'),
('Fermento', '0', '20', '10', '2023-10-19', '2023-09-19', '4', '8.99'),
('Presunto', '0', '300', '250', '2023-11-08', '2023-10-08', '1', '4.89'),
('Atum', '0', '100', '80', '2023-10-11', '2023-09-11', '1', '8.99'),
('Calabresa', '0', '100', '80', '2023-10-27', '2023-09-27', '1', '6.45');

-- PIZZAS
INSERT INTO pizzas (nome_pizza, ingredientes_pizza, tamanho_pizza, custo_pizza, valor_venda, data_fabricacao, data_validade) 
VALUES ('Pizza Presunto e Queijo', '1,2,4,5,6,7,8', 'Pequena', '29.40', '46.99', '2023-08-11', '2023-08-14'),
('Pizza Calabresa', '1,2,4,5,6,7,10', 'Média', '38.50', '71.50', '2023-08-12', '2023-08-15'),
('Pizza Atum', '1,2,4,5,6,7,9', 'Grande', '40', '84.60', '2023-08-11', '2023-08-14');

-- ACOMPANHAMENTOS
INSERT INTO acompanhamentos 
(nome_acompanhamento, CUSTO, VALOR_VENDA, data_fabricacao, data_validade, descricao, fornecedor_id_FK, categoria_acompanhamento, quantidade_minima, quantidade_maxima, quantidade_atual) 
VALUES ('Refrigerante', '2.80', '7.30', '2023-08-11', '2023-11-11', 'Refrigerante Zero Açucar', '2', 'Bebida', '4', '40', '30'),
('Sorvete', '8.89', '18.45', '2023-08-12', '2023-09-28', 'Sorvete de chocolate', '3', 'Sobremesa', '4', '25', '18'),
('Trufa congelada', '3.34', '8.00', '2023-08-13', '2023-09-13', 'Trufa de morango', '3', 'Sobremesa', '4', '45', '33'),
('Brownie trufado', '3.25', '9.50', '2023-08-11', '2023-09-11', 'Brownie prestígio', '1', 'Sobremesa', '4', '45', '32');

-- PEDIDOS
INSERT INTO pedidos (cliente_id_FK, tipo_entrega, status_pedido, forma_pagamento, desconto) 
VALUES 
('1', 'Delivery', 'Entregue', 'Débito', '4.00'),
('2', 'Delivery', 'Confirmado', 'Crédito', '2.50'),
('3', 'Estabelecimento', 'Entregue', 'Pix', '5.00'),
('4', 'Retirada Cliente', 'Em preparo', 'Débito', '2.50'),
('5', 'Estabelecimento', 'Cancelado', 'Dinheiro', '4.00'),
('6', 'Retirada Cliente', 'Em preparo', 'Crédito', '2.50'),
('2', 'Delivery', 'Em preparo', 'Pix', '5.50'),
('3', 'Delivery', 'Confirmado', 'Débito', '4.50'),
('2', 'Estabelecimento', 'Entregue', 'Dinheiro', '5.50'),
('1', 'Estabelecimento', 'Confirmado', 'Pix', '0');

UPDATE Pedidos SET data_pedido = curdate();
UPDATE Pedidos SET hora_pedido = curtime();

-- ITENS_PEDIDO
INSERT INTO itens_pedido (pedido_id_FK, pizza_id_FK, acompanhamento_id_FK, quantidade_pizza,
quantidade_acompanhamento, hora_pedido)
values (76, 1,2,1,1,curtime()),
(77, 2,1,2,2,curtime()),
(78, 3,3,1,4,curtime()),
(79, 1,4,1,2,curtime()),
(80, 2,4,2,1,curtime()),
(81, 2,1,1,2,curtime()),
(82, 3,3,2,2,curtime()),
(83, 1,2,1,3,curtime());


-- TRIGGERS
-- 1- calcular valor total do pedido pelo subtotal, incluindo desconto:
-- aplicar o desconto no valor total, depois de incluir desconto, pegue o subtotal, aplique o desconto
-- e atualize o valor total do pedido
-- 2 - Atualizar estoque do acompanhamento 
-- 3 - inserir endereço de entrega na tabela pedido, de acordo com o cliente. se possível concatenando
-- endereço, número, bairro, cep



DELIMITER $
-- 1 - calculando subtotal da tabela Itens_pedido
CREATE TRIGGER TGR_CALC_SUBTOTAL
BEFORE INSERT ON itens_pedido
FOR EACH ROW
BEGIN
    SET NEW.subtotal = (SELECT valor_venda FROM Pizzas WHERE id_pizza = NEW.pizza_id_FK) * NEW.quantidade_pizza + 
    (SELECT valor_venda FROM Acompanhamentos WHERE id_acompanhamento = NEW.acompanhamento_id_FK) * NEW.quantidade_acompanhamento;
END$

-- 2 - calculando valor total da tabela Pedidos
CREATE TRIGGER TGR_CALC_VALOR_TOTAL
AFTER INSERT ON itens_pedido
FOR EACH ROW
BEGIN
    DECLARE total_pedido DECIMAL(10, 2);
    DECLARE desconto_pedido DECIMAL(5,2);
    SET desconto_pedido = (SELECT desconto FROM pedidos where id_pedido = NEW.pedido_id_FK);
    SELECT SUM(subtotal * (1 - desconto_pedido / 100)) INTO total_pedido
    FROM itens_pedido
    WHERE pedido_id_FK = NEW.pedido_id_FK;
    
    UPDATE Pedidos
    SET valor_total = total_pedido
    WHERE id_pedido = NEW.pedido_id_FK;
END$

-- 3 - Preenchendo dados do cliente na tabela Pedidos
CREATE TRIGGER TGR_ADD_CLIENTE_PEDIDO
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    DECLARE endereco_completo varchar(255);
    DECLARE telefone_entrega varchar(14);
    
    SET endereco_completo = (
    SELECT CONCAT(endereco_cliente, ', ',
        numero_endereco, ', ',
        bairro_cliente, ', ',
        CEP_cliente
	)
    FROM clientes
    WHERE id_cliente = NEW.cliente_id_FK
    );
    SET telefone_entrega = (SELECT telefone_cliente FROM Clientes 
    WHERE id_cliente = NEW.cliente_id_FK);
    
    SET NEW.endereco_entrega = endereco_completo;
    SET NEW.telefone_cliente = telefone_entrega;
END$

-- 5 - atualizando estoque de Acompanhamentos
CREATE TRIGGER TGR_ATT_ESTOQUE_ACOMPANHAMENTO
AFTER INSERT ON itens_pedido
FOR EACH ROW
BEGIN
	UPDATE Acompanhamentos SET quantidade_atual = quantidade_atual - NEW.quantidade_acompanhamento
    WHERE id_acompanhamento = NEW.acompanhamento_id_FK;
END$

-- 6 - Atualizando após deletar
CREATE TRIGGER TGR_ATT_DELETE_ITENS_PEDIDO
AFTER DELETE ON itens_pedido
FOR EACH ROW
BEGIN
	-- Atualiza o estoque de acompanhamentos
	UPDATE Acompanhamentos SET quantidade_atual = quantidade_atual + OLD.quantidade_acompanhamento
    WHERE id_acompanhamento = OLD.acompanhamento_id_FK;
    
    -- Atualiza o valor total de Pedidos
    UPDATE Pedidos SET valor_total = 0 WHERE id_pedido = OLD.pedido_id_FK;
END$

DELIMITER ;

DROP TRIGGER TGR_ADD_CLIENTE_PEDIDO;

DELETE FROM ITENS_PEDIDO;
DELETE FROM PEDIDOS;

-- Views
-- 1 - Relatório de pedidos
-- id pedido, hora do pedido, data do pedido, itens pedido, subtotal, desconto, total, forma entrega

-- 2 - Pedidos por cliente

-- 3 - Pedidos mais feitos // Pizzas mais pedidas

-- 4 - Clientes que mais pedem
-- id, nome, telefone, pizza mais pedida

-- 5 - cardápio
-- id produto, nome produto, ingredientes, valor, categoria

-- 6 - produtos e fornecedores

-- 7 - filiais que tem mais pedidos




