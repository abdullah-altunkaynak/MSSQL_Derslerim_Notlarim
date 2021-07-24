/*-Temel Bilgiler-
Database Nedir?
	Veritabaný sistematik olarak verilere eriþilebilen hafýza üniteleridir. Baþlarda veresiye defteri gibi veritabanlarý
kullanýlýrken dijital dünya için çeþitli firmalar tarafýndan veritabanlarý geliþtirilmiþtir. Genel olarak bu veritabanlarý
tablolama mantýðýna dayanarak veri barýndýrsa da, json veya txt tipinde de veriler hala tutulmaktadýr. Tablolama mantýðý ile
veritabaný bize daha az alan ile daha fazla veri tutmayý ve verilere daha kolay ulaþmayý saðlar.
MSSQL
	Microsoft tarafýndan geliþtirilmiþ ve geliþmiþ uygulama lisanslarý bulunan veritabanýdýr. Veritabaný desteklenen tüm diller
üzerinden eriþim veya geliþtirme yapýlabilmektedir. Veritabaný söylediðimiz gibi tablolardan, tablolar ise sütünlardan oluþur.
Bu sütunlara column/kolon ismi verilir. Bu columnlarýn ise ismi, veri tipi ve nullable yani boþ geçilebilirlik bilgisi boolean
bir biçimde tutlur. 
SQL Sorulama Dili
	Veritabanýndan veri sorgulamak, veri eklemek, veri silmek, veri güncellemek, tablo oluþturmak, column oluþturmak... gibi birçok
iþlevi yerine getirmemizi saðlar. Açýlýmý Structured Query Language yani Yapýlandýrýlmýþ Sorgulama Dilidir. Microsoft SQL Server
ANSI standartlarýnda SQL sorgulama dilini kullanmaktadýr. Oracle ise PL/SQL sorgulama dilini kullanmaktadýr.
SQL SERVER
	Microsoft tarafýndan geliþtirilmiþ Veritabaný sunucu yazýlýmýdýr. SQL Server 1433 numaralý portu dinleyerek uzak veya yerel
aðdan veritabaný baðlantýlarýna izin verir.
DATABASE ÇÖZÜMLERÝ
	Veritabaný çözümleri OLTP(Online Transaction Processing) ve OLAP(Online Analytical Processing) olmak üzere ikiye ayrýlýr.
	#OLTP
		Kullanýcýlarýn veri ekledikleri, sildikleri veya güncelledikleri sistemlerdir. Çok sayýda kullanýcýya iþlem desteði sunar.
	#OLAP
		Veriler üzerinde analiz yapmak ve veri okumak amaçlý kurulan sistemlerdir.
SERVER TYPE
	#Database Engine
		Ýliþkisel veri tabanlarý oluþturarak gerçek zamanlý veri iþlememize olanak saðlar. Verileri yöneterek güvenliði saðlar.
	SQL Profile sayesinde sunucuda gerçekleþtirilen olaylar izlenebilmektedir.
	#Analysis Services
		Verilerin hýzlýca analiz edilmesi için çözümler sunar. OLAP özelliklerinden faydalanýr.
	#Reporting Services
		SQL Server için raporlama hizmeti sunar. Kullanýma hazýr araçlarý ile raporlarý kolay ve hýzlý biçimde oluþturulmasýný
	saðlar.
	#Integration Services
		Verilerin taþýnmasýný saðlayan server tipidir.
SYSTEM DATABASE
	SQL Serverin ilk kurulumunda Master, Model, TempDb ve Msdb olmak üzere 4 adet veritabanýnýn System Databases klasörü altýnda
oluþturulduðunu görürüz. Bu Database'ler
	#Master: Sql Server'in çalýþabilmesi için(Kullanýcý tanýmlarý ve temel bilgiler) gerekli olan yapýlarý barýndýrýr.
	#Model: Kullanýcý tarafýndan yeni oluþturulan veritabanlarý için örnek saðlar.
	#TempDb: Geçiçi olarak kullanýlan verilerin tutulmasýný saðlar.
	#Msdb: Tetikleme iþlemleri için gerekli bilgiler burada saklanýr. Yani zamanlanmýþ görevler ve bilgileri barýndýrýr.
NORMALIZATION RULES
	Söylediðimiz gibi tablolama mantýðý ile çalýþan veritabanlarý performanslý, hýzlý ve veri eriþimleri basittir. Bunlar için
bazý maximum faydayý elde etmek için bazý normalizasyon kurallarý vardýr.
	#: Tablolarda tekrarlanan verilerden kaçýlmalýdýr.
	#: Eriþim için kilit pozisyonda bulunan veriler Primary Key olarak tanýmlanmalý eðer kilit pozisyonda bulunan bir veri yok ise
	ID isimli bir kolon oluþturularak Primary Key olarak tanýmlanmalýdýr.
	#: Key tanýmlamasý yapýlmayan bir column ile yine key tanýmlamasý yapýlmamýþ bir column iliþkide olmamalýdýr.
	ÖRNEK 1 BAÞLIÐI ÝLE SORGU KODLARI VERÝLMÝÞ OLUP VERÝTABANI DersOrnekleri ÝÇERÝSÝNDEKÝ Ornek1Diagram 
*/

															/*ÖRNEK 1 START*/
