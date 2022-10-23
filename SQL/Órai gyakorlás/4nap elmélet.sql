/*
Adatt�pusok �s kapcsol�d� f�ggv�nyek

Mint minden programnyelvben az SQL-ben is minden �rt�khez hozz�tartozik valamilyen adatt�pus ilyen szempontb�l mindegy, hogy v�ltoz�tr�l vagy egy adatt�bla mez�j�r�l van sz�. 
Az adatt�pus sok esetben meghat�rozza, hogy milyen m�veletek �s hogyan hajthat�ak v�gre az adott �rt�kkel.
P�ld�ul ha van k�t v�ltoz�nk amiknek az �rt�ke '1' �s azok valamilyen sz�mt�pusk�nt vannak defini�lva akkor v�ltoz�1 + v�ltoz�2 =2,
viszont ha sz�vegt�pusk�nt vannak deklar�lva akkor v�ltoz�1 + v�ltoz�2=11 mivel sz�veg eset�n T-SQL-ben a + jel �sszef�z�st jelent.

Amikor adatokkal dolgozunk gyakran sz�ks�ges, hogy ezeket az adatt�pusokat konvert�ljuk. 
Az SQL ebben seg�ts�g�nkre van �s sok esetben ezt automatikusan megteszi. Azonban vannak helyzetek, amikor err�l nek�nk kell gondoskodni. 
Term�szetesen nem mindent lehet mindenn� �tkonvert�lni. Ezt a k�vetkez� t�bl�zat foglalja �ssze, illetve az alatta l�v� linken tal�lhattok tov�bbi inform�ci�kat.

T-SQL adatt�pus konverzi�
A konvert�l�sra t�bb f�ggv�ny�nk is van. A CAST() �s a CONVERT() f�ggv�nyek k�zel teljesen egyen�rt�k�ek alapszinten,
a CONVERT a nyelvf�gg� be�ll�t�sokn�l rendelkezik extra funkci�val cser�be a CAST t�bb SQL nyelvben haszn�latos m�g a CONVERT nem. 
A szintaktik�juk elt�r�, ami a k�vetkez�k�ppen n�z ki. CAST(konvert�land� AS adatt�pus) a CAST eset�ben fontos, hogy itt az AS sz� nem hagyhat� el mindig ki kell �rni.
A CONVERT(adatt�pus, konvert�land�) szintaktik�ja a ford�tottja a CAST-�nak. A kovert�lad� lehet v�ltoz� mez� stb. 
Az adatt�pus mindk�t esetben az az adatt�pus amire konvert�lni szeretn�nk. Fontos m�g megjegyezni, hogy vannak korl�tai annak milyen adatt�pusokra lehet konvert�lni.
A k�vetkez� kis p�ld�ban a term�kek m�ret�t pr�b�ljuk meg sz�mm� konvert�lni.
*/

SELECT P.Name, P.Size, CAST(P.size AS decimal) sizeint
FROM Production.product P

/*Azt fogjuk tapasztalni, hogy a f�ggv�ny�nk csin�l n�h�ny furcsas�got annak f�ggv�ny�ben, hogy az adott rekordban milyen �rt�k van a size mez�ben. - Ha sz�m volt benne akkor gond n�lk�l �tkonvert�lja - Ha NULL volt az �rt�ke akkor konverzi� ut�n is NULL lesz. - Ha sz�veg volt akkor viszont a konverzi� hib�ra fut. - Az ut�bbi esetekre k�n�l megold�st a TRY_CAST() �s a TRY_CONVERT(). A szintaktik�juk ugyanaz mint az alapv�ltozatoknak, de ha nem konvert�lhat� �rt�kkel tal�lkoznak, akkor nem sz�llnak el hib�val, hanem NULL �rt�kkel t�rnek vissza. A TRY verzi�k ugyan megoldj�k, hogy ne fusson hib�ra a k�dunk, de b�njunk vele k�r�ltekint�en. A konvert�lt adatokkal tov�bbi m�veleteket fogunk v�gezni �s a NULL nem egyenl� egy konkr�t �rt�kkel.
A konverzi�ra van m�g egy k�l�nleges parancsunk a PARSE() �s annak a TRY_PARSE() verzi�ja. Szint�n konverzi�s f�ggv�nyek viszont a CAST-al ellent�tben meg lehet adni a kult�r�t/nyelvet �s lekezeli az ebb�l fakad� elt�r�seket. Az olyen esetekben mint a p�nznem t�pusra konvert�l�s a CAST f�ggv�ny helytelen eredm�nyt adhat mert nem veszi figyelembe a nyelvi saj�toss�gokat. Ilyenkor kell nek�nk a PARSE, amit csak string sz�m vagy date/time t�pusokk� konvert�l�s�ra lehet haszn�lni.
Az al�bbi kis p�lda mutatja meg a PARSE haszn�lat�t egy v�ltoz�n.
*/
   
