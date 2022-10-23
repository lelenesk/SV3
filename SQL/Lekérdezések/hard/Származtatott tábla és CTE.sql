/* Készítsünk kimutatást a Sales.SalesOrderHeader tábla alapján, 
	hogy hány olyan vevõnk volt, aki 1-szer, hány olyan, aki kétszer, háromszor stb. 
	vásárolt. Az eredmény az alábbi formájú legyen:

Vásárlások száma	Hány partner
	1					1200
	2					 210
	3					  40
	4
	27
	28					  2*/

-- 1. verzió: Származtatott tábla (Derived table)
SELECT X.NoOfSales, COUNT(1) SalesNo
FROM (SELECT SOH.CustomerID, COUNT(1) NoOfSales
	  FROM Sales.SalesOrderHeader SOH
	  GROUP BY SOH.CustomerID) X
GROUP BY X.NoOfSales
ORDER BY 1

-- 2. verzió: CTE - Common Table Expression
;WITH X AS (SELECT SOH.CustomerID, COUNT(1) NoOfSales
	  FROM Sales.SalesOrderHeader SOH
	  GROUP BY SOH.CustomerID)
SELECT X.NoOfSales, COUNT(1) SalesNo
FROM X
GROUP BY X.NoOfSales
ORDER BY 1

-- 3. verzió: Ideiglenes tábla használata
SELECT SOH.CustomerID, COUNT(1) NoOfSales
INTO #T1
FROM Sales.SalesOrderHeader SOH
GROUP BY SOH.CustomerID

SELECT T1.NoOfSales, COUNT(1) SalesNo
FROM #T1 T1
GROUP BY T1.NoOfSales
ORDER BY 1

-- 4. verzió: Táblaváltozó használata
DECLARE @T1 table (CustomerID int, NoOfSales int)
INSERT @T1
SELECT SOH.CustomerID, COUNT(1) NoOfSales
FROM Sales.SalesOrderHeader SOH
GROUP BY SOH.CustomerID

SELECT T1.NoOfSales, COUNT(1) SalesNo
FROM @T1 T1
GROUP BY T1.NoOfSales
ORDER BY 1