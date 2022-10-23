--Kérdezd le a S-es kék termékeket a product táblából.
SELECT P.Name, P.Color, P.Size
From Production.Product P
WHERE P.Size='S' AND P.Color='Blue'

--Kérdezd le azokat a termékeket amiknek a nevében szerepel a bike szó.
SELECT P.Name, P.Color, P.Size, PSC.Name
FROM Production.Product AS P JOIN Production.ProductSubcategory PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
WHERE P.Name LIKE '%BIKE%'

SELECT P.Name, P.Color, P.Size, PSC.Name
FROM Production.Product AS P JOIN Production.ProductSubcategory PSC
ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
WHERE PSC.Name='road bikes'

--Kérdezd le a piros színû termékeket és a színét írd ki magyarul.
SELECT PP.Color, IIF(PP.Color = 'red', 'Piros', PP.Color) AS 'newcolumn',
'Piros' as 'ujoszlop'
FROM Production.Product AS PP
WHERE PP.Color ='Red'

SELECT Pr.Name,  CASE Pr.Color  WHEN 'Red' THEN 'PIROS'
END
FROM Production.Product AS Pr
WHERE CASE Pr.Color  WHEN 'Red' THEN 'PIROS'
END ='PIROS'

--Rendezd a termékek nevét ABC sorrendbe.
select P.name
from Production.Product P
order by P.name
--Kérdezd le a termékek nevét, árát és színét és rendezd listaár szerint csökkenõ sorrendbe
SELECT p.Name, p.ListPrice, p.Color
FROM Production.Product p
ORDER BY ListPrice DESC;

--Kérdezd le a 100 legrégebb óta (sellstartdate) forgalmazott terméket
SELECT TOP (100) Pr.Name, Pr.ListPrice, Pr.Color, Pr.SellStartDate, Pr.SellEndDate
FROM Production.Product AS Pr
ORDER BY Pr.SellStartDate

SELECT TOP (100) Pr.Name, Pr.ListPrice, Pr.Color, Pr.SellStartDate, Pr.SellEndDate
FROM Production.Product AS Pr
WHERE Pr.SellEndDate IS NULL
ORDER BY Pr.SellStartDate

/*Kérdezd le a 10 legolcsóbb terméket, aminek az ára nagyobb 0-nál és a
neve tartalmazza a Pedal szót.*/

select P.name, P.ListPrice
from Production.Product P
Where P.Name like '%Pedal%' AND P.ListPrice >0
order by P.ListPrice
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY

select TOP 10 P.name, P.ListPrice
from Production.Product P
Where P.Name like '%Pedal%' AND P.ListPrice >0
order by P.ListPrice

/*Kérdezd le az összes nevet és megszólítást (Title) a Person táblából
és fûzd össze õket, a megszólítást és a nevek között legyen egy darab
köz kezeld azokat az eseteket is amikor valamely mezõ értéke NULL.*/

select PP.FirstName, PP.MiddleName, PP.LastName, PP.Title,
CONCAT(COALESCE(PP.Title+' ',''),PP.FirstName, COALESCE(' '+ PP.MiddleName,''), ' ',PP.LastName)
--CONCAT(COALESCE(PP.Title+' ',''),COALESCE(PP.FirstName+' ',''),COALESCE(PP.MiddleName+' ',''),COALESCE(PP.LastName+ ' ',''))
FROM Person.Person PP


-- szövegfüggvények

SELECT P.name, LEFT(P.name,5) eleje, RIGHT(P.name, 4) vége, SUBSTRING(P.name,3,3) közepe
FROM Production.product P

SELECT P.name,
		CHARINDEX(' ', P.Name) as köz
FROM Production.Product P

SELECT P.name,
		CHARINDEX(' ', P.Name) as köz, --elsõ köz helye, ha több is van akkor az elsõ helyét adja vissza
		TRIM(LEFT(P.name, CHARINDEX(' ', P.Name))) as eleje, --visszaadja a karakterlánc elejét a közig
		TRIM(RIGHT(P.name, LEN(P.name)-CHARINDEX(' ', P.Name))) as vége -- visszaadja a karakterlánc végét a köztõl
			FROM Production.Product P

