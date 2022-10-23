-- Tábla nélküli skalár SELECT
SELECT 'Training360', 'Budapest', 11

-- A tábla összes sora
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product

-- A tábla összes sora és összes oszlopa
SELECT *
FROM Production.Product

-- Kifejezések használata
SELECT ProductID, Name + ' (' + ProductNumber + ')', YEAR(SellStartDate), 
	ListPrice - StandardCost 
FROM Production.Product

-- Alias alkalmazása a kifejezéseknél
SELECT ProductID, Name + ' (' + ProductNumber + ')' AS ProductName, YEAR(SellStartDate) AS SellStartYear,
	ListPrice - StandardCost AS Revenue
FROM Production.Product

-- ALias alkalmazása a táblára (most már az AS nélkül)
SELECT P.ProductID, P.Name + ' (' + P.ProductNumber + ')' ProductName, YEAR(P.SellStartDate) SellStartYear,
	P.ListPrice - P.StandardCost Revenue
FROM Production.Product P