/*
	start - end arasýndaki komutlar çalýþtýrýlýnca görülecek olan Süleyman UZUN isimli kiþinin birden fazla maili olduðu için
Süleyman UZUN kiþisinin Ýsim, Soyisim ve Doðum Tarihi verilerinin tekrarladýðýdýr. Dolayýsýyla Normalizasyon Kurallarýna 
uymayan bir tablo mantýðýdýr. Daha sonraki start - end arasýndaki komutlar çalýþtýrýlýnca verilerin tekrar etmediði ve gerekli
komutlar ile Süleyman UZUN kiþisinin maillerine ulaþabilmekteyiz.
*/
/*start*/
use DersOrnekleri
go
select * from YanlisNormalizasyon;
/*end*/
/*start*/
use DersOrnekleri
go
select * from Mailler where UserID = (select ID from DogruNormalizasyonKisiler where DogruNormalizasyonKisiler.Name = 'Süleyman'
and DogruNormalizasyonKisiler.Surname = 'UZUN');
/*end*/
/*
	Görüldüðü üzere bir adet kiþeler tablosu oluþturarak ve bu tablonun içine isim soyisim bilgilerinin yaný sýra mail adresi
bilgisini de eklediðimiz zaman verilerin tekrarlanmasý gibi bir sorun ile karþýlaþýyoruz. Bunun sebebi ise bir kiþinin birden
fazla mail adresine sahip olabilmesidir. Ayrýca bir mail adresi birden fazla kiþiye ait olabilmesi mümkün deðildir. Burada 1'e bir
iliþki vardýr. Bu yüzden kiþiler tablosunu oluþturup bir column'a primary key verip daha sonra mailler tablosu içerisinde 
UserID column ile baðladýk ve bu sayede tekrar eden verilerden kurtulduk. Yukardaki örnek sorguyu Türkçe olarak okursak
"Mailler tablosundan tüm columnlarý eðer UserID columnu DogruNormalizasyonKisiler tablosundaki name ve surname columlarý süleyman
ve uzun olan kiþinin ID si ile uyumluysa göster." þeklinde okunur.
*/
															/*ÖRNEK 1 END*/
/*
ÝLÝÞKÝSEL VERÝ TABANI
	Söylediðimiz gibi veritabanýnýn daha performanslý olmasý ve verilerin tekrarýnýn önlenmesi için iliþkilere ihtiyaç duyarýz.
Ýliþkiler Bire->Bir, Bire->Çok ve Çoka->Çok olmak üzere üçe ayrýlýr.
	Bire->Bir iliþki
		Örneðin bir kiþinin doðum yeri sadece bir tane þehir olabilir. Bu yüzden plaka numaralarý ID column'u ve bu column
	primary key olarak ayarlanýrsa ve kiþiler tablosunda Plaka columnu ile iliþkili olursa buna 1->1 iliþki denir.
	Bire->Çok iliþki
		Bunu açýklamaya en iyi örnek yukardaki DogruNormalizasyonKisiler tablosu ile Mailler tablosu arasýnda iliþkidir. (1->n)
	Çoka->Çok iliþki
		Þarkýlar ve sanatçýlar verilerini tutmak istediðimizi düþünürsek bir þarkýyý birden fazla sanatçý seslendirebilir ve bir
	sanatçý da birden fazla þarkýyý seslendirebilir. Anlaþýlacaðý üzere bu da n->n yani çoka çok bir iliþkidir. Bu tür iliþkilerde
	yapýlmasý en uygun adým ise Þarkýlar ve Sanatçýlar tablosuna ek olarak Seslendirmeler isminde bir tablo oluþturarak ve bu
	tablo üzerinde de Þarkýlar ve Sanatçýlar tablosundaki primary key olan columnlarýna iliþki(foreign key) kurmak olacaktýr.
*/

/*
PRIMARY KEY
	Birincil Anahtar anlamýna gelen bu özellik ile columnu özelleþtirip tekrar etmesini önleyebiliriz ve bu column üzerinden
tablodaki diðer verilere eriþebiliriz. Aþaðýda bu Primary Key dikkat etmemiz gereken maddeleri göreceðiz.
	#Her tabloda mutlaka bir adet Primary Key olmalý ve bir tabloda sadece bir adet Primary Key olabilmektedir.
	#Primary Key olarak belirtilen columnlar boþ geçilemez.
	#Veritabanýnýn altýnda bulunan Tables klasörü altýndaki ilgili tabloya sað týklayarak design seçeneðini seçtiðimiz zaman
	karþýmýza tablo düzenleme ekraný gelecektir ve yan tarafta tablo ile ilgili properties sekmesi görünecektir. Bu özellikler
	sekmesi içerisinde Identity Column olarak isimlendirilmiþ bir özellik vardýr. Bu özellik bu tablonun tüm keylerini tutar.
	Peki tablolardaki Columnlara nasýl Primary Key vereceðiz? Bunun için bazý yollar vardýr. Bunlar;
	#Primary Key olmasýný istediðimiz columna sað týklanýnca 'set primary key' seçeneðine týklanýr.
	#Primary Key column barýndýrmasýný istediðimiz tabloya sað týklayarak indexes/keys seçeneðine týklayarak buradan kural
	ekleyerek ayarlama yapýlabilir.
*/

/*
COMPOSITE KEY
	Bir tabloda birden fazla Primary Key kullanmamýz gerekebilmektedir. Yani birden fazla Primary Key kullanýmý Composite Key
olarak isimlendirilmektedir.
	Bunun için en iyi örnek Öðrenci ve Sýnav iliþkisi verilebilmektedir. Bir öðrenci birden fazla sýnava girebilmektedir fakat
bir öðrenci ayný sýnava bir daha girememektedir. Ayný zamanda öðrencinin sýnava girdiði yer bilgisinin de tutulduðunu ele alýrsak
bu iþlemleri gören Sýnav Ýþlemleri tablosu oluþtururuz. Burada öðrencinin numarasý 15 olsun. Bu öðrencinin girdiði sýnavlar 1 ve 2
numaralý sýnavlar olsun. Bu durumda öðrenci için tekrar 15 numara ve sýnav numarasý 1 kaydý girilmesinin engellenmesi gerekir.
Bu yüzden Composite Key kullanýlýr ise 15 öðrenci numarasý ve 1 ve 2 sýnav numaralarý artýk veri olarak girilemez.
*/

/*
FOREIGN KEY
	Ýsminden de anlaþýlacaðý üzere baþka bir tablonun Primary Key columnunu tutarak veritabaný iliþkisi saðlayan columna
Foreign Key isimlendirilir.
*/

/*
UNIQUE CONSTRAINT
	Adýndan da anlaþýlacaðý üzere columnlara tekrar etmeyen veriler girilmesini saðlar. Unique yapmak istenilen column için
tabloya sað týklayarak Indexes/Keys seçeneðinden istenilen column seçilerek is unique seçeneði true yapýlýr.
*/

