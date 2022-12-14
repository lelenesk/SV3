/****** Script for SelectTopNRows command from SSMS  ******/
/* Ki kell listázni a termékek azonosítóját, nevét, listaárát, 
	valamint az alábbi transzformációs táblázat alapján az osztályát:
	+-------------------------------------+
	|  Class	|  Megjelenítendő szöveg  |
	+-------------------------------------+
	|    L		|	Low					  |
	|    M		|	Medium				  |
	|    H		|	High				  |
	|   NULL	|	N/A					  |
	+-------------------------------------+ */


/* Ki kell listázni a termékek azonosítóját, nevét, listaárát, 
	valamint az alábbi transzformációs táblázat alapján az árkategóriát:
	+-------------------------------------+
	|  ListPrice		|  Megjelenítendő |
	+-------------------------------------+
	|  < 1000			|	Cheap		  |
	|>=1000 AND <3000	|	Medium		  |
	|  >= 3000			|	Expensive	  |
	+-------------------------------------+ */

/* Ki kell listázni a személyek vezetéknevét, keresztnevét és nemét
	M = Male, F = Female */

/* Ki kell listázni egy paraméterként megadott év rendeléseit a Sales.SalesOrderHeader táblából
	A negyedév római számmal jelenjen meg. */

