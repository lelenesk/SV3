-- Statikus SELECT példa (csak skalár érték, azaz 1 sor, 1 oszlop lehet)
-- Melyek azok a termékek, amelyek a termékek átlagáránál 20%-kal drágábbak?
-- Az átlagártól való eltérést is jelenítsük meg az eredményhalmazban!
-- A ListPrice=0 termékeket ne vegyük figyelembe az átlagár számításánál!

SELECT P.ProductID, P.Name, P.ListPrice, 
	P.ListPrice - (SELECT AVG(P.ListPrice) FROM Production.Product P WHERE P.ListPrice > 0) PriceDiff
FROM Production.Product P
WHERE P.ListPrice > (SELECT AVG(P.ListPrice) FROM Production.Product P WHERE P.ListPrice > 0) * 1.2

-- Korrelált SELECT példa (itt is csak skalár érték lehet)
-- Melyek azok a termékek, amelyek az alcsoportjuk átlagáránál 20%-kal drágábbak? 
-- A ListPrice=0 termékeket ne vegyük figyelembe az átlagár számításánál!

SELECT P1.ProductID, P1.Name, P1.ListPrice
FROM Production.Product P1
WHERE P1.ListPrice > 
	(SELECT AVG(P2.ListPrice) 
	 FROM Production.Product P2 
	 WHERE (P1.ProductSubcategoryID = P2.ProductSubcategoryID OR 
			P1.ProductSubcategoryID IS NULL AND P2.ProductSubcategoryID IS NULL) AND
			P2.ListPrice > 0) * 1.2

-- IN klauzula használata (csak egy oszlop lehet a SELECT-ben)
-- Melyek azok a rendelések, amelyeknél a kereskedõ SalesQuota értéke NULL
SELECT SOH.SalesOrderID, SOH.DueDate, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
WHERE SOH.SalesPersonID IN (SELECT SP.BusinessEntityID 
							FROM Sales.SalesPerson SP 
							WHERE SP.SalesQuota IS NULL)

-- Az elõzõ feladat megoldása JOIN-nal
-- Hasonlítsuk össze a két megoldást a végrehajtási terv alapján
SELECT SOH.SalesOrderID, SOH.DueDate, SOH.TotalDue
FROM Sales.SalesOrderHeader SOH
INNER JOIN Sales.SalesPerson SP ON SOH.SalesPersonID = SP.BusinessEntityID
WHERE SP.SalesQuota IS NULL

