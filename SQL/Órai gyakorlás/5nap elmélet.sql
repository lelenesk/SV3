
/*
Csoportos�t� lek�rdez�s (GROUP BY)

Az SQL lehet�s�get ad arra, hogy egy t�bla valamilyen mez�je szerint csoportokat alak�tsunk ki, �s ut�na az adott csoportra vonatkoz�an v�gezz�nk sz�m�t�sokat. 
Csoportos�tani a GROUP BY utas�t�ssal tudunk. Az al�bbi kis p�ld�ban megsz�molju, hogy melyik productsubcategory-ba h�nyf�le term�k tal�lhat�.
*/

SELECT P.productsubcategoryID, COUNT(P.ProductSubcategoryID) 'term�kf�l�k(db)'
        FROM Production.Product P
        GROUP BY P.ProductSubcategoryID

/*
A GROUP BY haszn�latakor fontos kik�t�s, hogy a SELECT r�szbe csak a csoportos�t� mez� �s olyan mez�k lehetnek, amin valamilyen �sszes�t� (aggreg�tor) f�ggv�nyt haszn�lunk. 
Term�szetesen a WHERE parancsot haszn�lhatjuk �s m�g a coportos�t�s el�tt kisz�rhetj�k a nek�nk sz�ks�ges rekordokat.
A lenti lek�rdez�sb�l p�ld�ul szeretn�nk elt�vol�tani azokat a rekordokat, amikn�l nincs megadva a SubCategoryID.
*/

SELECT P.productsubcategoryID, COUNT(P.ProductSubcategoryID) 'term�kf�l�k(db)'
FROM Production.Product P
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY P.ProductSubcategoryID

/*
Hogy m�g t�bb inf�t adjon a lek�rdez�s�nk lehet�s�g�nk van tov�bbi inform�ci�kat kisz�molni. 
P�ld�ul a legolcs�bb, a legdr�g�bb term�kek �r�t valamit a csoportonk�nt a term�kek �tlag�r�t. 
Ehhez a MIN() (legkisebb �rt�k), a MAX() (legnagyobb �rt�k) �s a AVG() (�tlag) f�gv�nyeket fogjuk haszn�lni.
*/

SELECT  P.productsubcategoryID, 
        COUNT(P.ProductSubcategoryID) 'term�kf�l�k(db)', 
        MIN(P.Listprice) legolcs�bb,
        MAX(P.Listprice) legdr�g�bb,
        AVG(P.ListPrice) �tlag�r
FROM Production.product P
WHERE P.ProductSubcategoryID IS NOTt NULL
GROUP BY P.ProductSubcategoryID
HAVING

/*
Mivel a fenti lek�rdez�sben az �sszes�t� f�ggv�nyeknek nincs �rtelme akkor, ha az adott kateg�ri�ban csak 1 term�k van. 
�gy azokat szeretn�m elt�vol�tani. A GROUP BY �ltal k�pzett csoportokra vonatkoz�an a HAVING paranccsal tudunk sz�r�felt�teleket megadni. 
Hasonl�an m�k�dik mint a WHERE felt�tel csak a csoportokra vonatkozik. Ezzel kapcsolatban fontos kik�t�s, 
hogy a SELECT r�szben l�trehozott aliasokat a HAVING r�szben nem haszn�lhatjuk mert b�r a SELECT szintaktikailag megel�zi a HAVING-et. 
A v�grehajt�si sorrendben a HAVING hamarabb hajt�dik v�gre ez�rt olyankor m�g a SELECT-ben l�trehozott aliasok nem l�teznek. 
Ez�rt a HAVING r�szben ki kell sz�moltatnunk az �rt�keket.
*/

SELECT  P.productsubcategoryID, 
        COUNT(P.ProductSubcategoryID) 'term�kf�l�k(db)', 
        MIN(P.Listprice) legolcs�bb,
        MAX(P.Listprice) legdr�g�bb,
        AVG(P.ListPrice) �tlag�r
FROM Production.Product P
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY P.ProductSubcategoryID
HAVING COUNT(P.ProductSubcategoryID) > 1

/*
V�g�l pedig, hogy rendezettebb k�pet kapjunk kieg�sz�thetj�k a legk�rdez�s�nket mondjuk egy sorbarendez�ssel ORDER BY parancs. 
Amit �rdemes megfigyelni, hogy itt m�r haszn�lhat� a SELECT-ben l�trehozott aliasok mivel az ORDER BY viszont a SELECT ut�n hajt�dik v�gre.
*/
SELECT  P.productsubcategoryID, 
        COUNT(P.ProductSubcategoryID) 'term�kf�l�k(db)', 
        MIN(P.Listprice) legolcs�bb,
        MAX(P.Listprice) legdr�g�bb,
        AVG(P.ListPrice) �tlag�r
FROM Production.Product P
WHERE P.ProductSubcategoryID is not NULL
GROUP BY P.ProductSubcategoryID
HAVING COUNT(P.ProductSubcategoryID) > 1
ORDER BY �tlag�r