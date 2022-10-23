/*
DQL 1.

Predikátumok, állítások.
Ezek segítségével is kialakíthatunk feltételeket , tehetünk állításokat vagy szûrhetünk. 
Ilyen például az IN a vizsgált adat a felsoroltak között van. Összehasonlító operátorok =, >, < stb. ezeket kombinálhatjuk a felkiáltójellel ami azt jelenti,
hogy nem igaz például != azt jelenti, hogy nem egyenlõ. Logikai operátorok AND, OR, NOT stb. ezekkel például feltételeket kapcsolhatunk össze logikailag stb. 
Aritmetikai operátorok szorzás*, osztás / stb. A % szorul magyarázatra. Ez T-SQL-ben az egész osztás maradékát jelenti tehát a 11%2=0,5. 
Karakteres összekapcsolásra a + jelet használjuk.

Változók

A T-SQL mint más programnyelvek is használ változókat. 
A változó olyan ideiglenesen használt adattároló, ami hivatkozható, jellemzõen nevet kap életciklusa és érvényességi köre van ezeken belül a változó neve egyedi kell hogy legyen hiszen egyértelmûen tudnunk kell hivatkozni rájuk. 
Azt hogy változóról van szó a @ jellel jelöljük a T-SQL-ben. A változókat mindig kötelezõ deklarálni és meg kell adni az adott változó adattípusát is.
A deklarációkor nem kötelezõ az értékadás, de akkor tudatosan figyelni kell rá. 
A T-SQL-ben a változók hatóköre egy batch (batch) ez egy fordítás/futtatási egységet jelent.

Kötegelt feldolgozás

Az SQL szerver az általunk írt scripteket / scriptsorozatokat kötegekben dolgozza fel. 
A feldolgozás során elõször szintaktikailag ellenõrzi majd értelmezi, lefordítja és végül végrehajtja. 
Kötegek feldolgozása tekintetében az utasítások két csoportba sorohatóak. Bizonyos parancsok használhatóak egy kötegen belül másokat pl.: create table külön kötegbe kell rendezni. 
A kötegek határát a GO szóval tudjuk jelölni a szervernek. A GO nem SQL utasítás csak egy szintaktikai jelölõ.

Adattípusok

A változók deklarálása kapcsán már felmerült az adattípusok kérdése.
Mint sok más programnyelvben a T-SQL-ben is meg kell adni, hogy mikor milyen adattípusról van szó. 
Nem csak a változók, de a táblák mezõinek megadásakor is. Az adattípus határozza meg, hogy a program hogy értelmezze az adott karaktereket.
Például ha az “5” mint karakter egy változóban valamilyen számként van definiálva akkor matematikai mûveletekkel hozzáadható egy másik számhoz és az összegüket kapjuk vissza. 
Ha viszont szövegként van ugyanez a változó deklarálva akkor egy másik szöveghez fûzhetjük hozzá mint bármilyen más szöveget. 
Az értelmezésen túl az adattípus meghatározza azt is, hogy az adatbázis mekkora tárterületet foglal le egy-egy adat tárolásához illetve, hogy milyen értékeket vehet fel az adot karakter.
A következõ táblázat egy rövid áttekintést nyújt az adat típusokról. Fontos, hogy sok további információ kapcsolódik a használatukhoz arról a táblázat alatti linken érdemes tájékozódni.

MSSQL Adattípusok

Kifejezések
A kifejezések mezõket, változókat, függvényeket és operátorokat tartalmazhatnak. 
A végrehajtási sorrendet zárojelekkel befolyásolhatjuk ha az alapértelmezett számunkra nem megfelelõ. 
A kifejezések mindenhol használhatóak, ahol a szintaktika megengedi.

Kommentelés
A kommentelés segít nekünk és a kollégáinknak, hogy az általunk írtakat értelmezni tudjuk.
Ezek a megjegyzések nem kerülnek értelmezésre futáskor épp ezért akár arra is használhatjuk, hogy a kódunk egy részét ne futtassuk le ha éppen nem szeretnénk.
A kommenteket kétféleképpen jelölhetjük.

-- a sor végéig kommenté válik amit mögé írunk. (inline komment)  

https://github.com/PM-Uzemeltetok/sv3SQL

A kommenteket az MSSM zöld színnel jelzi.

Lekérdezések

A lekérdezések segítségével tudunk egy adatbázisból adatokat kinyerni és azokat utána új struktúrában tudjuk õket felhasználni.
A lekérdezés nem más mint egy rövid program, ami utasítja az adatbázis szervert, hogy milyen adatokat milyen formában gyûjtsön össze.
Automatikusan sem a lekérdezés kódja sem a lekérdezés eredménye nem kerül mentésre, de lehetõségünk van mindkettõt elmenteni vagy továbbirányítani például változóba.

A SELECT utasítás végrehajtási sorrendje és szintaktikája sajnos nem egyezik meg viszont mindkettõt tudnunk kell.

A végrehajtási sorrend határozza meg, hogy a szerver az utasításainkat milyen sorrendben hajtja végre. Ez nagyban befolyásolja a végeredményt is.Az alábbi végrehajtási sorrend nem minden eleme kötelezõ csak a SELECT és a FROM. A végrehajtási sorrend:
* FROM (melyik adatbázis melyik táblázatából, táblázataiból szeretnénk az adatokat)
* (JOIN) (amennyiben több táblából szeretnénk dolgozni) * WHERE (itt határozhatjuk meg a feltételeket ami alapján leszûrjük az eredményt)
* GROUP BY (itt a feltételeinknek megfelelõ rekordokat csoportosíthatjuk)
* HAVING (ugyanúgy mint a WHERE parancsnál feltételeket adhatunk meg ami alapján szûrjük az eredményt, de ezúttal már nem az egyes rekordokra szûrünk, hanem a GROUP BY által képzett csoportok közül választhatjuk ki a nekünk szükségeseket)
* SELECT (itt választhatjuk azokat a mezõket, amiket szeretnénk megjeleníteni, fontos itt a mezõket (oszlopokat) adjuk meg amiket látni szeretnénk
* DISTINCT (ezzel a paraméterrel tudjuk csak az egyedi értékekeket értékkombinációkat megjeleníteni)
* ORDER BY (a legkérdezésünk eddigi eredményét valamilyen sorrendbe rendezhetjük akár több szempont alapján is)
* TOP (itt meghatározhatjuk hogy a lekérdezett és sorba rendezett rekordok közül hányat szeretnénk látni)

A szintaktikai sorrend pedig az alábbi:
* SELECT DISTINCT TOP * FROM
* (JOIN) * WHERE
* GROUP BY
* HAVING
* ORDER BY
* LIMIT

Nézzük a parancsokat és pár lehetõségüket

Egytáblás SELECT:
Mezõk kiválasztása és módosítása

A SELECT után egyértelmûen meg kell határoznunk a megjeleníteni kívánt mezõket. 
Ha csak egyetlen táblát használunk a lekérdezésünkben (FROM után csak egy tábla van) akkor a mezõnév megadásakor az õt tartalmazó táblázat neve elhagyható. 
Mivel azonban az egytáblás lekérdezések viszonylag ritkák így már a kezdeteknél érdemes rászokni, hogy a mezõnév elõtt megadjuk a tábla nevét is a táblanév.mezõnév formában. 
Hiszen a mezõneveknek csak táblán belül kell egyedinek lennie. Másik tábla már tartalmazhat azonos mezõnevet. 
Fontos megjegyezni, hogy a T-SQL case sensitive lehet a táblaneveket illetõen ez a szerver beállításaitól függ.
Fontos, hogy az egyes lekérdezések végére írjunk pontosvesszõt (;) ellenkezõ esetben a SSMS hibát fog jelezni ha mögé írjuk a következõ lekérdezést vagy más utasítást.
A kényelmünk érdekében lehetõség van arra, hogy egy-egy lekérdezésen belül aliasokkal hivatkozzunk adattáblákra, hogy ne kelljen mindig kiírni a teljes nevüket ezt a FROM után kell megadni. 
Fontos hogy ezeket az aliasokat akkor ismeri föl a szerver ha a FROM-ba már beleírtuk. 
Ezért gyakori hogy elõször a select utána csak egy csillagot írunk utána megírjuk a FROM részt majd visszatérünk a SELECT-hez amikor már felismeri a program az aliasaink és ki tudja egészíteni.
*/