/*
CHECK CONSTARINT
	Kýsýtlayýcýlar anlamýna gelen bu özellik ile veri giriþinde bazý kýsýtlamalar saðlayabiliriz. Örneðin bir insanýn doðum günü
þu anda 1500 olamamaktadýr. Bunun için Birthdate > 1500-01-01 gibi bir kýsýtlayýcý yazabiliriz. Bu kýsýtlayýcý kodu yazmak için
ise tabloya sað týklayarak Check Constraint seçeneðinden kýsýtlayýcý eklenmek istenilen column eklenir ve kýsýtlayýcý kod yazýlýr.
*/

/*
DEFAULT CONSTRAINT
	Adýndan da anlaþýlacaðý üzere bir columna veri giriþi yapýlmadan varsayýlan olarak bir deðer atamasý yapmak için kullanýlýr.
Bir columna default constarint vermek için o columnun properties sekmesindeki "Default Value Or Binding" özelliðine deðer verilir.
*/

/*
SORGU YAZMAK
	Sorgu yazmak için CTRL+N kombinine basarak veya Microsoft SQL Server Management Studio da bulunan araç çubuðunun altýndaki
New Query seçeneðine basarak .sql uzantýlý dosyayý açmamýz gerekmektedir. Sorguyu yazarken CTRL+U kombini veya Execute seçeneðinin
solunda bulunan ComboBox üzerinden sorgularý yazmak istediðimiz veritabanýný belirtmek zorundayýz. Fakat bunu belirtmek için
sorgu içerisinde use komutu da vardýr.
	#USE
		Bu komut ardýndan gelen veritabaný ismi ile sorguyu iþleyeceðimiz veritabanýný belirtmiþ oluyoruz. Bu sayede belirtilen
	veritabanýnýn elemanlarýna/tablolarýna direkt olarak ulaþmýþ oluyoruz.

	Fakat yine USE komutu olmadan veya veritabaný seçimi yapýlmadan da bir veritabaný üzerinde iþlem gerçekleþtirebiliyoruz.
Bunun için bilmemiz gereken SCHEMA bilgisidir. SCHEMA veritabanýndaki nesneleri gruplandýrýlmasý için kullanýlýr. C# içerisinde
namespace'e benzetilebilir. Varsayýlan SCHEMA 'dbo' dur. Buna göre örnek olan NORTHWIND veritabanýndaki Catagories tablosu
üzerinde bir sorgu yazmak istiyorsak bunu, "Northwind.dbo.Catagories" yani DatabaseName.Schema.ObjectName modelinde yazabiliriz.
	#GO
		Bu komut ise sorgu içerisinde daha önceden yazýlan sorgularýn iþlerinin bittiðini ve birdaha kullanýlmayacaðýný belirtir.
	Henüz görmedik ama alttaki sorgu ile GO komutunun kullanýmý örneklendirilmiþtir.
*/
declare @number INT; /*Sorgu içerisinde deðiþken oluþturma*/
SELECT @number = 3; /*Sorgu içerisinde oluþturulan bir deðiþkene deðer atama*/
print(@number); /*Ekrana deðer basma*/
go
print(@number); 
/*Görüldüðü üzere artýk number deðiþkeni kullanýlamýyor çünkü, go komutu ile eski sorgularýn iþinin bittiðini belirttik. Fakat
go ve sonrasýnda gelen print komutlarý seçilmeden sorgu çalýþtýrýlýrsa sorgu sorunsuz biçimde çalýþýr.*/

