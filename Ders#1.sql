/*-Temel Bilgiler-
Database Nedir?
	Veritaban� sistematik olarak verilere eri�ilebilen haf�za �niteleridir. Ba�larda veresiye defteri gibi veritabanlar�
kullan�l�rken dijital d�nya i�in �e�itli firmalar taraf�ndan veritabanlar� geli�tirilmi�tir. Genel olarak bu veritabanlar�
tablolama mant���na dayanarak veri bar�nd�rsa da, json veya txt tipinde de veriler hala tutulmaktad�r. Tablolama mant��� ile
veritaban� bize daha az alan ile daha fazla veri tutmay� ve verilere daha kolay ula�may� sa�lar.
MSSQL
	Microsoft taraf�ndan geli�tirilmi� ve geli�mi� uygulama lisanslar� bulunan veritaban�d�r. Veritaban� desteklenen t�m diller
�zerinden eri�im veya geli�tirme yap�labilmektedir. Veritaban� s�yledi�imiz gibi tablolardan, tablolar ise s�t�nlardan olu�ur.
Bu s�tunlara column/kolon ismi verilir. Bu columnlar�n ise ismi, veri tipi ve nullable yani bo� ge�ilebilirlik bilgisi boolean
bir bi�imde tutlur. 
SQL Sorulama Dili
	Veritaban�ndan veri sorgulamak, veri eklemek, veri silmek, veri g�ncellemek, tablo olu�turmak, column olu�turmak... gibi bir�ok
i�levi yerine getirmemizi sa�lar. A��l�m� Structured Query Language yani Yap�land�r�lm�� Sorgulama Dilidir. Microsoft SQL Server
ANSI standartlar�nda SQL sorgulama dilini kullanmaktad�r. Oracle ise PL/SQL sorgulama dilini kullanmaktad�r.
SQL SERVER
	Microsoft taraf�ndan geli�tirilmi� Veritaban� sunucu yaz�l�m�d�r. SQL Server 1433 numaral� portu dinleyerek uzak veya yerel
a�dan veritaban� ba�lant�lar�na izin verir.
DATABASE ��Z�MLER�
	Veritaban� ��z�mleri OLTP(Online Transaction Processing) ve OLAP(Online Analytical Processing) olmak �zere ikiye ayr�l�r.
	#OLTP
		Kullan�c�lar�n veri ekledikleri, sildikleri veya g�ncelledikleri sistemlerdir. �ok say�da kullan�c�ya i�lem deste�i sunar.
	#OLAP
		Veriler �zerinde analiz yapmak ve veri okumak ama�l� kurulan sistemlerdir.
SERVER TYPE
	#Database Engine
		�li�kisel veri tabanlar� olu�turarak ger�ek zamanl� veri i�lememize olanak sa�lar. Verileri y�neterek g�venli�i sa�lar.
	SQL Profile sayesinde sunucuda ger�ekle�tirilen olaylar izlenebilmektedir.
	#Analysis Services
		Verilerin h�zl�ca analiz edilmesi i�in ��z�mler sunar. OLAP �zelliklerinden faydalan�r.
	#Reporting Services
		SQL Server i�in raporlama hizmeti sunar. Kullan�ma haz�r ara�lar� ile raporlar� kolay ve h�zl� bi�imde olu�turulmas�n�
	sa�lar.
	#Integration Services
		Verilerin ta��nmas�n� sa�layan server tipidir.
SYSTEM DATABASE
	SQL Serverin ilk kurulumunda Master, Model, TempDb ve Msdb olmak �zere 4 adet veritaban�n�n System Databases klas�r� alt�nda
olu�turuldu�unu g�r�r�z. Bu Database'ler
	#Master: Sql Server'in �al��abilmesi i�in(Kullan�c� tan�mlar� ve temel bilgiler) gerekli olan yap�lar� bar�nd�r�r.
	#Model: Kullan�c� taraf�ndan yeni olu�turulan veritabanlar� i�in �rnek sa�lar.
	#TempDb: Ge�i�i olarak kullan�lan verilerin tutulmas�n� sa�lar.
	#Msdb: Tetikleme i�lemleri i�in gerekli bilgiler burada saklan�r. Yani zamanlanm�� g�revler ve bilgileri bar�nd�r�r.
NORMALIZATION RULES
	S�yledi�imiz gibi tablolama mant��� ile �al��an veritabanlar� performansl�, h�zl� ve veri eri�imleri basittir. Bunlar i�in
baz� maximum fayday� elde etmek i�in baz� normalizasyon kurallar� vard�r.
	#: Tablolarda tekrarlanan verilerden ka��lmal�d�r.
	#: Eri�im i�in kilit pozisyonda bulunan veriler Primary Key olarak tan�mlanmal� e�er kilit pozisyonda bulunan bir veri yok ise
	ID isimli bir kolon olu�turularak Primary Key olarak tan�mlanmal�d�r.
	#: Key tan�mlamas� yap�lmayan bir column ile yine key tan�mlamas� yap�lmam�� bir column ili�kide olmamal�d�r.
	�RNEK 1 BA�LI�I �LE SORGU KODLARI VER�LM�� OLUP VER�TABANI DersOrnekleri ��ER�S�NDEK� Ornek1Diagram 
*/

															/*�RNEK 1 START*/
