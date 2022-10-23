
/*Listázd ki azt a 10 váráslót (customerID) a Sales.SalesorderHeader táblából, akik 2013 harmadik negyedévében a legnagyobb összértékben (totaldue) rendeltek 
és rendeléseik összértéke ebben az időszakban meghaladta a 160000-et. Ne ved figyelembe azokat a rendeléseket, amiknek az értéke 100-nál kisebb volt.*/


SELECT TOP 10 S.CustomerID AS 'Megrendelő "neve"', SUM(CAST(S.TotalDue AS decimal)) AS 'Rendelések összértéke',
CONVERT(VARCHAR,COUNT(S.OrderDate))+' db' AS 'Negyedéves rendelések száma' --a cast és a convert csak opcionális,zavart a 4db tizedesjegy 
FROM Sales.SalesOrderHeader S
WHERE DATEPART(q,S.OrderDate) = 3 AND DATEPART(yyyy,S.OrderDate) = '2013'
--WHERE S.OrderDate BETWEEN '20130701' AND '20130930' ->alternatív megoldás
GROUP BY S.CustomerID
HAVING sum(S.TotalDue) > 100 AND sum(S.TotalDue) > 160000 -->ha csökkentem az értéket több találtom is lesz
ORDER BY sum(S.TotalDue) DESC
--OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY ->alternativ megoldás, de a 'TOP 10'-et ki kell hozzá szedni a selectből

SELECT S.CustomerID, S.TotalDue
FROM Sales.SalesOrderHeader S
WHERE DATEPART(q,S.OrderDate) = 3 AND DATEPART(yyyy,S.OrderDate) = '2013' and S.CustomerID =11019
order by S.CustomerID