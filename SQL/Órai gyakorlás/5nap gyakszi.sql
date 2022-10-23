select REPLACE(P.Name,' ','-')
from Production.Product as P

select P.Name, DATEPART(m,P.SellStartDate)
from Production.Product as P

select P.Name, DATENAME(w,P.SellStartDate)
from Production.Product as P

SELECT P.Size, P.productsubcategoryID, 
        COUNT(P.ProductSubcategoryID) 'term�kf�l�k(db)', 
        MIN(P.Listprice) 'legolcs�bb',
        MAX(P.Listprice) 'legdr�g�bb',
        AVG(P.ListPrice) '�tlag�r',
		SUM(P.ListPrice) 'term�kek �r�nak �sszege'
FROM Production.product P
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY P.ProductSubcategoryID, P.Size


Select P.SellStartDate,
	AVG(P.ListPrice) 'Lista�r',
	MIN(P.ListPrice) 'Legolcs�bb T',
	MAX(P.ListPrice) 'Legdr�g�bb T',
	COUNT(P.ListPrice) 'Ennyi db T'
From Production.Product P
Where P.ListPrice is not null
Group BY  P.SellStartDate
Order By P.SellStartDate

Select S.OrderDate 'Ezen a napon', COUNT(S.PurchaseOrderNumber) as 'Ennyi db v�s�rl�s t�rt�nt'
From Sales.SalesOrderHeader S
Group by S.OrderDate
Order by COUNT(S.PurchaseOrderNumber) DESC



