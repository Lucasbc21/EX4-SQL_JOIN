CREATE DATABASE locadora
GO
USE locadora
GO 

CREATE TABLE filme(
id                        INT                                        NOT NULL,
titulo                    VARCHAR(40)                                NOT NULL,
ano                       INT             CHECK(ano <= 2021)         NULL,
PRIMARY KEY(id)
)
GO

CREATE TABLE estrela(
id                        INT                   NOT NULL,
nome                      VARCHAR(50)           NOT NULL
PRIMARY KEY(id)
)
GO

CREATE TABLE filme_estrela(
filme_id                  INT                   NOT NULL,
estrela_id                INT                   NOT NULL
PRIMARY KEY (filme_id, estrela_id)
FOREIGN KEY (filme_id)      REFERENCES filme(id), 
FOREIGN KEY (estrela_id)    REFERENCES estrela(id)
)
GO

CREATE TABLE dvd(
num                       INT                                                            NOT NULL,
data_fabricacao           DATE        CHECK(data_fabricacao < GETDATE())                 NOT NULL,
filme_id                  INT                                                            NOT NULL
PRIMARY KEY (num)
FOREIGN KEY (filme_id)      REFERENCES filme(id)
)
GO

CREATE TABLE cliente(
num_cadastro             INT                                         NOT NULL,
nome                     VARCHAR(70)                                 NOT NULL,
logradouro               VARCHAR(150)                                NOT NULL,
num                      INT         CHECK(num > 0)                  NOT NULL,
cep                      CHAR(8)     CHECK(LEN(cep) = 8)             NULL
PRIMARY KEY (num_cadastro)
) 
GO

CREATE TABLE locacao(
dvd_num                  INT                                                                               NOT NULL,
cliente_num_cadastro     INT                                                                               NOT NULL,
data_locacao             DATE                DEFAULT(GETDATE())                                            NOT NULL,
data_devolucao           DATE                                                                             NOT NULL,
valor                    DECIMAL(7,2)        CHECK(valor > 0.00)                                                              NOT NULL
PRIMARY KEY (dvd_num, cliente_num_cadastro, data_locacao)
FOREIGN KEY (dvd_num)                   REFERENCES   dvd (num),
FOREIGN KEY (cliente_num_cadastro)      REFERENCES   cliente(num_cadastro),
CONSTRAINT check_data CHECK(data_devolucao > data_locacao)
)
GO


--ESQUEMA CRIAÇÃO DA COLUNA nome_real 

ALTER TABLE estrela
ADD nome_real       VARCHAR(50)    NULL
GO

--ESQUEMA DA ALTERAÇÃO DO VARCHAR(40) PARA VARCHAR(80)

ALTER TABLE filme
ALTER COLUMN titulo     VARCHAR(80)    NOT NULL
GO


-- INSERÇÃO DE DADOS DO FILME

INSERT INTO filme(id, titulo, ano)
VALUES (1001, 'Whiplash', 2015)
GO

INSERT INTO filme(id, titulo, ano)
VALUES (1002, 'Birdman', 2015)
GO

INSERT INTO filme(id, titulo, ano)
VALUES (1003, 'Interestelar', 2014)
GO

INSERT INTO filme(id, titulo, ano)
VALUES (1004, 'A Culpa é das estrelas', 2014)
GO

