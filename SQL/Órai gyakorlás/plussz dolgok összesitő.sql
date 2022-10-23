-- középsõ név fomrázás én megoldásom

SELECT p.Title, p.FirstName, p.MiddleName, p.LastName,
case when p.MiddleName like '_.' then CONCAT(COALESCE(p.Title+' ',''),p.FirstName,' '+ p.MiddleName,' ',p.LastName)
     when p.MiddleName like '_'  then CONCAT(COALESCE(p.Title+' ',''),p.FirstName,' '+p.MiddleName+'.', ' ',p.LastName)
     when p.MiddleName is null   then CONCAT(COALESCE(p.Title+' ',''),p.FirstName,' ',p.LastName)
     else CONCAT(COALESCE(p.Title+' ',''),p.FirstName,' '+ p.MiddleName,' ',p.LastName)
     END as 'Teljes név'
FROM Person.Person p
ORDER BY p.FirstName, p.MiddleName, p.LastName

-- középsõ név fomrázás vercsi megoldása

SELECT p.Title, p.FirstName, p.MiddleName, p.LastName, p.Suffix,
REPLACE (REPLACE (CONCAT(p.Title,+' '+p.FirstName,+' '+IIF(LEN (P.MiddleName)>2,p.MiddleName+' ',COALESCE(p.MiddleName+'. ',''))+p.LastName,+' '+p.Suffix),'  ',' '),'..','.')
FROM Person.Person p
ORDER BY P.FirstName, P.MiddleName, P.LastName

--alap verzió
--Kérdezd le az összes nevet és megszólítást (Title) a Person táblából és fûzd össze õket, a megszólítást és a nevek között legyen egy darab köz kezeld azokat az eseteket is amikor valamely mezõ értéke NULL.
select PP.FirstName, PP.MiddleName, PP.LastName, PP.Title,
CONCAT(COALESCE(PP.Title+' ',''),PP.FirstName, COALESCE(' '+ PP.MiddleName,''), ' ',PP.LastName)
--CONCAT(COALESCE(PP.Title+' ','sb '),COALESCE(PP.FirstName+' ',''),COALESCE(PP.MiddleName+' ',''),COALESCE(PP.LastName+ ' ',''))
from Person.Person PP

