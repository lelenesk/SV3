--1 .K�rdezd le az �sszes kapcsolattart� nev�t a Person.Person t�bl�b�l.
SELECT 
COALESCE(P.Title,'') +' '+ P.LastName +' '+ COALESCE(P.MiddleName,'') + ' ' + P.FirstName  as 'Teljes n�v'
FROM Person.Person as P
ORDER BY P.FirstName

SELECT COALESCE(P.Title,'') as Title, P.FirstName, COALESCE(P.MiddleName,'') as MiddleName, P.LastName
FROM Person.Person AS P
ORDER BY P.FirstName,P.MiddleName,P.LastName

--2. K�rdezd le a 46-os m�ret� term�kek nev�t �s sz�n�t a product t�bl�b�l.
SELECT Pr.Name, Pr.Color
FROM Production.Product AS Pr
WHERE pr.Size LIKE '46'
--�gy j�

SELECT Pr.Name, Pr.Color
FROM Production.Product AS Pr
WHERE pr.Size IN ('46')
--�gy is j�, t�bbet is fel lehet sorolni

SELECT Pr.Name, Pr.Color
FROM Production.Product AS Pr
WHERE pr.Size='46'
--�gy is j�

--3. K�rdezd le a Kim keresztnev� felhaszn�l�kat a Person t�bl�b�l.

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

--4. K�rdezd le a 56-os piros term�keket a product t�bl�b�l.

SELECT Pr.Name, Pr.Size 
FROM Production.Product AS PR
WHERE Pr.Size='56' AND Pr.Color='Red'

SELECT Pr.Name + ' ('+ Pr.ProductNumber + ')' AS Product 
FROM Production.Product AS PR
WHERE Pr.Size='56' AND Pr.Color='Red'

--5. K�rdezd le a 42-es �s 62-es m�ret� term�keket a product t�bl�b�l.
SELECT *
FROM Production.Product AS Pr

SELECT *
FROM Production.Product AS Pr
WHERE Pr.Size IN ('42','62')

SELECT *
FROM Production.Product AS Pr
WHERE Pr.Size='42' OR Pr.Size='62'

--6. K�rdezd le azokat a term�keket amiknek a lista�ra 100 �s 500 forint k�z�tt van.
--Az m�r 500 nem tartozik bele
SELECT *
FROM Production.Product AS Pr
WHERE Pr.ListPrice>=100 AND Pr.ListPrice<500
ORDER BY Pr.ListPrice

SELECT *
FROM Production.Product AS Pr
WHERE Pr.ListPrice BETWEEN 100 AND 500
ORDER BY Pr.ListPrice

--7. K�rdezd le azokat a term�kekekt amik nem fekete sz�n�ek.
SELECT Pr.Name, Pr.Color
FROM Production.Product AS Pr
WHERE Pr.Color!='Black' 
--Itt a null �rt�k� sz�nt nem adja vissza!

SELECT P.Name, P.Color
FROM Production.Product AS P
WHERE P.Color IS NULL OR P.Color!='Black'
order by P.Name
--VISSZA ADJA A NULLOKAT IS, (AND-del �rtelmetlen)

SELECT Pr.Name, COALESCE(Pr.Color,'ismeretlen sz�n, ak�r lehetne fekete is')
FROM Production.Product Pr
WHERE COALESCE(Pr.Color,'')!='Black'
--eleg�nsabb, szint�n NULL-okkal


--8. K�rdezd le azokat a term�keket amiknek a neve Red sz�ra v�gz�dik.
SELECT *
FROM Production.Product AS Pr
WHERE Pr.Name LIKE '% Red%' OR Pr.Name LIKE '%Red%'
--�gy az is tal�lat, ha Paint az elefe, meg az is, ha benne van �s csak az a sz�.

SELECT *
FROM Production.Product AS Pr
WHERE Pr.Name LIKE '% Red'
--�gy a t�nyleges red sz�t fogja megtal�lni

--9. K�rdezd le azokat a term�keket amiknek a nev�ben szerepel a Ball sz�.
SELECT *
FROM Production.Product AS Pr
WHERE Pr.Name LIKE '%Ball%'

--10. K�rdezd le azon term�kek nev�t amit m�r nem �rus�tunk �s a �llapot nev� mez�be �rd ki hogy nem forgalmazzuk.

SELECT *, 'Nem Forgalmazzuk' AS '�llapot'
FROM Production.Product AS Pr
WHERE ISDATE (Pr.SellEndDate)=1
--Ez �gy ok

SELECT *, 'Nem Forgalmazzuk' AS '�llapot'
FROM Production.Product AS Pr
WHERE Pr.SellEndDate IS NOT NULL 

SELECT P.Name, IIF(P.SellEndDate > 0, 'NEm �ruljuk', 'Ez itt b�rmi lehet') �llapot
FROM Production.Product AS P
WHERE P.SellEndDate > 0

SELECT P.Name, P.SellEndDate,
CASE ISDATE(P.SellEndDate) WHEN 1 THEN 'M�r nem �ruljuk'
END AS '�llapot'
From Production.Product P
WHERE P.SellEndDate != 1