DECLARE @�sszeg varchar(30) = '1350,20'
SELECT @�sszeg, Parse(@�sszeg as money using 'hu-hu')

/*
Sz�veg f�ggv�nyek

�sszegy�jt�tt�nk n�h�ny olyan f�ggv�nyt ami a sz�veg t�pus� adatokhoz haszn�lhat�. 
Ezek megfelel�i sok m�s programnyelvben megjelennek. 
A legfontosabb k�z�l�k tal�n a sz�veg �sszef�z�s�re szolg�l� CONCAT() f�ggv�ny, ami nem csin�l m�st, mint a megadott sz�vegeket vagy kifejez�sek �rt�k�t �sszef�zi egym�s ut�n. 
Fontos kit�tel, hogyha b�rmely �sszef�zni k�v�nt kifejez�s �rt�ke NULL akkor a CONCAT eredm�nye is NULL lesz. 
Term�szetesen erre is van megold�s, amit majd a NULL kezel�s t�mak�r�ben fogunk megn�zni.
Az al�bbi kis p�lda a term�k nev�t �s sz�n�t f�zi �ssze egyetlen karakterl�ncc�.
*/

SELECT P.Name, P.Color, CONCAT (P.name, P.Color)  as 'term�k �s sz�n'
FROM Production.product P

/*
A k�vetkez� 3 f�gv�nyt olyankor haszn�ljuk, amikor egy sz�veg egy r�sz�re van sz�ks�g�nk. 
Eze a LEFT() a RIGHT() �s a SUBSTRING(). Az el�bbi kett� el�g egy�rtelm� a SUBSTRING seg�ts�g�vel pedig egy karakterl�nc k�zep�r�l szedhet�nk ki karaktereket.
A szintaktik�juk a k�vetkez�: LEFT()(sz�veg, karakterek sz�ma) Balr�l kezdve ad vissza megadott sz�m� karaktert. 
RIGHT() (sz�veg, karakterek sz�ma) A sz�veg v�g�r�l indulva add vissza megadott sz�m� karaktert. 
SUBSTRING() (sz�veg, honnant�l,mennyit) A megadott sz�m� karaktert�l kezdve ad vissza megadott sz�m� karaktert.
Az al�bbi kis p�lda nem fog �rtelmes adatot visszaadni, de arra j�, hogy l�ssuk a szintaktik�t �l�ben.
*/

SELECT P.name, LEFT(P.name,5) eleje, RIGHT(P.name, 4) v�ge, SUBSTRING(P.name,3,3) k�zepe
FROM Production.product P
/*
A k�vetkez� csoportba n�h�ny olyan f�ggv�nyt soroltunk, amik a karakterl�nc hossz�t valamint a k�z�k ' ' elt�vol�t�s�t teszik lehet�v�.
DATALENGTH (sz�veg) Egy karakterl�nc karaktereinek sz�m�t adja vissza k�z�kkel egy�tt. LEN (sz�veg) Ugyanaz mint a DATALENGTH, de a karakterl�nc v�g�n l�v� k�z�ket nem sz�molja bele. 
LTRIM (sz�veg) Lev�gja a karakterl�nc elej�r�l a f�l�sleges k�z�ket. RTRIM(sz�veg) Lev�gja a f�l�sleges k�z�ket egy karakterl�nc v�g�r�l. TRIM (sz�veg) 2017 �ta haszn�lhat�. 
A karakterl�nc mindk�t v�g�r�l lev�gja a f�l�sleges k�z�ket.
V�g�l pedig a CHARINDEX(), amit b�r gyakran haszn�lunk a k�z�k kezel�s�hez egy karakterl�ncban de enn�l t�bbet tud. 
A CHARINDEX seg�ts�g�vel egy sz�vegr�szre kereshet�nk r� egy karakterl�ncban �s visszaadja, hogy h�nyadik karaktern�l tal�lta meg.
A sz�mol�st 1-t�l kezdi. Ha nem tal�lja meg a keresett sz�vegr�szt, akkor 0 �rt�kkel t�r vissza. 
N�zz�nk is egy gyakorlati p�ld�t a karakterf�ggv�nyek haszn�lat�ra. 
Gyakran el�fordul, hogy a vezet�knevet �s keresztnevet egy cell�ba mentik el �s sokszor k�l�n k�l�n is sz�ks�g lenne r�juk.
Ilyenkor j�n j�l az al�bbi programocska, amivel most a term�kek nev�t fogjuk sz�tbontani.
*/

