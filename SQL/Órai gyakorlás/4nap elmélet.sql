/*
Adattípusok és kapcsolódó függvények

Mint minden programnyelvben az SQL-ben is minden értékhez hozzátartozik valamilyen adattípus ilyen szempontból mindegy, hogy változótról vagy egy adattábla mezõjérõl van szó. 
Az adattípus sok esetben meghatározza, hogy milyen mûveletek és hogyan hajthatóak végre az adott értékkel.
Például ha van két változónk amiknek az értéke '1' és azok valamilyen számtípusként vannak definiálva akkor változó1 + változó2 =2,
viszont ha szövegtípusként vannak deklarálva akkor változó1 + változó2=11 mivel szöveg esetén T-SQL-ben a + jel összefûzést jelent.

Amikor adatokkal dolgozunk gyakran szükséges, hogy ezeket az adattípusokat konvertáljuk. 
Az SQL ebben segítségünkre van és sok esetben ezt automatikusan megteszi. Azonban vannak helyzetek, amikor errõl nekünk kell gondoskodni. 
Természetesen nem mindent lehet mindenné átkonvertálni. Ezt a következõ táblázat foglalja össze, illetve az alatta lévõ linken találhattok további információkat.

T-SQL adattípus konverzió
A konvertálásra több függvényünk is van. A CAST() és a CONVERT() függvények közel teljesen egyenértékûek alapszinten,
a CONVERT a nyelvfüggû beállításoknál rendelkezik extra funkcióval cserébe a CAST több SQL nyelvben használatos míg a CONVERT nem. 
A szintaktikájuk eltérõ, ami a következõképpen néz ki. CAST(konvertálandó AS adattípus) a CAST esetében fontos, hogy itt az AS szó nem hagyható el mindig ki kell írni.
A CONVERT(adattípus, konvertálandó) szintaktikája a fordítottja a CAST-énak. A kovertáladó lehet változó mezõ stb. 
Az adattípus mindkét esetben az az adattípus amire konvertálni szeretnénk. Fontos még megjegyezni, hogy vannak korlátai annak milyen adattípusokra lehet konvertálni.
A következõ kis példában a termékek méretét próbáljuk meg számmá konvertálni.
*/

SELECT P.Name, P.Size, CAST(P.size AS decimal) sizeint
FROM Production.product P

/*Azt fogjuk tapasztalni, hogy a függvényünk csinál néhány furcsaságot annak függvényében, hogy az adott rekordban milyen érték van a size mezõben. - Ha szám volt benne akkor gond nélkül átkonvertálja - Ha NULL volt az értéke akkor konverzió után is NULL lesz. - Ha szöveg volt akkor viszont a konverzió hibára fut. - Az utóbbi esetekre kínál megoldást a TRY_CAST() és a TRY_CONVERT(). A szintaktikájuk ugyanaz mint az alapváltozatoknak, de ha nem konvertálható értékkel találkoznak, akkor nem szállnak el hibával, hanem NULL értékkel térnek vissza. A TRY verziók ugyan megoldják, hogy ne fusson hibára a kódunk, de bánjunk vele körültekintõen. A konvertált adatokkal további mûveleteket fogunk végezni és a NULL nem egyenlõ egy konkrét értékkel.
A konverzióra van még egy különleges parancsunk a PARSE() és annak a TRY_PARSE() verziója. Szintén konverziós függvények viszont a CAST-al ellentétben meg lehet adni a kultúrát/nyelvet és lekezeli az ebbõl fakadó eltéréseket. Az olyen esetekben mint a pénznem típusra konvertálás a CAST függvény helytelen eredményt adhat mert nem veszi figyelembe a nyelvi sajátosságokat. Ilyenkor kell nekünk a PARSE, amit csak string szám vagy date/time típusokká konvertálására lehet használni.
Az alábbi kis példa mutatja meg a PARSE használatát egy változón.
*/
   
DECLARE @összeg varchar(30) = '1350,20'
SELECT @összeg, Parse(@összeg as money using 'hu-hu')

/*
Szöveg függvények

Összegyûjtöttünk néhány olyan függvényt ami a szöveg típusú adatokhoz használható. 
Ezek megfelelõi sok más programnyelvben megjelennek. 
A legfontosabb közülük talán a szöveg összefûzésére szolgáló CONCAT() függvény, ami nem csinál mást, mint a megadott szövegeket vagy kifejezések értékét összefûzi egymás után. 
Fontos kitétel, hogyha bármely összefûzni kívánt kifejezés értéke NULL akkor a CONCAT eredménye is NULL lesz. 
Természetesen erre is van megoldás, amit majd a NULL kezelés témakörében fogunk megnézni.
Az alábbi kis példa a termék nevét és színét fûzi össze egyetlen karakterlánccá.
*/

SELECT P.Name, P.Color, CONCAT (P.name, P.Color)  as 'termék és szín'
FROM Production.product P