/*
	start - end aras�ndaki komutlar �al��t�r�l�nca g�r�lecek olan S�leyman UZUN isimli ki�inin birden fazla maili oldu�u i�in
S�leyman UZUN ki�isinin �sim, Soyisim ve Do�um Tarihi verilerinin tekrarlad���d�r. Dolay�s�yla Normalizasyon Kurallar�na 
uymayan bir tablo mant���d�r. Daha sonraki start - end aras�ndaki komutlar �al��t�r�l�nca verilerin tekrar etmedi�i ve gerekli
komutlar ile S�leyman UZUN ki�isinin maillerine ula�abilmekteyiz.
*/
/*start*/
use DersOrnekleri
go
select * from YanlisNormalizasyon;
/*end*/
/*start*/
use DersOrnekleri
go
select * from Mailler where UserID = (select ID from DogruNormalizasyonKisiler where DogruNormalizasyonKisiler.Name = 'S�leyman'
and DogruNormalizasyonKisiler.Surname = 'UZUN');
/*end*/
/*
	G�r�ld��� �zere bir adet ki�eler tablosu olu�turarak ve bu tablonun i�ine isim soyisim bilgilerinin yan� s�ra mail adresi
bilgisini de ekledi�imiz zaman verilerin tekrarlanmas� gibi bir sorun ile kar��la��yoruz. Bunun sebebi ise bir ki�inin birden
fazla mail adresine sahip olabilmesidir. Ayr�ca bir mail adresi birden fazla ki�iye ait olabilmesi m�mk�n de�ildir. Burada 1'e bir
ili�ki vard�r. Bu y�zden ki�iler tablosunu olu�turup bir column'a primary key verip daha sonra mailler tablosu i�erisinde 
UserID column ile ba�lad�k ve bu sayede tekrar eden verilerden kurtulduk. Yukardaki �rnek sorguyu T�rk�e olarak okursak
"Mailler tablosundan t�m columnlar� e�er UserID columnu DogruNormalizasyonKisiler tablosundaki name ve surname columlar� s�leyman
ve uzun olan ki�inin ID si ile uyumluysa g�ster." �eklinde okunur.
*/
															/*�RNEK 1 END*/
/*
�L��K�SEL VER� TABANI
	S�yledi�imiz gibi veritaban�n�n daha performansl� olmas� ve verilerin tekrar�n�n �nlenmesi i�in ili�kilere ihtiya� duyar�z.
�li�kiler Bire->Bir, Bire->�ok ve �oka->�ok olmak �zere ��e ayr�l�r.
	Bire->Bir ili�ki
		�rne�in bir ki�inin do�um yeri sadece bir tane �ehir olabilir. Bu y�zden plaka numaralar� ID column'u ve bu column
	primary key olarak ayarlan�rsa ve ki�iler tablosunda Plaka columnu ile ili�kili olursa buna 1->1 ili�ki denir.
	Bire->�ok ili�ki
		Bunu a��klamaya en iyi �rnek yukardaki DogruNormalizasyonKisiler tablosu ile Mailler tablosu aras�nda ili�kidir. (1->n)
	�oka->�ok ili�ki
		�ark�lar ve sanat��lar verilerini tutmak istedi�imizi d���n�rsek bir �ark�y� birden fazla sanat�� seslendirebilir ve bir
	sanat�� da birden fazla �ark�y� seslendirebilir. Anla��laca�� �zere bu da n->n yani �oka �ok bir ili�kidir. Bu t�r ili�kilerde
	yap�lmas� en uygun ad�m ise �ark�lar ve Sanat��lar tablosuna ek olarak Seslendirmeler isminde bir tablo olu�turarak ve bu
	tablo �zerinde de �ark�lar ve Sanat��lar tablosundaki primary key olan columnlar�na ili�ki(foreign key) kurmak olacakt�r.
*/

/*
PRIMARY KEY
	Birincil Anahtar anlam�na gelen bu �zellik ile columnu �zelle�tirip tekrar etmesini �nleyebiliriz ve bu column �zerinden
tablodaki di�er verilere eri�ebiliriz. A�a��da bu Primary Key dikkat etmemiz gereken maddeleri g�rece�iz.
	#Her tabloda mutlaka bir adet Primary Key olmal� ve bir tabloda sadece bir adet Primary Key olabilmektedir.
	#Primary Key olarak belirtilen columnlar bo� ge�ilemez.
	#Veritaban�n�n alt�nda bulunan Tables klas�r� alt�ndaki ilgili tabloya sa� t�klayarak design se�ene�ini se�ti�imiz zaman
	kar��m�za tablo d�zenleme ekran� gelecektir ve yan tarafta tablo ile ilgili properties sekmesi g�r�necektir. Bu �zellikler
	sekmesi i�erisinde Identity Column olarak isimlendirilmi� bir �zellik vard�r. Bu �zellik bu tablonun t�m keylerini tutar.
	Peki tablolardaki Columnlara nas�l Primary Key verece�iz? Bunun i�in baz� yollar vard�r. Bunlar;
	#Primary Key olmas�n� istedi�imiz columna sa� t�klan�nca 'set primary key' se�ene�ine t�klan�r.
	#Primary Key column bar�nd�rmas�n� istedi�imiz tabloya sa� t�klayarak indexes/keys se�ene�ine t�klayarak buradan kural
	ekleyerek ayarlama yap�labilir.
*/

/*
COMPOSITE KEY
	Bir tabloda birden fazla Primary Key kullanmam�z gerekebilmektedir. Yani birden fazla Primary Key kullan�m� Composite Key
olarak isimlendirilmektedir.
	Bunun i�in en iyi �rnek ��renci ve S�nav ili�kisi verilebilmektedir. Bir ��renci birden fazla s�nava girebilmektedir fakat
bir ��renci ayn� s�nava bir daha girememektedir. Ayn� zamanda ��rencinin s�nava girdi�i yer bilgisinin de tutuldu�unu ele al�rsak
bu i�lemleri g�ren S�nav ��lemleri tablosu olu�tururuz. Burada ��rencinin numaras� 15 olsun. Bu ��rencinin girdi�i s�navlar 1 ve 2
numaral� s�navlar olsun. Bu durumda ��renci i�in tekrar 15 numara ve s�nav numaras� 1 kayd� girilmesinin engellenmesi gerekir.
Bu y�zden Composite Key kullan�l�r ise 15 ��renci numaras� ve 1 ve 2 s�nav numaralar� art�k veri olarak girilemez.
*/

/*
FOREIGN KEY
	�sminden de anla��laca�� �zere ba�ka bir tablonun Primary Key columnunu tutarak veritaban� ili�kisi sa�layan columna
Foreign Key isimlendirilir.
*/

/*
UNIQUE CONSTRAINT
	Ad�ndan da anla��laca�� �zere columnlara tekrar etmeyen veriler girilmesini sa�lar. Unique yapmak istenilen column i�in
tabloya sa� t�klayarak Indexes/Keys se�ene�inden istenilen column se�ilerek is unique se�ene�i true yap�l�r.
*/

