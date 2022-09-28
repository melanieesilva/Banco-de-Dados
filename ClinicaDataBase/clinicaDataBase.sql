CREATE DATABASE CLINICA;
USE CLINICA;

CREATE TABLE Paciente (
paciente_id int primary key NOT NULL,
nome_paciente varchar(50) NOT NULL,
cpf_paciente varchar(15) NOT NULL,
email_paciente varchar(25) NOT NULL,
telefone_paciente varchar(25) NOT NULL,
convenio_paciente varchar(25) NOT NULL,
data_nasc Date not null
);

create table Funcionario (
func_id int primary key NOT NULL,
nome_func varchar(50) NOT NULL,
data_nasc varchar(30) NOT NULL,
email varchar(35) NOT NULL,
telefone varchar(35) NOT NULL,
cpf varchar(15) NOT NULL
);

create table Medico (
medico_id int primary key NOT NULL,
nome_medico varchar(50) NOT NULL,
crm_medico varchar(30) NOT NULL,
data_nasc varchar(30) NOT NULL,
email_medico varchar(35) NOT NULL,
telefone_medico varchar(35) NOT NULL,
convenio varchar(20) NOT NULL,
cpf_medico varchar(15) NOT NULL,
especialidade varchar(30) NOT NULL
);

SELECT * FROM PACIENTE;
SELECT * FROM MEDICO;

SELECT * FROM FUNCIONARIO;
SELECT * FROM CONSULTA;
SELECT * FROM EXAME;
SELECT * FROM AGENDAMENTO;


create table Consulta (
consulta_id int primary key NOT NULL,
tempo_atend TIME,
horario_atend TIME,
paciente_id int NOT NULL,
medico_id int NOT NULL,
foreign key (medico_id) references Medico(medico_id),
foreign key (paciente_id) references Paciente(paciente_id)
);

create table Exame (
exame_id int primary key NOT NULL,
tipo_exame varchar(50) NOT NULL,
data_exame Date NOT NULL,
hora_exame Time NOT NULL,
paciente_id int NOT NULL,
medico_id int NOT NULL,
func_id int NOT NULL,
foreign key (medico_id) references Medico(medico_id),
foreign key (paciente_id) references Paciente(paciente_id),
foreign key (func_id) references Funcionario(func_id)
);

create table Agendamento (
agenda_id int primary key NOT NULL,
forma_pagamento varchar(30) ,
convenio varchar(30) ,
data_consulta Date NOT NULL,
data_pedido Date NOT NULL,
data_retorno Date NOT NULL,
hora_consulta TIME NOT NULL,
paciente_id int,
medico_id int,
foreign key (medico_id) references Medico(medico_id),
foreign key (paciente_id) references Paciente(paciente_id)
);

ALTER TABLE Paciente
ADD COLUMN Bairro varchar(40);

ALTER TABLE Agendamento
ADD COLUMN Especialidade varchar(40);

ALTER TABLE Consulta
ADD COLUMN Convenio varchar(40);

ALTER TABLE Consulta
ADD COLUMN agenda_id int not null;

select * from Agendamento where Agendamento.data_consulta = "2022-09-01";
select * from Agendamento where Agendamento.data_consulta >="2022-09-01" and Agendamento.data_consulta <="2022-09-10";
select * from Agendamento where Agendamento.Especialidade = "Pediatria";

select convenio, count(convenio) as MaisUtilizados
FROM CONSULTA
GROUP BY CONVENIO
ORDER BY MaisUtilizados desc;

select bairro,count(bairro) as BairroFrequente
FROM PACIENTE
group by Bairro
ORDER BY Bairro asc;

SELECT medico_id,count(medico_id) as TotalAtend
from Agendamento
where Agendamento.data_consulta >= "2022-09-01" and Agendamento.data_consulta <= "2022-09-14"
group by medico_id
order by TotalAtend desc;

SELECT * FROM  Consulta where Consulta.consulta_id = Consulta.agenda_id;
