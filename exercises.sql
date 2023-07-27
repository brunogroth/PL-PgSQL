-- Exercício 1 - transferência de valores entre contas com PROCEDURE
create table contas(
	id int,
	nome varchar(100),
	saldo decimal
);

insert into contas(id, nome, saldo) values (1, 'Ana', 5000);
insert into contas(id, nome, saldo) values (2, 'Bruno', 1000);

select * from contas;

create or replace procedure transferencia(origem int, destino int, valor decimal)
language plpgsql
as $$
begin 
	-- subtraindo o montante transferido pela conta de origem
	update contas set saldo = saldo - valor where id = origem;
	
	-- adicionar o montante transferido para a conta de destino
	update contas set saldo = saldo + valor where id = destino;
	
end $$;

call transferencia(1, 2, 300); 

select * from contas;

-- Exercício 2 - Olá Mundo com FUNCTION

CREATE or replace FUNCTION helloWorld() returns varchar as
$$
DECLARE  
	msg varchar := 'Hello World!';
BEGIN
	return msg;

END;
$$
language plpgsql;

select olaMundo();

-- Exercício 3 - Função para criação de um professor com base em parâmetros

create table professor(
	id integer primary key,
	nome varchar(100),
	data_nasc date,
	salario numeric
);

create or replace function createProfessor(id integer, nome varchar, data_nasc date, salario numeric)
returns void as
$$
begin
 -- Inserir na tabela professor
	insert into professor values (id, nome, data_nasc, salario);

end; $$
language plpgsql;

select createProfessor(1, 'Dr Victor', '10/03/1985', 5000);
select * from professor;
 

