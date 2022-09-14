ALTER TABLE Funcionario 
RENAME COLUMN RA TO RG;

ALTER TABLE Pedido
ADD EnderecoEntrega VARCHAR(20) NOT NULL;

ALTER TABLE Venda
ADD Cod_Barra int, 
ADD Itens_Venda int,
ADD foreign key (Cod_Barra) references Produto(CodBarra),
ADD foreign key (Itens_Venda) references ItensVenda(IdVenda);

ALTER TABLE itensvenda
ADD foreign key (CodBarra) references Produto(CodBarra);

INSERT INTO Fornecedor (NomeFantasia)
values ("Marilia");

INSERT INTO Pedido (MatFunc,QtdItens,ValorTotal,EnderecoEntrega)
values (1,12,123.90,"Cajazeiras");

INSERT INTO Pedido (CodBarra, CNPJ, MatFunc, QtdItens, ValorTotal, EnderecoEntrega)
values (2,1,2,);

INSERT INTO Fornecedor (RazaoSocial, NomeFantasia, Contato, IE, Telefone1, Telefone2, WhatsApp, Email, Endereco,CEP, Bairro, Cidade, UF, Pais)
values ("Indústria Biscoiteira","Bauduco","(71)98745-0809","78564123","(71)98502-3215","Desconhecido","Não informado","bauduco@bauduco.com",
"Rua das Margaridas, 33","45896-86","Juraci","Salvador", "Bahia","Brasil");

insert into itensvenda (CodBarra, QtdVendida,SubTotal)
values (1,12,56.76);

insert into Produto (Descricao, Marca, ValCompra, ValVenda, CNPJ_FORN, Lote, Peso, Umedida, QtdEstocada, AtdMinima, Categoria)
values("Legume","Health",10.50,19.50,2,147,1,"KG",145,120,"Alimento");

insert into Venda (MatFuncionario, Desconto, Total, Cod_Barra, Itens_Venda)
values (2, 15, 150, 3, 2 );

insert into itensvenda (CodBarra,QtdVenda, SubTotal)
values (2,50,150.65,255);

UPDATE Produto SET CNPJ_FORN=1 WHERE CodBarra=1;
UPDATE Pedido SET CodBarra=1 WHERE CodigoPedido=1;
UPDATE Pedido SET CNPJ=1 WHERE CodigoPedido=1;

DELETE FROM Produto WHERE CodBarra = 1;

select * from Fornecedor;
select * from Funcionario;
select * from Produto;
select * from Pedido;
select * from itensvenda;
select * from venda;

use supermercado;
select * from Funcionario where (Cidade LIKE "Candeias");

select * from Produto where (CNPJ_FORN LIKE "1");

select  * from Pedido where (MatFunc Like 1);