/*
CHECK CONSTARINT
	K�s�tlay�c�lar anlam�na gelen bu �zellik ile veri giri�inde baz� k�s�tlamalar sa�layabiliriz. �rne�in bir insan�n do�um g�n�
�u anda 1500 olamamaktad�r. Bunun i�in Birthdate > 1500-01-01 gibi bir k�s�tlay�c� yazabiliriz. Bu k�s�tlay�c� kodu yazmak i�in
ise tabloya sa� t�klayarak Check Constraint se�ene�inden k�s�tlay�c� eklenmek istenilen column eklenir ve k�s�tlay�c� kod yaz�l�r.
*/

/*
DEFAULT CONSTRAINT
	Ad�ndan da anla��laca�� �zere bir columna veri giri�i yap�lmadan varsay�lan olarak bir de�er atamas� yapmak i�in kullan�l�r.
Bir columna default constarint vermek i�in o columnun properties sekmesindeki "Default Value Or Binding" �zelli�ine de�er verilir.
*/

/*
SORGU YAZMAK
	Sorgu yazmak i�in CTRL+N kombinine basarak veya Microsoft SQL Server Management Studio da bulunan ara� �ubu�unun alt�ndaki
New Query se�ene�ine basarak .sql uzant�l� dosyay� a�mam�z gerekmektedir. Sorguyu yazarken CTRL+U kombini veya Execute se�ene�inin
solunda bulunan ComboBox �zerinden sorgular� yazmak istedi�imiz veritaban�n� belirtmek zorunday�z. Fakat bunu belirtmek i�in
sorgu i�erisinde use komutu da vard�r.
	#USE
		Bu komut ard�ndan gelen veritaban� ismi ile sorguyu i�leyece�imiz veritaban�n� belirtmi� oluyoruz. Bu sayede belirtilen
	veritaban�n�n elemanlar�na/tablolar�na direkt olarak ula�m�� oluyoruz.

	Fakat yine USE komutu olmadan veya veritaban� se�imi yap�lmadan da bir veritaban� �zerinde i�lem ger�ekle�tirebiliyoruz.
Bunun i�in bilmemiz gereken SCHEMA bilgisidir. SCHEMA veritaban�ndaki nesneleri grupland�r�lmas� i�in kullan�l�r. C# i�erisinde
namespace'e benzetilebilir. Varsay�lan SCHEMA 'dbo' dur. Buna g�re �rnek olan NORTHWIND veritaban�ndaki Catagories tablosu
�zerinde bir sorgu yazmak istiyorsak bunu, "Northwind.dbo.Catagories" yani DatabaseName.Schema.ObjectName modelinde yazabiliriz.
	#GO
		Bu komut ise sorgu i�erisinde daha �nceden yaz�lan sorgular�n i�lerinin bitti�ini ve birdaha kullan�lmayaca��n� belirtir.
	Hen�z g�rmedik ama alttaki sorgu ile GO komutunun kullan�m� �rneklendirilmi�tir.
*/
declare @number INT; /*Sorgu i�erisinde de�i�ken olu�turma*/
SELECT @number = 3; /*Sorgu i�erisinde olu�turulan bir de�i�kene de�er atama*/
print(@number); /*Ekrana de�er basma*/
go
print(@number); 
/*G�r�ld��� �zere art�k number de�i�keni kullan�lam�yor ��nk�, go komutu ile eski sorgular�n i�inin bitti�ini belirttik. Fakat
go ve sonras�nda gelen print komutlar� se�ilmeden sorgu �al��t�r�l�rsa sorgu sorunsuz bi�imde �al���r.*/

