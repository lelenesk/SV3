-- Összegezzük adott idõszak forgalmát országonként, de 
-- csak azok az országok jelenjenek meg, ahol az idõszak 
-- forgalma egy megadott paraméterösszeg fölött van

-- 1. fázis: WHERE feltételes szûrés
DECLARE @FromDate datetime = '20130101', 
		@ToDate   datetime = '20130131'
SELECT ST.CountryRegionCode, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
LEFT JOIN Sales.SalesTerritory ST ON SOH.TerritoryID = ST.TerritoryID 
WHERE SOH.DueDate BETWEEN @FromDate AND @ToDate
GO

-- 2. fázis: GROUP BY
DECLARE @FromDate datetime = '20130101', 
		@ToDate   datetime = '20130131',
		@Limit	  money    = 100000
SELECT ST.CountryRegionCode, SUM(SOH.TotalDue) TotalSales
FROM Sales.SalesOrderHeader SOH
LEFT JOIN Sales.SalesTerritory ST ON SOH.TerritoryID = ST.TerritoryID 
WHERE SOH.DueDate BETWEEN @FromDate AND @ToDate
GROUP BY ST.CountryRegionCode
GO

-- 3. fázis HAVING + további aggregáló függvények
DECLARE @FromDate datetime = '20130101', 
		@ToDate   datetime = '20130131',
		@Limit	  money    = 100000
SELECT ST.CountryRegionCode, SUM(SOH.TotalDue) TotalSales, 
	COUNT(1) NoOfOrders, COUNT(SOH.CreditCardID),
	AVG(SOH.TotalDue) AvgSales, 
	MIN(SOH.TotalDue) MinSales, MAX(SOH.TotalDue) MaxSales
FROM Sales.SalesOrderHeader SOH
LEFT JOIN Sales.SalesTerritory ST ON SOH.TerritoryID = ST.TerritoryID 
WHERE SOH.DueDate BETWEEN @FromDate AND @ToDate
GROUP BY ST.CountryRegionCode
HAVING SUM(SOH.TotalDue) > @Limit
GO

-- Egészítsük ki az elõzõ lekérdezést a kereskedõvel (SalesPerson), azaz
-- országonként és kereskedõnként jelenjenek meg az adatok
DECLARE @FromDate datetime = '20130101', 
		@ToDate   datetime = '20130131',
		@Limit	  money    = 100000
SELECT ST.CountryRegionCode, CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName) SalesPersonName,
	SUM(SOH.TotalDue) TotalSales, 
	COUNT(1) NoOfOrders, COUNT(SOH.CreditCardID),
	AVG(SOH.TotalDue) AvgSales, 
	MIN(SOH.TotalDue) MinSales, MAX(SOH.TotalDue) MaxSales
FROM Sales.SalesOrderHeader SOH
LEFT JOIN Sales.SalesTerritory ST ON SOH.TerritoryID = ST.TerritoryID
LEFT JOIN Person.Person P ON SOH.SalesPersonID = P.BusinessEntityID 
WHERE SOH.DueDate BETWEEN @FromDate AND @ToDate
GROUP BY ST.CountryRegionCode, CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName)
HAVING SUM(SOH.TotalDue) > @Limit
ORDER BY 1,2
GO

-- Vajon mi van, ha hibás logikával a WHERE helyett a HAVING szintjén
-- akarunk az US országra szûrni? A végrehajtási terv mindent elárul:)
DECLARE @FromDate datetime = '20130101', 
		@ToDate   datetime = '20130131',
		@Limit	  money    = 100000
SELECT ST.CountryRegionCode, CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName) SalesPersonName,
	SUM(SOH.TotalDue) TotalSales, 
	COUNT(1) NoOfOrders, COUNT(SOH.CreditCardID),
	AVG(SOH.TotalDue) AvgSales, 
	MIN(SOH.TotalDue) MinSales, MAX(SOH.TotalDue) MaxSales
FROM Sales.SalesOrderHeader SOH
LEFT JOIN Sales.SalesTerritory ST ON SOH.TerritoryID = ST.TerritoryID
LEFT JOIN Person.Person P ON SOH.SalesPersonID = P.BusinessEntityID 
WHERE SOH.DueDate BETWEEN @FromDate AND @ToDate
GROUP BY ST.CountryRegionCode, CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName)
HAVING ST.CountryRegionCode = 'US'
ORDER BY 1,2

-- Ide is kellene egy GO, különben a következõ példa deklarációit aláhúzza pirossal

-- Az elõzõ lekérdezést cizelláljuk tovább úgy, hogy 3 oszlopban jelenjen meg a forgalom:
--	1. oszlop: Hitelkártyával vásárlás összege
--  2. oszlop: Hitelkártya nélküli vásárlás összege
--  3. oszlop: A teljes forgalom - úgy, ahogy eddig is megjelent
-- További igény, hogy jelenítsük meg, hogy hány különbözõ napon történtek a vásárlások
DECLARE @FromDate datetime = '20130101', 
		@ToDate   datetime = '20130131',
		@Limit	  money    = 100000
SELECT ST.CountryRegionCode, CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName) SalesPersonName,
	SUM(IIF(SOH.CreditCardID IS NOT NULL, SOH.TotalDue, 0)) CreditCardSales,
	SUM(IIF(SOH.CreditCardID IS NULL, SOH.TotalDue, 0)) CashSales,
	SUM(SOH.TotalDue) TotalSales,
	COUNT(SOH.DueDate) NoOfDueDates_Bad, COUNT(DISTINCT SOH.DueDate) NoOfDueDates_Correct,
	COUNT(1) NoOfOrders, COUNT(SOH.CreditCardID) NoOfCreditCardOrders,
	AVG(SOH.TotalDue) AvgSales, 
	MIN(SOH.TotalDue) MinSales, MAX(SOH.TotalDue) MaxSales
FROM Sales.SalesOrderHeader SOH
LEFT JOIN Sales.SalesTerritory ST ON SOH.TerritoryID = ST.TerritoryID
LEFT JOIN Person.Person P ON SOH.SalesPersonID = P.BusinessEntityID 
WHERE SOH.DueDate BETWEEN @FromDate AND @ToDate
GROUP BY ST.CountryRegionCode, CONCAT(P.LastName, ' ' + P.MiddleName, ', ' + P.FirstName)
HAVING SUM(SOH.TotalDue) > @Limit
ORDER BY 1,2 