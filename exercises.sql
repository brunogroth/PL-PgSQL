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

insert into professor values (2, 'Gil Gomes', '01/04/1962',8642.60);
insert into professor values (3, 'Renata Costa', '02/05/1988',1250.30);
insert into professor values (4,'Renato Gil', '01/01/1997',998.00);
insert into professor values (5,'Pedro Silva', '03/05/2001',3500);
insert into professor values (6,'Raquel Souza', '29/10/1996',2400);
insert into professor values (7, 'Sêneca Figueiredo', '11/11/1990',6700.34);
insert into professor values (8, 'Harry Potter', '01/04/1998',998);
insert into professor values (9, 'Cícero', '01/12/1986',12150.34);
insert into professor values (10, 'Jimmy Page', '03/05/2001',1200);
insert into professor values (11, 'Marco Aurélio', '03/12/2000',998);
insert into professor values (12, 'Helena Silva', '02/01/1997',998);
insert into professor values (13, 'Sócrates Pereira', '29/10/1995',3200);
insert into professor values (14, 'Mata Rocha', '03/12/2001',3570);
insert into professor values (15, 'Maria Carla', '02/01/1997',1998);
insert into professor values (16, 'Renato Feliz', '01/07/2001',6789.34);
insert into professor values (17, 'Lucas Sávio', '29/10/2000',3410);
insert into professor values (18,'Raul Seixas', '02/02/1978',12150.34);

select * from professor;
-- Exercícios IN, OUT, INOUT

-- Out fornece parâmetros de saída para uma função
-- O Return deve ser "Records"

-- Exercício 4 - Função que mostra a maior, menor e a média de salario dos professores

create or replace function min_avg_max(out lo numeric, out average numeric, out hi numeric)
AS
$$
BEGIN
	select max(salario) from professor into hi;
	select min(salario) from professor into lo;
	select round(avg(salario), 2) from professor into average;
END;
$$ LANGUAGE plpgsql;

select min_avg_max();
select * from min_avg_max();


-- CONDICIONAIS

-- Exercício 5 - Crie uma função que, dado o ID de um professor, retorna TRUE
-- se ele ganha mais que a média salarial.

create or replace function isAboveAverage(professor_id int)
as
$$
DECLARE 
	average numeric;
	salario numeric;
	
BEGIN
	average := select average from min_avg_max();
	salario := select salario from professor where id = professor_id;
	
	if(salario > average){
		return true;
	}

END;
$$ language plpgsql;


-- LAÇOS DE REPETIÇÃO

-- Exercício 6 - Escreva uma função que calcule o fatorial de um número inteiro positivo.

CREATE OR replace FUNCTION fatorial(x int) returns int
AS
$$
DECLARE
	fatorial int;
	i int;
	conta int;
begin
	fatorial := x;
	i := x-1;

	while i > 0 loop
		fatorial = fatorial * i;
		i = i - 1;

	end loop;
	
	RETURN fatorial;
	
END;
$$ LANGUAGE plpgsql;

select fatorial(6);

-- teste de mesa para debug

-- x = 4
-- i = 3
-- i > 0 ? conta = 12 | fatorial = 12 | i = 2
-- i > 0 ? conta = 6 | fatorial = 12 + 6 // Aqui esta o problema // Resolvido | i = 1
-- i > 0 ? conta = 6 | fatorial = 18 + 2 // Aqui esta o problema // Resolvido | i = 0
-- i > 0 ? false (end loop)