/*
#SELECT SORGUSU
	Veritaban�ndan tablo/tablolar �zerinden veri okumak i�in kullan�l�r. select sorgusundan sonra gelen column isimlerini from
ifadesinden sonra gelen tablo i�erisinden arar ve de�erleri ekrana basar. Ayr�ca t�m columnlar�n bas�lmas� isteniyorsa bunun
i�in * ifadesi eklenebilir. Fakat dikkat edilmelidir ki �ok fazla veri varsa performans etkilenir. Ayr�ca MSSQL Managment Studio
i�erisinde * ifadesinin �zerinde bir s�re durduktan sonra var olan column isimleri g�z�kecektir. Ayn� samanda select sorgusu
ile elde edilen sonu�lar� result sekmesinden t�m de�erleri se�erek veya istenilen de�erleri se�erek CTLR+SHIFT+C kombinine
basarak veya sa� t�klay�p Copy with Headers se�ene�ine basarak excel veye world i�in tablo bi�iminde kopyalama yap�labilir.
*/
use Northwind;
go
select * from Categories;
/*
#WHERE
	Select sorgusu i�in belirli �artlar dahilinde sonu�lar�n getirlmesi isteniyorsa kullan�l�r. Select sorgusu normal yap�ld�ktan
sonra where ifadesi getirilir ve �art/�artlar yaz�l�r.
*/
/*Northwind veritaban�nda Products tablosu �zerinde UnitPrice column de�erinin 18'den b�y�k olanlar� getirece�iz.*/
use Northwind;
go
select * from Products where UnitPrice > 18; /*UnitPrice 18'den b�y�k ise sonu�lar getirilir.*/
/*
#BETWEEN AND
	Where ifadesi ile birlikte �art/�artlar i�in iki de�er aras�nda sorgulama ger�ekle�tirmek i�in kullan�l�r. Where ifadesinden
sonra gelen ve kontrol edilmek istenen column isminden sonra BETWEEN ifadesi gelir ve kapal� aral���n ba�lang�� de�eri verilir.
Daha sonra ise AND ifadesi gelir ve sonras�ndaki kapal� aral���n di�er de�eri verilir.
*/
/*Northwind veritaban�nda Products tablosu �zerinde UnitPrice 18 dahil ve 21 dahil aral���ndaki de�erleri getirece�iz.*/
use Northwind;
go
select * from Products where UnitPrice between 18 and 21; /*K���k de�er between ifadesinden sonra yaz�l�r.*/
/*
#KO�ULDA FONKS�YON KULLANMA
	Where ifadesinden sonra ko�ullar i�in fonksiyonlar kullanabilir ve bu fonksiyonlardan gelen de�erlere g�re �art/�artlar
ekleyebiliriz.
*/
use Northwind
go
select E.FirstName+' '+E.LastName as 'Ad� Soyad�', E.BirthDate as 'Do�um Tarihi', YEAR(GETDATE()) - YEAR(E.BirthDate) as Ya��, 
E.Country as 'Do�um Yeri' from Employees E where YEAR(GETDATE()) - YEAR(e.BirthDate) > 65;
/*Yukar�daki sorguyu s�rayla a��klayal�m. �ncelikle from ifadesinden sonra gelen tablo isminden sonra E harfi gelmi�tir.
Bunun anlam� bu sorgu i�erisinde E g�r�len yerde Employees tablo ismi vard�r. Yani Employees tablosu i�in E k�saltmas�n� 
kulland�k. Daha sonra E.FirstName+' '+E.LastName as 'Ad� Soyad�' ile yazd���m�z k�s�mda, bu tablonun i�erisindeki FirsName
column'u ile LastName column'unu + operat�r� ile birle�tirdik. Fakat ekstra olarak ' ' ifadesini yani isim ve soyisim aras�nda
bo�luk olmas�n� da sa�lad�k. Daha sonra gelen as ifadesi bu column ifadesinin tablo ismini yani �ste yazacak ismini belirlemek
i�in kullan�l�r. Tek t�rnak aras�na yazd�k ��nk� Ad� yazd�ktan sonra arada bo�luk b�rakmak istiyoruz. Bunu Ad�Soyad� bi�iminde de
yazabilirdik. Daha sonra , ile ba�ka column getirece�imizi belirtmi� olduk. Daha sonras�nda ise YEAR fonksiyonunu kulland�k
bu fonksiyon ile verilen tarih i�erisinden y�l� elde edebiliyoruz. ��erisinde de GETDATE fonksiyonunu kulland�k. Bu fonksiyon
ile de �uan ki tarihi elde edebiliyoruz. Bunlar� da birbirinden ��kartarak ki�inin ya��n� elde etmi� olduk ve as ile bu sonucun
ba�l���n� Ya�� olarak belirledik. where ifadesinde de bu ya�� hesaplay�p ya�� 65 den b�y�kleri elde etmi� olduk.*/
/*
#DISTINCT
	Select ifadesi ile getirlien column yani verilerin tekrar�n�n �nlenmesi i�in kullan�l�r. A�a��daki �rnekte de g�r�ld��� �zere,
hangi �ehirlerden �al��anlar�n oldu�unu tekrar� �nleyerek elde ettik.
*/
use Northwind;
go
select distinct City as �ehirler from Employees;
/*
#AND ve OR ifadeleri
	Where ifadesinden sonra gelen �art�/�artlar� ve/veya kap�s�ndaki oldu�u gibi �leme sokmak i�in kullan�l�r. Bu sayede birden
fazla �art yaz�labilir ve istenilene g�re and veya or se�ilebilir. A�a��daki �rnekte 1960 do�umlu ve UK do�umlu insanlar�n
bilgileri listelenecektir. Onun alt�ndaki �rnekte ise �r�n fiyat� 18 veya 19 olan �r�nler listelenecektir. Son �rnekte ise birden
fazla between-and ifadesinin de and veya or ile kullan�labilece�i g�sterilecektir.
*/
/*1960 y�l�nda �ngiltere'de do�an �al��anlar� listeler. Employees tablosu i�inde BirthDate ve Country columnlar� kullan�ld�.*/
use Northwind;
go
select * from Employees where YEAR(BirthDate) = 1960 and Country = 'UK';
/*�r�n birim fiyat� 18 veya 19 olan �r�nleri listeler. Products tablosu i�inde UnitPrice columnu kullan�ld�.*/
use Northwind
go
select * from Products 
where UnitPrice = 18.00 or UnitPrice = 19;/*virg�l �zel ifade oldu�u i�in ondal�kl� say�larda nokta kullan�l�r.*/
/*Between-and ifadesi ile ya�lar� 1930 ile 1960 aras�nda olup i�e girme tarihi 1990 ile 1992 aras�nda olan �al��anlar.*/
use Northwind
go
select * from Employees where YEAR(BirthDate) between 1930 and 1960 and YEAR(HireDate) between 1990 and 1992;
/*
#IN
	Peki ya �ok fazla or i�lemi yazacak olursak? Teker teker yazmam�za gerek yok. Bir column i�erisinde birden fazla de�eri arat�p
herhangi biri bulundu�u zaman g�stermek i�in kullan�l�r. in ifadesinden sonra parantezler a��l�r ve virg�l ile de�erler ayr�larak
yaz�l�r. A�a��daki �rnekte Seattle, Tacoma ve London �ehirlerinde do�an �al��anlar listelenmi�tir.
*/
use Northwind
go
select * from Employees where City in('Seattle', 'London', 'Tacoma')
/*
#LIKE
	Bu ifade column i�erisinde benzerlik aramak i�in kullan�l�r. Programlama dillerinde string i�erisinde veya int i�erisinde bir
de�er veya ifade aramaya benzetilebilir. Fakat bu ifade �zel karakterler ile birlikte kullan�l�rlar. Bu �zel karakterler;
		#(_)-> Bir harf veya rakam karakterini ifade eder.
		#([A-Z])-> A ve Z dahil aral���ndaki harfleri ifade eder.
		#([0-9])-> 0 ve 9 dahil aral���ndaki rakamlar� ifade eder.
		#([])-> Herhangi bir harf veya rakam yerine gelebilecek harf veya rakam� ifade eder.
		#([^])-> Herhangi bir harf veya rakam yerine gelemeyecek harf veya rakam� ifade eder.
		#(%)-> Birden fazla harf veya rakam� ifade eder.
		#(+)-> String ifadeleri birle�tirir. Say�sal ifadeleri toplar.
	Yukarda g�r�len tablodaki sadece % karakterini kullanarak a�a��da kutulanm�� �r�nleri g�steren bir �rnek vard�r. Di�er 
karakterler ile ilgili de �rnekler �dev olarak yap�lacakt�r. Bu karakterler birden fazla bi�imde kullan�labilir
ve birle�tirilebilir. Bu y�zden �dev i�erisinde bu karakterleri kullanabilece�iniz t�m formatlarda kullan�n. Ayr�ca benzerlik
yerine benzemezlik de kullan�labilir. Bunun i�in NOT ifadesi like ifadesinin �n�ne gelebilir. Yani a�a��daki �rnekte like ifadesi
�n�ne not gelseydi kutulanmam�� �r�nler g�sterilecekti.
*/
use Northwind
go
select ProductName as �r�n, QuantityPerUnit as 'Paket T�r�' from Products where QuantityPerUnit like '%box%';
/*
#KAR�ILA�TIRMA OPERAT�RLER�
	Verileri where ile birlikte kontrol ederken kar��la�t�rma operat�rleri kullan�l�r. Bu operat�rler a�a��daki gibidir.
		#(=)-> E�itlik anlam�na gelir.
		#(!= veya <>)-> E�it de�il anlam�na gelir.
		#(>, >=, < veya <=)-> B�y�k/K���k veya B�y�k E�it/K���k E�it anlam�na gelir.
		#(is null)-> De�er atanmam�� anlam�a gelir. (= null) ifadesi ile ayn� g�revi g�r�r.
	Yukar�daki tablodaki is null ifadesi ayn� zamanda ISNULL fonksiyonu olarak column belirtilen alanlarda e�er null gelirse
geriye d�nderilecek de�eri belirtmek i�in kullan�l�r. Anla��laca�� �zere iki adet parametresi vard�r. �lk parametre kontrol
edilecek column, ikinci parametre ise bu columnun null olmas� durumunda d�necek de�erdir. A�a��daki �rnekte ise herhangi bir
b�gleye ait olmayan �irketler listelenmi�tir.
*/
use Northwind
go
select CompanyName as �irket, ISNULL(Region, 'B�lge Yok!') as B�lge from Customers where Region is null;
/*
#Order By
	Select sorgusu ile elde edilen veri gurubunu s�ralamak i�in kullan�l�r. �rne�in select sorgusu ile �al��anlar� ald���m�z� ve
bu �al��anlar� b�y�kten k����e s�ralamak istedi�imizi varsayal�m.
	#asc: Azalandan - Artana s�ralama i�in eklenir.
	#desc: Artandan - Azalana s�ralama i�in eklenir.
*/
use Northwind
go
select E.FirstName + ' ' + E.LastName as 'Ad� Soyad�', CONVERT(nvarchar(10), E.BirthDate, 104) as 'Do�um Tarihi' 
from Employees E order by YEAR(E.BirthDate) asc, MONTH(E.BirthDate) asc, DAY(E.BirthDate) asc;
/*
#TOP
	Ba�lang��tan itibaren adet veya y�zde olarak ka� veri g�sterilece�ini belirlemek i�in kullan�l�r. Select sorgusunun yan�na
gelerek belirtilir. �rne�in a�a��da personeller aras�ndan en b�y�k 3 ki�iyi alal�m.
*/
use Northwind
go
select top 3 E.FirstName + ' ' + E.LastName as 'Ad� Soyad�', CONVERT(nvarchar(10), E.BirthDate, 104) as 'Do�um Tarihi' 
from Employees E order by YEAR(E.BirthDate) asc, MONTH(E.BirthDate) asc, DAY(E.BirthDate) asc;
/*
#Top fonksiyonu i�in With Ties Parametresi
	Top fonksiyonu ile birlikte kullan�l�r. Listelenen son eleman�n de�eri ile ayn� bir de�er var ise onu da listelemeye dahil
eder. �rne�in En az fiyatl� top 12 �r�n� listeleyelim ve with ties parametresini de ekleyelim.
*/
use Northwind
go
select top 12 with ties P.ProductName as '�r�n �smi', P.UnitPrice as 'Birim Fiyat�'
from Products P order by P.UnitPrice asc;
/*G�r�ld��� �zere 12 �r�n nlistelendi ve 12. �r�n�n birim fiyat� 10 oldu�u i�in di�er birim fiyat� 10 olan �r�nler de ek olarak
listelenmi�tir. Fakat dikkat edilmeksi gereken �ey �udur ki order by ile s�ralanma y�ntemi belirlenmelidir.*/
/*
#DE���KENLER - VARIABLES
	De�i�kenler bilindi�i gibi veri tipine g�re ram �zerinde veri tutmak ve de�i�ken olarak bunlar� kullanmak istedi�imiz i�in
kullan�l�rlar.
	Tan�mlama
		Declare @variable_name variable_type => bi�iminde tan�mlama yap�l�r.
	De�er Atama
		#set: Tek bir de�i�kene de�er atamas� yapmak i�in kullan�l�r.
		#select: Birden fazla de�i�kene de�er atamas� yap�labilmektedir.
*/
go
Declare @sample_variable nvarchar(23);
Declare @sample_variable_2 nvarchar(25);
set @sample_variable = 'This is a test variable';
set @sample_variable_2 = 'This is a second variable';
select @sample_variable as 'sample_variable', @sample_variable_2 as 'sample_variabl_2';
select @sample_variable = 'First variable changed', @sample_variable_2 = 'Second variable changed';
select @sample_variable as 'sample_variable', @sample_variable_2 as 'sample_variabl_2';
/*
#Tip D�n���m�
	Tip d�n���m� bir de�i�kenin de�erini farkl� veri tiplerinde elde etmek i�in kullan�l�r. Fakat dikkat edilmesi gereken bir
metini asla tarihe �eviremiyecek olman�zd�r. Tip d�n���m� i�in Convert, Try_Convert ve Cast olmak �zere 3 adet y�ntem vard�r.
	#return Convert(variable_type, variable_name, format): G�r�ld��� �zere 3 adet parametre al�r ve 3. parametre yaln�zca iste�e
	ba�l� olarak tarih d�n���mlerinde kullan�l�r. �lk parametrede de�i�kenin d�n��t�r�lece�i veri tipi, ikinci parametrede ise
	de�i�kenin kendisi yer almaktad�r. �evrilen de�er geriye d�nderilir. Tarihler i�in ise baz� formatlar kullan�lmaktad�r. �rne�in
	Almanya bizim ile ayn� yani g�n/ay/y�l bi�iminde tarih tutar ve bunun kodu 104 olmaktad�r. (Bkz. Microsoft Documents)
	#return Try_Convert(variable_type, variable_name, format): Convert metodundan tek farkl�, �evirme i�lemi ba�ar�l� ise �evrilen
	de�er d�ner. �evirme i�lemi ba�ar�s�z ise geriye null de�eri d�ner.
	#return cast(variable_name as converting_variable_type): �evirme i�leminde de�i�kenin stilini/format�n� de�i�tirmeksizin
	veri �evrimi yapar ve geriye d�nderir.
	#return hierarchyid::parse('format'): hierarchyid veri tiplerinin �evriminde kullan�l�r.
	#return Try_Parse(variable_name as variable_type using region_format): E�er �evirme i�lemi ba�ar�l� ise �evrilen de�eri
	ba�ar�s�z ise geriye null d�nderir. Herhangi bir string de�eri ba�ka bir de�ere �evirmek i�in kullan�l�r.
*/
/*
#Transact-SQL
	Microsoft taraf�ndan (if, else vb.) baz� karma��k sorgularda kullan�lmak �zere geli�tirilmi�, ANSI standartlar� d���nda olan
bir sorgulama dilidir. DML, DDL ve DCL olmak �zere 3 grubda incelenebilir.
	#DML(Data Manipulation Language) - Veri ��leme Dili
		Select, delete, update ve insert komutlar� bu grubda kullan�lmaktad�r.
	#DDL(Data Definition Language) - Veri Tan�mlama Dili
		Create Table, Alter Table, Drop Table ve Create Index gibi database olu�turma komutlar� bu grubdad�r.
	#DCL(Data Control Language) - Veri Kontrol Dili
		Grant, Deny ve Revoke ile birlikte kullan�c� yetkilerini kontrol etmektedir.
*/

