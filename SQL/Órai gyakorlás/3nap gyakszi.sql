/* Bemeleg�t� */
SELECT 
P.Name AS 'Term�k neve',
P.Color color,
P.ListPrice as listprice,
P.Weight as 'weight',
P.ListPrice+P.Weight '�r �s s�ly'
FROM Production.product as P
WHERE P.ListPrice+P.Weight IS NOT NULL
Order BY '�r �s s�ly'

/*K�rdezd le az �sszes term�k alkateg�ria nevet a productsubcategory t�bl�b�l.*/
SELECT PSC.Name as Subname
FROM Production.ProductSubcategory as PSC
WHERE PSC.Name IS NOT NULL
Order BY 'Subname'

/*K�rdezd le az �sszes term�kkateg�ria nevet a productcategory t�bl�b�l.*/
SELECT PC.Name as 'Name'
FROM Production.ProductCategory as PC
WHERE PC.Name IS NOT NULL
Order BY 'Name'

/*K�rdezd le az �sszes kapcsolattart� nev�t �s e-mail c�m�t a Person t�bl�b�l.*/
SELECT 
P.FirstName + ' ' + COALESCE(P.Title,'LMBTQ') + ' ' + P.LastName as 'Teljes n�v'
FROM Person.Person as P
ORDER BY P.LastName

/*gyakorl�s*/
Select P.Name, P.Color, P.Size
From Production.Product P
-- Where P.Color='Blue' OR P.Color='Red'
-- Where P.Color in ('Blue, 'Red')
-- WHERE P.Size between '52' AND '56'
-- WHERE P.Color='Blue' OR P.Color='Red' AND P.Size between '52' AND '56'
-- Where P.Name between 'Road-150 Red, 52' AND 'Touring-1000 Blue, 54'
-- Where P.name LIKE '%jam%'


SELECT P.ProductID, P.Name,
    CASE P.Color WHEN 'Blue' THEN 'K�k'
                 WHEN 'Red' THEN 'Piros'
                 WHEN 'Silver' THEN 'Ez�st'
                 WHEN 'Black' THEN 'Fekete'
                 ELSE 'N/A'
                 END as Sz�n
FROM Production.product P



SELECT 
COALESCE(P.Title,'') +' '+ P.LastName +' '+ COALESCE(P.MiddleName,'') + ' ' + P.FirstName  as 'Teljes n�v'
FROM Person.Person as P
ORDER BY P.LastName

/*K�rdezd le azoka a rendel�sazonos�t�kat amiket 2012.03.01 �s 2012.03.20. k�z�tt rendeltek SalesOrderHeader t�bl�b�l.*/
Select *
From Production.Product P

Select S.SalesOrderNumber, S.OrderDate
From Sales.SalesOrderHeader S
WHERE S.OrderDate between '2012-03-01' and '2012-03-20' --ez �gy csak 19-�ig list�z, a 0 �ra nulla perc miatt
Order by S.OrderDate 



/*K�rdezd le a term�kek nev�t, ha a sellenddate meg van adva �rasd ki hogy m�r nem �ruljuk ha nincs megadva akkor azt hogy m�g �ruljuk az �ruljuk? nev� mez�be.*/

Select P.Name, IIF(P.SellEndDate <>0,'M�r nem �ruljuk', 'M�g �ruljuk')
From Production.Product P
Order by P.Name


SELECT P.Name, P.SellEndDate,
CASE ISDATE(P.SellEndDate) WHEN 0 THEN 'M�g �ruljuk'
						   WHEN 1 THEN 'M�r nem �ruljuk'
						   END as '�ruljuk-e'
From Production.Product P
Order by P.Name






