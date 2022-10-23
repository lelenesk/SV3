/* K�sz�ts�nk kimutat�st a Sales.SalesOrderHeader t�bla alapj�n, 
	hogy h�ny olyan vev�nk volt, aki 1-szer, h�ny olyan, aki k�tszer, h�romszor stb. 
	v�s�rolt. Az eredm�ny az al�bbi form�j� legyen:

V�s�rl�sok sz�ma	H�ny partner
	1					1200
	2					 210
	3					  40
	4
	27
	28					  2*/

-- 1. verzi�: Sz�rmaztatott t�bla (Derived table)
SELECT X.NoOfSales, COUNT(1) SalesNo
FROM (SELECT SOH.CustomerID, COUNT(1) NoOfSales
	  FROM Sales.SalesOrderHeader SOH
	  GROUP BY SOH.CustomerID) X
GROUP BY X.NoOfSales
ORDER BY 1

-- 2. verzi�: CTE - Common Table Expression
;WITH X AS (SELECT SOH.CustomerID, COUNT(1) NoOfSales
	  FROM Sales.SalesOrderHeader SOH
	  GROUP BY SOH.CustomerID)
SELECT X.NoOfSales, COUNT(1) SalesNo
FROM X
GROUP BY X.NoOfSales
ORDER BY 1

-- 3. verzi�: Ideiglenes t�bla haszn�lata
SELECT SOH.CustomerID, COUNT(1) NoOfSales
INTO #T1
FROM Sales.SalesOrderHeader SOH
GROUP BY SOH.CustomerID

SELECT T1.NoOfSales, COUNT(1) SalesNo
FROM #T1 T1
GROUP BY T1.NoOfSales
ORDER BY 1

-- 4. verzi�: T�blav�ltoz� haszn�lata
DECLARE @T1 table (CustomerID int, NoOfSales int)
INSERT @T1
SELECT SOH.CustomerID, COUNT(1) NoOfSales
FROM Sales.SalesOrderHeader SOH
GROUP BY SOH.CustomerID

SELECT T1.NoOfSales, COUNT(1) SalesNo
FROM @T1 T1
GROUP BY T1.NoOfSales
ORDER BY 1