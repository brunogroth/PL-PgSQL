# Objetivos da Linguagem

  - Criar funções e procedimentos
    - Criar gatilhos
  - Adicionar estruturas de controle à linguagem SQL
  - Realizar operações computacionais complexas
  - Fácil de Implementar

# Criando Funções

  ```
  CREATE FUNCION somefunc(integer, text) RETURNS integer AS 'function body text' LANGUAGE plpgsql;
  ```

  Construção:
  ```
  CREATE FUNCTION <nome da funcao>
  Parâmetros da função 
  Tipo de retorno + AS
  Implementamos a função 
  LANGUAGE plpgsql
  ```

  PL-PGSQL é case insensitive

  ## BLOCO DE CÓDIGO
  ```
  $$ 
  DECLARE
    -- declaração de nome + tipo de variáveis
  BEGIN
    -- início da implementação com variáveis e parâmetros da função
  END;
  $$ LANGUAGE plpgsql;
  ```
  ## Exemplo
  ```
  DECLARE
  user_id integer;
  preco numeric;
  url varchar;
  minhalinha nometabela%ROWTYPE;
  meucampo nometabela.nomecoluna%TYPE;
  quantidade integer DEFAULT 32;
  uri varchar := 'https://mysite.com';
  k CONSTANT integer := 10;
  ```

  ## PARÂMETROS
  Os parâmetros são as variáveis importantes para a chamada da função
  
  Sintaxe: nome + tipo
  ```
  CREATE FUNCTION aplicaTaxa(valor1 real, valor2 real)
  RETURNS real AS 
  $$
  BEGIN
    RETURN (valor1 + valor2) * 0.06;
  END;
  $$ LANGUAGE plpgsql;
  ```

  ## SITUACIONAIS
  Parâmetros podem ser anônimos e nesse caso devem ser chamados por $1, $2, [...]. (DIMINUI LEGIBILIDADE)
  Também podem ser especificados por alias no DECLARE da função.

  ```
  CREATE FUNCTION aplicaTaxa(real, real)
  RETURNS real AS 
  $$
  DECLARE
    valor2 ALIAS FOR $2;
  BEGIN
    RETURN ($1 + valor2) * 0.06;
  END;
  $$ LANGUAGE plpgsql;
  ```

# CHAMANDO FUNÇÕES

  As chamadas de funções são feitas usando a cláusula SELECT
  
  ```
  SELECT aplicaTaxa(10,30.50);
  ```

# EXERCÍCIOS

# LAÇOS DE REPETICAO

	WHILE i > 0 LOOP

  END LOOP;

  FOR variavel IN init..final LOOP

  END LOOP;