SELECT P.name, 
        CHARINDEX(' ', P.Name) as k�z, --els� k�z helye, ha t�bb is van akkor az els� hely�t adja vissza
        LEFT(P.name, CHARINDEX(' ', P.Name)) as eleje, --visszaadja a karakterl�nc elej�t a k�zig
        RIGHT(P.name, LEN(P.name)-CHARINDEX(' ', P.Name)) as v�ge -- visszaadja a karakterl�nc v�g�t a k�zt�l
        FROM Production.Product P
/*
Mint l�that� a f�ggv�nyek param�tereinek hely�re �rhatunk kifejez�seket.
Az utols� sz�vegf�ggv�ny amivel most foglalkozunk az a REPLACE(). Seg�ts�g�vel egy karaktert vagy karakter l�ncot cser�lhet�nk ki egy m�sikra egy sz�vegben.
Erre meglep�en gyakran van sz�ks�g. P�ld�ul a magyar �kezetes bet�ket n�met nyelvter�leten szeretik karakterkombin�ci�val helyettes�teni p�ld�ul � helyet ai-t �rnak. 
Vagy p�ld�ul sz�vegk�nt mentenek el sz�mokat �s a tizedesvessz�t mint karaktert elt�rolj�k. Ilyen esetekben j�n j�l a REPLACE.
A k�vetkez� p�ld�ban a k�z�k hely�re al�von�st '_' �runk.
*/

SELECT P.name, REPLACE(P.name,' ','_')
    FROM Production.Product p
/*
D�tum f�ggv�nyek

A m�sik f�gv�nycsoport amivel foglalkozunk most azok a d�tum form�tumhoz kapcsol�d� f�ggv�nyek. 
A legegyszer�bb k�z�l�k amikor csak a d�tum egy r�sz�re van sz�ks�g�nk �vre, h�napra, adott napra k�l�n k�l�n. 
Erre val� a YEAR(), MONTH() �s DAY() f�ggv�nyek amik m�g� csak z�r�jelbe meg kell adnunk az adatot. Egy egyszer� kis p�lda erre.
*/

SELECT P.name, P.SellStartDate, YEAR(P.SellStartDate) �v, MONTH(P.SellStartDate) h�nap, DAY(P.SellStartDate) nap
    FROM Production.Product P
/*
Ezek a f�ggv�nyek sz�mk�nt adj�k vissza a k�rt adatot.
A DATEPART() f�ggv�ny tov�bbi adatokat tud adni nek�nk egy adott d�tumr�l, annak f�ggv�ny�ben, hogy milyen param�terrel haszn�ljuk. 
N�h�ny param�ter: 
- YYYY az �vsz�mot adja vissza mint a YEAR f�ggv�ny 
- Y h�nyadik napja az adott �vnek 
- q visszaadja a negyed�vet ahova a d�tum esik 
- ww h�nyadik h�tre esik a d�tum 
- w visszaadja, hogy az adott h�t h�nyadik napj�ra esik a d�tum.
N�zz�nk erre egy r�vid kis p�ld�t. 
Ami a fent felsorolt param�terek szerint visszaadja a term�kek elad�s�nak kezdet�re vonatkoz� inf�kat. 
Ahhoz hogy a DATEPART f�ggv�nyek biztos helyesen m�k�dj�n �rdemes be�ll�tani a h�t kezd�napj�t k�l�nben a nyelvi be�ll�t�sok f�ggv�ny�ben el�fordulhat hogy helytelen adatot kapunk,
amikor lek�rdezz�k h�nyadik napj�ra esik a h�tnek az adott d�tum ehhez a SET DATEFIRST 1 parancsot kell kiadnunk.
*/

SET DATEFIRST 1 
SELECT P.name, 
        P.SellStartDate,
        DATEPART(yyyy,P.SellStartDate) �v,
        DATEPART(y,P.SellStartDate) 'nap az �vben',
        DATEPART(q,P.SellStartDate) negyed�v,
        DATEPART(ww,P.SellStartDate) 'h�nyadik h�t',
        DATEPART(w,P.SellStartDate) 'nap a h�ten'
        FROM Production.Product P