SELECT P.ProductID
FROM Production.Product P 

/*
Használhatunk képleteket és kifejezéseket amiknek utána aliast adhatunk. 
Fontos, hogy mivel a WHERE hamarabb hajtódik végre, ezért a SELECT-ben definiált aliasok nem hivatkozhatóak a WHERE részben.
Az itt megadott alias lesz a lekérdezésünk eredményében az oszlop neve ha nem adunk meg akkor No column name fog megjelenni.
*/
SELECT P.StandardCost, P.ListPrice, P.StandardCost + P.ListPrice as összeg
FROM Production.product as P

/*
Használhatunk képleteket és kifejezéseket amiknek utána aliast adhatunk. 
Fontos, hogy mivel a WHERE hamarabb hajtódik végre, ezért a SELECT-ben definiált aliasok nem hivatkozhatóak a WHERE részben.
Az itt megadott alias lesz a lekérdezésünk eredményében az oszlop neve ha nem adunk meg akkor No column name fog megjelenni.
Több programnak problémája lehet azzal ha egy mezõnek nincs neve ezért kerülendõ
*/
 SELECT P.name+ P.Productnumber as hosszunév
        FROM Production.Product P 

/*
A fenti példában a névhez hozzáfûzzük a productnumber-t folytatólagosan.
Ha szeretnénk valamilyen fix karakterláncot hozzáfûzni egy mezõ értékéhez akkor azt aposztrófok (‘) közé kell tenni.
Így már lesz egy space a productnumber és a ProductNumber között.
*/
SELECT P.name + ' ' + P.Productnumber as hosszunév
        FROM Production.Product P 

