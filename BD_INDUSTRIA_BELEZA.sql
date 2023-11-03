-- Criação o banco de dados
CREATE DATABASE INDUSTRIA_BELEZA;

-- Usa o banco de dados
USE INDUSTRIA_BELEZA;

-- Exclui o banco de dados
DROP DATABASE INDUSTRIA_BELEZA

-- Criação a tabela TBL_Regiao
CREATE TABLE TBL_Regiao (
    Cod_Reg int identity NOT NULL,
    Nome_Reg varchar(75) NOT NULL,
    PRIMARY KEY (Cod_Reg)
);

-- Criação a tabela TBL_Ponto_Estrategico
CREATE TABLE TBL_Ponto_Estrategico (
    Cod_PE int identity NOT NULL,
    Nome_PE varchar(75) NOT NULL,
    Cod_Reg int NOT NULL,
    PRIMARY KEY (Cod_PE),
    FOREIGN KEY (Cod_Reg) REFERENCES TBL_Regiao (Cod_Reg)
);

-- Criação a tabela TBL_Vendedor
CREATE TABLE TBL_Vendedor (
    Cod_Vend int identity NOT NULL,
    Nome_Vend varchar(151) NOT NULL,
    Cod_Reg int NOT NULL,
    PRIMARY KEY (Cod_Vend),
    FOREIGN KEY (Cod_Reg) REFERENCES TBL_Regiao (Cod_Reg)
);

-- Criação a tabela TBL_Veiculo
CREATE TABLE TBL_Veiculo (
    Cod_Veiculo int identity NOT NULL,
    Placa_Veiculo varchar(8) NOT NULL,
    Cor_Veiculo varchar(30) NOT NULL,
    Modelo varchar(30) NOT NULL,
    PRIMARY KEY (Cod_Veiculo)
);

-- Criação a tabela TBL_Vendedor_Veiculo
CREATE TABLE TBL_Vendedor_Veiculo (
    Cod_Vend int NOT NULL,
    Cod_Veiculo int NOT NULL,
    Data_Uso datetime NOT NULL DEFAULT (GETDATE()),
    FOREIGN KEY (Cod_Vend) REFERENCES TBL_Vendedor (Cod_Vend),
    FOREIGN KEY (Cod_Veiculo) REFERENCES TBL_Veiculo (Cod_Veiculo)
);

-- Criação a tabela TBL_Cliente
CREATE TABLE TBL_Cliente (
    Cod_Cliente int identity NOT NULL,
    Nome_Cliente varchar(151) NOT NULL,
    CPF varchar(11) NOT NULL,
    Telefone varchar(9) NOT NULL,
    PRIMARY KEY (Cod_Cliente)
);

-- Criação a tabela TBL_Nota_Fiscal
CREATE TABLE TBL_Nota_Fiscal (
    Cod_NF int identity NOT NULL,
    Cod_Vend int NOT NULL,
    Cod_Cliente int NOT NULL,
    Data_Venda datetime NOT NULL DEFAULT (GETDATE()),
    PRIMARY KEY (Cod_NF),
    FOREIGN KEY (Cod_Vend) REFERENCES TBL_Vendedor (Cod_Vend),
    FOREIGN KEY (Cod_Cliente) REFERENCES TBL_Cliente (Cod_Cliente)
);

-- Criação a tabela TBL_Produto
CREATE TABLE TBL_Produto (
    Cod_Prod int identity NOT NULL,
    Nome_Prod varchar(255) NOT NULL,
    QTDE_Estoque varchar(255) NOT NULL,
    Preco float NOT NULL,
    PRIMARY KEY (Cod_Prod)
);

