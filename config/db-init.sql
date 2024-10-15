USE [master]
GO

IF DB_ID('RestaurantDb') IS NOT NULL
	SET NOEXEC ON

CREATE DATABASE [RestaurantDb];
GO


USE RestaurantDb;
GO


CREATE TABLE dbo.Ingredient
(
	id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	description TEXT NULL,
	ingredientPrice DECIMAL(19,2)
);


CREATE TABLE dbo.DishType(
	id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	name VARCHAR(255)  NOT NULL,
);


SET IDENTITY_INSERT dbo.Ingredient ON;
INSERT INTO dbo.Ingredient(id,name,ingredientPrice)
VALUES
(1,'manzana',5.2),
(2,'cebolla',2.5),
(3,'sal',3.5),
(4,'limon',4.5),
(5,'pan',10.0),
(6,'yogurt',10.0),
(7,'agua',15.0);
SET IDENTITY_INSERT dbo.Ingredient OFF;

SET IDENTITY_INSERT dbo.DishType ON;
INSERT INTO dbo.DishType(id,name) VALUES (1,'aperitvo'),(2,'postre');
SET IDENTITY_INSERT dbo.DishType OFF;

CREATE TABLE dbo.Dish(
	id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	idDishType INT,
	name VARCHAR(255),
	description TEXT,
	dishPrice DECIMAL(19,2),
	CONSTRAINT fk_dish_type FOREIGN KEY(idDishType) REFERENCES dbo.DishType(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

SET IDENTITY_INSERT dbo.Dish ON;
INSERT INTO dbo.Dish(id,idDishType,name,description,dishPrice)
    VALUES
(1,1,'ensalada de manzana','ensalada de manzana',40.0),
(2,1,'ensalada ligera','ensalada ligera',30);
SET IDENTITY_INSERT dbo.Dish OFF;

CREATE TABLE dbo.IngredientXDish(
    id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    idIngredient INT,
    idDish INT,
    quantity INT,
    CONSTRAINT fk_ixd_i FOREIGN KEY(idIngredient) REFERENCES dbo.Ingredient(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_ixd_d FOREIGN KEY(idDish) REFERENCES dbo.Dish(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

SET IDENTITY_INSERT dbo.IngredientXDish ON;
INSERT INTO dbo.IngredientXDish(id,idIngredient,idDish,quantity) VALUES
(1,1,1,3),
(2,6,1,1),
(3,2,2,3),
(4,3,2,2),
(5,4,2,2);
SET IDENTITY_INSERT dbo.IngredientXDish OFF;

CREATE TABLE dbo.PurchaseOrder(
    id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    idDish INT,
    totalPrice DECIMAL(19,2),
    CONSTRAINT fk_p_d FOREIGN KEY(idDish) REFERENCES dbo.Dish(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- Crear la tabla OrderDetail
CREATE TABLE dbo.OrderDetail (
    id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    idPurchaseOrder INT,
    idDish INT,
    CONSTRAINT fk_od_p FOREIGN KEY(idPurchaseOrder) REFERENCES dbo.PurchaseOrder(id),
    CONSTRAINT fk_od_d FOREIGN KEY(idDish) REFERENCES dbo.Dish(id)
);
GO

CREATE PROCEDURE dbo.SP_CREATE_INGREDIENT(
    @name VARCHAR(100),
    @description VARCHAR(MAX) = NULL,
    @ingredientPrice DECIMAL(19, 2)
)
AS
BEGIN

    INSERT INTO dbo.Ingredient (name, description, ingredientPrice) VALUES (@name, @description, @ingredientPrice);
END
GO

CREATE PROCEDURE dbo.GET_DISHES
AS
BEGIN
    SELECT
        d.id,
        d.name,
        d.description,
        d.dishPrice AS dishPrice,
        d.idDishType AS dishTypeId,
        dt.name AS dishTypeName
    FROM
        dbo.Dish d
        INNER JOIN dbo.DishType dt ON d.idDishType = dt.id;
END
GO

CREATE PROCEDURE dbo.GET_INGREDIENTS_FROM_DISH(
    @dish_id INT
)
AS
BEGIN
    SELECT
        ixd.idIngredient AS id,
        ixd.quantity AS quantity,
        i.name AS ingredient_name,
        i.ingredientPrice AS unitIngredient,
        (i.ingredientPrice * ixd.quantity) AS totalPriceIngrediente
    FROM
        dbo.IngredientXDish ixd
        INNER JOIN dbo.Dish d ON d.id = ixd.idDish
        INNER JOIN dbo.Ingredient i ON ixd.idIngredient = i.id
    WHERE
        ixd.idDish = @dish_id;
END
GO

SET IDENTITY_INSERT dbo.IngredientXDish ON;
INSERT INTO dbo.IngredientXDish(id, idIngredient, idDish, quantity) VALUES
(6, 8, 3, 2),   -- ajo en pasta con pollo
(7, 16, 3, 3),  -- pasta en pasta con pollo
(8, 17, 3, 1),  -- pollo en pasta con pollo
(9, 9, 4, 4),   -- zanahoria en sopa de zanahoria
(10, 8, 4, 2),  -- ajo en sopa de zanahoria
(11, 10, 5, 2), -- tomate en ensalada griega
(12, 11, 5, 1), -- pepino en ensalada griega
(13, 12, 5, 3), -- queso en ensalada griega
(14, 13, 7, 1), -- aceite de oliva en papas al horno
(15, 26, 7, 4), -- papas en papas al horno
(16, 18, 8, 2), -- carne de res en carne asada
(17, 23, 8, 1), -- pimienta en carne asada
(18, 25, 9, 3), -- limón amarillo en jugo de limón
(19, 24, 8, 1), -- perejil en carne asada
(20, 8, 10, 2), -- ajo en pan de ajo
(21, 12, 11, 2), -- queso en sándwich de pollo
(22, 17, 11, 2), -- pollo en sándwich de pollo
(23, 27, 8, 1), -- ajo en polvo en carne asada
(24, 19, 12, 2), -- papas en papas fritas
(25, 13, 12, 1); -- aceite de oliva en papas fritas
SET IDENTITY_INSERT dbo.IngredientXDish OFF;

SET IDENTITY_INSERT dbo.DishType ON;
INSERT INTO dbo.DishType(id, name) VALUES
(3, 'entrada'),
(4, 'principal'),
(5, 'sopa'),
(6, 'bebida'),
(7, 'ensalada'),
(8, 'snack'),
(9, 'pan'),
(10, 'guarnición'),
(11, 'sándwich'),
(12, 'plato fuerte');
SET IDENTITY_INSERT dbo.DishType OFF;

SET IDENTITY_INSERT dbo.Dish ON;
INSERT INTO dbo.Dish(id, idDishType, name, description, dishPrice) VALUES
(3, 4, 'pasta con pollo', 'deliciosa pasta con pollo', 55.0),
(4, 3, 'sopa de zanahoria', 'crema de zanahoria con un toque de ajo', 25.0),
(5, 7, 'ensalada griega', 'ensalada con queso, tomate y pepino', 40.0),
(6, 4, 'arroz con pollo', 'arroz cocido con pollo y especias', 50.0),
(7, 10, 'papas al horno', 'papas horneadas con aceite de oliva', 35.0),
(8, 12, 'carne asada', 'carne de res asada con pimienta y ajo', 70.0),
(9, 6, 'jugo de limón', 'jugo de limón fresco', 20.0),
(10, 9, 'pan de ajo', 'pan tostado con ajo y aceite de oliva', 25.0),
(11, 11, 'sándwich de pollo', 'sándwich con pollo y queso', 45.0),
(12, 8, 'papas fritas', 'papas fritas crocantes', 30.0);
SET IDENTITY_INSERT dbo.Dish OFF;

SET IDENTITY_INSERT dbo.IngredientXDish ON;
INSERT INTO dbo.IngredientXDish(id, idIngredient, idDish, quantity) VALUES
(6, 8, 3, 2),   -- ajo en pasta con pollo
(7, 16, 3, 3),  -- pasta en pasta con pollo
(8, 17, 3, 1),  -- pollo en pasta con pollo
(9, 9, 4, 4),   -- zanahoria en sopa de zanahoria
(10, 8, 4, 2),  -- ajo en sopa de zanahoria
(11, 10, 5, 2), -- tomate en ensalada griega
(12, 11, 5, 1), -- pepino en ensalada griega
(13, 12, 5, 3), -- queso en ensalada griega
(14, 13, 7, 1), -- aceite de oliva en papas al horno
(15, 26, 7, 4), -- papas en papas al horno
(16, 18, 8, 2), -- carne de res en carne asada
(17, 23, 8, 1), -- pimienta en carne asada
(18, 25, 9, 3), -- limón amarillo en jugo de limón
(19, 24, 8, 1), -- perejil en carne asada
(20, 8, 10, 2), -- ajo en pan de ajo
(21, 12, 11, 2), -- queso en sándwich de pollo
(22, 17, 11, 2), -- pollo en sándwich de pollo
(23, 27, 8, 1), -- ajo en polvo en carne asada
(24, 19, 12, 2), -- papas en papas fritas
(25, 13, 12, 1); -- aceite de oliva en papas fritas
SET IDENTITY_INSERT dbo.IngredientXDish OFF;


EXEC  dbo.GET_INGREDIENTS_FROM_DISH @dish_id = 6