/*
#SELECT SORGUSU
	Veritabanýndan tablo/tablolar üzerinden veri okumak için kullanýlýr. select sorgusundan sonra gelen column isimlerini from
ifadesinden sonra gelen tablo içerisinden arar ve deðerleri ekrana basar. Ayrýca tüm columnlarýn basýlmasý isteniyorsa bunun
için * ifadesi eklenebilir. Fakat dikkat edilmelidir ki çok fazla veri varsa performans etkilenir. Ayrýca MSSQL Managment Studio
içerisinde * ifadesinin üzerinde bir süre durduktan sonra var olan column isimleri gözükecektir. Ayný samanda select sorgusu
ile elde edilen sonuçlarý result sekmesinden tüm deðerleri seçerek veya istenilen deðerleri seçerek CTLR+SHIFT+C kombinine
basarak veya sað týklayýp Copy with Headers seçeneðine basarak excel veye world için tablo biçiminde kopyalama yapýlabilir.
*/
use Northwind;
go
select * from Categories;
/*
#WHERE
	Select sorgusu için belirli þartlar dahilinde sonuçlarýn getirlmesi isteniyorsa kullanýlýr. Select sorgusu normal yapýldýktan
sonra where ifadesi getirilir ve þart/þartlar yazýlýr.
*/
/*Northwind veritabanýnda Products tablosu üzerinde UnitPrice column deðerinin 18'den büyük olanlarý getireceðiz.*/
use Northwind;
go
select * from Products where UnitPrice > 18; /*UnitPrice 18'den büyük ise sonuçlar getirilir.*/
/*
#BETWEEN AND
	Where ifadesi ile birlikte þart/þartlar için iki deðer arasýnda sorgulama gerçekleþtirmek için kullanýlýr. Where ifadesinden
sonra gelen ve kontrol edilmek istenen column isminden sonra BETWEEN ifadesi gelir ve kapalý aralýðýn baþlangýç deðeri verilir.
Daha sonra ise AND ifadesi gelir ve sonrasýndaki kapalý aralýðýn diðer deðeri verilir.
*/
/*Northwind veritabanýnda Products tablosu üzerinde UnitPrice 18 dahil ve 21 dahil aralýðýndaki deðerleri getireceðiz.*/
use Northwind;
go
select * from Products where UnitPrice between 18 and 21; /*Küçük deðer between ifadesinden sonra yazýlýr.*/
/*
#KOÞULDA FONKSÝYON KULLANMA
	Where ifadesinden sonra koþullar için fonksiyonlar kullanabilir ve bu fonksiyonlardan gelen deðerlere göre þart/þartlar
ekleyebiliriz.
*/
use Northwind
go
select E.FirstName+' '+E.LastName as 'Adý Soyadý', E.BirthDate as 'Doðum Tarihi', YEAR(GETDATE()) - YEAR(E.BirthDate) as Yaþý, 
E.Country as 'Doðum Yeri' from Employees E where YEAR(GETDATE()) - YEAR(e.BirthDate) > 65;
/*Yukarýdaki sorguyu sýrayla açýklayalým. öncelikle from ifadesinden sonra gelen tablo isminden sonra E harfi gelmiþtir.
Bunun anlamý bu sorgu içerisinde E görülen yerde Employees tablo ismi vardýr. Yani Employees tablosu için E kýsaltmasýný 
kullandýk. Daha sonra E.FirstName+' '+E.LastName as 'Adý Soyadý' ile yazdýðýmýz kýsýmda, bu tablonun içerisindeki FirsName
column'u ile LastName column'unu + operatörü ile birleþtirdik. Fakat ekstra olarak ' ' ifadesini yani isim ve soyisim arasýnda
boþluk olmasýný da saðladýk. Daha sonra gelen as ifadesi bu column ifadesinin tablo ismini yani üste yazacak ismini belirlemek
için kullanýlýr. Tek týrnak arasýna yazdýk çünkü Adý yazdýktan sonra arada boþluk býrakmak istiyoruz. Bunu AdýSoyadý biçiminde de
yazabilirdik. Daha sonra , ile baþka column getireceðimizi belirtmiþ olduk. Daha sonrasýnda ise YEAR fonksiyonunu kullandýk
bu fonksiyon ile verilen tarih içerisinden yýlý elde edebiliyoruz. Ýçerisinde de GETDATE fonksiyonunu kullandýk. Bu fonksiyon
ile de þuan ki tarihi elde edebiliyoruz. Bunlarý da birbirinden çýkartarak kiþinin yaþýný elde etmiþ olduk ve as ile bu sonucun
baþlýðýný Yaþý olarak belirledik. where ifadesinde de bu yaþý hesaplayýp yaþý 65 den büyükleri elde etmiþ olduk.*/
/*
#DISTINCT
	Select ifadesi ile getirlien column yani verilerin tekrarýnýn önlenmesi için kullanýlýr. Aþaðýdaki örnekte de görüldüðü üzere,
hangi þehirlerden çalýþanlarýn olduðunu tekrarý önleyerek elde ettik.
*/
use Northwind;
go
select distinct City as Þehirler from Employees;
/*
#AND ve OR ifadeleri
	Where ifadesinden sonra gelen þartý/þartlarý ve/veya kapýsýndaki olduðu gibi þleme sokmak için kullanýlýr. Bu sayede birden
fazla þart yazýlabilir ve istenilene göre and veya or seçilebilir. Aþaðýdaki örnekte 1960 doðumlu ve UK doðumlu insanlarýn
bilgileri listelenecektir. Onun altýndaki örnekte ise ürün fiyatý 18 veya 19 olan ürünler listelenecektir. Son örnekte ise birden
fazla between-and ifadesinin de and veya or ile kullanýlabileceði gösterilecektir.
*/
/*1960 yýlýnda Ýngiltere'de doðan çalýþanlarý listeler. Employees tablosu içinde BirthDate ve Country columnlarý kullanýldý.*/
use Northwind;
go
select * from Employees where YEAR(BirthDate) = 1960 and Country = 'UK';
/*Ürün birim fiyatý 18 veya 19 olan ürünleri listeler. Products tablosu içinde UnitPrice columnu kullanýldý.*/
use Northwind
go
select * from Products 
where UnitPrice = 18.00 or UnitPrice = 19;/*virgül özel ifade olduðu için ondalýklý sayýlarda nokta kullanýlýr.*/
/*Between-and ifadesi ile yaþlarý 1930 ile 1960 arasýnda olup iþe girme tarihi 1990 ile 1992 arasýnda olan çalýþanlar.*/
use Northwind
go
select * from Employees where YEAR(BirthDate) between 1930 and 1960 and YEAR(HireDate) between 1990 and 1992;
/*
#IN
	Peki ya çok fazla or iþlemi yazacak olursak? Teker teker yazmamýza gerek yok. Bir column içerisinde birden fazla deðeri aratýp
herhangi biri bulunduðu zaman göstermek için kullanýlýr. in ifadesinden sonra parantezler açýlýr ve virgül ile deðerler ayrýlarak
yazýlýr. Aþaðýdaki örnekte Seattle, Tacoma ve London þehirlerinde doðan çalýþanlar listelenmiþtir.
*/
use Northwind
go
select * from Employees where City in('Seattle', 'London', 'Tacoma')
/*
#LIKE
	Bu ifade column içerisinde benzerlik aramak için kullanýlýr. Programlama dillerinde string içerisinde veya int içerisinde bir
deðer veya ifade aramaya benzetilebilir. Fakat bu ifade özel karakterler ile birlikte kullanýlýrlar. Bu özel karakterler;
		#(_)-> Bir harf veya rakam karakterini ifade eder.
		#([A-Z])-> A ve Z dahil aralýðýndaki harfleri ifade eder.
		#([0-9])-> 0 ve 9 dahil aralýðýndaki rakamlarý ifade eder.
		#([])-> Herhangi bir harf veya rakam yerine gelebilecek harf veya rakamý ifade eder.
		#([^])-> Herhangi bir harf veya rakam yerine gelemeyecek harf veya rakamý ifade eder.
		#(%)-> Birden fazla harf veya rakamý ifade eder.
		#(+)-> String ifadeleri birleþtirir. Sayýsal ifadeleri toplar.
	Yukarda görülen tablodaki sadece % karakterini kullanarak aþaðýda kutulanmýþ ürünleri gösteren bir örnek vardýr. Diðer 
karakterler ile ilgili de örnekler ödev olarak yapýlacaktýr. Bu karakterler birden fazla biçimde kullanýlabilir
ve birleþtirilebilir. Bu yüzden ödev içerisinde bu karakterleri kullanabileceðiniz tüm formatlarda kullanýn. Ayrýca benzerlik
yerine benzemezlik de kullanýlabilir. Bunun için NOT ifadesi like ifadesinin önüne gelebilir. Yani aþaðýdaki örnekte like ifadesi
önüne not gelseydi kutulanmamýþ ürünler gösterilecekti.
*/
use Northwind
go
select ProductName as Ürün, QuantityPerUnit as 'Paket Türü' from Products where QuantityPerUnit like '%box%';
/*
#KARÞILAÞTIRMA OPERATÖRLERÝ
	Verileri where ile birlikte kontrol ederken karþýlaþtýrma operatörleri kullanýlýr. Bu operatörler aþaðýdaki gibidir.
		#(=)-> Eþitlik anlamýna gelir.
		#(!= veya <>)-> Eþit deðil anlamýna gelir.
		#(>, >=, < veya <=)-> Büyük/Küçük veya Büyük Eþit/Küçük Eþit anlamýna gelir.
		#(is null)-> Deðer atanmamýþ anlamýa gelir. (= null) ifadesi ile ayný görevi görür.
	Yukarýdaki tablodaki is null ifadesi ayný zamanda ISNULL fonksiyonu olarak column belirtilen alanlarda eðer null gelirse
geriye dönderilecek deðeri belirtmek için kullanýlýr. Anlaþýlacaðý üzere iki adet parametresi vardýr. Ýlk parametre kontrol
edilecek column, ikinci parametre ise bu columnun null olmasý durumunda dönecek deðerdir. Aþaðýdaki örnekte ise herhangi bir
bögleye ait olmayan þirketler listelenmiþtir.
*/
use Northwind
go
select CompanyName as Þirket, ISNULL(Region, 'Bölge Yok!') as Bölge from Customers where Region is null;
/*
#Order By
	Select sorgusu ile elde edilen veri gurubunu sýralamak için kullanýlýr. Örneðin select sorgusu ile çalýþanlarý aldýðýmýzý ve
bu çalýþanlarý büyükten küçüðe sýralamak istediðimizi varsayalým.
	#asc: Azalandan - Artana sýralama için eklenir.
	#desc: Artandan - Azalana sýralama için eklenir.
*/
use Northwind
go
select E.FirstName + ' ' + E.LastName as 'Adý Soyadý', CONVERT(nvarchar(10), E.BirthDate, 104) as 'Doðum Tarihi' 
from Employees E order by YEAR(E.BirthDate) asc, MONTH(E.BirthDate) asc, DAY(E.BirthDate) asc;
/*
#TOP
	Baþlangýçtan itibaren adet veya yüzde olarak kaç veri gösterileceðini belirlemek için kullanýlýr. Select sorgusunun yanýna
gelerek belirtilir. Örneðin aþaðýda personeller arasýndan en büyük 3 kiþiyi alalým.
*/
use Northwind
go
select top 3 E.FirstName + ' ' + E.LastName as 'Adý Soyadý', CONVERT(nvarchar(10), E.BirthDate, 104) as 'Doðum Tarihi' 
from Employees E order by YEAR(E.BirthDate) asc, MONTH(E.BirthDate) asc, DAY(E.BirthDate) asc;
/*
#Top fonksiyonu için With Ties Parametresi
	Top fonksiyonu ile birlikte kullanýlýr. Listelenen son elemanýn deðeri ile ayný bir deðer var ise onu da listelemeye dahil
eder. Örneðin En az fiyatlý top 12 ürünü listeleyelim ve with ties parametresini de ekleyelim.
*/
use Northwind
go
select top 12 with ties P.ProductName as 'Ürün Ýsmi', P.UnitPrice as 'Birim Fiyatý'
from Products P order by P.UnitPrice asc;
/*Görüldüðü üzere 12 ürün nlistelendi ve 12. ürünün birim fiyatý 10 olduðu için diðer birim fiyatý 10 olan ürünler de ek olarak
listelenmiþtir. Fakat dikkat edilmeksi gereken þey þudur ki order by ile sýralanma yöntemi belirlenmelidir.*/
/*
#DEÐÝÞKENLER - VARIABLES
	Deðiþkenler bilindiði gibi veri tipine göre ram üzerinde veri tutmak ve deðiþken olarak bunlarý kullanmak istediðimiz için
kullanýlýrlar.
	Tanýmlama
		Declare @variable_name variable_type => biçiminde tanýmlama yapýlýr.
	Deðer Atama
		#set: Tek bir deðiþkene deðer atamasý yapmak için kullanýlýr.
		#select: Birden fazla deðiþkene deðer atamasý yapýlabilmektedir.
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
#Tip Dönüþümü
	Tip dönüþümü bir deðiþkenin deðerini farklý veri tiplerinde elde etmek için kullanýlýr. Fakat dikkat edilmesi gereken bir
metini asla tarihe çeviremiyecek olmanýzdýr. Tip dönüþümü için Convert, Try_Convert ve Cast olmak üzere 3 adet yöntem vardýr.
	#return Convert(variable_type, variable_name, format): Görüldüðü üzere 3 adet parametre alýr ve 3. parametre yalnýzca isteðe
	baðlý olarak tarih dönüþümlerinde kullanýlýr. Ýlk parametrede deðiþkenin dönüþtürüleceði veri tipi, ikinci parametrede ise
	deðiþkenin kendisi yer almaktadýr. Çevrilen deðer geriye dönderilir. Tarihler için ise bazý formatlar kullanýlmaktadýr. Örneðin
	Almanya bizim ile ayný yani gün/ay/yýl biçiminde tarih tutar ve bunun kodu 104 olmaktadýr. (Bkz. Microsoft Documents)
	#return Try_Convert(variable_type, variable_name, format): Convert metodundan tek farklý, çevirme iþlemi baþarýlý ise çevrilen
	deðer döner. Çevirme iþlemi baþarýsýz ise geriye null deðeri döner.
	#return cast(variable_name as converting_variable_type): Çevirme iþleminde deðiþkenin stilini/formatýný deðiþtirmeksizin
	veri çevrimi yapar ve geriye dönderir.
	#return hierarchyid::parse('format'): hierarchyid veri tiplerinin çevriminde kullanýlýr.
	#return Try_Parse(variable_name as variable_type using region_format): Eðer çevirme iþlemi baþarýlý ise çevrilen deðeri
	baþarýsýz ise geriye null dönderir. Herhangi bir string deðeri baþka bir deðere çevirmek için kullanýlýr.
*/
/*
#Transact-SQL
	Microsoft tarafýndan (if, else vb.) bazý karmaþýk sorgularda kullanýlmak üzere geliþtirilmiþ, ANSI standartlarý dýþýnda olan
bir sorgulama dilidir. DML, DDL ve DCL olmak üzere 3 grubda incelenebilir.
	#DML(Data Manipulation Language) - Veri Ýþleme Dili
		Select, delete, update ve insert komutlarý bu grubda kullanýlmaktadýr.
	#DDL(Data Definition Language) - Veri Tanýmlama Dili
		Create Table, Alter Table, Drop Table ve Create Index gibi database oluþturma komutlarý bu grubdadýr.
	#DCL(Data Control Language) - Veri Kontrol Dili
		Grant, Deny ve Revoke ile birlikte kullanýcý yetkilerini kontrol etmektedir.
*/