/*
#SQL Server Functions
	1-)Date Functions - Tarih Fonksiyonlar�
		#DATEDIFF(Date Shortcut, start date, finish date) fonksiyonu geriye date shortuct format�nda tarih d�nderir. �al��anlar�n
		ka� ya��nda olduklar�n� bulan sorguyu yazal�m.
		#GETDATE() parametre almadan geriye y�l/ay/g�n format�nda tarih d�nderir.
		#DATEPART(Shortcut, date) parametre olarak verilen tarihi shortuct k�altmas� format�nda geriye d�nderir.
		#DATEADD(Date to will add shortcut, NumberOfAdd, Date) Date to will add shortcut parametresinde verilen formata yani y�l
		ise y�la g�re NumberOfAdd kadar y�l veya ne belirtilir ise son parametredeki tarihe ekler.
		#DATENAME(Shortcut, date) verilen tarihin shortcut ile verilen ay, hafta ile ay ismini veya g�n ismini d�nderir.
		#DAY(Date) verilen tarihin g�n�n� say�sal olarak geriye d�nderir.
		#MONTH(Date) verilen tarihin ay�n� say�sal olarak geriye d�nderir.
		#YEAR(Date) verilen tarihin y�l�n� say�sal olarak d�rt haneli geriye d�nderir.
		#DATEFROMPARTS(Year, Month, Day) Girilen y�l/ay/g�n e g�re tarih olu�turup geriye d�nderir.
		#DATETIMEFROMPARTS(Year, Month, Day, Hour, Minute, Second, Salise, Milisecond) parametrelerinden DateTime elde edilir.
		#SMALLDATETIMEFROMPARTS(Year, Month, Day, Hour, Minute) Parametrelerinden SmallDateTime elde edilir.
		#TIMEFROMPARTS(Hour, Minute, Second, Kesir, Duyarl�l�k) Parametrelerinden Time elde edilir.
		#ISDATE('Date') Paremetre olarak verilen stringin tarih olup olmad���n true veya false ile geriye d�nderir.
		Ara�t�r daha fazlas� var.
*/
/*1-)DATEDIFF()*/
use Northwind
go
select FirstName + ' ' + LastName as 'Ad� Soyad�', DATEDIFF(yy, BirthDate, GETDATE()) as Y�l, 
DATEDIFF(mm, BirthDate, GETDATE()) as Ay, DATEDIFF(dd, BirthDate, GETDATE()) as G�n from Employees
order by DATEDIFF(dd, BirthDate, GETDATE()) desc;
/*1-)DATEADD()*/
use Northwind
go
select *, DATEADD(yy, 17, OrderDate) as "17 Y�l Sonra" from Orders;
/*1-)DATENAME()*/
use Northwind
go
set language Turkish; /*Dil ayar�n� ayarlama*/
select *, DATENAME(w, GETDATE()) as "Haftan�n G�n� Ustam!" from Orders;
/*
#SQL Server Functions
	2-)Aggregate Functions - K�meleme Fonksyionlar�
	Warning - Uyar�
	* E�er sorguya, k�meleme yap�lacak s�t�ndan ba�ka bir s�t�n daha eklenecek olursa; eklenen bu s�t�na g�re sorguyu
	gruplamak gerekmektedir.
	* Gruplama i�lemine her s�tunun dahil edilmesi gerekmektedir. "Group By" ifadesinde Aggregate Functions kullan�lan s�t�ndan
	ba�ka her s�tun dahil edilmesi gerekmektedir.
	* Aggregate Functions sadece say�sal veriler ile birlikte �al���rlar. Null de�erleri dikkate almazlar.
	* Aggregate Functions kullan�larak olu�turulan sonu�lar� i�eren veriyi, filtreleme yaparken yani "where" ifadesi ile
	kullanamay�z. (Aggregate Functions ile de ko�ul yaz�labilmektedir. �lerde g�rece�imiz ko�ul yap�s� ile where ile de�il!)
	* S�tunlara verilen takma(alias) isimler "Having" ile yap�lamazlar.
		#AVG(Values) Parametre olarak verilen de�erlerin ortalamas�n� geriye d�nderir.
		#COUNT(Values) Parametre olarak verilen de�erlerin ka� adet oldu�unu geriye d�nderir.
		#SUM(Values) Parametre olarak verilen de�erlerin toplam�n� geriye d�nderir.
		#MAX-MIN(Values) Parametre olarak verilen de�erlerden en b�y���n� veya en k�����n� geriye d�nderir.
*/
/*2-)AVG()*/
use Northwind
go
select AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) as 'AKP Kadrosu Ya� Ortalamas�' from Employees;
/*3-)COUNT()*/
use Northwind
go
select City as �ehirler, COUNT(City) as '�al��an Say�s�' 
from Employees Group By City Order by COUNT(City) asc;
/*
#SQL Server Functions
	3-)Scalar Functions - Skaler Fonksyionlar
		3.1-)String Functions - Dize Fonksiyonlar�
			#UPPER(String) ��erisine verilen metinin t�m harflerini b�y�terek geriye d�nderir.
			#LOWER(String) ��erisine verilen metinin t�m harflerini k���lterek geriye d�nderir.
			#SUBSTRING(String text, int PartCount, int StartingPart) Parametre olarak verilen text'in PartCount parametresinde
			verilen de�er kadar; StartingPart parametresinde verilen de�erden ba�layarak alt string geriye d�nderir.
			#LEN(String) Parametre olarak verilen string'in uzunlu�unu geriye d�nderir.
			#ROUND(Double value, var RoundCount) Parametre olarak verilen value de�erini RoundCount kadar yuvarlayarak geriye
			d�nderir.
			#ASCII(Char) veya UNICODE(Char) Paremtre olarak verilen karakterin ASCII veya UNICODE kodunu geriye d�nderir.
			#CHAR(Code) Parametre olarak verilen karakter kodunu karaktere �evirerek geriye d�nderir.
			Ara�t�r daha fazlas� var.
			#STR(FloatNumber, FloatNumberCharCount, CutCount) Parametre olarak verilen FloatNumber ondal�kl� say�s�ndan CutCount
			kadar soldan karakter kesmek i�in kullan�l�r. Buradaki FloatNumberCharCount FloatNumber ondal�kl� say�s�n�n karakter
			say�s�na e�ittir.
*/
/*
#HAVING
	Bir sorguda Group By kullan�lm�� ise where kullan�lamaz. Where yerine having kullan�l�r.
	Warning - Uyar�
		* E�er sorguda ko�ul i�lemi, i�lem yap�lan s�tunun sonucuna g�re olacaksa; Having ifadesinde i�lem yap�lan s�tunun takma
		ad� kullan�lamaz, i�lem i�in yaz�lan sorgu kodlar� tekrar yaz�l�r.
		* Ko�ul i�emli, i�lem yap�lan s�tuna g�re de�ilse; s�tun ad� aynen yaz�lmal�d�r. Yani Having ifadesi kullan�ld���nda
		s�tunun orijinal ad� yaz�lmal�d�r.
*/
/*
#SQL Server Functions
	4-)SET STATEMENT - �fade Belirleme
		#Set DateFirst value Haftan�n ilk g�n�n� belirlemek i�in kullan�l�r.
		#Set RowCount value Sorguda ka� sat�r�n de�erinin d�nderilece�ini s�n�rlar. 0 yazarsak s�n�rlama kalkar.
		#Set DateFormat value(DMY bizde) Varsay�lan tarih format�n� de�i�tirmek i�in kullan�l�r.
		#Set CONCAT_NULL_YIELDS_NULL booleanValue Null ile birle�imin sonucunun Null olmas�n� istiyorsak bu ifade on, tersi i�in
		ise off olmas� gerekir.
		#Set Language Region Dil belirlemek i�in kullan�l�r.
			Set edilen de�eri @@LANGID ile say�sal olarak elde edilir. @@LANGUAGE ile de metinsel olarak elde edilir.
		#@@MaxConnection Veri taban�na ba�lant� say�s�n� D�nderir.
		#@@ServerName Server ismi elde etmek i�in kullan�l�r.
		#@@ServiceName Servis ad�n� elde etmek i�in kullan�l�r.
		#@@MicrosoftVersion Microsoft versiyonunun elde etmek i�in kullan�l�r.
*/

