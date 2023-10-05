

create table Cardapio(
	id_item INT auto_increment primary key,
    nome varchar(35),
    descricao varchar(50),
    valor_venda decimal(10,2),
    categoria varchar(20),
    status_cardapio ENUM('Disponível','Indisponível')
);

create table Cliente(
	id_cliente int auto_increment primary key,
    nome varchar(40),
    telefone varchar(14),
    email varchar(35),
    whatsapp varchar(14),
    mesa_num int
);

create table Pedido(
id_pedido int auto_increment primary key, 
num_mesa int, 
id_cliente int,
status_pedido enum ("Solicitado","Em preparo","Entregue"),
total varchar (10),
data_pedido date,
desconto float,
forma_pagamento varchar(30)
);


create table ItensPedido(
	id_pedido_FK int,
    id_item_cardapio_FK int,
    quantidade int,
    subtotal decimal(10,2),
    data_pedido datetime,
	foreign key(id_pedido_FK) references Pedido(id_pedido),
    foreign key(id_item_cardapio_FK) references Cardapio(id_item)
);


-- POVOANDO
-- CARDÁPIO
INSERT INTO `bar`.`cardapio` (`nome`, `descricao`, `valor_venda`, `categoria`, `status_cardapio`) VALUES ('Margarita', 'Tequila, Limão e Açucar', '9.90', 'Drinks', 'Disponível');
INSERT INTO `bar`.`cardapio` (`nome`, `descricao`, `valor_venda`, `categoria`, `status_cardapio`) VALUES ('Caipirinha', 'Cachaça, Limão e Gelo', '11.90', 'Drinks', 'Indisponível');
INSERT INTO `bar`.`cardapio` (`nome`, `descricao`, `valor_venda`, `categoria`, `status_cardapio`) VALUES ('Caipifruta', 'Cachaça, Morango e Gelo', '13.80', 'Drinks', 'Disponível');
INSERT INTO `bar`.`cardapio` (`nome`, `valor_venda`, `categoria`, `status_cardapio`) VALUES ('Pão de Alho', '4.50', 'Petiscos', 'Disponível');

-- CLIENTE
INSERT INTO `bar`.`cliente` (`nome`, `telefone`, `email`, `whatsapp`,`mesa_num`) VALUES ('Melanie Silva', '71-998752314', 'melaniesilva@gmail.com', '71-998752314',1);
INSERT INTO `bar`.`cliente` (`nome`, `telefone`, `email`, `whatsapp`,`mesa_num`) VALUES ('João Pedro', '71-985647125', 'joao.pedro.b@gmail.com', '71-985647125',1);
INSERT INTO `bar`.`cliente` (`nome`, `telefone`, `email`, `whatsapp`,`mesa_num`) VALUES ('Davi Dórea', '71-999657421', 'davi.dorea.a@gmail.com', '71-999657421',2);

-- PEDIDO
INSERT INTO `bar`.`pedido` (`id_cliente`, `status_pedido`, `desconto`, `forma_pagamento`) VALUES ('1', 'Solicitado', '4.00', 'Débito');
INSERT INTO `bar`.`pedido` (`id_cliente`, `status_pedido`, `desconto`, `forma_pagamento`) VALUES ('2', 'Em preparo', '2.00', 'Dinheiro');
INSERT INTO `bar`.`pedido` (`id_cliente`, `status_pedido`, `desconto`, `forma_pagamento`) VALUES ('3', 'Entregue', '3.00', 'PIX');
UPDATE PEDIDO SET data_pedido = CURDATE();

-- ITENS PEDIDO
insert into ITENSPEDIDO (id_pedido_FK, id_item_cardapio_FK, quantidade, data_pedido)
VALUES (4,2,4,CURDATE()),
(5,1,4,CURDATE()),
(6,3,4,CURDATE());

DELIMITER $
-- PREENCHENDO NUMERO MESA
create TRIGGER TGR_NUM_MESA
BEFORE INSERT ON PEDIDO
FOR EACH ROW
BEGIN
	SET NEW.num_mesa = (SELECT mesa_num FROM CLIENTE where id_cliente = NEW.id_cliente);
END$


CREATE TRIGGER TGR_CALC_SUBTOTAL
BEFORE INSERT ON itenspedido
FOR EACH ROW
BEGIN
    SET NEW.subtotal = (SELECT valor_venda FROM cardapio WHERE id_item = NEW.id_item_cardapio_FK) * NEW.quantidade;
END$

CREATE TRIGGER TGR_CALC_TOTAL_PEDIDO
AFTER INSERT on ITENSPEDIDO
for each row
begin
	DECLARE TOTAL_PEDIDO DECIMAL(10,2);
    DECLARE DESCONTO_PEDIDO DECIMAL(10,2);
    
    SET DESCONTO_PEDIDO = (SELECT desconto FROM PEDIDO WHERE id_pedido = NEW.id_pedido_FK);
    SELECT SUM(subtotal * (1 - DESCONTO_PEDIDO / 100)) INTO TOTAL_PEDIDO
    FROM itenspedido
    WHERE id_pedido_FK = NEW.id_pedido_FK;
	
    Update Pedido
    SET total = TOTAL_PEDIDO
    WHERE id_pedido = NEW.id_pedido_FK;
end$

DELIMITER ;




