select @@VERSION --pl python csatlakozáshoz

create database GTCsalad
use GTCsalad

create table Csaladtag (
	csaladtagID int primary key identity(1,1),
	Nev NVARCHAR(30),
	SzD DATE,
	Hazimunkadij decimal(8,2)
)

insert into Csaladtag (Nev,SzD, Hazimunkadij)
	values ('Anya', '2002-09-28',4600.45)

create table Hazimunka (
	hazimunkaID int primary key,
	Nev NVARCHAR(50) not null,
	Pontertek int default 1,
	leiras NVARCHAR(200) unique
)

select * from [dbo].[Hazimunka]

insert into Hazimunka (hazimunkaID, Nev, leiras)
	values (56,'mosogatás', 'sok habbal')
insert into Hazimunka (hazimunkaID, Nev, leiras)
	values (55,'mosogatás', 'sok habbbbal')
insert into Hazimunka (hazimunkaID, Nev, leiras)
	values (1,'mosogatás1,mosogatás2,mosogatás3,
			mosogatás4,mosogatás5,mosogatás6,mosogatás7,
			mosogatás8,mosogatás9,mosogatás10,',12, 'sok vízzel')

ALTER AUTHORIZATION ON DATABASE::[AdventureWorks2019] TO [sa]

create table Hazimunka2 (
	hazimunkaID int primary key,
	Nev NVARCHAR(50) not null,
	Pontertek int check (Pontertek > 10 and Pontertek <100),
	leiras NVARCHAR(200) unique
)





