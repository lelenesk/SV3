-- Statikus SELECT p�lda (csak skal�r �rt�k, azaz 1 sor, 1 oszlop lehet)
-- Melyek azok a term�kek, amelyek a term�kek �tlag�r�n�l 20%-kal dr�g�bbak?
-- Az �tlag�rt�l val� elt�r�st is jelen�ts�k meg az eredm�nyhalmazban!
-- A ListPrice=0 term�keket ne vegy�k figyelembe az �tlag�r sz�m�t�s�n�l!

SELECT P.ProductID, P.Name, P.ListPrice, 
	P.ListPrice - (SELECT AVG(P.ListPrice) FROM Production.Product P WHERE P.ListPrice > 0) PriceDiff
FROM Production.Product P
WHERE P.ListPrice > (SELECT AVG(P.ListPrice) FROM Production.Product P WHERE P.ListPrice > 0) * 1.2

-- Korrel�lt SELECT p�lda (itt is csak skal�r �rt�k lehet)
-- Melyek azok a term�kek, amelyek az alcsoportjuk �tlag�r�n�l 20%-kal dr�g�bbak? 
-- A ListPrice=0 term�keket ne vegy�k figyelembe az �tlag�r sz�m�t�s�n�l!

SELECT P1.ProductID, P1.Name, P1.ListPrice
FROM Production.Product P1
WHERE P1.ListPrice > 
	(SELECT AVG(P2.ListPrice) 
	 FROM Production.Product P2 
	 WHERE (P1.ProductSubcategoryID = P2.ProductSubcategoryID OR 
			P1.ProductSubcategoryID IS NULL AND P2.ProductSubcategoryID IS NULL) AND
			P2.ListPrice > 0) * 1.2

-- IN klauzula haszn�lata (csak egy oszlop lehet a SELECT-ben)
-- Melyek azok a rendel�sek, amelyekn�l a keresked� SalesQuota �rt�ke NULL
SELECT SOH.SalesOrderID, SOH.DueDate, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
WHERE SOH.SalesPersonID IN (SELECT SP.BusinessEntityID 
							FROM Sales.SalesPerson SP 
							WHERE SP.SalesQuota IS NULL)

-- Az el�z� feladat megold�sa JOIN-nal
-- Hasonl�tsuk �ssze a k�t megold�st a v�grehajt�si terv alapj�n
SELECT SOH.SalesOrderID, SOH.DueDate, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
INNER JOIN Sales.SalesPerson SP ON SOH.SalesPersonID = SP.BusinessEntityID
WHERE SP.SalesQuota IS NULL

