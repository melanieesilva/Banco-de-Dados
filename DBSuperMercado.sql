create database Supermercado;
use Supermercado;

create table Fornecedor(
CNPJ int auto_increment primary key,
RazaoSocial	varchar(40),
NomeFantasia	varchar(40),
Contato	varchar(40),
IE	varchar(40),
Telefone1	varchar(40),
Telefone2	varchar(40),
WhatsApp	varchar(40),
Email	varchar(40),
Endereco	varchar(40),
Cep	varchar(40),
Bairro	varchar(40),
Cidade	varchar(40),
UF	varchar(40),
Pais	varchar(40)
);

create table Funcionario(
MatFunc	int auto_increment primary key,
NomeFunc	varchar(40),
DtNasc	Date,
DtAdmissao	Date,
CPF	varchar(40),
CNH	varchar(40),
Genero	varchar(40),
RG	varchar(40),
EstadoCivil	varchar(40),
Cargo	varchar(40),
Telefone1	varchar(40),
Telefone2	varchar(40),
WhatsApp	varchar(40),
Email varchar(40),
Endereco varchar(40),
Cep	varchar(40),
Bairro varchar(40),
Cidade varchar(40),
UF varchar(40),
Pais varchar(40)
);

create table Produto(
CodBarra	int auto_increment primary key,
Descricao	varchar(40),
Marca	varchar(40),
ValCompra	float,
ValVenda	float,
CNPJ	int,
foreign key (CNPJ) references Fornecedor(CNPJ),
DtFab	Date,
DtVal	Date,
Lote	varchar(40),
Peso	float,
Umedida	varchar(40),
QtdEstocada	Int,
AtdMinima	Int,
Categoria	varchar(40)
);

create table Venda(
IdVenda	int auto_increment primary key,
MatFunc	int,
foreign key (MatFunc) references Funcionario(MatFunc),
DtVenda	Date,
HrVenda	Time,
Desconto	float,
Total	float
);

create table Pedido(
CodPedido	int auto_increment primary key,
CodBarra	int,
foreign key (CodBarra) references Produto(CodBarra),
CNPJ	int,
foreign key (CNPJ) references Fornecedor(CNPJ),
MatFunc	int,
foreign key (MatFunc) references Funcionario(MatFunc),
DtPedido	Date,
QtdPedida	int,
EnderecoEntrega	varchar(40)
);

create table ItensVenda(
IdVenda	int auto_increment primary key,
CodBarra	int,
foreign key (CodBarra) references Produto(CodBarra),
QtdVendida	int,
SubTotal	float
);


insert into Fornecedor
values (
1,
"BAUDUCO",
"Bauduco LTDA",
"Sem Contato",
"Sem IE",
"Sem Telefone 1",
"Sem Telefone 2",
"Sem whatsapp",
"bauduco@gmail.com",
"Rua das Margaridas",
"78945612",
"CAJAZEIRAS",
"SALVADOR",
"BAHIA",
"PAIS"
);

insert into Funcionario
values (
4,
"KELLY MARIA",
('2002-08-15'),
('2021-02-02'),
"3334455666",
"7778885256",
"FEMININO",
"669955448",
"CASADA",
"SECRETÁRIA",
"7578965412",
"7195682356",
"7185468523",
"kellymaria@gmail.com",
"rua dos morangos",
"75698125",
"SÃO OPERADOR",
"SALVADOR",
"BAHIA",
"BRASIL"
);

insert into Produto
values (
1,
"LOREM",
"ITAU",
19.50,
15,
1,
('2015-01-01'),
('2022-12-31'),
"1111111",
12,
"KG",
190,
150,
"CATEGORIA A"
);

insert into Venda
values (
1,
1,
('2022-01-01'),
('00:15:30'),
25,
150.50
);

insert into ItensVenda
values (
1,
1,
150,
230.50
);

insert into Pedido
values (
1,
1,
1,
1,
('2022-01-01'),
15,
"Salvador, Cajazeiras"
);


drop table itensvenda;

select * from venda;
select * from itensvenda;
select * from produto;
select * from fornecedor;
select * from funcionario;
select * from pedido;

/* 
	Consulta 1 -  Crie uma consulta para apresentar todos os fornecedores de "Camaçari"
*/

SELECT * FROM FORNECEDOR WHERE (Cidade LIKE "CAMAÇARI");

/* 
	Consulta 2 -  Crie uma consulta para apresentar todos os funcionários que moram no "Imbui"
*/

SELECT * FROM FORNECEDOR WHERE (Bairro LIKE "IMBUÍ");

/* 
	Consulta 3 - - Crie uma consulta para apresentar os produtos que terão seus vencimentos entre "01/09/2022 e 30/09/2022"
*/

SELECT * FROM PRODUTO WHERE DtVal between ('2022-09-01') and ('2022-09-30');

/* 
	Consulta 4 - Crie uma consulta para exibir o total de todas as compras realizadas entre "01/09/2022 e 14/09/2022".
*/

SELECT * FROM VENDA WHERE DtVenda between ('2022-09-01') and ('2022-09-14');

/* 
	Consulta 5 -  - Crie uma consulta para exbir todos os produtos de um determinado fornecedor
*/

SELECT * FROM Produto WHERE CNPJ=1;

/* 
	Consulta 6 -  Crie uma consulta para apresentar todos os pedidos feitos por um determinado funcionário
*/

SELECT * FROM PEDIDO WHERE MatFunc=1;

/* 
	Consulta 7 -  - Crie uma consulta que altere todos os funcionarios que possuem CNH categoria "B" para "AB".
*/

UPDATE Funcionario
set CNH = AB;

/* 
	Consulta 8 -  - Crie uma consulta que apague todos os pedidos feitos em "14/09/2022".
*/

DELETE FROM Pedidos WHERE DtPedido=('2022-09-14');