SELECT P.name, REPLACE(P.name,' ','_')
		FROM Production.Product p

-- dátumfüggvények

SELECT P.name, P.SellStartDate, YEAR(P.SellStartDate) év, MONTH(P.SellStartDate) hónap, DAY(P.SellStartDate) nap
	FROM Production.Product P

SET DATEFIRST 1
SELECT P.name,
		P.SellStartDate,
		DATEPART(yyyy,P.SellStartDate) év,
		DATEPART(y,P.SellStartDate) 'nap az évben',
		DATEPART(q,P.SellStartDate) negyedév,
		DATEPART(ww,P.SellStartDate) 'hányadik hét',
		DATEPART(w,P.SellStartDate) 'nap a héten'
		FROM Production.Product P

SET LANGUAGE MAGYAR
SELECT P.name, P.SellStartDate,DATENAME(w, P.SellStartDate), DATENAME(m, P.SellStartDate)
	FROM Production.Product P
SET LANGUAGE ENGLISH

select GETDATE(),  SYSDATETIME(), GETUTCDATE()

-- csoportosító lekérdezések

SELECT P.productsubcategoryID,P.Size,
		COUNT(P.ProductSubcategoryID) 'termékfélék(db)',
		MIN (P.listprice) 'legolcsóbb termék',
		MAX(P.listprice) ' legdrágább termék',
		AVG(P.ListPrice) 'termékek átlagára',
		SUM(P.listprice) 'termékek árának összege'

		FROM Production.Product P
		where P.Size is not null
		GROUP BY P.ProductSubcategoryID, P.Size
		Having AVG(P.ListPrice)>1000
		Order By AVG(P.ListPrice)


SELECT * from Production.Product
-- csoportosítsd a termékeket a productsellstartdate mezõ szerint számold ki az átlagárat
--a legolcsóbb és legdrább termékeket és hogy mely napon hány féle terméket kezdtünk el árulni
-- production.product táblából

SELECT TRY_CAST(P.SellStartDate as nvarchar)+P.Color as 'értékesítés kezdete és szín',
AVG(P.listprice) ' átlagár',--átlagárat
MIN(P.ListPrice), MAX(P.ListPrice),--legolcsóbb és legdrább termékeket
COUNT(P.Name)-- hány féle terméket kezdtünk el árulni
FROM production.product P
GROUP BY P.SellStartDate, P.Color
ORDER BY P.SellStartDate,P.Color

SELECT P.SellStartDate, P.Name, P.ListPrice
from Production.Product P
WHERE P.SellStartDate='2008-04-30 00:00:00.000'


SELECT P.SellStartDate, P.Name, P.ListPrice
from Production.Product P
WHERE P.SellStartDate='2011-05-31 00:00:00.000'

/*Számold meg hogy hány vásárlás történt az egyes napokon a
Sales.Salesorderheader tábla adatai szerint. (orderdate-et vedd alapul)*/

SELECT S.OrderDate,
COUNT(S.OrderDate) AS 'Daily Sales', COUNT(S.SalesOrderID), COUNT(S.PurchaseOrderNumber)
FROM Sales.SalesOrderHeader S
GROUP BY S.OrderDate

/*Számold ki mennyi volt az átlagos vásárlás értéke ()Totaldue)
a./ éves bontásban (orderdate), csak a 100-nál nagyobbakat listázd Sales.salesorderheader*/
SELECT YEAR(SOH.OrderDate), AVG(SOH.TotalDue)
FROM Sales.SalesOrderHeader SOH
WHERE SOH.TotalDue>100
GROUP BY YEAR(SOH.OrderDate)
HAVING AVG(SOH.TotalDue)>2000
ORDER BY YEAR(SOH.OrderDate)
