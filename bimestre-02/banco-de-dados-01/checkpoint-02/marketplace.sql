/*
Este script simula um Marketplace simples, no qual há compradores (Buyers) e Vendedores (Sellers).

Algumas regras de negócio importantes deste modelo são:
- Podem haver vendedores sem nenhum produto cadastrado;
- O campo shipment_delivery_date na tabela Shipments pode ser nulo, pois o produto pode ainda estar em trânsito;
- O campo card_number na tabela Payments só será preenchido caso o método de pagamento for com cartão.

Ao longo do script serão feitas algumas observações sobre as operações realizadas;
 */

-- Criação e ativação do banco de dados MarketplaceDH.
DROP DATABASE IF EXISTS MarketplaceDH;
CREATE DATABASE MarketplaceDH;
USE MarketplaceDH;

-- Criação das tabelas na ordem necessária para que as Foreign Keys possam ser criadas juntamente.
CREATE TABLE Buyers(
	buyer_id INT NOT NULL AUTO_INCREMENT,
    buyer_name VARCHAR(50) NOT NULL,
    buyer_cpf CHAR(11) NOT NULL,
    buyer_birth_date DATE NOT NULL,
    buyer_email VARCHAR(50) NOT NULL,
    buyer_address VARCHAR(100) NOT NULL,
    buyer_phone BIGINT NOT NULL,
    CONSTRAINT PK_Buyers PRIMARY KEY (buyer_id)
);

CREATE TABLE Shipments(
	shipment_id INT NOT NULL AUTO_INCREMENT,
	delivery_address VARCHAR(100) NOT NULL,
    shipment_cost DECIMAL(10, 2) NOT NULL,
    shipment_send_date DATE NOT NULL,
    shipment_delivery_date DATE NULL,
    CONSTRAINT PK_Shipments PRIMARY KEY (shipment_id)
);

CREATE TABLE Payments(
	payment_id INT NOT NULL AUTO_INCREMENT,
    payment_method VARCHAR(20) NOT NULL,
    payment_amount DECIMAL(10, 2) NOT NULL,
    card_number CHAR(16) NULL,
    CONSTRAINT PK_Payments PRIMARY KEY (payment_id)
);

CREATE TABLE Orders(
	order_id INT NOT NULL AUTO_INCREMENT,
    buyer_id INT NOT NULL,
    shipment_id INT NOT NULL,
    payment_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_Orders PRIMARY KEY (order_id),
    CONSTRAINT FK_Orders_Buyers FOREIGN KEY (buyer_id)
		REFERENCES Buyers(buyer_id),
	CONSTRAINT FK_Orders_Shipments FOREIGN KEY (buyer_id)
		REFERENCES Shipments(shipment_id),
	CONSTRAINT FK_Orders_Payments FOREIGN KEY (buyer_id)
		REFERENCES Payments(payment_id)
);

CREATE TABLE Sellers(
	seller_id INT NOT NULL AUTO_INCREMENT,
    seller_name VARCHAR(30) NOT NULL,
    seller_cnpj CHAR(14) NOT NULL,
    seller_email VARCHAR(50) NOT NULL,
    seller_address VARCHAR(100) NOT NULL,
    seller_phone BIGINT NOT NULL,
    CONSTRAINT PK_Sellers PRIMARY KEY (seller_id)
);

CREATE TABLE Products(
	product_id INT NOT NULL AUTO_INCREMENT,
    seller_id INT NOT NULL,
    product_name VARCHAR(50) NOT NULL,
    product_description VARCHAR(200) NOT NULL,
    product_price DECIMAL(10, 2) NOT NULL,
    quantity_in_stock INT NOT NULL,
    CONSTRAINT PK_Products PRIMARY KEY (product_id),
    CONSTRAINT FK_Products_Sellers FOREIGN KEY (seller_id)
		REFERENCES Sellers(seller_id)
);

CREATE TABLE OrdersProducts(
	order_product_id INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    CONSTRAINT PK_OrdersProducts PRIMARY KEY (order_product_id),
    CONSTRAINT FK_OrdersProducts_Orders FOREIGN KEY (order_id)
		REFERENCES Orders(order_id),
	CONSTRAINT FK_OrdersProducts_Products FOREIGN KEY (product_id)
		REFERENCES Products(product_id)
);

