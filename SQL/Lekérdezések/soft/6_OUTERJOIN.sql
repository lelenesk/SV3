-- Term�kek �s alkateg�ri�k egy�ttes megjelen�t�se, az alkateg�ri�ba be nem sorolt term�kek kimaradnak
SELECT PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	P.ProductID, P.Name ProductName
FROM Production.Product P
INNER JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID

-- Term�kek �s alkateg�ri�k egy�ttes megjelen�t�se (LEFT JOIN), minden term�k megjelenik
SELECT PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	P.ProductID, P.Name ProductName
FROM Production.Product P
LEFT JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID

-- Term�kek �s alkateg�ri�k egy�ttes megjelen�t�se (RIGHT JOIN), minden term�k megjelenik
SELECT PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	P.ProductID, P.Name ProductName
FROM Production.ProductSubcategory PS
RIGHT JOIN Production.Product P ON PS.ProductSubcategoryID = P.ProductSubcategoryID

-- Term�kek �s alkateg�ri�k egy�ttes megjelen�t�se (FULL JOIN), minden term�k �s minden alkateg�ria megjelenik
INSERT Production.ProductSubcategory(ProductCategoryID, Name)
VALUES (1, 'City Bikes')
SELECT PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	P.ProductID, P.Name ProductName
FROM Production.ProductSubcategory PS
FULL JOIN Production.Product P ON PS.ProductSubcategoryID = P.ProductSubcategoryID

-- Term�kek, alkateg�ri�k, f�kateg�ri�k �s term�kmodellek egy�ttes megjelen�t�se (LEFT JOIN), 
-- minden term�k megjelenik, de az �rva alkateg�ri�k, f�kateg�ri�k �s modellek nem.
SELECT PC.ProductCategoryID CategoryID, PC.Name CategoryName,
	PS.ProductSubcategoryID SubcategoryID, PS.Name SubcategoryName,
	PM.ProductModelID, PM.Name ModelName, 
	P.ProductID, P.Name ProductName, P.Color, P.ListPrice
FROM Production.Product P
LEFT JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID
LEFT JOIN Production.ProductCategory PC ON PS.ProductCategoryID = PC.ProductCategoryID
LEFT JOIN Production.ProductModel PM ON P.ProductModelID = PM.ProductModelID 