/*
Lehet�s�g�nk van arra is, hogy az adott h�nap nev�t �s az adott nap nev�t tudjuk meg. Erre haszn�lhat� a DATENAME() f�ggv�ny.
A w param�terrel a napot m param�terrel a h�nap nev�t kapjuk meg,
A SET LANGUAGE parancsal pedig a nyelvet m�dos�thatjuk annak megfelel�en hogy milyen nyelven szeretn�nk visszakapni az eredm�nyet. Itt egy kis p�lda a haszn�lat�ra.
*/

SET LANGUAGE MAGYAR
SELECT P.name, P.SellStartDate,DATENAME(w, P.SellStartDate), DATENAME(m, P.SellStartDate)
    FROM Production.Product P

/*
Az aktu�lis d�tumot �s id�t is lek�rhetj�k SQL seg�ts�g�vel. T�bb f�ggv�ny is k�pes erre �s a r�szletekre oda kell figyelni a haszn�latukkor.
A GETDATE �s a SYSDATETIME f�ggv�nyek az aktu�lis id�pontot k�rik le az ut�bbi pontosabb. 
Arra viszont oda kell figyelni a haszn�latukkor, hogy az SQL szerver szerinti id�z�n�t haszn�lj�k. 
Ezt k�sz�b�li ki a GETUTCDATE() f�ggv�ny, ami mindig a greenwichi id�t adja vissza.

NULL kezel�s

Az SQL nyelvben a NULL nem egyenl� a matematikai null�val vagy semmivel. A NULL azt jelenti, hogy az adott �rt�ket nem ismerj�k.
�ppen ez�rt sokszor kell kezeln�nk ezt az esetet, mert a NULL-al val� �sszehasonl�t�s eredm�nye mindig FALSE illetve a NULL-al v�gzet b�rmilyen m�velet p�ld�ul az �sszead�s �rt�ke mindig NULL lesz. 
Ezt az esetet tudja kezelni p�ld�ul a COALESCE() f�ggv�ny, aminek a szintaktik�ja COALESCE (mez�n�v, helyettes�t� �rt�k). A COALESCE haszn�latakor ha az adott mez�ben egy rekord �rt�ke NULL akkor a helyettes�t� �rt�ket haszn�lja az SQL. 
Az al�bbi p�ld�ban lek�rj�k a term�keink nev�t �s ahol nincs megadva sz�n oda be�rjuk hogy sz�ntelen.
*/

SELECT P.Name, P.Color, COALESCE(P.Color,'szintelen') as 'sz�n'
FROM Production.product P
/*
Fontos m�g tudni, hogy COALESCE f�ggv�nyn�l ak�r a mez�n�v hely�re ak�r a helyettes�t� �rt�k hely�re �rhatunk kifejez�seket is. 
Az el�bbi p�ld�t kicsit tov�bbvive. A k�vetkez� r�vid kis lek�rdez�sben �sszef�zz�k egy mez�be a term�k nev�t �s sz�n�t �s kezelj�k azokat az eseteket ha ak�r a n�v ak�r a sz�n mez�ben NULL van.
*/

SELECT P.Name, P.Color, CONCAT (COALESCE(P.name, 'n�v?'), COALESCE(P.Color, 'sz�n?'))  as 'term�k �s sz�n'
FROM Production.product P
/*
Sz�mok �s d�tumok eset�n az IFNULL() f�ggv�nyt is haszn�lhatjuk �s ak�r csak a COALESCE-n�l meg kell adnunk egy helyettes�t� �rt�ket. 
Az al�bbi kis p�ld�ban ha nincs megadva a term�k s�lya akkor automatikusan be�rja hogy 2 legyen.
*/

SELECT P.Name, P.Weight, ifnull(P.weight, '2')
FROM Production.product P
/*
Vannak olyan esetek, amikor arra vagyunk k�v�ncsiak, hogy egy adott mez� �rt�ke NULL vagy nem NULL erre szolg�l az IS NULL kifejez�s.
Az al�bbi kis p�ld�ban kigy�jtj�k azokat a term�keket, amiknek nincs megadva a sz�ne.
*/

SELECT P.Name, P.color
FROM Production.product P
WHERE P.Color IS NULL
/*
Ennek az ellent�te amikor arra vagyunk k�v�ncsiak, hogy mely term�keknek van megadva a sz�ne. Erre haszn�lhatjuk az IS NOT NULL kifejez�st.
*/

SELECT P.Name, P.color
FROM Production.product P
WHERE P.Color IS NOT NULL