-- Inserção dos dados dos vendedores e seus produtos.
INSERT INTO Sellers
	VALUES (DEFAULT, "Magazine Luiz", "98765432100000", "magazineluiz@exemplo.com", "Av. das Nações Unidas, 2000. Osasco - SP", 11988888888);
    
INSERT INTO Products
	VALUES (DEFAULT, 1, "Mouse e Teclado", "Conjunto com mouse 1.600 DPI e teclado ABNT.", 90.00, 10);
    
INSERT INTO Products
	VALUES (DEFAULT, 1, "Caixa de som", "Caixa de som para computador com conexão USB.", 50.00, 20);


-- Inserção dos dados da compra realizada pelo primeiro comprador.
INSERT INTO Buyers
	VALUES (DEFAULT, "Maria da Silva", "12345678900", "1992-09-28", "maria@exemplo.com", "Rua Getúlio Vargas, 1500. Porto Alegre - RS", 51999999999);
    
INSERT INTO Shipments (shipment_id, delivery_address, shipment_cost, shipment_send_date)
	VALUES (DEFAULT, "Av. Desembargador Moreira, 1200. Fortaleza - CE", 19.99, "2022-04-03");
    
INSERT INTO Payments
	VALUES (DEFAULT, "Cartão de crédito", 159.99, "123456******7890");

INSERT INTO Orders
	VALUES (DEFAULT, 1, 1, 1, "2022-04-03", 140.00);
    
INSERT INTO OrdersProducts
	VALUES (DEFAULT, 1, 1);
    
INSERT INTO OrdersProducts
	VALUES (DEFAULT, 1, 2);


-- Neste momento, o preço de um dos produtos é atualizado.
UPDATE Products
SET product_price = 100.00
WHERE product_id = 1;


-- Inserção dos dados da compra realizada pelo segundo comprador.
INSERT INTO Buyers
	VALUES (DEFAULT, "Felipe da Souza", "00987654321", "1998-05-21", "felipe@exemplo.com", "Av. Desembargador Moreira, 1200. Fortaleza - CE", 81977777777);
    
INSERT INTO Shipments
	VALUES (DEFAULT, "Rua Getúlio Vargas, 1500. Porto Alegre - RS", 9.99, "2022-04-01", "2022-04-05");
    
INSERT INTO Payments (payment_id, payment_method, payment_amount)
	VALUES (DEFAULT, "Boleto", 99.99);
    
INSERT INTO Orders
	VALUES (DEFAULT, 2, 2, 2, "2022-04-01", 100.00);

INSERT INTO OrdersProducts
	VALUES (DEFAULT, 2, 1);
    
    
/*
Neste momento, considera-se que a primeira compra foi cancelada (apenas para ilustação, certamente não seria correto remover registros neste caso).
Para que seja possível excluir o registro da tabela Orders, primeiramente é preciso excluir o registro da tabela OrdersProducts,
pois ela tem um chave estrangeira que referencia a tabela Orders.
*/
DELETE FROM OrdersProducts
WHERE order_id = 1;

DELETE FROM Orders
WHERE order_id = 1;


/* É feita uma seleção de dados buscando o faturamento dos vendedores. Nota-se que o resultado mostra somente o valor total da segunda compra.
Isso ocorre porque a primeira compra foi excluída da tabela Orders, que é de onde estamos buscando os valores recebidos pelo vendedor.
Nota-se também que o valor mostrado é o valor atualizado do produto, uma vez que a atualização do seu preço foi feita antes da segunda compra.
*/
SELECT Sellers.seller_id, Sellers.seller_name, SUM(DISTINCT Orders.total_amount) AS faturamento
FROM Sellers
	LEFT JOIN Products ON Sellers.seller_id = Products.seller_id
	LEFT JOIN OrdersProducts ON Products.product_id = OrdersProducts.product_id
    LEFT JOIN Orders ON OrdersProducts.order_id = Orders.order_id
GROUP BY Sellers.seller_id;