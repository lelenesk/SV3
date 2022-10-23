-- Gy�jts�k ki minden vev� (CustomerID) utols� 3 rendel�s�t a
-- Sales.SalesOrderHeader t�bl�bl�l
-- 2005 el�tti megval�s�t�s, elrettent�s v�gett:)
WITH X AS
	(SELECT C1.CustomerID, C1.SalesOrderID, COUNT(1) SOrsz�m
	FROM Sales.SalesOrderHEader C1
	INNER JOIN Sales.SalesOrderHeader C2 
		ON C1.CustomerID = C2.CustomerID AND C1.SalesOrderID <= C2.SalesOrderID
	GROUP BY C1.CustomerID, C1.SalesOrderID)
SELECT * 
FROM X 
WHERE Sorsz�m <= 3
ORDER BY CustomerID, Sorsz�m

-- Korszer� megold�s Ranking f�ggv�nnyel. �rdemes �sszehasonl�tani.
;WITH Y AS
	(SELECT SOH.CustomerID, SOH.SalesOrderID, 
		ROW_NUMBER() OVER(PARTITION BY SOH.CustomerID ORDER BY SOH.SalesOrderID DESC) Sorsz�m
	FROM Sales.SalesOrderHeader SOH)
SELECT *
FROM Y
WHERE Sorsz�m <= 3
ORDER BY CustomerID, Sorsz�m

-- Ranking f�ggv�nyek �sszehasonl�t�sa egy virtu�lis t�bl�n
SELECT *, ROW_NUMBER() OVER(ORDER BY X) RN,
		  RANK() OVER(ORDER BY X) R,
		  DENSE_RANK() OVER(ORDER BY X) DR,
		  NTILE(2) OVER(ORDER BY X) NT
FROM (VALUES (22,'A'),(35,'B'),(22,'C'),(16,'B'),(11,'A'),(22,'D'),(82,'B')) Z(X,Y)