/*
#SQL Server Functions
	1-)Date Functions - Tarih Fonksiyonlarý
		#DATEDIFF(Date Shortcut, start date, finish date) fonksiyonu geriye date shortuct formatýnda tarih dönderir. Çalýþanlarýn
		kaç yaþýnda olduklarýný bulan sorguyu yazalým.
		#GETDATE() parametre almadan geriye yýl/ay/gün formatýnda tarih dönderir.
		#DATEPART(Shortcut, date) parametre olarak verilen tarihi shortuct kýaltmasý formatýnda geriye dönderir.
		#DATEADD(Date to will add shortcut, NumberOfAdd, Date) Date to will add shortcut parametresinde verilen formata yani yýl
		ise yýla göre NumberOfAdd kadar yýl veya ne belirtilir ise son parametredeki tarihe ekler.
		#DATENAME(Shortcut, date) verilen tarihin shortcut ile verilen ay, hafta ile ay ismini veya gün ismini dönderir.
		#DAY(Date) verilen tarihin gününü sayýsal olarak geriye dönderir.
		#MONTH(Date) verilen tarihin ayýný sayýsal olarak geriye dönderir.
		#YEAR(Date) verilen tarihin yýlýný sayýsal olarak dört haneli geriye dönderir.
		#DATEFROMPARTS(Year, Month, Day) Girilen yýl/ay/gün e göre tarih oluþturup geriye dönderir.
		#DATETIMEFROMPARTS(Year, Month, Day, Hour, Minute, Second, Salise, Milisecond) parametrelerinden DateTime elde edilir.
		#SMALLDATETIMEFROMPARTS(Year, Month, Day, Hour, Minute) Parametrelerinden SmallDateTime elde edilir.
		#TIMEFROMPARTS(Hour, Minute, Second, Kesir, Duyarlýlýk) Parametrelerinden Time elde edilir.
		#ISDATE('Date') Paremetre olarak verilen stringin tarih olup olmadýðýn true veya false ile geriye dönderir.
		Araþtýr daha fazlasý var.
*/
/*1-)DATEDIFF()*/
use Northwind
go
select FirstName + ' ' + LastName as 'Adý Soyadý', DATEDIFF(yy, BirthDate, GETDATE()) as Yýl, 
DATEDIFF(mm, BirthDate, GETDATE()) as Ay, DATEDIFF(dd, BirthDate, GETDATE()) as Gün from Employees
order by DATEDIFF(dd, BirthDate, GETDATE()) desc;
/*1-)DATEADD()*/
use Northwind
go
select *, DATEADD(yy, 17, OrderDate) as "17 Yýl Sonra" from Orders;
/*1-)DATENAME()*/
use Northwind
go
set language Turkish; /*Dil ayarýný ayarlama*/
select *, DATENAME(w, GETDATE()) as "Haftanýn Günü Ustam!" from Orders;
/*
#SQL Server Functions
	2-)Aggregate Functions - Kümeleme Fonksyionlarý
	Warning - Uyarý
	* Eðer sorguya, kümeleme yapýlacak sütündan baþka bir sütün daha eklenecek olursa; eklenen bu sütüna göre sorguyu
	gruplamak gerekmektedir.
	* Gruplama iþlemine her sütunun dahil edilmesi gerekmektedir. "Group By" ifadesinde Aggregate Functions kullanýlan sütündan
	baþka her sütun dahil edilmesi gerekmektedir.
	* Aggregate Functions sadece sayýsal veriler ile birlikte çalýþýrlar. Null deðerleri dikkate almazlar.
	* Aggregate Functions kullanýlarak oluþturulan sonuçlarý içeren veriyi, filtreleme yaparken yani "where" ifadesi ile
	kullanamayýz. (Aggregate Functions ile de koþul yazýlabilmektedir. Ýlerde göreceðimiz koþul yapýsý ile where ile deðil!)
	* Sütunlara verilen takma(alias) isimler "Having" ile yapýlamazlar.
		#AVG(Values) Parametre olarak verilen deðerlerin ortalamasýný geriye dönderir.
		#COUNT(Values) Parametre olarak verilen deðerlerin kaç adet olduðunu geriye dönderir.
		#SUM(Values) Parametre olarak verilen deðerlerin toplamýný geriye dönderir.
		#MAX-MIN(Values) Parametre olarak verilen deðerlerden en büyüðünü veya en küçüðünü geriye dönderir.
*/
/*2-)AVG()*/
use Northwind
go
select AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) as 'AKP Kadrosu Yaþ Ortalamasý' from Employees;
/*3-)COUNT()*/
use Northwind
go
select City as Þehirler, COUNT(City) as 'Çalýþan Sayýsý' 
from Employees Group By City Order by COUNT(City) asc;
/*
#SQL Server Functions
	3-)Scalar Functions - Skaler Fonksyionlar
		3.1-)String Functions - Dize Fonksiyonlarý
			#UPPER(String) Ýçerisine verilen metinin tüm harflerini büyüterek geriye dönderir.
			#LOWER(String) Ýçerisine verilen metinin tüm harflerini küçülterek geriye dönderir.
			#SUBSTRING(String text, int PartCount, int StartingPart) Parametre olarak verilen text'in PartCount parametresinde
			verilen deðer kadar; StartingPart parametresinde verilen deðerden baþlayarak alt string geriye dönderir.
			#LEN(String) Parametre olarak verilen string'in uzunluðunu geriye dönderir.
			#ROUND(Double value, var RoundCount) Parametre olarak verilen value deðerini RoundCount kadar yuvarlayarak geriye
			dönderir.
			#ASCII(Char) veya UNICODE(Char) Paremtre olarak verilen karakterin ASCII veya UNICODE kodunu geriye dönderir.
			#CHAR(Code) Parametre olarak verilen karakter kodunu karaktere çevirerek geriye dönderir.
			Araþtýr daha fazlasý var.
			#STR(FloatNumber, FloatNumberCharCount, CutCount) Parametre olarak verilen FloatNumber ondalýklý sayýsýndan CutCount
			kadar soldan karakter kesmek için kullanýlýr. Buradaki FloatNumberCharCount FloatNumber ondalýklý sayýsýnýn karakter
			sayýsýna eþittir.
*/
/*
#HAVING
	Bir sorguda Group By kullanýlmýþ ise where kullanýlamaz. Where yerine having kullanýlýr.
	Warning - Uyarý
		* Eðer sorguda koþul iþlemi, iþlem yapýlan sütunun sonucuna göre olacaksa; Having ifadesinde iþlem yapýlan sütunun takma
		adý kullanýlamaz, iþlem için yazýlan sorgu kodlarý tekrar yazýlýr.
		* Koþul iþemli, iþlem yapýlan sütuna göre deðilse; sütun adý aynen yazýlmalýdýr. Yani Having ifadesi kullanýldýðýnda
		sütunun orijinal adý yazýlmalýdýr.
*/
/*
#SQL Server Functions
	4-)SET STATEMENT - Ýfade Belirleme
		#Set DateFirst value Haftanýn ilk gününü belirlemek için kullanýlýr.
		#Set RowCount value Sorguda kaç satýrýn deðerinin dönderileceðini sýnýrlar. 0 yazarsak sýnýrlama kalkar.
		#Set DateFormat value(DMY bizde) Varsayýlan tarih formatýný deðiþtirmek için kullanýlýr.
		#Set CONCAT_NULL_YIELDS_NULL booleanValue Null ile birleþimin sonucunun Null olmasýný istiyorsak bu ifade on, tersi için
		ise off olmasý gerekir.
		#Set Language Region Dil belirlemek için kullanýlýr.
			Set edilen deðeri @@LANGID ile sayýsal olarak elde edilir. @@LANGUAGE ile de metinsel olarak elde edilir.
		#@@MaxConnection Veri tabanýna baðlantý sayýsýný Dönderir.
		#@@ServerName Server ismi elde etmek için kullanýlýr.
		#@@ServiceName Servis adýný elde etmek için kullanýlýr.
		#@@MicrosoftVersion Microsoft versiyonunun elde etmek için kullanýlýr.
*/

