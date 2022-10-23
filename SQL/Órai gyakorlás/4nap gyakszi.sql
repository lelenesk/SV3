SELECT P.ProductID, P.Name, P.Color
FROM Production.product P
--ORDER BY P.name ASC, P.Color DESC
ORDER BY 3

SELECT TOP 10 P.name, P.ListPrice 
FROM Production.Product P
WHERE P.ListPrice >0
Order BY P.ListPrice

SELECT P.ProductID, P.name, P.ListPrice
FROM Production.Product P
ORDER BY P.ProductID
OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY

SELECT P.Name, P.ListPrice, P.Color
FROM Production.Product P
ORDER BY P.ListPrice DESC

SELECT P.Name, P.ListPrice, P.Color
FROM Production.Product AS P
WHERE P.ListPrice >0 AND P.Color='Blue'
ORDER BY P.ListPrice DESC
OFFSET 19 ROWS FETCH NEXT 30 ROWS ONLY

SELECT P.Name, P.Color, COALESCE(P.Color,'színtelen') as 'sz�n'
FROM Production.product P

select P.name, P.SellEndDate, COALESCE(P.SellEndDate,'1990.10.10')
from Production.Product P

SELECT P.Name, COALESCE(P.Sellenddate,'Nem �ruljuk')
FROM Production.Product P

SELECT P.FirstName, P.MiddleName, P.LastName, 
	P.FirstName+P.MiddleName+P.LastName,
	P.FirstName+' '+P.MiddleName+' '+P.LastName,
	P.FirstName+' '+Coalesce(P.MiddleName+' ','')+P.LastName,
	CONCAT(COALESCE(P.Title+' ',''),COALESCE(P.FirstName+' ',''), COALESCE(P.MiddleName+' ', ''), COALESCE(P.LastName,''))
FROM Person.Person P

SELECT P.Name, P.color
FROM Production.product P
WHERE P.Color IS NULL

SELECT P.Name, P.color
FROM Production.product P
WHERE P.Color IS NOT NULL

SELECT P.Name, P.Size, CAST(P.size AS decimal) sizeint
FROM Production.product P

SELECT P.Name, P.Size, CONVERT(decimal, P.Size) sizeint
FROM Production.product P

SELECT P.Name, P.Size, TRY_CAST(P.size AS decimal) sizeint
FROM Production.product P

SELECT P.Name, P.Size, TRY_CONVERT(decimal, P.Size) sizeint
FROM Production.product P

SELECT P.Name, P.Size
FROM Production.Product P
WHERE ISNUMERIC(P.size)=0

SELECT P.name, P.size,  
IIF(ISNUMERIC(P.size)=1, P.Size, Case P.size	when 'M' THEN 40
					when 'S' THEN 35
					when 'L' THEN 50
					WHEN 'XL' THEN 55
					end)
FROM Production.Product P
WHERE IIF(ISNUMERIC(P.size)=1, P.Size, Case P.size	when 'M' THEN 40
					when 'S' THEN 35
					when 'L' THEN 50
					WHEN 'XL' THEN 55
					end) =40


DECLARE @�sszeg varchar(30) = '1350.20'
	SELECT @�sszeg, Parse(@�sszeg as decimal using 'hu-hu')