set language Turkish;
select @@LANGUAGE;
/*
#SQL Server Functions
	5-)Defined From User Functions - Kullan�c� Taraf�ndan Olu�turulan Fonksiyonlar
		Fonksiyonlar geriye de�er d�nd�rme �zelli�i olan yap�lard�r. Stored Procedure, sorgu i�erisinde kullan�lamazken,
	fonksiyonlar sorgu i�erisinde de kullan�labilir. Geriye bir de�er veya tablo d�nd�rebilirler. View ile sa�lanan tablo
	yap�s�ndan farkl� olarak, parametre alan bir yap�ya sahiplerdir.
	Warning - Uyar�
		* Fonksiyonlar Insert, Update, Delete i�lemi yapamazlar fakat Insert, Update, Delete sorgular�n�n i�erisinde yer alabilir.
		* Fonksiyon kullan�rken dbo(Schema) belirtilmelidir.
*/
/*Defining User Function*/
use Northwind
go
Create Function Calculate_KDV
(@price money, @kdvRate float)
returns money
Begin
return @price + (@price * @kdvRate)
End
go
Declare @kdvRate float = 0.18;
select OrderID as ID, UnitPrice as 'KDV Olmadan Birim Fiyat', dbo.Calculate_KDV(UnitPrice, @kdvRate)
as 'KDV Dahil Birim Fiyat' from [Order Details]
/*Returning Table Functions*/
use Northwind
go
Create Function ListCustomer
(@CompanyName NVARCHAR(40))
returns Table
return (select * from Customers where CompanyName = @CompanyName)
go
select * from dbo.ListCustomer('Alfreds Futterkiste')
/*
#KO�UL YAPILARI
	1-)Case When Then
		SQL Server'da �artlara ba�l� bir kontrol ger�ekle�tirmek i�in bu yap�dan yararlanabiliriz.
		Kullan�m
			a-) E�itlik Kontrol� Yap�lacaksa
				Case <Kontrol� Yap�lacak Veri>
				When <E�it Olmas� Beklenen De�er>
				Then <�art Sa�land���nda Yap�lacak ��lem>
				End
			b-) E�itlik Kontrol� Yap�lmayacaksa
				Case When <Kontrol� Yap�lacak Veri> <Kontrol C�mlesi>
				Then <�art Sa�land���nda Yap�lacak ��lem>
				End
*/
/*Case When Then �r�n kategorilerinin T�rk�e kar��l�klar� ile listelenmesi ve kontrol edilen de�erin e�itlik durumuna bakma*/
use Northwind
go
select CategoryName as '�ngili��e Kategori �smi', Description as 'A��klama',
case CategoryName
when 'Beverages' then '��ecekler'
when 'Condiments' then 'Bal'
when 'Confections' then '�ekerlemeler'
when 'Dairy Products' then 'S�t �r�nleri'
when 'Grains/Cereals' then 'Tah�llar'
when 'Meat/Poultry' then 'Et ve Tavuk �r�nleri'
when 'Produce' then '�malat'
when 'Seafood' then 'Deniz �r�nleri'
else 'Unknown'
end as 'Kategori �smi'
from Categories order by CategoryName desc;
/*Case When Then Using With Variable*/
go
declare @value int = 5;
set @value = case (select @value)
when 5 then 3
end
print(@value)
go
/*
#KO�UL YAPILARI
	2-)IF EXISTS
		Bir tabloda istedi�imiz ko�ulu sa�layan kay�tlar�n var olup olmad���n� kontrol eder. Tablodo ko�ulu sa�layan de�er de�er
	varsa true d�ner.
*/
/*�r�nler tablosunda Chai adl� bir �r�n var m�?*/
use Northwind
go
if exists(select * from Products where ProductName = 'Chai')
begin
print('Chai isimli �r�n bulunmaktad�r!');
end
else
begin
print('Chai isimli �r�n bulunmamaktad�r!');
end
/*If Exists Using With Variable*/
go
declare @value int = 99;
if exists(select * where @value = 98)
begin
set @value = 77;
end
else
begin
set @value = 66;
end
print(@value);
go
/*
#KO�UL YAPILARI
	3-)IIF
		Direkt olarak bir ko�ul, ko�ul sa�land� ise ve ko�ul sa�lanmad� ise de�erleri alarak i�lem yapar.
		Kullan�m�
			IIF(Logical Expression, then procces, else procces)
*/
/*Kategoriler tablosunda, kategori ad� Beverages ise ��ecekler de�ilse ��ecek de�il yazan sorgu*/
use Northwind
go
select case CategoryName
when 'Beverages' then '��ecekler'
when 'Condiments' then 'Bal'
when 'Confections' then '�ekerlemeler'
when 'Dairy Products' then 'S�t �r�nleri'
when 'Grains/Cereals' then 'Tah�llar'
when 'Meat/Poultry' then 'Et ve Tavuk �r�nleri'
when 'Produce' then '�malat'
when 'Seafood' then 'Deniz �r�nleri'
else 'Unknown'
end as 'Kategori �smi', Description as 'A��klama', IIF(CategoryName = 'Beverages', '��ecekler', '��ecek De�il') as
'T�r' from Categories
/*
JOIN
	Birden fazla tablodaki ili�kisel verileri sorgularken Join ifadelerinden yararlan�r�z. Birbiri ile ili�kili olan tablolar�n
verileri Join ile birle�tirilerek, t�m verileri bir araya getirebiliriz.
	1-)Inner Join: Join ifadesinde kullan�lan tablolarda, sadece e�le�en kay�tlar listelenir.
	2-)Left Join: Soldaki tablodan t�m kay�tlar listelenir. Sa�daki tablodan ise sadece e�le�en kay�tlar listelenir.
	3-)Right Join: Sa�daki tablodan t�m kay�tlar listelenir. Soldaki kay�ttan sadece e�le�en kay�tlar listelenir.
	4-)Outter Join: Her iki tablodan t�m kay�tlar listelenir. E�le�en kay�tlar yan yana g�sterilir. E�le�meyen kay�tlar i�in
	ise s�t�nlar bo� b�rakl�r.
	5-)Full Join: Her iki tablodan e�le�en ve e�le�meyen kay�tlar listelenir. E�le�meyen s�t�nlar bo� b�rak�l�r.
*/
/*Inner Join �r�nlerin kategori adlar�na g�re listelenmesi*/
use Northwind
go
select case C.CategoryName 
when 'Beverages' then '��ecekler'
when 'Condiments' then 'Bal'
when 'Confections' then '�ekerlemeler'
when 'Dairy Products' then 'S�t �r�nleri'
when 'Grains/Cereals' then 'Tah�llar'
when 'Meat/Poultry' then 'Et ve Tavuk �r�nleri'
when 'Produce' then '�malat'
when 'Seafood' then 'Deniz �r�nleri'
else 'Unknown'
end as 'Kategori �smi', P.ProductName as '�r�n �smi' from Products P Join Categories C 
on P.CategoryID = C.CategoryID;
/*Left Join*/
use Northwind
go
select P.ProductName as '�r�n �smi', case C.CategoryName 
when 'Beverages' then '��ecekler'
when 'Condiments' then 'Bal'
when 'Confections' then '�ekerlemeler'
when 'Dairy Products' then 'S�t �r�nleri'
when 'Grains/Cereals' then 'Tah�llar'
when 'Meat/Poultry' then 'Et ve Tavuk �r�nleri'
when 'Produce' then '�malat'
when 'Seafood' then 'Deniz �r�nleri'
else 'Unknown'
end as 'Kategori �smi' from Products P Left Join Categories C 
on P.CategoryID = C.CategoryID;
/*
Information Schema
	Tablolar i�in varsay�lan Schema dbo dur.
*/
/*Listing Northwind Database's Tables*/
go
select * from Northwind.INFORMATION_SCHEMA.TABLES order by TABLE_TYPE asc;