set language Turkish;
select @@LANGUAGE;
/*
#SQL Server Functions
	5-)Defined From User Functions - Kullanýcý Tarafýndan Oluþturulan Fonksiyonlar
		Fonksiyonlar geriye deðer döndürme özelliði olan yapýlardýr. Stored Procedure, sorgu içerisinde kullanýlamazken,
	fonksiyonlar sorgu içerisinde de kullanýlabilir. Geriye bir deðer veya tablo döndürebilirler. View ile saðlanan tablo
	yapýsýndan farklý olarak, parametre alan bir yapýya sahiplerdir.
	Warning - Uyarý
		* Fonksiyonlar Insert, Update, Delete iþlemi yapamazlar fakat Insert, Update, Delete sorgularýnýn içerisinde yer alabilir.
		* Fonksiyon kullanýrken dbo(Schema) belirtilmelidir.
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
#KOÞUL YAPILARI
	1-)Case When Then
		SQL Server'da þartlara baðlý bir kontrol gerçekleþtirmek için bu yapýdan yararlanabiliriz.
		Kullaným
			a-) Eþitlik Kontrolü Yapýlacaksa
				Case <Kontrolü Yapýlacak Veri>
				When <Eþit Olmasý Beklenen Deðer>
				Then <Þart Saðlandýðýnda Yapýlacak Ýþlem>
				End
			b-) Eþitlik Kontrolü Yapýlmayacaksa
				Case When <Kontrolü Yapýlacak Veri> <Kontrol Cümlesi>
				Then <Þart Saðlandýðýnda Yapýlacak Ýþlem>
				End
*/
/*Case When Then Ürün kategorilerinin Türkçe karþýlýklarý ile listelenmesi ve kontrol edilen deðerin eþitlik durumuna bakma*/
use Northwind
go
select CategoryName as 'Ýngiliççe Kategori Ýsmi', Description as 'Açýklama',
case CategoryName
when 'Beverages' then 'Ýçecekler'
when 'Condiments' then 'Bal'
when 'Confections' then 'Þekerlemeler'
when 'Dairy Products' then 'Süt Ürünleri'
when 'Grains/Cereals' then 'Tahýllar'
when 'Meat/Poultry' then 'Et ve Tavuk Ürünleri'
when 'Produce' then 'Ýmalat'
when 'Seafood' then 'Deniz Ürünleri'
else 'Unknown'
end as 'Kategori Ýsmi'
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
#KOÞUL YAPILARI
	2-)IF EXISTS
		Bir tabloda istediðimiz koþulu saðlayan kayýtlarýn var olup olmadýðýný kontrol eder. Tablodo koþulu saðlayan deðer deðer
	varsa true döner.