-- Criação a tabela TBL_Item_Nota_Fiscal
CREATE TABLE TBL_Item_Nota_Fiscal (
    Cod_Item int identity NOT NULL,
    Cod_NF int NOT NULL,
    Cod_Prod int NOT NULL,
    QTDE_Vendido varchar(255) NOT NULL,
    PRIMARY KEY (Cod_Item),
    FOREIGN KEY (Cod_NF) REFERENCES TBL_Nota_Fiscal (Cod_NF),
    FOREIGN KEY (Cod_Prod) REFERENCES TBL_Produto (Cod_Prod)
);

-- Inserts das Tabelas

-- Insert Regiao
INSERT INTO TBL_Regiao (Nome_Reg)
VALUES 
	('Regiaão 1'),
	('Regiaão 2'),
	('Regiaão 3');

-- Insert Ponto_Estrategico
INSERT INTO TBL_Ponto_Estrategico (Nome_PE, Cod_Reg)
VALUES
	('Ponto 1', 1),
	('Ponto 2', 2),
	('Ponto 3', 3);

-- Insert Vendedor
INSERT INTO TBL_Vendedor (Nome_Vend, Cod_Reg)
VALUES
	('Vendedor A', 1),
	('Vendedor B', 2),
	('Vendedor C', 3);

-- Insert Veiculo
INSERT INTO TBL_Veiculo (Placa_Veiculo, Cor_Veiculo, Modelo)
VALUES
	('DZK-6713','Azul','Peugeot 208'),
	('COR-0101','Preto','Fiat Argo'),
	('BVC-4117','Vermelho','HB20');

-- Insert Vendedor_Veiculo
INSERT INTO TBL_Vendedor_Veiculo (Cod_Vend,Cod_Veiculo)
VALUES
	(1, 1),
	(2, 2),
	(3, 3);

-- Insert Cliente
INSERT INTO TBL_Cliente (Nome_Cliente, CPF, Telefone)
VALUES
	('Cliente A', 19324666061,997501045),
	('Cliente B', 16370765848, 994291490),
	('Cliente C', 83811914839, 992701461);

-- Insert Nota_Fiscal
INSERT INTO TBL_Nota_Fiscal (Cod_Vend,Cod_Cliente)
VALUES
	(1, 1),
	(2, 2),
	(3, 3);

-- Insert Produto
INSERT INTO TBL_Produto (Nome_Prod,QTDE_Estoque,Preco)
VALUES
	('Produto A', '10 unidades', 100.00),
	('Produto B', '5 unidades', 50.00),
	('Produto C', '15 unidades', 25.00);

-- Insert Item_Nota_Fiscal
INSERT INTO TBL_Item_Nota_Fiscal (Cod_NF, Cod_Prod, QTDE_Vendido)
VALUES
	(1, 1, '2 unidades'),
	(2, 2, '3 unidades'),
	(3, 3, '5 unidades');


-- SELECTS
SELECT * FROM TBL_Regiao
SELECT * FROM TBL_Ponto_Estrategico
SELECT * FROM TBL_Vendedor
SELECT * FROM TBL_Veiculo
SELECT * FROM TBL_Vendedor_Veiculo
SELECT * FROM TBL_Cliente
SELECT * FROM TBL_Nota_Fiscal
SELECT * FROM TBL_Produto
SELECT * FROM TBL_Item_Nota_Fiscal

 -- A - Listar todos os pontos estratégicos de cada região:
 SELECT TBL_Regiao.Nome_Reg, TBL_Ponto_Estrategico.Cod_PE
 FROM TBL_Regiao INNER JOIN TBL_Ponto_Estrategico 
 ON TBL_Regiao.Cod_Reg = TBL_Ponto_Estrategico.Cod_Reg;

 -- B - Listar os nomes das regiões cadastradas:
 SELECT TBL_Regiao.Nome_Reg
 FROM TBL_Regiao

 -- C - Listar todos os vendedores e quais veículos que eles utilizaram no último mês:
