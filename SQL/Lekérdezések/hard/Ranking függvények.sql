-- Gyûjtsük ki minden vevõ (CustomerID) utolsó 3 rendelését a
-- Sales.SalesOrderHeader tábláblól
-- 2005 elõtti megvalósítás, elrettentés végett:)
WITH X AS
	(SELECT C1.CustomerID, C1.SalesOrderID, COUNT(1) SOrszám
	FROM Sales.SalesOrderHEader C1
	INNER JOIN Sales.SalesOrderHeader C2 
		ON C1.CustomerID = C2.CustomerID AND C1.SalesOrderID <= C2.SalesOrderID
	GROUP BY C1.CustomerID, C1.SalesOrderID)
SELECT * 
FROM X 
WHERE Sorszám <= 3
ORDER BY CustomerID, Sorszám

-- Korszerû megoldás Ranking függvénnyel. Érdemes összehasonlítani.
;WITH Y AS
	(SELECT SOH.CustomerID, SOH.SalesOrderID, 
		ROW_NUMBER() OVER(PARTITION BY SOH.CustomerID ORDER BY SOH.SalesOrderID DESC) Sorszám
	FROM Sales.SalesOrderHeader SOH)
SELECT *
FROM Y
WHERE Sorszám <= 3
ORDER BY CustomerID, Sorszám

-- Ranking függvények összehasonlítása egy virtuális táblán
SELECT *, ROW_NUMBER() OVER(ORDER BY X) RN,
		  RANK() OVER(ORDER BY X) R,
		  DENSE_RANK() OVER(ORDER BY X) DR,
		  NTILE(2) OVER(ORDER BY X) NT
FROM (VALUES (22,'A'),(35,'B'),(22,'C'),(16,'B'),(11,'A'),(22,'D'),(82,'B')) Z(X,Y)
