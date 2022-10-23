--1 .Kérdezd le az összes kapcsolattartó nevét a Person.Person táblából.
SELECT 
COALESCE(P.Title,'') +' '+ P.LastName +' '+ COALESCE(P.MiddleName,'') + ' ' + P.FirstName  as 'Teljes név'
FROM Person.Person as P
ORDER BY P.FirstName

SELECT COALESCE(P.Title,'') as Title, P.FirstName, COALESCE(P.MiddleName,'') as MiddleName, P.LastName
FROM Person.Person AS P
ORDER BY P.FirstName,P.MiddleName,P.LastName

--2. Kérdezd le a 46-os méretû termékek nevét és színét a product táblából.
SELECT Pr.Name, Pr.Color
FROM Production.Product AS Pr
WHERE pr.Size LIKE '46'
--Így jó

SELECT Pr.Name, Pr.Color
FROM Production.Product AS Pr
WHERE pr.Size IN ('46')
--Így is jó, többet is fel lehet sorolni

SELECT Pr.Name, Pr.Color
FROM Production.Product AS Pr
WHERE pr.Size='46'
--Így is jó

--3. Kérdezd le a Kim keresztnevû felhasználókat a Person táblából.

SELECT*
FROM Person.Person AS P
WHERE P.FirstName = 'Kim'

SELECT P.Title, P.FirstName, P.MiddleName, P.LastName
FROM Person.Person AS P
WHERE P.FirstName LIKE ('Kim')

SELECT COALESCE(P.Title,'') as Title, P.FirstName, COALESCE(P.MiddleName,'') as MiddleName, P.LastName
FROM Person.Person AS P
WHERE P.FirstName LIKE ('Kim')
ORDER BY P.FirstName,P.MiddleName,P.LastName

--4. Kérdezd le a 56-os piros termékeket a product táblából.

SELECT Pr.Name, Pr.Size 
FROM Production.Product AS PR
WHERE Pr.Size='56' AND Pr.Color='Red'

SELECT Pr.Name + ' ('+ Pr.ProductNumber + ')' AS Product 
FROM Production.Product AS PR
WHERE Pr.Size='56' AND Pr.Color='Red'

--5. Kérdezd le a 42-es és 62-es méretû termékeket a product táblából.
SELECT *
FROM Production.Product AS Pr

SELECT *
FROM Production.Product AS Pr
WHERE Pr.Size IN ('42','62')

SELECT *
FROM Production.Product AS Pr
WHERE Pr.Size='42' OR Pr.Size='62'

--6. Kérdezd le azokat a termékeket amiknek a listaára 100 és 500 forint között van.
--Az már 500 nem tartozik bele
SELECT *
FROM Production.Product AS Pr
WHERE Pr.ListPrice>=100 AND Pr.ListPrice<500
ORDER BY Pr.ListPrice

SELECT *
FROM Production.Product AS Pr
WHERE Pr.ListPrice BETWEEN 100 AND 500
ORDER BY Pr.ListPrice

--7. Kérdezd le azokat a termékekekt amik nem fekete színûek.
SELECT Pr.Name, Pr.Color
FROM Production.Product AS Pr
WHERE Pr.Color!='Black' 
--Itt a null értékû színt nem adja vissza!

SELECT P.Name, P.Color
FROM Production.Product AS P
WHERE P.Color IS NULL OR P.Color!='Black'
order by P.Name
--VISSZA ADJA A NULLOKAT IS, (AND-del értelmetlen)

SELECT Pr.Name, COALESCE(Pr.Color,'ismeretlen szín, akár lehetne fekete is')
FROM Production.Product Pr
WHERE COALESCE(Pr.Color,'')!='Black'
--elegánsabb, szintén NULL-okkal


--8. Kérdezd le azokat a termékeket amiknek a neve Red szóra végzõdik.
SELECT *
FROM Production.Product AS Pr
WHERE Pr.Name LIKE '% Red%' OR Pr.Name LIKE '%Red%'
--Így az is találat, ha Paint az elefe, meg az is, ha benne van és csak az a szó.

SELECT *
FROM Production.Product AS Pr
WHERE Pr.Name LIKE '% Red'
--Így a tényleges Red szót fogja megtalálni

--9. Kérdezd le azokat a termékeket amiknek a nevében szerepel a Ball szó.
SELECT *
FROM Production.Product AS Pr
WHERE Pr.Name LIKE '%Ball%'

--10. Kérdezd le azon termékek nevét amit már nem árusítunk és a állapot nevû mezõbe írd ki hogy nem forgalmazzuk.

SELECT *, 'Nem Forgalmazzuk' AS 'Állapot'
FROM Production.Product AS Pr
WHERE ISDATE (Pr.SellEndDate)=1
--Ez így ok

SELECT *, 'Nem Forgalmazzuk' AS 'Állapot'
FROM Production.Product AS Pr
WHERE Pr.SellEndDate IS NOT NULL 

SELECT P.Name, IIF(P.SellEndDate > 0, 'NEm áruljuk', 'Ez itt bármi lehet') Állapot
FROM Production.Product AS P
WHERE P.SellEndDate > 0

SELECT P.Name, P.SellEndDate,
CASE ISDATE(P.SellEndDate) WHEN 1 THEN 'Már nem áruljuk'
END AS 'Állapot'
From Production.Product P
WHERE P.SellEndDate != 1