/*
Constraint
	Veritaban�na eklenen verilerin tutarl�l���n� sa�lamak �zere, tabloya girilecek verilerin gir�ini s�n�rland�ran yap�lard�r.
*/

/*Constraint Listesini Sorgulamak*/
use Northwind
go
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS;

/*Getting User Name*/
select SUSER_NAME(1) Kullan�c�1;
select SUSER_NAME(2) Kullan�c�2;
select SUSER_NAME(3) Kullan�c�3;
select SUSER_NAME(4) Kullan�c�4;
select SUSER_NAME(5) Kullan�c�5;
select SUSER_NAME(6) Kullan�c�6;
select SUSER_NAME(7) Kullan�c�7;
select SUSER_NAME(8) Kullan�c�8;
select SUSER_NAME(9) Kullan�c�9;
select SUSER_NAME(10) Kullan�c�10;

/*Getting User Roles*/
use Northwind
go
select * from sys.server_principals where type_desc in('SQL_LOGIN', 'WINDOWS_LOGIN') and name not like 'NT%'

/*Getting SQL Version*/
select name, compatibility_level from sys.databases;

/*DENSE_RANK()*/
/*
Warning - Uyar�
	over ve order by ifadeleri olmadan kullan�lamamaktad�r.
*/
use Northwind
go
select DENSE_RANK() over (order by TitleOfCourtesy) as 'Group Number', TitleOfCourtesy ,FirstName + ' ' + LastName from Employees