/*
A következõ 3 fügvényt olyankor használjuk, amikor egy szöveg egy részére van szükségünk. 
Ezek a LEFT() a RIGHT() és a SUBSTRING(). Az elõbbi kettõ elég egyértelmû a SUBSTRING segítségével pedig egy karakterlánc közepérõl szedhetünk ki karaktereket. 
A szintaktikájuk a következõ: LEFT()(szöveg, karakterek száma) Balról kezdve ad vissza megadott számú karaktert. 
RIGHT() (szöveg, karakterek száma) A szöveg végérõl indulva add vissza megadott számú karaktert. 
SUBSTRING() (szöveg, honnantól,mennyit) A megadott számú karaktertõl kezdve ad vissza megadott számú karaktert.
Az alábbi kis példa nem fog értelmes adatot visszaadni, de arra jó, hogy lássuk a szintaktikát élõben.
*/

SELECT P.name, LEFT(P.name,5) eleje, RIGHT(P.name, 4) vége, SUBSTRING(P.name,3,3) közepe
FROM Production.product P
/*
A következõ csoportba néhány olyan függvényt soroltunk, amik a karakterlánc hosszát valamint a közök ' ' eltávolítását teszik lehetõvé.
DATALENGTH (szöveg) Egy karakterlánc karaktereinek számát adja vissza közökkel együtt. LEN (szöveg) Ugyanaz mint a DATALENGTH, de a karakterlánc végén lévõ közöket nem számolja bele. 
LTRIM (szöveg) Levágja a karakterlánc elejérõl a fölösleges közöket. RTRIM(szöveg) Levágja a fölösleges közöket egy karakterlánc végérõl. TRIM (szöveg) 2017 óta használható. 
A karakterlánc mindkét végérõl levágja a fölösleges közöket.
Végül pedig a CHARINDEX(), amit bár gyakran használunk a közök kezeléséhez egy karakterláncban de ennél többet tud. 
A CHARINDEX segítségével egy szövegrészre kereshetünk rá egy karakterláncban és visszaadja, hogy hányadik karakternél találta meg.
A számolást 1-tõl kezdi. Ha nem találja meg a keresett szövegrészt, akkor 0 értékkel tér vissza. 
Nézzünk is egy gyakorlati példát a karakterfüggvények használatára. 
Gyakran elõfordul, hogy a vezetéknevet és keresztnevet egy cellába mentik el és sokszor külön külön is szükség lenne rájuk.
Ilyenkor jön jól az alábbi programocska, amivel most a termékek nevét fogjuk szétbontani.
*/

SELECT P.name, 
        CHARINDEX(' ', P.Name) as köz, --elsõ köz helye, ha több is van akkor az elsõ helyét adja vissza
        LEFT(P.name, CHARINDEX(' ', P.Name)) as eleje, --visszaadja a karakterlánc elejét a közig
        RIGHT(P.name, LEN(P.name)-CHARINDEX(' ', P.Name)) as vége -- visszaadja a karakterlánc végét a köztõl
        FROM Production.Product P
/*
Mint látható a függvények paramétereinek helyére írhatunk kifejezéseket.
Az utolsó szövegfüggvény amivel most foglalkozunk az a REPLACE(). Segítségével egy karaktert vagy karakter láncot cserélhetünk ki egy másikra egy szövegben.
Erre meglepõen gyakran van szükség. Például a magyar ékezetes betûket német nyelvterületen szeretik karakterkombinációval helyettesíteni például é helyet ai-t írnak. 
Vagy például szövegként mentenek el számokat és a tizedesvesszõt mint karaktert eltárolják. Ilyen esetekben jön jól a REPLACE.
A következõ példában a közök helyére alávonást '_' írunk.
*/

SELECT P.name, REPLACE(P.name,' ','_')
    FROM Production.Product p
/*
Dátum függvények

A másik fügvénycsoport amivel foglalkozunk most azok a dátum formátumhoz kapcsolódó függvények. 
A legegyszerûbb közülük amikor csak a dátum egy részére van szükségünk évre, hónapra, adott napra külön külön. 
Erre való a YEAR(), MONTH() és DAY() függvények amik mögé csak zárójelbe meg kell adnunk az adatot. Egy egyszerû kis példa erre.
*/

SELECT P.name, P.SellStartDate, YEAR(P.SellStartDate) év, MONTH(P.SellStartDate) hónap, DAY(P.SellStartDate) nap
    FROM Production.Product P