*/
/*Ürünler tablosunda Chai adlý bir ürün var mý?*/
use Northwind
go
if exists(select * from Products where ProductName = 'Chai')
begin
print('Chai isimli ürün bulunmaktadýr!');
end
else
begin
print('Chai isimli ürün bulunmamaktadýr!');
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
#KOÞUL YAPILARI
	3-)IIF
		Direkt olarak bir koþul, koþul saðlandý ise ve koþul saðlanmadý ise deðerleri alarak iþlem yapar.
		Kullanýmý
			IIF(Logical Expression, then procces, else procces)
*/
/*Kategoriler tablosunda, kategori adý Beverages ise Ýçecekler deðilse Ýçecek deðil yazan sorgu*/
use Northwind
go
select case CategoryName
when 'Beverages' then 'Ýçecekler'
when 'Condiments' then 'Bal'
when 'Confections' then 'Þekerlemeler'
when 'Dairy Products' then 'Süt Ürünleri'
when 'Grains/Cereals' then 'Tahýllar'
when 'Meat/Poultry' then 'Et ve Tavuk Ürünleri'
when 'Produce' then 'Ýmalat'
when 'Seafood' then 'Deniz Ürünleri'
else 'Unknown'
end as 'Kategori Ýsmi', Description as 'Açýklama', IIF(CategoryName = 'Beverages', 'Ýçecekler', 'Ýçecek Deðil') as
'Tür' from Categories
/*
JOIN
	Birden fazla tablodaki iliþkisel verileri sorgularken Join ifadelerinden yararlanýrýz. Birbiri ile iliþkili olan tablolarýn
verileri Join ile birleþtirilerek, tüm verileri bir araya getirebiliriz.
	1-)Inner Join: Join ifadesinde kullanýlan tablolarda, sadece eþleþen kayýtlar listelenir.
	2-)Left Join: Soldaki tablodan tüm kayýtlar listelenir. Saðdaki tablodan ise sadece eþleþen kayýtlar listelenir.
	3-)Right Join: Saðdaki tablodan tüm kayýtlar listelenir. Soldaki kayýttan sadece eþleþen kayýtlar listelenir.
	4-)Outter Join: Her iki tablodan tüm kayýtlar listelenir. Eþleþen kayýtlar yan yana gösterilir. Eþleþmeyen kayýtlar için
	ise sütünlar boþ býraklýr.
	5-)Full Join: Her iki tablodan eþleþen ve eþleþmeyen kayýtlar listelenir. Eþleþmeyen sütünlar boþ býrakýlýr.
*/
/*Inner Join Ürünlerin kategori adlarýna göre listelenmesi*/
use Northwind
go
select case C.CategoryName 
when 'Beverages' then 'Ýçecekler'
when 'Condiments' then 'Bal'
when 'Confections' then 'Þekerlemeler'
when 'Dairy Products' then 'Süt Ürünleri'
when 'Grains/Cereals' then 'Tahýllar'
when 'Meat/Poultry' then 'Et ve Tavuk Ürünleri'
when 'Produce' then 'Ýmalat'
when 'Seafood' then 'Deniz Ürünleri'
else 'Unknown'
end as 'Kategori Ýsmi', P.ProductName as 'Ürün Ýsmi' from Products P Join Categories C 
on P.CategoryID = C.CategoryID;
/*Left Join*/
use Northwind
go
select P.ProductName as 'Ürün Ýsmi', case C.CategoryName 
when 'Beverages' then 'Ýçecekler'
when 'Condiments' then 'Bal'
when 'Confections' then 'Þekerlemeler'
when 'Dairy Products' then 'Süt Ürünleri'
when 'Grains/Cereals' then 'Tahýllar'
when 'Meat/Poultry' then 'Et ve Tavuk Ürünleri'
when 'Produce' then 'Ýmalat'
when 'Seafood' then 'Deniz Ürünleri'
else 'Unknown'
end as 'Kategori Ýsmi' from Products P Left Join Categories C 
on P.CategoryID = C.CategoryID;
/*
Information Schema
	Tablolar için varsayýlan Schema dbo dur.
*/
/*Listing Northwind Database's Tables*/
go
select * from Northwind.INFORMATION_SCHEMA.TABLES order by TABLE_TYPE asc;