INSERT INTO filme(id, titulo, ano)
VALUES (1005, 'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014)
GO

INSERT INTO filme(id, titulo, ano)
VALUES (1006, 'Sing', 2016)
GO



--INSERÇÃO DE DADOS DA ESTRELA


INSERT INTO estrela(id, nome, nome_real)
VALUES (9901, 'Michael Keaton', 'Michael John Douglas')
GO

INSERT INTO estrela(id, nome, nome_real)
VALUES (9902, 'Emma Stone', 'Emily Jean Stone')
GO

INSERT INTO estrela(id, nome)
VALUES (9903, 'Miles Teller ')
GO

INSERT INTO estrela(id, nome, nome_real)
VALUES (9904, 'Steve Carrell', 'Steven John Carell')
GO

INSERT INTO estrela(id, nome, nome_real)
VALUES (9905, 'Jennifer Garner', 'Jennifer Anne Garner')
GO



--INSERÇÃO DE DADOS DA ESTRELA DO FILME



INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES (1002, 9901)
GO

INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES (1002, 9902)
GO

INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES (1001, 9903)
GO

INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES (1005, 9904)
GO

INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES (1005, 9905)
GO

--INSERÇÃO DE DADOS DO DVD


INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES         (10001, '2020-12-02', 1001)
GO

INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES         (10002, '2019-10-18', 1002)
GO

INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES         (10003, '2020-04-03', 1003)
GO

INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES         (10004, '2020-12-02', 1001)
GO

INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES         (10005, '2019-10-18', 1004)
GO

INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES         (10006, '2020-04-03', 1002)
GO

INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES         (10007, '2020-12-02', 1005)
GO

INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES         (10008, '2019-10-18', 1002)
GO

INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES         (10009, '2020-04-03', 1003)
GO

--INSERÇÃO DA DADOS DO CLIENTE

INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES (5501, 'Matilde Luz', 'Rua Síria', 150, '03086040')
GO

INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES (5502, 'Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110')
GO

INSERT INTO cliente(num_cadastro, nome, logradouro, num)
VALUES (5503, 'Daniel Ramalho', 'Rua Itajutiba', 169)
GO

INSERT INTO cliente(num_cadastro, nome, logradouro, num)
VALUES (5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg', 36)
GO

INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES (5505, 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')
GO

--INSERÇÃO DE DADOS DA LOCAÇÃO

INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES (10001, 5502, '2021-02-18', '2021-02-21', 3.50)
GO

INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES (10009, 5502, '2021-02-18', '2021-02-21', 3.50)
GO

INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES (10002, 5503, '2021-02-18', '2021-02-19', 3.50)
GO

INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES (10002, 5505, '2021-02-20', '2021-02-23', 3.00)
GO

INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES (10004, 5505, '2021-02-20', '2021-02-23', 3.00)
GO

INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES (10005, 5505, '2021-02-20', '2021-02-23', 3.00)
GO

INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES (10001, 5501, '2021-02-24', '2021-02-26', 3.50)
GO

INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES (10008, 5501, '2021-02-24', '2021-02-26', 3.50)
GO


--ATUALIZAÇÃO DO CLIENTE 5503  DE NOT NULL PARA CEP 08411150

UPDATE cliente
SET cep = '08411150' 
WHERE num_cadastro = 5503
GO

--ATUALIZAÇÃO DO CLIENTE 5504 DE NOTT NULL PARA CEP 02918190

UPDATE cliente
SET cep = '02918190'
WHERE num_cadastro = 5504
GO

--ATUALIZAÇÃO DA LOCAÇÃO DE 2021-02-18 DO CLIENTE 5502 NO VALOR DE 3.50 PARA AGORA 3.25

UPDATE locacao
SET valor = 3.25
WHERE data_locacao = '2021-02-18' AND cliente_num_cadastro = 5502 
GO

--ATUALIZAÇÃO DA LOCAÇÃO DE 2021-02-24 DO CLIENTE 5501 NO VALOR DE 3.50 PARA AGORA 3.10

UPDATE locacao
SET valor = 3.10
WHERE data_locacao = '2021-02-24' AND cliente_num_cadastro = 5501
GO

--ATUALIZAÇÃO DA DATA DE FABRICAÇÃO DO DVD 10005 PARA 2019-07-14

UPDATE dvd
SET data_fabricacao = '2019-07-14'
WHERE num = 10005
GO


--ATUALIZAÇÃO DO NOME REAL DE MILES TELLER DE NULL PARA MILES ALEXANDER TELLER

UPDATE estrela
SET nome_real = 'Miles Alexander Teller'
WHERE nome = 'Miles Teller'
GO

--DELETAÇÃO DO REGISTRO DO FILME SING POIS NÃO TEM DVD CADASTRADO

DELETE filme
WHERE titulo = 'Sing'
GO


--1) SQL(92)

SELECT DISTINCT cliente.num_cadastro,
       cliente.nome,
	   CONVERT(CHAR(10), locacao.data_locacao, 103) AS data_locacao,

       DATEDIFF(DAY, locacao.data_locacao, locacao.data_devolucao) AS Qtd_dias_alugado,
	   filme.titulo,
	   filme.ano

FROM cliente INNER JOIN locacao 
ON cliente.num_cadastro = locacao.cliente_num_cadastro
INNER JOIN dvd
ON dvd.num = locacao.dvd_num
INNER JOIN filme
ON filme.id = dvd.filme_id

WHERE cliente.nome LIKE 'Matilde%'
GO

--2) SQL(99)

SELECT es.nome, es.nome_real, fil.titulo 
FROM estrela es, filme_estrela fe, filme fil
WHERE es.id = fe.estrela_id
      AND fil.id = fe.filme_id
      AND fil.ano = 2015
ORDER BY es.nome ASC
GO
--3)

SELECT DISTINCT fil.titulo, 
       CONVERT (CHAR(10), dv.data_fabricacao, 103) AS data_fabricacao,

	   CASE WHEN (YEAR(GETDATE()) - fil.ano) > 6
	        THEN
	        CAST((YEAR(GETDATE()) - fil.ano) AS VARCHAR(4)) + ' anos'
	        ELSE
			CAST((YEAR(GETDATE()) - fil.ano) AS VARCHAR(4))
	   END AS anos_de_diferença
FROM filme fil, dvd dv 
WHERE fil.id = dv.filme_id
      
      
ORDER BY fil.titulo ASC
GO   
     
      
      
      
       

SELECT * FROM dvd
SELECT * FROM locacao
SELECT * FROM filme
SELECT * FROM filme_estrela
SELECT * FROM estrela
SELECT * FROM cliente
 


