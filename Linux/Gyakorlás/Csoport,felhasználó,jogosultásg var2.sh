#mappa struktúra létrehozása a home könyvtárban
mkdir -p ~/felmero/alfelmero

# 3-3 üres fájl létrehozása
touch ./felmero/{file1.txt,file2.txt,file3.txt}
touch ./felmero/alfelmero/{file4.txt,file5.txt,file6.txt}

#tanari csoport létrehozása
sudo groupadd tanar1

#3 tanár user létrehozása
sudo useradd tanárka1
sudo useradd tanárka2
sudo useradd tanárka3

#3 tanár hozzáadása a tanar1 csoporthoz
sudo usermod -a -G tanar1 tanárka1
sudo usermod -a -G tanar1 tanárka2
sudo usermod -a -G tanar1 tanárka3

#tanar1 csoport ellenőrzése 
getent group | grep tanar1

#alfelmero mappa tulajdonát átadni a tanar1 csoportnak
sudo chown :tanar1 ./felmero/alfelmero/

#felmero mappa és almappáinak jogának megváltoztatása
sudo chmod -R 744 ./felmero/

#ls -l paranncsal ellenőrízzük le hogy megtörtént-e a változás
