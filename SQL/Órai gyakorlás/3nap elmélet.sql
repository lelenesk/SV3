/*
DQL 1.

Predik�tumok, �ll�t�sok.
Ezek seg�ts�g�vel is kialak�thatunk felt�teleket , tehet�nk �ll�t�sokat vagy sz�rhet�nk. 
Ilyen p�ld�ul az IN a vizsg�lt adat a felsoroltak k�z�tt van. �sszehasonl�t� oper�torok =, >, < stb. ezeket kombin�lhatjuk a felki�lt�jellel ami azt jelenti,
hogy nem igaz p�ld�ul != azt jelenti, hogy nem egyenl�. Logikai oper�torok AND, OR, NOT stb. ezekkel p�ld�ul felt�teleket kapcsolhatunk �ssze logikailag stb. 
Aritmetikai oper�torok szorz�s*, oszt�s / stb. A % szorul magyar�zatra. Ez T-SQL-ben az eg�sz oszt�s marad�k�t jelenti teh�t a 11%2=0,5. 
Karakteres �sszekapcsol�sra a + jelet haszn�ljuk.

V�ltoz�k

A T-SQL mint m�s programnyelvek is haszn�l v�ltoz�kat. 
A v�ltoz� olyan ideiglenesen haszn�lt adatt�rol�, ami hivatkozhat�, jellemz�en nevet kap �letciklusa �s �rv�nyess�gi k�re van ezeken bel�l a v�ltoz� neve egyedi kell hogy legyen hiszen egy�rtelm�en tudnunk kell hivatkozni r�juk. 
Azt, hogy v�ltoz�r�l van sz� a @ jellel jel�lj�k a T-SQL-ben. A v�ltoz�kat mindig k�telez� deklar�lni �s meg kell adni az adott v�ltoz� adatt�pus�t is.
A deklar�ci�kor nem k�telez� az �rt�kad�s, de akkor tudatosan figyelni kell r�. 
A T-SQL-ben a v�ltoz�k hat�k�re egy batch (batch) ez egy ford�t�s/futtat�si egys�get jelent.

K�tegelt feldolgoz�s

Az SQL szerver az �ltalunk �rt scripteket / scriptsorozatokat k�tegekben dolgozza fel. 
A feldolgoz�s sor�n el�sz�r szintaktikailag ellen�rzi majd �rtelmezi, leford�tja �s v�g�l v�grehajtja. 
K�tegek feldolgoz�sa tekintet�ben az utas�t�sok k�t csoportba sorohat�ak. Bizonyos parancsok haszn�lhat�ak egy k�tegen bel�l m�sokat pl.: create table k�l�n k�tegbe kell rendezni. 
A k�tegek hat�r�t a GO sz�val tudjuk jel�lni a szervernek. A GO nem SQL utas�t�s csak egy szintaktikai jel�l�.

Adatt�pusok

A v�ltoz�k deklar�l�sa kapcs�n m�r felmer�lt az adatt�pusok k�rd�se.
Mint sok m�s programnyelvben a T-SQL-ben is meg kell adni, hogy mikor milyen adatt�pusr�l van sz�. 
Nem csak a v�ltoz�k, de a t�bl�k mez�inek megad�sakor is. Az adatt�pus hat�rozza meg, hogy a program hogy �rtelmezze az adott karaktereket.
P�ld�ul ha az �5� mint karakter egy v�ltoz�ban valamilyen sz�mk�nt van defini�lva akkor matematikai m�veletekkel hozz�adhat� egy m�sik sz�mhoz �s az �sszeg�ket kapjuk vissza. 
Ha viszont sz�vegk�nt van ugyanez a v�ltoz� deklar�lva akkor egy m�sik sz�veghez f�zhetj�k hozz� mint b�rmilyen m�s sz�veget. 
Az �rtelmez�sen t�l az adatt�pus meghat�rozza azt is, hogy az adatb�zis mekkora t�rter�letet foglal le egy-egy adat t�rol�s�hoz illetve, hogy milyen �rt�keket vehet fel az adot karakter.
A k�vetkez� t�bl�zat egy r�vid �ttekint�st ny�jt az adat t�pusokr�l. Fontos, hogy sok tov�bbi inform�ci� kapcsol�dik a haszn�latukhoz arr�l a t�bl�zat alatti linken �rdemes t�j�koz�dni.

MSSQL Adatt�pusok

Kifejez�sek
A kifejez�sek mez�ket, v�ltoz�kat, f�ggv�nyeket �s oper�torokat tartalmazhatnak. 
A v�grehajt�si sorrendet z�rojelekkel befoly�solhatjuk ha az alap�rtelmezett sz�munkra nem megfelel�. 
A kifejez�sek mindenhol haszn�lhat�ak, ahol a szintaktika megengedi.

Kommentel�s
A kommentel�s seg�t nek�nk �s a koll�g�inknak, hogy az �ltalunk �rtakat �rtelmezni tudjuk.
Ezek a megjegyz�sek nem ker�lnek �rtelmez�sre fut�skor �pp ez�rt ak�r arra is haszn�lhatjuk, hogy a k�dunk egy r�sz�t ne futtassuk le ha �ppen nem szeretn�nk.
A kommenteket k�tf�lek�ppen jel�lhetj�k.

-- a sor v�g�ig komment� v�lik amit m�g� �runk. (inline komment)  

https://github.com/PM-Uzemeltetok/sv3SQL

A kommenteket az MSSM z�ld sz�nnel jelzi.

Lek�rdez�sek

A lek�rdez�sek seg�ts�g�vel tudunk egy adatb�zisb�l adatokat kinyerni �s azokat ut�na �j strukt�r�ban tudjuk �ket felhaszn�lni.
A lek�rdez�s nem m�s mint egy r�vid program, ami utas�tja az adatb�zis szervert, hogy milyen adatokat milyen form�ban gy�jts�n �ssze.
Automatikusan sem a lek�rdez�s k�dja sem a lek�rdez�s eredm�nye nem ker�l ment�sre, de lehet�s�g�nk van mindkett�t elmenteni vagy tov�bbir�ny�tani p�ld�ul v�ltoz�ba.

A SELECT utas�t�s v�grehajt�si sorrendje �s szintaktik�ja sajnos nem egyezik meg viszont mindkett�t tudnunk kell.

A v�grehajt�si sorrend hat�rozza meg, hogy a szerver az utas�t�sainkat milyen sorrendben hajtja v�gre. Ez nagyban befoly�solja a v�geredm�nyt is.Az al�bbi v�grehajt�si sorrend nem minden eleme k�telez� csak a SELECT �s a FROM. A v�grehajt�si sorrend:
* FROM (melyik adatb�zis melyik t�bl�zat�b�l, t�bl�zataib�l szeretn�nk az adatokat)
* (JOIN) (amennyiben t�bb t�bl�b�l szeretn�nk dolgozni) * WHERE (itt hat�rozhatjuk meg a felt�teleket ami alapj�n lesz�rj�k az eredm�nyt)
* GROUP BY (itt a felt�teleinknek megfelel� rekordokat csoportos�thatjuk)
* HAVING (ugyan�gy mint a WHERE parancsn�l felt�teleket adhatunk meg ami alapj�n sz�rj�k az eredm�nyt, de ez�ttal m�r nem az egyes rekordokra sz�r�nk, hanem a GROUP BY �ltal k�pzett csoportok k�z�l v�laszthatjuk ki a nek�nk sz�ks�geseket)
* SELECT (itt v�laszthatjuk azokat a mez�ket, amiket szeretn�nk megjelen�teni, fontos itt a mez�ket (oszlopokat) adjuk meg amiket l�tni szeretn�nk
* DISTINCT (ezzel a param�terrel tudjuk csak az egyedi �rt�kekeket �rt�kkombin�ci�kat megjelen�teni)
* ORDER BY (a legk�rdez�s�nk eddigi eredm�ny�t valamilyen sorrendbe rendezhetj�k ak�r t�bb szempont alapj�n is)
* TOP (itt meghat�rozhatjuk hogy a lek�rdezett �s sorba rendezett rekordok k�z�l h�nyat szeretn�nk l�tni)

A szintaktikai sorrend pedig az al�bbi:
* SELECT DISTINCT TOP * FROM
* (JOIN) * WHERE
* GROUP BY
* HAVING
* ORDER BY
* LIMIT

N�zz�k a parancsokat �s p�r lehet�s�g�ket

Egyt�bl�s SELECT:
Mez�k kiv�laszt�sa �s m�dos�t�sa

A SELECT ut�n egy�rtelm�en meg kell hat�roznunk a megjelen�teni k�v�nt mez�ket. 
Ha csak egyetlen t�bl�t haszn�lunk a lek�rdez�s�nkben (FROM ut�n csak egy t�bla van) akkor a mez�n�v megad�sakor az �t tartalmaz� t�bl�zat neve elhagyhat�. 
Mivel azonban az egyt�bl�s lek�rdez�sek viszonylag ritk�k �gy m�r a kezdetekn�l �rdemes r�szokni, hogy a mez�n�v el�tt megadjuk a t�bla nev�t is a t�blan�v.mez�n�v form�ban. 
Hiszen a mez�neveknek csak t�bl�n bel�l kell egyedinek lennie. M�sik t�bla m�r tartalmazhat azonos mez�nevet. 
Fontos megjegyezni, hogy a T-SQL case sensitive lehet a t�blaneveket illet�en ez a szerver be�ll�t�sait�l f�gg.
Fontos, hogy az egyes lek�rdez�sek v�g�re �rjunk pontosvessz�t (;) ellenkez� esetben a SSMS hib�t fog jelezni ha m�g� �rjuk a k�vetkez� lek�rdez�st vagy m�s utas�t�st.
A k�nyelm�nk �rdek�ben lehet�s�g van arra, hogy egy-egy lek�rdez�sen bel�l aliasokkal hivatkozzunk adatt�bl�kra, hogy ne kelljen mindig ki�rni a teljes nev�ket ezt a FROM ut�n kell megadni. 
Fontos hogy ezeket az aliasokat akkor ismeri f�l a szerver ha a FROM-ba m�r bele�rtuk. 
Ez�rt gyakori hogy el�sz�r a select ut�na csak egy csillagot �runk ut�na meg�rjuk a FROM r�szt majd visszat�r�nk a SELECT-hez amikor m�r felismeri a program az aliasaink �s ki tudja eg�sz�teni.
*/

