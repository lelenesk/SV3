select REPLACE(P.Name,' ','-')
from Production.Product as P

select P.Name, DATEPART(m,P.SellStartDate)
from Production.Product as P

select P.Name, DATENAME(w,P.SellStartDate)
from Production.Product as P

SELECT P.Size, P.productsubcategoryID, 
        COUNT(P.ProductSubcategoryID) 'termékfélék(db)', 
        MIN(P.Listprice) 'legolcsóbb',
        MAX(P.Listprice) 'legdrágább',
        AVG(P.ListPrice) 'átlagár',
		SUM(P.ListPrice) 'termékek árának összege'
FROM Production.product P
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY P.ProductSubcategoryID, P.Size


Select P.SellStartDate,
	AVG(P.ListPrice) 'Listaár',
	MIN(P.ListPrice) 'Legolcsóbb T',
	MAX(P.ListPrice) 'LEgdrágább T',
	COUNT(P.ListPrice) 'Ennyi db T'
From Production.Product P
Where P.ListPrice is not null
Group BY  P.SellStartDate
Order By P.SellStartDate

Select S.OrderDate 'Ezen a napon', COUNT(S.PurchaseOrderNumber) as 'Ennyi db vásárlás történt'
From Sales.SalesOrderHeader S
Group by S.OrderDate
Order by COUNT(S.PurchaseOrderNumber) DESC



