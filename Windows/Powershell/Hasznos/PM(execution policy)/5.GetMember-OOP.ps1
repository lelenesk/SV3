<#
Powershell Objektumok struktúrájának lekérdezése
Get-Member cmdlet

Get-Member
Get-Member -MemberType Properties
Get-Member -MemberType AliasProperty
Get-Member -PropertySet
Get-Member -MemberType Method
Get-Member -MemberType ScriptMethod
Get-Member -MemberType Event

A PS-ben a parancsok kimenete általában nem egyszerű szöveg vagy szám, hanem valamilyen típusba tartozó OBJEKTUM.
Az objektumok egységbe foglalják az adatokat és a hozzájuk tartozó műveleteket.
Az adatokat mezők, attribútumok, tulajdonságok néven, a műveleteket metódusokként szokták emlegetni.
Az objektum által tartalmazott adatokon általában az objektum metódusai végeznek műveletet.
#>

#1. Listázzuk ki egy már ismert lekérdező cmdlet vissza adott értékének struktúráját
Get-LocalUser | Get-Member                          #Az objektum összes lehetősége
Get-LocalUser | Get-Member -MemberType Property     #Az objektum tulajdonságai (Property)
Get-LocalUser | Get-Member -MemberType Method       #Az objektum metódusai (műveletei)
#
$sajatnev = 'hidve'                                 # A saját felhasználó neved, (szöveg típusu azaz string)
$sajatnev | Get-Member                              # System.String lehetséges műveletei (metódusai) - bármilyen System.String elemnek ugyanezek a tulajdonságai, metódusai

$szam1 = 5                                          # System.Int32 azaz egész szám típusú változó
$szam1 | Get-Member                                 # System.Int32 lehetséges műveletei (metódusai) - bármilyen System.Int32 elemnek ugyanezek a tulajdonságai, metódusai

$szam2 = 43.55                                      # System.Double azaz max. 17 jegyű bármilyen szám
$szam2 | Get-Member                                 # System.Double lehetséges műveletei (metódusai) - bármilyen System.Int32 elemnek ugyanezek a tulajdonságai, metódusai

$felhasznalok = Get-LocalUser                       # Az összes lokális felhasználó objektumait eltároljuk a $felhasznalok változóban (egész pontosan egy listában, mert a lekérdezés eredménye nem 1 adat)
$felhasznalo = Get-LocalUser -Name $sajatnev        # $felhasznalo valtozó pedig megkapja a saját felhasználóm adatait.    

#2. Hasonlítsuk össze a két lekérdezést
Get-LocalUser | Get-Member 
$felhasznalo | Get-Member
$felhasznalok | Get-Member                          

#Vegyük észre, hogy az összes lekérdezett objektum ugyanannak az objektum osztálynak 1-1 példanya: (az első sorban található)
# TypeName: Microsoft.PowerShell.Commands.LocalUser
#azaz mi most egy LocalUser típusú objektumot próbálgatunk.

$felhasznalo | Select-Object *                 #A lekérdezett felhasználó objektumának minden adata

#Mi van akkor ha mi konkrét információra vagyunk kiváncsiak az objektumból.
# Tulajdonságok (Property, Properties)
$felhasznalo.Name
$felhasznalo.PasswordRequired
$felhasznalok.Name


(Get-LocalUser -Name 'hidve').name                  # Egy szöveget (stringet) ad vissza
((Get-LocalUser -Name 'hidve').name) | Get-Member   # Egy string lehetséges műveletei
((Get-LocalUser -Name 'hidve').name).length         # A () levő string hossza 
('Szép hosszú szöveg').Length                       # A () levő string hossza 


<# Az objektumok nem csak tulajdonságokat és Metódusokat tartalmazhatnak. 
Ennek bemutatása miatt egy eddig nem használt cmdlet-et fogok használni, ami már ismerős adatokat tartalmaz.

Futó folyamatok kezelése (Feldatkezelő/Folyamatok alatt találjuk grafikusan)
Get-Process cmdlet#>

Get-Process                 #Összes futó folyamat
Get-Process -Name win*      #win szóval kezdödő folyamatok
Get-Process -Name chrome*
Get-Process -Name discord*

#Nézzük mit tartalmaz a Get-Process objektum és vegyük észre hogy nem csak Property-t és Method-ot tartalmaz hanem sok minden mást is. (MemberType)
Get-Process | Get-Member

#Az már ismert tartalom:
Get-Process | Get-Member -MemberType Property
Get-Process | Get-Member -MemberType Properties     #A PS engedi az angol egyesszám és többesszám használatát, hogy a kiadott parancsok számunkra könnyebben értelmezhetőek legyenek.
Get-Process | Get-Member -MemberType Method
Get-Process | Get-Member -MemberType Methods

#Egyéb tartalom
Get-Process | Get-Member -MemberType AliasProperty  #Aliasok azaz álnevek? Egy tulajdonságot a "becenevén" is lekérdezhetünk.

Get-Process -Name discord* 
Get-Process -ProcessName discord*

Get-Process | Get-Member -MemberType Event          #Események amelyek valamilyen egyéb parancsot hívnak meg.

Get-Process | Get-Member -MemberType PropertySet    #A visszaadott tulajdonság érték nem 1 hanem több adatot tartalmaz

<# PS C:\Users\hidve\Documents\Progmasters\Scripts\system-admin> Get-Process -ProcessName task*

Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName
-------  ------    -----      -----     ------     --  -- -----------
    316      37     9004      16464       3,55  13236   7 taskhostw
    643      30    32172      49288     219,98   7264   7 Taskmgr
#>