SELECT P.ProductID
FROM Production.Product P 

/*
Haszn�lhatunk k�pleteket �s kifejez�seket amiknek ut�na aliast adhatunk. 
Fontos, hogy mivel a WHERE hamarabb hajt�dik v�gre, ez�rt a SELECT-ben defini�lt aliasok nem hivatkozhat�ak a WHERE r�szben.
Az itt megadott alias lesz a lek�rdez�s�nk eredm�ny�ben az oszlop neve ha nem adunk meg akkor No column name fog megjelenni.
*/
SELECT P.StandardCost, P.ListPrice, P.StandardCost + P.ListPrice as �sszeg
FROM Production.product as P

/*
Haszn�lhatunk k�pleteket �s kifejez�seket amiknek ut�na aliast adhatunk. 
Fontos, hogy mivel a WHERE hamarabb hajt�dik v�gre, ez�rt a SELECT-ben defini�lt aliasok nem hivatkozhat�ak a WHERE r�szben.
Az itt megadott alias lesz a lek�rdez�s�nk eredm�ny�ben az oszlop neve ha nem adunk meg akkor No column name fog megjelenni.
T�bb programnak probl�m�ja lehet azzal ha egy mez�nek nincs neve ez�rt ker�lend�
*/
 SELECT P.name+ P.Productnumber as hosszun�v
        FROM Production.Product P 

