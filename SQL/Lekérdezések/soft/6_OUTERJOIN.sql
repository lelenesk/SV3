-- Termékek és alkategóriák együttes megjelenítése, az alkategóriába be nem sorolt termékek kimaradnak
SELECT PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	P.ProductID, P.Name ProductName
FROM Production.Product P
INNER JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID

-- Termékek és alkategóriák együttes megjelenítése (LEFT JOIN), minden termék megjelenik
SELECT PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	P.ProductID, P.Name ProductName
FROM Production.Product P
LEFT JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID

-- Termékek és alkategóriák együttes megjelenítése (RIGHT JOIN), minden termék megjelenik
SELECT PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	P.ProductID, P.Name ProductName
FROM Production.ProductSubcategory PS
RIGHT JOIN Production.Product P ON PS.ProductSubcategoryID = P.ProductSubcategoryID

-- Termékek és alkategóriák együttes megjelenítése (FULL JOIN), minden termék és minden alkategória megjelenik
INSERT Production.ProductSubcategory(ProductCategoryID, Name)
VALUES (1, 'City Bikes')
SELECT PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	P.ProductID, P.Name ProductName
FROM Production.ProductSubcategory PS
FULL JOIN Production.Product P ON PS.ProductSubcategoryID = P.ProductSubcategoryID

-- Termékek, alkategóriák, fõkategóriák és termékmodellek együttes megjelenítése (LEFT JOIN), 
-- minden termék megjelenik, de az árva alkategóriák, fõkategóriák és modellek nem.
SELECT PC.ProductCategoryID CategoryID, PC.Name CategoryName,
	PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	PM.ProductModelID, PM.Name ModelName, 
	P.ProductID, P.Name ProductName, P.Color, P.ListPrice
FROM Production.Product P
LEFT JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID
LEFT JOIN Production.ProductCategory PC ON PS.ProductCategoryID = PC.ProductCategoryID
LEFT JOIN Production.ProductModel PM ON P.ProductModelID = PM.ProductModelID 