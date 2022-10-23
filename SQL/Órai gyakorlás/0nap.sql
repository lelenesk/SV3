select @@VERSION --pl python csatlakoz�shoz

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
	values (56,'mosogat�s', 'sok habbal')
insert into Hazimunka (hazimunkaID, Nev, leiras)
	values (55,'mosogat�s', 'sok habbbbal')
insert into Hazimunka (hazimunkaID, Nev, leiras)
	values (1,'mosogat�s1,mosogat�s2,mosogat�s3,
			mosogat�s4,mosogat�s5,mosogat�s6,mosogat�s7,
			mosogat�s8,mosogat�s9,mosogat�s10,',12, 'sok v�zzel')

ALTER AUTHORIZATION ON DATABASE::[AdventureWorks2019] TO [sa]

create table Hazimunka2 (
	hazimunkaID int primary key,
	Nev NVARCHAR(50) not null,
	Pontertek int check (Pontertek > 10 and Pontertek <100),
	leiras NVARCHAR(200) unique
)