/*
A fenti p�ld�ban a n�vhez hozz�f�zz�k a productnumber-t folytat�lagosan.
Ha szeretn�nk valamilyen fix karakterl�ncot hozz�f�zni egy mez� �rt�k�hez akkor azt aposztr�fok (�) k�z� kell tenni.
�gy m�r lesz egy space a productnumber �s a ProductNumber k�z�tt.
*/
SELECT P.name + ' ' + P.Productnumber as hosszun�v
        FROM Production.Product P 

/*
**********************WHERE***********************************
Term�szetesen amikor lek�rdez�st csin�lunk akkor nem mindig akarjuk l�tni az �sszes rekordot, hanem valamilyen szempont szerint szeretn�nk sz�rni ezeket. 
Erre szolg�l a WHERE kulcssz�. A legegyszer�bb eset, amikor egyetlen szempont szerint szeretn�nk sz�rni. Mint az al�bbi p�lda mutatja.
*/
SELECT P.ProductID, P.Name, P.Color
FROM Production.product P
WHERE P.Color ='Red'


/*
Ebben az esetben a lek�rdez�s�nk a piros sz�n� term�keket fogja kisz�rni. 
Fontos, hogy sz�r�skor a felt�tel �rt�k�t (jelen esetben a Red sz�t) aposztrofok (') k�z� kell tenni. 
Term�szetesen nem mindig csak egy �rt�kre akarunk sz�rni. Ha ugyanannak a mez�nek t�bb lehets�ges �rt�k�re is k�v�ncsiak vagyunk akkor azt k�tf�lek�ppen is le�rhatjuk. 
A k�l�nb�z� felt�teleket az **OR** sz� haszn�lat�val �sszef�zhetj�k vagy ak�r az **IN** sz� haszn�lat�val fel is sorohatjuk. 
Teh�t a WHERE felt�tel ut�n a k�vetkez� k�t kifejez�s egyen�rt�k�
*/
SELECT P.ProductID, P.Name, P.Color
FROM Production.product P
WHERE P.Color ='Red' OR P.Color='Blue'
/*vagy �gy:
WHERE P.Color IN ('Red', 'Blue')
*/

