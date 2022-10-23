

--Kérdezd le a S-es kék termékeket a product táblából.
select P.name, P.color, P.size
from Production.Product P
where P.color='Blue' and P.size = 'S'

--Kérdezd le azokat a termékeket amiknek a nevében szerepel a bike szó.
select P.name, P.color, P.size
from Production.Product P
where P.name like '%bike%'

--Kérdezd le a piros színû termékeket és a színét írd ki magyarul.
select P.name,
	case P.color WHEN 'Red' THEN 'Piros'
	else ''
	end as Szín
from Production.Product P
where P.color ='Red'

--Rendezd a termékek nevét ABC sorrendbe.
select P.name
from Production.Product P
order by P.name

--Kérdezd le a termékek nevét, árát és színét és rendezd listaár szerint csökkenõ sorrendbe
select P.name, P.ListPrice, P.Color
from Production.Product P
order by P.ListPrice DESC


--Kérdezd le a 100 legrégebb óta (sellstartdate) forgalmazott terméket
select P.name, P.SellStartDate
from Production.Product P
order by P.ListPrice DESC
OFFSET 0 ROWS FETCH NEXT 100 ROWS ONLY

--Kérdezd le a 10 legolcsóbb terméket, aminek az ára nagyobb 0-nál és a neve tartalmazza a Pedal szót.
select P.name, P.ListPrice
from Production.Product P
Where P.Name like '%Pedal%' AND P.ListPrice >0
order by P.ListPrice
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY

--Kérdezd le az összes nevet és megszólítást (Title) a Person táblából és fûzd össze õket, a megszólítást és a nevek között legyen egy darab köz kezeld azokat az eseteket is amikor valamely mezõ értéke NULL.
select PP.FirstName, PP.MiddleName, PP.LastName, PP.Title,
CONCAT(COALESCE(PP.Title+' ',''),PP.FirstName, COALESCE(' '+ PP.MiddleName,''), ' ',PP.LastName)
--CONCAT(COALESCE(PP.Title+' ','sb '),COALESCE(PP.FirstName+' ',''),COALESCE(PP.MiddleName+' ',''),COALESCE(PP.LastName+ ' ',''))
from Person.Person PP




