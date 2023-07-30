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
	select createProfessor(id, nome, data_nasc, salario);

end; $$
language plpgsql;

select createProfessor(1, 'Dr Victor', '10/03/1985', 5000);

select * from professor;

select createProfessor(2, 'Gil Gomes', '01/04/1962',8642.60);
select createProfessor(3, 'Renata Costa', '02/05/1988',1250.30);
select createProfessor(4,'Renato Gil', '01/01/1997',998.00);
select createProfessor(5,'Pedro Silva', '03/05/2001',3500);
select createProfessor(6,'Raquel Souza', '29/10/1996',2400);
select createProfessor(7, 'Sêneca Figueiredo', '11/11/1990',6700.34);
select createProfessor(8, 'Harry Potter', '01/04/1998',998);
select createProfessor(9, 'Cícero', '01/12/1986',12150.34);
select createProfessor(10, 'Jimmy Page', '03/05/2001',1200);
select createProfessor(11, 'Marco Aurélio', '03/12/2000',998);
select createProfessor(12, 'Helena Silva', '02/01/1997',998);
select createProfessor(13, 'Sócrates Pereira', '29/10/1995',3200);
select createProfessor(14, 'Mata Rocha', '03/12/2001',3570);
select createProfessor(15, 'Maria Carla', '02/01/1997',1998);
select createProfessor(16, 'Renato Feliz', '01/07/2001',6789.34);
select createProfessor(17, 'Lucas Sávio', '29/10/2000',3410);
select createProfessor(18,'Raul Seixas', '02/02/1978',12150.34);

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

create or replace function isAboveAverage(professor_id int) returns bool
as
$$
DECLARE 
	averag numeric;
	salary numeric;
	
BEGIN
	select avg(salario) from professor into averag;
	select salario from professor where id = professor_id into salary;
	
	if salary > averag then
		return true;
	end if;

END;
$$ language plpgsql;

select isAboveAverage(1);


-- LAÇOS DE REPETIÇÃO

-- Exercício 6 - Escreva uma função que calcule o fatorial de um número inteiro positivo. 
-- (WHILE)

CREATE OR replace FUNCTION fatorial(x int) returns int
AS
$$
DECLARE
	fatorial int := x;
	i int := x-1;

begin

	while i > 0 loop
		fatorial = fatorial * i;
		i = i - 1;

	end loop;
	
	RETURN fatorial;
	
END;
$$ LANGUAGE plpgsql;

select fatorial(6);

-- teste de mesa para debug

-- select fatorial(4);
-- x = 4 | i = 3
-- i > 0 ? conta = 12 | fatorial = 12 | i = 2
-- i > 0 ? conta = 6 | fatorial = 12 + 6 // Aqui esta o problema // Resolvido | i = 1
-- i > 0 ? conta = 6 | fatorial = 18 + 2 // Aqui esta o problema // Resolvido | i = 0
-- i > 0 ? false (end loop)


-- FOR variavel IN init..final LOOP
-- commands;
-- END LOOP;

-- Exercício 7 - - Escreva uma função que calcule o fatorial de um número inteiro positivo. 
-- (FOR)

create or replace function fatorialFor(x int) returns int
as
$$
declare 
	fatorial int := x;
	i int := x - 1;
	
begin
	raise notice 'x: %', i;
	for i in reverse i..1 loop -- diminuir ao invés de somar
		fatorial = fatorial * i;
		raise notice 'x: % i: % fat: %', x, i, fatorial; -- imprime na tela
	end loop;
	
	return fatorial;
end;
$$ language plpgsql;

select fatorialFor(6);