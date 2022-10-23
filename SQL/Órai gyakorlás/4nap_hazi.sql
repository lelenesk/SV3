

--K�rdezd le a S-es k�k term�keket a product t�bl�b�l.
select P.name, P.color, P.size
from Production.Product P
where P.color='Blue' and P.size = 'S'

--K�rdezd le azokat a term�keket amiknek a nev�ben szerepel a bike sz�.
select P.name, P.color, P.size
from Production.Product P
where P.name like '%bike%'

--K�rdezd le a piros sz�n� term�keket �s a sz�n�t �rd ki magyarul.
select P.name,
	case P.color WHEN 'Red' THEN 'Piros'
	else ''
	end as Sz�n
from Production.Product P
where P.color ='Red'

--Rendezd a term�kek nev�t ABC sorrendbe.
select P.name
from Production.Product P
order by P.name

--K�rdezd le a term�kek nev�t, �r�t �s sz�n�t �s rendezd lista�r szerint cs�kken� sorrendbe
select P.name, P.ListPrice, P.Color
from Production.Product P
order by P.ListPrice DESC


--K�rdezd le a 100 legr�gebb �ta (sellstartdate) forgalmazot term�ket
select P.name, P.SellStartDate
from Production.Product P
order by P.ListPrice DESC
OFFSET 0 ROWS FETCH NEXT 100 ROWS ONLY

--K�rdezd le a 10 legolcs�bb term�ket, aminek az �ra nagyobb 0-n�l �s a neve tartalmazza a Pedal sz�t.
select P.name, P.ListPrice
from Production.Product P
Where P.Name like '%Pedal%' AND P.ListPrice >0
order by P.ListPrice
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY

--K�rdezd le az �sszes nevet �s megsz�l�t�st (Title) a Person t�bl�b�l �s f�zd �ssze �ket, a megsz�l�t�st �s a nevek k�z�tt legyen egy darab k�z kezeld azokat az eseteket is amikor valamely mez� �rt�ke NULL.
select PP.FirstName, PP.MiddleName, PP.LastName, PP.Title,
CONCAT(COALESCE(PP.Title+' ',''),PP.FirstName, COALESCE(' '+ PP.MiddleName,''), ' ',PP.LastName)
--CONCAT(COALESCE(PP.Title+' ','sb '),COALESCE(PP.FirstName+' ',''),COALESCE(PP.MiddleName+' ',''),COALESCE(PP.LastName+ ' ',''))
from Person.Person PP