/*
Constraint
	Veritabanýna eklenen verilerin tutarlýlýðýný saðlamak üzere, tabloya girilecek verilerin girþini sýnýrlandýran yapýlardýr.
*/

/*Constraint Listesini Sorgulamak*/
use Northwind
go
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS;

/*Getting User Name*/
select SUSER_NAME(1) Kullanýcý1;
select SUSER_NAME(2) Kullanýcý2;
select SUSER_NAME(3) Kullanýcý3;
select SUSER_NAME(4) Kullanýcý4;
select SUSER_NAME(5) Kullanýcý5;
select SUSER_NAME(6) Kullanýcý6;
select SUSER_NAME(7) Kullanýcý7;
select SUSER_NAME(8) Kullanýcý8;
select SUSER_NAME(9) Kullanýcý9;
select SUSER_NAME(10) Kullanýcý10;

/*Getting User Roles*/
use Northwind
go
select * from sys.server_principals where type_desc in('SQL_LOGIN', 'WINDOWS_LOGIN') and name not like 'NT%'

/*Getting SQL Version*/
select name, compatibility_level from sys.databases;

/*DENSE_RANK()*/
/*
Warning - Uyarý
	over ve order by ifadeleri olmadan kullanýlamamaktadýr.
*/
use Northwind
go
select DENSE_RANK() over (order by TitleOfCourtesy) as 'Group Number', TitleOfCourtesy ,FirstName + ' ' + LastName from Employees
