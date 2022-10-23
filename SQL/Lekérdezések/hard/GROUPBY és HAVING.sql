-- �sszegezz�k adott id�szak forgalm�t orsz�gonk�nt, de 
-- csak azok az orsz�gok jelenjenek meg, ahol az id�szak 
-- forgalma egy megadott param�ter�sszeg f�l�tt van

-- 1. f�zis: WHERE felt�teles sz�r�s
DECLARE @FromDate datetime = '20130101', 
		@ToDate   datetime = '20130131'
SELECT ST.CountryRegionCode, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
LEFT JOIN Sales.SalesTerritory ST ON SOH.TerritoryID = ST.TerritoryID 
WHERE SOH.DueDate BETWEEN @FromDate AND @ToDate
GO

-- 2. f�zis: GROUP BY
DECLARE @FromDate datetime = '20130101', 
		@ToDate   datetime = '20130131',
		@Limit	  money    = 100000
SELECT ST.CountryRegionCode, SUM(SOH.TotalDue) TotalSales
FROM Sales.SalesOrderHeader SOH
LEFT JOIN Sales.SalesTerritory ST ON SOH.TerritoryID = ST.TerritoryID 
WHERE SOH.DueDate BETWEEN @FromDate AND @ToDate
GROUP BY ST.CountryRegionCode
GO

-- 3. f�zis HAVING + tov�bbi aggreg�l� f�ggv�nyek
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

-- Eg�sz�ts�k ki az el�z� lek�rdez�st a keresked�vel (SalesPerson), azaz
-- orsz�gonk�nt �s keresked�nk�nt jelenjenek meg az adatok
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

-- Vajon mi van, ha hib�s logik�val a WHERE helyett a HAVING szintj�n
-- akarunk az US orsz�gra sz�rni? A v�grehajt�si terv mindent el�rul:)
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

-- Ide is kellene egy GO, k�l�nben a k�vetkez� p�lda deklar�ci�it al�h�zza pirossal

-- Az el�z� lek�rdez�st cizell�ljuk tov�bb �gy, hogy 3 oszlopban jelenjen meg a forgalom:
--	1. oszlop: Hitelk�rty�val v�s�rl�s �sszege
--  2. oszlop: Hitelk�rtya n�lk�li v�s�rl�s �sszege
--  3. oszlop: A teljes forgalom - �gy, ahogy eddig is megjelent
-- Tov�bbi ig�ny, hogy jelen�ts�k meg, hogy h�ny k�l�nb�z� napon t�rt�ntek a v�s�rl�sok
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