-- Piros sz�n� term�kek
SELECT P.ProductID, P.Name, P.Color, P.Size
FROM Production.Product P
WHERE P.Color = 'Red'

-- Piros, k�k �s s�rga term�kek
SELECT P.ProductID, P.Name, P.Color, P.Size
FROM Production.Product P
WHERE P.Color = 'Red' OR P.Color = 'Blue' or p.cOLOR = 'Yellow'

SELECT P.ProductID, P.Name, P.Color, P.Size
FROM Production.Product P
WHERE P.Color IN ('Red', 'Blue', 'Yellow')

-- Adott id�szakban t�rt�nt v�s�rl�sok
SELECT SOH.SalesOrderID, SOH.DueDate, SOH.CustomerID, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
WHERE SOH.DueDate BETWEEN '20130101' AND '20130331'

SELECT SOH.SalesOrderID, SOH.DueDate, SOH.CustomerID, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
WHERE SOH.DueDate >= '20130101' AND SOH.DueDate < '20130401'

-- LIKE predik�tum haszn�lata
SELECT P.ProductID, P.Name, P.Color, P.Size
FROM Production.Product P
WHERE P.Name LIKE 'Socks%'

SELECT P.ProductID, P.Name, P.Color, P.Size
FROM Production.Product P
WHERE P.Name LIKE '%Socks%'

-- Egyszer� rendez�s: vev�re, azon bel�l rendel�ssz�mra
SELECT SOH.SalesOrderID, SOH.DueDate, SOH.CustomerID, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
WHERE SOH.DueDate >= '20130101' AND SOH.DueDate < '20130401'
ORDER BY SOH.CustomerID, SOH.SalesOrderID

SELECT SOH.SalesOrderID, SOH.DueDate, SOH.CustomerID, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
WHERE SOH.DueDate >= '20130101' AND SOH.DueDate < '20130401'
ORDER BY 3, 1

-- Cs�kken� sorrend� rendez�s: el�l �lljanak a nagyobb v�s�rl�si �sszegek:
SELECT SOH.SalesOrderID, SOH.DueDate, SOH.CustomerID, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
WHERE SOH.DueDate >= '20130101' AND SOH.DueDate < '20130401'
ORDER BY SOH.TotalDue DESC