/*
Ezek a függvények számként adják vissza a kért adatot.
A DATEPART() függvény további adatokat tud adni nekünk egy adott dátumról, annak függvényében, hogy milyen paraméterrel használjuk. 
Néhány paraméter: 
- YYYY az évszámot adja vissza mint a YEAR függvény 
- Y hányadik napja az adott évnek 
- q visszaadja a negyedévet ahova a dátum esik 
- ww hányadik hétre esik a dátum 
- w visszaadja, hogy az adott hét hányadik napjára esik a dátum.
Nézzünk erre egy rövid kis példát. 
Ami a fent felsorolt paraméterek szerint visszaadja a termékek eladásának kezdetére vonatkozó infókat. 
Ahhoz hogy a DATEPART függvények biztos helyesen mûködjön érdemes beállítani a hét kezdõnapját különben a nyelvi beállítások függvényében elõfordulhat hogy helytelen adatot kapunk,
amikor lekérdezzük hányadik napjára esik a hétnek az adott dátum ehhez a SET DATEFIRST 1 parancsot kell kiadnunk.
*/

SET DATEFIRST 1 
SELECT P.name, 
        P.SellStartDate,
        DATEPART(yyyy,P.SellStartDate) év,
        DATEPART(y,P.SellStartDate) 'nap az évben',
        DATEPART(q,P.SellStartDate) negyedév,
        DATEPART(ww,P.SellStartDate) 'hányadik hét',
        DATEPART(w,P.SellStartDate) 'nap a héten'
        FROM Production.Product P

/*
Lehetõségünk van arra is, hogy az adott hónap nevét és az adott nap nevét tudjuk meg. Erre használható a DATENAME() függvény.
A w paraméterrel a napot m paraméterrel a hónap nevét kapjuk meg,
A SET LANGUAGE parancsal pedig a nyelvet módosíthatjuk annak megfelelõen hogy milyen nyelven szeretnénk visszakapni az eredményet. Itt egy kis példa a használatára.
*/

SET LANGUAGE MAGYAR
SELECT P.name, P.SellStartDate,DATENAME(w, P.SellStartDate), DATENAME(m, P.SellStartDate)
    FROM Production.Product P

/*
Az aktuális dátumot és idõt is lekérhetjük SQL segítségével. Több függvény is képes erre és a részletekre oda kell figyelni a használatukkor.
A GETDATE és a SYSDATETIME függvények az aktuális idõpontot kérik le az utóbbi pontosabb. 
Arra viszont oda kell figyelni a használatukkor, hogy az SQL szerver szerinti idõzónát használják. 
Ezt küszöböli ki a GETUTCDATE() függvény, ami mindig a greenwichi idõt adja vissza.

NULL kezelés

Az SQL nyelvben a NULL nem egyenlõ a matematikai nullával vagy semmivel. A NULL azt jelenti, hogy az adott értéket nem ismerjük.
Éppen ezért sokszor kell kezelnünk ezt az esetet, mert a NULL-al való összehasonlítás eredménye mindig FALSE illetve a NULL-al végzet bármilyen mûvelet például az összeadás értéke mindig NULL lesz. 
Ezt az esetet tudja kezelni például a COALESCE() függvény, aminek a szintaktikája COALESCE (mezõnév, helyettesítõ érték). A COALESCE használatakor ha az adott mezõben egy rekord értéke NULL akkor a helyettesítõ értéket használja az SQL. 
Az alábbi példában lekérjük a termékeink nevét és ahol nincs megadva szín oda beírjuk hogy színtelen.
*/

SELECT P.Name, P.Color, COALESCE(P.Color,'szintelen') as 'szín'
FROM Production.product P
/*
Fontos még tudni, hogy COALESCE függvénynél akár a mezõnév helyére akár a helyettesítõ érték helyére írhatunk kifejezéseket is. 
Az elõbbi példát kicsit továbbvive. A következõ rövid kis lekérdezésben összefûzzük egy mezõbe a termék nevét és színét és kezeljük azokat az eseteket ha akár a név akár a szín mezõben NULL van.
*/

SELECT P.Name, P.Color, CONCAT (COALESCE(P.name, 'név?'), COALESCE(P.Color, 'szín?'))  as 'termék és szín'
FROM Production.product P
/*
Számok és dátumok esetén az IFNULL() függvényt is használhatjuk és akár csak a COALESCE-nél meg kell adnunk egy helyettesítõ értéket. 
Az alábbi kis példában ha nincs megadva a termék súlya akkor automatikusan beírja hogy 2 legyen.
*/

SELECT P.Name, P.Weight, ifnull(P.weight, '2')
FROM Production.product P
/*
Vannak olyan esetek, amikor arra vagyunk kíváncsiak, hogy egy adott mezõ értéke NULL vagy nem NULL erre szolgál az IS NULL kifejezés.
Az alábbi kis példában kigyûjtjük azokat a termékeket, amiknek nincs megadva a színe.
*/

SELECT P.Name, P.color
FROM Production.product P
WHERE P.Color IS NULL
/*
Ennek az ellentéte amikor arra vagyunk kíváncsiak, hogy mely termékeknek van megadva a színe. Erre használhatjuk az IS NOT NULL kifejezést.
*/

SELECT P.Name, P.color
FROM Production.product P
WHERE P.Color IS NOT NULL