/*
**********************WHERE***********************************
Természetesen amikor lekérdezést csinálunk akkor nem mindig akarjuk látni az összes rekordot, hanem valamilyen szempont szerint szeretnénk szûrni ezeket. 
Erre szolgál a WHERE kulcsszó. A legegyszerûbb eset, amikor egyetlen szempont szerint szeretnénk szûrni. Mint az alábbi példa mutatja.
*/
SELECT P.ProductID, P.Name, P.Color
FROM Production.product P
WHERE P.Color ='Red'


/*
Ebben az esetben a lekérdezésünk a piros színû termékeket fogja kiszûrni. 
Fontos, hogy szûréskor a feltétel értékét (jelen esetben a Red szót) aposztrofok (') közé kell tenni. 
Természetesen nem mindig csak egy értékre akarunk szûrni. Ha ugyanannak a mezõnek több lehetséges értékére is kíváncsiak vagyunk akkor azt kétféleképpen is leírhatjuk. 
A különbözõ feltételeket az **OR** szó használatával összefûzhetjük vagy akár az **IN** szó használatával fel is sorohatjuk. 
Tehát a WHERE feltétel után a következõ két kifejezés egyenértékû
*/
SELECT P.ProductID, P.Name, P.Color
FROM Production.product P
WHERE P.Color ='Red' OR P.Color='Blue'
/*vagy így:
WHERE P.Color IN ('Red', 'Blue')
*/

/*
Az IN szó használatakor a lehetséges értékekeket zárójelek között vesszõvel elválasztva kell felsorolni. 
Ha számokról vagy dátumokról van szó, akkor használhatjuk a BETWEEN szót. 
Így nem kell minden lehetséges értéket felsorolni, hanem elég az intervallumot megadni. 
Lásd az alábbi példa.
*/
SELECT SOH.SalesOrderID, SOH.DueDate
FROM Sales.salesorderheader SOH
WHERE SOH.DueDate BETWEEN '20120301' AND '20120331'

/*
A fenti lekérdezéssel a márciusi rendeléseket kapjuk meg. 
A BETWEEN után az értékeket aposztrofok között az AND szóval kell megadni.
Természetesen ilyen esetekben használhatjuk a relációs jeleket is.
*/
SELECT SOH.SalesOrderID, SOH.DueDate
FROM Sales.salesorderheader SOH
WHERE SOH.DueDate >= '20120301' AND SOH.DueDate < '20120404'

