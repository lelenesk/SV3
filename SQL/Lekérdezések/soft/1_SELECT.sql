-- A logikai végrehajtási sorrendbõl fakadó következmények: 
-- A SELECT késõbb hozza létre a Revenue aliast, ezért nem lehet korábban a WHERE-ben hivatkozni rá:
SELECT P.ProductID, P.Name, P.ListPrice, P.StandardCost, P.ListPrice - P.StandardCost Revenue
FROM Production.Product P
WHERE Revenue > 1000

-- A korrekt szintaxis:
SELECT P.ProductID, P.Name, P.ListPrice, P.StandardCost, P.ListPrice - P.StandardCost Revenue
FROM Production.Product P
WHERE P.ListPrice - P.StandardCost > 1000

-- Ha le akarjuk rendezni az eredményt a jövedelem mezõre, akkor az ORDER BY-ban már felhasználhatjuk a Revenue mezõt,
-- mert az ORDER BY a SELECT után jön logikailag
SELECT P.ProductID, P.Name, P.ListPrice, P.StandardCost, P.ListPrice - P.StandardCost Revenue
FROM Production.Product P
WHERE P.ListPrice - P.StandardCost > 1000
ORDER BY Revenue DESC

-- Változó feltöltõ SELECT
DECLARE @RedProducts varchar(1000) = ''
SELECT @RedProducts += ', ' + CAST(P.ProductID AS varchar(10))
FROM Production.Product P
WHERE P.Color = 'Red'
SET @RedProducts = STUFF(@RedProducts,1,2,'')
SELECT @RedProducts

-- 2017-es korszerûsített megvalósítás
DECLARE @RedProducts2 varchar(1000) = ''
SELECT STRING_AGG(P.ProductID, ',')
FROM Production.Product P
WHERE P.Color = 'Red'

