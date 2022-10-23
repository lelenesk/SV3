#Portszámok: 445, 139

#Samba szerver
#A samba egy fájl szerver ami, ami lehetővé teszi fájlok megosztását különböző operációs rendszereken pl.: linux windows vagy macOS valamint nyomtatók megosztását is. Továbbá akár domain controler is lehet. A Samba az smb (server message block) protokol segítségével kommunikál.

#Samba telepítése
sudo apt install samba
sudo apt install samba-client #teszteléshez opcionális

#Az smbd szolgáltatás ellenőrzése:
systemctl status smbd

#Megosztás létrehozása

1.#Csinálj egy megosztási mappát például sambashare néven. Nyisd meg a Samba konfig fájlját admin joggal.
sudo nano /etc/samba/smb.conf

2.#A fájl végére írd be a következőket
"""
[sambashare] 
    comment = Samba on Ubuntu (ez lesz a megosztás neve)
    path = /home/username/sambashare (a megosztás elérési útja amelyik mappára hivatkozik)
    valid users =watis81 (ide írható be, hogy ki léphet be @csoportnévvel csoportnak is adhatunk hozzáférést)
    read only = no (engedélyezi a módosításokat)
    create mask =0660 (az itt létrehozott fájlok jogosultságai)
    force create mode = 0660 (az itt force módban létrehozott fájlok jogosultságai)
    directory mask =0770 (az itt létrehozott mappák jogosultságai)
    force directory mode=0770 (az itt force módban létrehozott mappák jogosultságai)

    browsable = yes (látható a fájlkezelők számára)
"""

3.#Indítsd újra az smbd szolgáltatást, hogy a módosítások életbe lépjenek.
sudo service smbd restart

4.#Engedélyezd a samba-t a tűzfalon.
sudo ufw allow samba

5.#Majd a 'testparm' parancsal ellenőrizd a smb.conf fájl szintakszisát.

#A hozzáférés beállítása
#A samba nem a linux jelszavunk használja ezért külön létre kell hozni egy samba account-ot és be kell hozzá állatani a jelszót. Ezt a következő paranccsal tehetjük meg.
sudo smbpasswd -a username (létrehozza a samba felhasználót és kéri a jelszavát) 
sudo smbdpasswd -n username jelszó törlése
sudo smbdpasswd username ha már létezik, jelszó modositása, sudo nélkül help csak 

#Kapcsolódás a megosztáshoz windows alól
A fájlkezelő címsorába írd be a következőt. '\\szerver ip-címe\sambashare'