SELECT TBL_Vendedor.Nome_Vend, TBL_Vendedor_Veiculo.Cod_Veiculo, TBL_Vendedor_Veiculo.Data_Uso
FROM TBL_Vendedor INNER JOIN TBL_Vendedor_Veiculo
ON TBL_Vendedor.Cod_Vend = TBL_Vendedor_Veiculo.Cod_Vend
WHERE TBL_Vendedor_Veiculo.Data_Uso >= DATEADD(MONTH, -1, GETDATE());

-- D - Listar todos os vendedores responsáveis por cada região:
SELECT TBL_Regiao.Nome_Reg, TBL_Vendedor.Nome_Vend
FROM TBL_Regiao INNER JOIN TBL_Vendedor
ON TBL_Regiao.Cod_Reg = TBL_Vendedor.Cod_Reg;

-- E - Todos os produtos vendidos por um determinado vendedor:
SELECT TBL_Vendedor.Nome_Vend,TBL_Produto.Nome_Prod, TBL_Item_Nota_Fiscal.QTDE_Vendido
FROM TBL_Vendedor INNER JOIN TBL_Nota_Fiscal
ON TBL_Vendedor.Cod_Vend = TBL_Nota_Fiscal.Cod_Vend
INNER JOIN TBL_Item_Nota_Fiscal 
ON TBL_Nota_Fiscal.Cod_NF = TBL_Item_Nota_Fiscal.Cod_NF
INNER JOIN TBL_Produto
ON TBL_Item_Nota_Fiscal.Cod_Prod = TBL_Produto.Cod_Prod
WHERE TBL_Vendedor.Cod_Vend = 2;

-- F - Todos os vendedores que venderam um determinado produto:
SELECT TBL_Vendedor.Nome_Vend, TBL_Produto.Nome_Prod
FROM TBL_Vendedor INNER JOIN TBL_Nota_Fiscal
ON TBL_Vendedor.Cod_Vend = TBL_Nota_Fiscal.Cod_Vend
INNER JOIN TBL_Item_Nota_Fiscal
ON TBL_Nota_Fiscal.Cod_NF = TBL_Item_Nota_Fiscal.Cod_NF
INNER JOIN TBL_Produto
ON TBL_Item_Nota_Fiscal.Cod_Prod = TBL_Produto.Cod_Prod
WHERE TBL_Produto.Nome_Prod = 'Produto A';

-- G - Todos os produtos que ainda não foram vendidos:
SELECT TBL_Produto.Nome_Prod AS PRODUTO
FROM TBL_Produto LEFT JOIN TBL_Item_Nota_Fiscal
ON TBL_Produto.Cod_Prod = TBL_Item_Nota_Fiscal.Cod_Prod
WHERE TBL_Item_Nota_Fiscal.Cod_Prod IS NULL;

-- H - Listar o histórico de utilização de um determinado veículo:
SELECT TBL_Vendedor_Veiculo.Cod_Vend, TBL_Vendedor.Nome_Vend, TBL_Vendedor_Veiculo.Data_Uso
FROM TBL_Veiculo INNER JOIN TBL_Vendedor_Veiculo 
ON TBL_Veiculo.Cod_Veiculo = TBL_Vendedor_Veiculo.Cod_Veiculo
INNER JOIN TBL_Vendedor
ON TBL_Vendedor_Veiculo.Cod_Vend = TBL_Vendedor.Cod_Vend
WHERE TBL_Veiculo.Placa_Veiculo = 'BVC-4117';

-- I - A quantidade de itens de cada nota fiscal:
SELECT TBL_Nota_Fiscal.Cod_NF, COUNT(TBL_Item_Nota_Fiscal.Cod_Item) AS QUANTIDADE_DE_ITENS
FROM TBL_Nota_Fiscal INNER JOIN TBL_Item_Nota_Fiscal
ON TBL_Nota_Fiscal.Cod_NF = TBL_Item_Nota_Fiscal.Cod_NF
GROUP BY TBL_Nota_Fiscal.Cod_NF;