/*
Az IN sz� haszn�latakor a lehets�ges �rt�kekeket z�r�jelek k�z�tt vessz�vel elv�lasztva kell felsorolni. 
Ha sz�mokr�l vagy d�tumokr�l van sz�, akkor haszn�lhatjuk a BETWEEN sz�t. 
�gy nem kell minden lehets�ges �rt�ket felsorolni, hanem el�g az intervallumot megadni. 
L�sd az al�bbi p�lda.
*/
SELECT SOH.SalesOrderID, SOH.DueDate
FROM Sales.salesorderheader SOH
WHERE SOH.DueDate BETWEEN '20120301' AND '20120331'

/*
A fenti lek�rdez�ssel a m�rciusi rendel�seket kapjuk meg. 
A BETWEEN ut�n az �rt�keket aposztrofok k�z�tt az AND sz�val kell megadni.
Term�szetesen ilyen esetekben haszn�lhatjuk a rel�ci�s jeleket is.
*/
SELECT SOH.SalesOrderID, SOH.DueDate
FROM Sales.salesorderheader SOH
WHERE SOH.DueDate >= '20120301' AND SOH.DueDate < '20120404'

/*
Az AND logikai �s. Teh�t mindk�t felt�telnek teljes�lnie kell. 
Fontos, hogy a nagyobb �s a nagyobb egyenl� k�zti k�l�nbs�gekre ilyen esetben odafigyelj�nk.
Ha csak az egyes �rt�kek egy r�sz�re szeretn�nk sz�rni p�ld�ul minden olyan term�kre ami a Socks sz�val kezd�dik akkor a LIKE-ot kell haszn�lnunk. 
SQL-ben a % jel a joker karakter. Az al�bbi p�lda minden olyan term�ket kigy�jt, ahol a Name mez�ben Chain-el kezd�d� �rt�k van.
*/
SELECT P.ProductID, P.Name      
FROM Production.product P
WHERE P.Name LIKE 'Chain%'

