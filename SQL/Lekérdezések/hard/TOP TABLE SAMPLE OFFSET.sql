-- Kérjük le a 10 legnagyobb összegû vásárlás adatait a
--  Sales.SalesOrderHeader táblából
SELECT TOP 10 SOH.*
FROM Sales.SalesOrderHeader SOH
ORDER BY SOH.TotalDue DESC
GO

-- Ugyanaz, de változó megadási lehetõséggel:
DECLARE @N int = 10
SELECT TOP(@N) SOH.*
FROM Sales.SalesOrderHeader SOH
ORDER BY SOH.TotalDue DESC
GO

-- Az elõzõhöz hasonló feladat, de a legmagasabb 10% jöjjön le:
DECLARE @N int = 10
SELECT TOP(@N) PERCENT SOH.*
FROM Sales.SalesOrderHeader SOH
ORDER BY SOH.TotalDue DESC

-- Kérünk 1000 sort a táblából random
SELECT SOH.*
FROM Sales.SalesOrderHeader SOH 
TABLESAMPLE(1000 ROWS)
-- Érdekes de itt hiba lenne egyes számban megadni a ROW-t:
-- TABLESAMPLE(1000 ROW)

-- Nocsak nem pont annyit kaptunk, és minden futásnál más a darabszám.
-- Ha tényleg 1000 kell pontosan, akkor kérjünk egy kicsit többet, és TOP 1000
SELECT TOP 1000 SOH.*
FROM Sales.SalesOrderHeader SOH 
TABLESAMPLE(2000 ROWS)

-- Ha egy párszor szeretnénk, hogy pontosan ugyanaz a halmaz jöjjön vissza,
-- akkor kell a REPETABLE(n), ahol 'n' a darbszám
SELECT TOP 1000 SOH.*
FROM Sales.SalesOrderHeader SOH 
TABLESAMPLE(2000 ROWS) REPEATABLE(10)
GO

-- Kliens rendszerek kiszolgálásánál gyakori igény, hogy például az 5. lap
-- tartalmát adjuk vissza, és egy lap mondjuk 20 sor.
SELECT P.* 
FROM Production.Product P
ORDER BY P.Name
OFFSET 100 ROWS FETCH NEXT 20 ROWS ONLY
-- Itt lazább volt az 'alkotó', mert egyes számban is elfogadja a ROW-t bármelyik helyen a kettõbõl:
-- OFFSET 100 ROW FETCH NEXT 20 ROW ONLY

