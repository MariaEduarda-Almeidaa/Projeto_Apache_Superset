CREATE DATABASE vendas;
\connect vendas;
CREATE TABLE vendas (
 id SERIAL PRIMARY KEY, data_venda DATE NOT NULL, vendedor VARCHAR(80) NOT NULL,
 produto VARCHAR(100) NOT NULL, categoria VARCHAR(60) NOT NULL, regiao VARCHAR(40) NOT NULL,
 quantidade INTEGER NOT NULL, valor_unitario NUMERIC(10,2) NOT NULL
);
INSERT INTO vendas (data_venda,vendedor,produto,categoria,regiao,quantidade,valor_unitario) VALUES
('2026-01-05','Ana','Notebook','Informática','Sudeste',2,3500),
('2026-01-08','Bruno','Mouse','Acessórios','Sul',10,80),
('2026-01-12','Carla','Monitor','Informática','Sudeste',3,950),
('2026-01-15','Ana','Teclado','Acessórios','Nordeste',5,150),
('2026-02-02','Diego','Notebook','Informática','Sul',1,3500),
('2026-02-07','Bruno','Headset','Acessórios','Sudeste',4,220),
('2026-02-11','Carla','Monitor','Informática','Centro-Oeste',2,950),
('2026-02-18','Ana','Mouse','Acessórios','Nordeste',12,80),
('2026-03-03','Diego','Notebook','Informática','Sudeste',2,3500),
('2026-03-09','Carla','Teclado','Acessórios','Sul',8,150),
('2026-03-14','Bruno','Monitor','Informática','Nordeste',1,950),
('2026-03-21','Ana','Headset','Acessórios','Centro-Oeste',6,220),
('2026-04-04','Diego','Mouse','Acessórios','Sudeste',15,80),
('2026-04-10','Carla','Notebook','Informática','Sul',1,3500),
('2026-04-16','Bruno','Teclado','Acessórios','Sudeste',7,150),
('2026-04-23','Ana','Monitor','Informática','Nordeste',3,950),
('2026-05-02','Diego','Headset','Acessórios','Sul',5,220),
('2026-05-08','Bruno','Notebook','Informática','Centro-Oeste',1,3500),
('2026-05-17','Carla','Mouse','Acessórios','Sudeste',9,80),
('2026-05-25','Ana','Monitor','Informática','Sul',2,950),
('2026-06-01','Diego','Teclado','Acessórios','Nordeste',10,150),
('2026-06-07','Bruno','Notebook','Informática','Sudeste',2,3500),
('2026-06-15','Carla','Headset','Acessórios','Centro-Oeste',4,220),
('2026-06-22','Ana','Mouse','Acessórios','Sul',11,80);
CREATE VIEW resumo_vendas AS
SELECT id,data_venda,vendedor,produto,categoria,regiao,quantidade,valor_unitario,
       quantidade * valor_unitario AS faturamento
FROM vendas;