/*Fontos hogy sok programnyelvel ellent�tben SQL-ben a joker karaktert is aposztrofok k�z� kell tenni.
Sok esetben el�fordul, hogy hogy nem azt az �rt�ket szeretn�nk megjelen�teni, ami az adatt�bl�nkban van hanem a t�bla tartalm�t�l f�gg�en valamilyen m�s �rt�ket. 
Erre haszn�lhatjuk a CASE f�ggv�nyt. A CASE f�ggv�nyben a CASE sz� ut�n �rjuk a mez� nev�t amire a felt�teleink vonatkoznak. 
A WHEN sz�val kezdj�k az adott �gat, ut�na �rjuk a felt�telt majd a THEN sz� ut�n hogy mire cser�lje. A CASE f�ggv�nynek lehet ELSE �ga, ami minden fel nem sorolt esetet jelent. A CASE f�ggv�nyt END-el z�rjuk le. Az al�bbi p�ld�ban a neveket szeretn�m magyarul megjelen�teni.
*/
SELECT P.ProductID, P.Name,
    CASE P.Color WHEN 'Blue' THEN 'K�k'
                 WHEN 'Red' THEN 'Piros'
                 WHEN 'Silver' THEN 'Ez�st'
                 WHEN 'Black' THEN 'Fekete'
                 ELSE 'N/A'
                 END as Sz�n
FROM Production.product P
/*
Lehet�s�g�nk van arra is, hogy egy mez� �rt�k�t valamilyen felt�telhez k�tve adjuk meg. 
Ehhez az IIF parancsot kell haszn�lni aminek a szintaktik�ja IIF (felt�tel, �rt�k ha igaz, �rt�k ha hamis). 
Haszn�lat�ra l�sd az al�bbi p�ld�t.
*/
SELECT E.LoginID, IIF(E.Gender='M', 'Male', 'Female') Gendername
FROM Humanresources.employee E

/* **************ORDER BY**************************
A rendez�s a k�vetkez� olyan funkci�, amit gyakran haszn�lunk.
Alap�rtelmez�sk�nt az SQL n�vekv� sorrendbe rendez a megadott mez� szerint. 
Ha cs�kken� sorrendet szeretn�nk akkor a DESC kit�tel haszn�lata sz�ks�ges.
Ha akarunk akkor rendezhet�nk t�bb szempont szerint ilyenkor a be�rt mez�k sorrendj�ben fog rendezni a program.
A mez�kre hivatkozhatunk a nev�kkel vagy a sorsz�mukkal is (h�nyadik mez� a SELECT-ben) Mint a al�bbi p�ld�ban l�that�.
*/
SELECT P.ProductID, P.Name, P.Color
FROM Production.product P
ORDER BY P.name, P.Color DESC

/* **************************R�szhalmazok lek�rdez�se***************************
Vannak olyan esetek, amikor nincs sz�ks�g�nk egy lek�rdez�s �sszes adat�ra, hanem csak valamilyen szempont szerint az els� 10.
Erre haszn�lhatjuk a TOP utas�t�st. �gy lekorl�tozni a darabsz�mot t�bbnyire akkor szoktunk miut�n valamilyen szempont szerint m�r sorbarendezt�k az adatainkat.
Klasszikus p�lda amikor a legocs�bb term�kekre vagyunk k�v�ncsiak. 
Ezt fogjuk megn�zni a k�vetkez� ki p�ld�ban.
*/
SELECT TOP 10 P.name, P.ListPrice 
FROM Production.Product P
WHERE P.ListPrice >0
Order BY P.ListPrice

/*M�sik gyakori eset amikor r�szhalmazra van sz�ks�g p�ld�ul egy web�ruh�z oldala, amikor nem akarjuk egyszerre megjelen�teni az �sszes adatot, hanem egyszerre csak kevesebbet. 
Jellemz�en 10-20 term�ket mondjuk majd ut�na �jabb 10-20 term�ket. Ezt az OFFSET �s FETCH parancs kombin�ci�val tehetj�k meg.
Ahol az OFFSET ut�n kell megadni, hogy h�ny rekordot nem szeretn�nk l�tni (az ut�na k�vetkez�t�l l�tjuk majd) �s a FETCH ut�n hogy h�ny sort jelen�tsen meg.
A k�vetkez� kis p�lda 25 sort fog megmutatni a 51. rekordt�l.
*/
SELECT P.ProductID, P.name, P.ListPrice
FROM Production.Product P
ORDER BY P.ProductID
OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY























