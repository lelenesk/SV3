-- k�z�ps� n�v fomr�z�s �n megold�som

SELECT p.Title, p.FirstName, p.MiddleName, p.LastName,
case when p.MiddleName like '_.' then CONCAT(COALESCE(p.Title+' ',''),p.FirstName,' '+ p.MiddleName,' ',p.LastName)
     when p.MiddleName like '_'  then CONCAT(COALESCE(p.Title+' ',''),p.FirstName,' '+p.MiddleName+'.', ' ',p.LastName)
     when p.MiddleName is null   then CONCAT(COALESCE(p.Title+' ',''),p.FirstName,' ',p.LastName)
     else CONCAT(COALESCE(p.Title+' ',''),p.FirstName,' '+ p.MiddleName,' ',p.LastName)
     END as 'Teljes n�v'
FROM Person.Person p
ORDER BY p.FirstName, p.MiddleName, p.LastName

-- k�z�ps� n�v fomr�z�s Vercsi megold�sa

SELECT p.Title, p.FirstName, p.MiddleName, p.LastName, p.Suffix,
REPLACE (REPLACE (CONCAT(p.Title,+' '+p.FirstName,+' '+IIF(LEN (P.MiddleName)>2,p.MiddleName+' ',COALESCE(p.MiddleName+'. ',''))+p.LastName,+' '+p.Suffix),'  ',' '),'..','.')
FROM Person.Person p
ORDER BY P.FirstName, P.MiddleName, P.LastName

--alap verzi�
--K�rdezd le az �sszes nevet �s megsz�l�t�st (Title) a Person t�bl�b�l �s f�zd �ssze �ket, a megsz�l�t�st �s a nevek k�z�tt legyen egy darab k�z kezeld azokat az eseteket is amikor valamely mez� �rt�ke NULL.
select PP.FirstName, PP.MiddleName, PP.LastName, PP.Title,
CONCAT(COALESCE(PP.Title+' ',''),PP.FirstName, COALESCE(' '+ PP.MiddleName,''), ' ',PP.LastName)
--CONCAT(COALESCE(PP.Title+' ','sb '),COALESCE(PP.FirstName+' ',''),COALESCE(PP.MiddleName+' ',''),COALESCE(PP.LastName+ ' ',''))
from Person.Person PP