/*
Az AND logikai és. Tehát mindkét feltételnek teljesülnie kell. 
Fontos, hogy a nagyobb és a nagyobb egyenlõ közti különbségekre ilyen esetben odafigyeljünk.
Ha csak az egyes értékek egy részére szeretnénk szûrni például minden olyan termékre ami a Socks szóval kezdõdik akkor a LIKE-ot kell használnunk. 
SQL-ben a % jel a joker karakter. Az alábbi példa minden olyan terméket kigyûjt, ahol a Name mezõben Chain-el kezdõdõ érték van.
*/
SELECT P.ProductID, P.Name      
FROM Production.product P
WHERE P.Name LIKE 'Chain%'

/*Fontos hogy sok programnyelvel ellentétben SQL-ben a joker karaktert is aposztrofok közé kell tenni.
Sok esetben elõfordul, hogy hogy nem azt az értéket szeretnénk megjeleníteni, ami az adattáblánkban van hanem a tábla tartalmától függõen valamilyen más értéket. 
Erre használhatjuk a CASE függvényt. A CASE függvényben a CASE szó után írjuk a mezõ nevét amire a feltételeink vonatkoznak. 
A WHEN szóval kezdjük az adott ágat, utána írjuk a feltételt majd a THEN szó után hogy mire cserélje. A CASE függvénynek lehet ELSE ága, ami minden fel nem sorolt esetet jelent. A CASE függvényt END-el zárjuk le. Az alábbi példában a neveket szeretném magyarul megjeleníteni.
*/
SELECT P.ProductID, P.Name,
    CASE P.Color WHEN 'Blue' THEN 'Kék'
                 WHEN 'Red' THEN 'Piros'
                 WHEN 'Silver' THEN 'Ezüst'
                 WHEN 'Black' THEN 'Fekete'
                 ELSE 'N/A'
                 END as Szín
FROM Production.product P
/*
Lehetõségünk van arra is, hogy egy mezõ értékét valamilyen feltételhez kötve adjuk meg. 
Ehhez az IIF parancsot kell használni aminek a szintaktikája IIF (feltétel, érték ha igaz, érték ha hamis). 
Használatára lásd az alábbi példát.
*/
SELECT E.LoginID, IIF(E.Gender='M', 'Male', 'Female') Gendername
FROM Humanresources.employee E

/* **************ORDER BY**************************
A rendezés a következõ olyan funkció, amit gyakran használunk.
Alapértelmezésként az SQL növekvõ sorrendbe rendez a megadott mezõ szerint. 
Ha csökkenõ sorrendet szeretnénk akkor a DESC kitétel használata szükséges.
Ha akarunk akkor rendezhetünk több szempont szerint ilyenkor a beírt mezõk sorrendjében fog rendezni a program.
A mezõkre hivatkozhatunk a nevükkel vagy a sorszámukkal is (hányadik mezõ a SELECT-ben) Mint a alábbi példában látható.
*/
SELECT P.ProductID, P.Name, P.Color
FROM Production.product P
ORDER BY P.name, P.Color DESC

/* **************************Részhalmazok lekérdezése***************************
Vannak olyan esetek, amikor nincs szükségünk egy lekérdezés összes adatára, hanem csak valamilyen szempont szerint az elsõ 10.
Erre használhatjuk a TOP utasítást. Így lekorlátozni a darabszámot többnyire akkor szoktunk miután valamilyen szempont szerint már sorbarendeztük az adatainkat.
Klasszikus példa amikor a legocsóbb termékekre vagyunk kíváncsiak. 
Ezt fogjuk megnézni a következõ ki példában.
*/
SELECT TOP 10 P.name, P.ListPrice 
FROM Production.Product P
WHERE P.ListPrice >0
Order BY P.ListPrice

/*Másik gyakori eset amikor részhalmazra van szükség például egy webáruház oldala, amikor nem akarjuk egyszerre megjeleníteni az összes adatot, hanem egyszerre csak kevesebbet. 
Jellemzõen 10-20 terméket mondjuk majd utána újabb 10-20 terméket. Ezt az OFFSET és FETCH parancs kombinációval tehetjük meg.
Ahol az OFFSET után kell megadni, hogy hány rekordot nem szeretnénk látni (az utána következõtõl látjuk majd) és a FETCH után hogy hány sort jelenítsen meg.
A következõ kis példa 25 sort fog megmutatni a 51. rekordtól.
*/
SELECT P.ProductID, P.name, P.ListPrice
FROM Production.Product P
ORDER BY P.ProductID
OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY























