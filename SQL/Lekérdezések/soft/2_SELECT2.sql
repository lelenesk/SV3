-- T�bla n�lk�li skal�r SELECT
SELECT 'Training360', 'Budapest', 11

-- A t�bla �sszes sora
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product

-- A t�bla �sszes sora �s �sszes oszlopa
SELECT *
FROM Production.Product

-- Kifejez�sek haszn�lata
SELECT ProductID, Name + ' (' + ProductNumber + ')', YEAR(SellStartDate), 
	ListPrice - StandardCost 
FROM Production.Product

-- Alias alkalmaz�sa a kifejez�sekn�l
SELECT ProductID, Name + ' (' + ProductNumber + ')' AS ProductName, YEAR(SellStartDate) AS SellStartYear,
	ListPrice - StandardCost AS Revenue
FROM Production.Product

-- ALias alkalmaz�sa a t�bl�ra (most m�r az AS n�lk�l)
SELECT P.ProductID, P.Name + ' (' + P.ProductNumber + ')' ProductName, YEAR(P.SellStartDate) SellStartYear,
	P.ListPrice - P.StandardCost Revenue
FROM Production.Product P

