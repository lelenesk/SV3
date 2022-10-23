-- Termékek listaárának eltérése az alkategória átlagos listaárától
-- Hagyományos megoldás, azaz SQL Windowing nélkül
WITH SubcategoryAvgPrice AS
	(SELECT P.ProductSubcategoryID, AVG(P.ListPrice) AvgListPrice
	FROM Production.Product P
	WHERE P.ListPrice > 0
	GROUP BY P.ProductSubcategoryID)
SELECT P.ProductID, P.Name, P.Color, P.ListPrice, PS.AvgListPrice,
	P.ListPrice - PS.AvgListPrice ListPriceDiff 
FROM Production.Product P
INNER JOIN SubcategoryAvgPrice PS ON
	COALESCE(P.ProductSubcategoryID,0) = COALESCE(PS.ProductSubcategoryID,0)
WHERE P.ListPrice > 0
ORDER BY 2 

-- Az elõzõvel funkcionálisan megegyezõ megoldás, SQL Windowing révén
-- Érdemes összehasonlítani a kettõt
SELECT P.ProductID, P.Name, P.Color, P.ListPrice, 
	AVG(P.ListPrice) OVER(PARTITION BY P.ProductSubCategoryID) AvgListPrice,
	P.ListPrice - AVG(P.ListPrice) OVER(PARTITION BY P.ProductSubCategoryID) ListPriceDiff 
FROM Production.Product P
LEFT JOIN Production.ProductSubcategory PS ON
	P.ProductSubcategoryID = PS.ProductSubcategoryID
WHERE P.ListPrice > 0
ORDER BY 2 

-- Vevõk vásárlásainak összegzése (futó összesen)
SELECT * FROM (
SELECT SOH.CustomerID, SOH.SalesOrderID, SOH.DueDate, SOH.TotalDue,
	SUM(SOH.TotalDue) OVER (PARTITION BY SOH.CustomerID, YEAR(SOH.DueDate)	
		ORDER BY SOH.SalesOrderID
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) CustomerTotal
FROM Sales.SalesOrderHeader SOH) X
WHERE CustomerTotal > 50000
ORDER BY 1, 2

;WITH Sales AS
(SELECT YEAR(SOH.DueDate) DueYear, P.ProductID, P.Name ProductName, 
	PS.ProductSubcategoryID, PS.Name SubcategoryName,
	PC.ProductCategoryID, PC.Name CategoryName, SUM(SOD.LineTotal) LineTotal
FROM Sales.SalesOrderDetail SOD
INNER JOIN Sales.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
INNER JOIN Production.Product P ON SOD.ProductID = P.ProductID
LEFT JOIN Production.ProductSubcategory PS ON
	P.ProductSubcategoryID = PS.ProductSubcategoryID
LEFT JOIN Production.ProductCategory PC ON PS.ProductCategoryID = PC.ProductCategoryID
GROUP BY YEAR(SOH.DueDate), P.ProductID, P.Name, 
	PS.ProductSubcategoryID, Ps.Name, PC.ProductCategoryID, PC.Name)
SELECT *, 
	S.LineTotal / SUM(S.LineTotal) 
		OVER(PARTITION BY S.ProductSubcategoryID, S.DueYear) SubcategoryRate,
	SUM(S.LineTotal) OVER(PARTITION BY S.ProductSubcategoryID, S.DueYear) /
	SUM(S.LineTotal) OVER(PARTITION BY S.ProductCategoryID, S.DueYear) CategoryRate
FROM Sales S
ORDER BY S.DueYear, S.ProductName
    