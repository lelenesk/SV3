/* Bemelegítõ */
SELECT 
P.Name AS 'Termék neve',
P.Color color,
P.ListPrice as listprice,
P.Weight as 'weight',
P.ListPrice+P.Weight 'Ár és súly'
FROM Production.product as P
WHERE P.ListPrice+P.Weight IS NOT NULL
Order BY 'Ár és súly'

/*Kérdezd le az összes termék alkategória nevet a productsubcategory táblából.*/
SELECT PSC.Name as Subname
FROM Production.ProductSubcategory as PSC
WHERE PSC.Name IS NOT NULL
Order BY 'Subname'

/*Kérdezd le az összes termékkategória nevet a productcategory táblából.*/
SELECT PC.Name as 'Name'
FROM Production.ProductCategory as PC
WHERE PC.Name IS NOT NULL
Order BY 'Name'

/*Kérdezd le az összes kapcsolattartó nevét és e-mail címét a Person táblából.*/
SELECT 
P.FirstName + ' ' + COALESCE(P.Title,'LMBTQ') + ' ' + P.LastName as 'Teljes név'
FROM Person.Person as P
ORDER BY P.LastName

/*gyakorlás*/
Select P.Name, P.Color, P.Size
From Production.Product P
-- Where P.Color='Blue' OR P.Color='Red'
-- Where P.Color in ('Blue, 'Red')
-- WHERE P.Size between '52' AND '56'
-- WHERE P.Color='Blue' OR P.Color='Red' AND P.Size between '52' AND '56'
-- Where P.Name between 'Road-150 Red, 52' AND 'Touring-1000 Blue, 54'
-- Where P.name LIKE '%jam%'


SELECT P.ProductID, P.Name,
    CASE P.Color WHEN 'Blue' THEN 'Kék'
                 WHEN 'Red' THEN 'Piros'
                 WHEN 'Silver' THEN 'Ezüst'
                 WHEN 'Black' THEN 'Fekete'
                 ELSE 'N/A'
                 END as Szín
FROM Production.product P



SELECT 
COALESCE(P.Title,'') +' '+ P.LastName +' '+ COALESCE(P.MiddleName,'') + ' ' + P.FirstName  as 'Teljes név'
FROM Person.Person as P
ORDER BY P.LastName

/*Kérdezd le azokat a rendelésazonosítókat amiket 2012.03.01 és 2012.03.20. között rendeltek SalesOrderHeader táblából.*/
Select *
From Production.Product P

Select S.SalesOrderNumber, S.OrderDate
From Sales.SalesOrderHeader S
WHERE S.OrderDate between '2012-03-01' and '2012-03-20' --ez így csak 19-éig listáz, a 0 óra nulla perc miatt
Order by S.OrderDate 



/*Kérdezd le a termékek nevét, ha a sellenddate meg van adva írasd ki hogy már nem áruljuk ha nincs megadva akkor azt hogy még áruljuk az áruljuk? nevû mezõbe.*/

Select P.Name, IIF(P.SellEndDate <>0,'Már nem áruljuk', 'Még áruljuk')
From Production.Product P
Order by P.Name


SELECT P.Name, P.SellEndDate,
CASE ISDATE(P.SellEndDate) WHEN 0 THEN 'Még áruljuk'
						   WHEN 1 THEN 'Már nem áruljuk'
						   END as 'Áruljuk-e'
From Production.Product P
Order by P.Name






