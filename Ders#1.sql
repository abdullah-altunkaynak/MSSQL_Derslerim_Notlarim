/*-Temel Bilgiler-
Database Nedir?
	Veritabanı, verilerin yapılandırılmış bir şekilde depolandığı, yönetildiği ve sorgulandığı bir sistemdir. Geleneksel olarak veresiye defterleri gibi manuel yöntemler kullanılırken, dijitalleşme ile birlikte çeşitli veritabanı yönetim sistemleri (DBMS) geliştirilmiştir.
	İlişkisel Veritabanları (RDBMS): Verileri satır ve sütunlardan oluşan tablolarda saklar. Bu yapı, veri tekrarını azaltır, veri bütünlüğünü sağlar ve verilere kolay erişim imkanı sunar. MSSQL, MySQL, PostgreSQL ve Oracle bu türün popüler örnekleridir.
	NoSQL Veritabanları: Tablo yapısına bağlı kalmayan, esnek veri modelleri sunan veritabanlarıdır. Belge (JSON, XML), anahtar-değer, sütun ailesi veya graf gibi farklı veri modellerini desteklerler. Özellikle büyük veri (Big Data) ve gerçek zamanlı uygulamalarda tercih edilirler. MongoDB, Cassandra, Redis ve Neo4j popüler NoSQL veritabanlarıdır.
	Bulut Veritabanları (Cloud Databases): Amazon Web Services (AWS), Microsoft Azure ve Google Cloud gibi bulut platformları üzerinde çalışan, ölçeklenebilirlik, esneklik ve yönetilen hizmet avantajları sunan veritabanlarıdır. Örnek olarak Azure SQL Database, Amazon RDS ve Google Cloud SQL verilebilir.
MSSQL (Microsoft SQL Server)
	Microsoft tarafından geliştirilen, kurumsal düzeyde özellikler ve gelişmiş lisanslama seçenekleri sunan bir ilişkisel veritabanı yönetim sistemidir (RDBMS). .NET, Java, Python gibi birçok programlama dili üzerinden erişilebilir ve yönetilebilir. Veritabanı, tablolardan; tablolar ise sütunlardan (kolon) oluşur. Her sütunun bir adı, veri tipi, ve boş geçilip geçilemeyeceğini (nullable) belirten bir özelliği bulunur. SQL Server, son sürümleriyle (SQL Server 2019, 2022 ve Azure SQL) JSON veri desteği, makine öğrenmesi servisleri ve büyük veri kümeleri gibi modern yetenekler de kazanmıştır.
SQL Sorgulama Dili
	Açılımı "Structured Query Language" yani "Yapılandırılmış Sorgulama Dili" olan SQL, veritabanından veri eklemek, silmek, güncellemek, sorgulamak, tablo ve diğer veritabanı nesnelerini oluşturmak gibi işlemleri gerçekleştirmemizi sağlayan standart bir dildir. Microsoft SQL Server, T-SQL (Transact-SQL) adında, standart SQL'e ek olarak prosedürel programlama, yerel değişkenler ve ek fonksiyonlar içeren bir lehçe kullanır. Oracle ise PL/SQL adında kendi SQL lehçesini kullanır.
SQL SERVER
	Microsoft tarafından geliştirilmiş bir veritabanı sunucu yazılımıdır. Varsayılan olarak 1433 numaralı TCP portunu dinleyerek yerel veya uzak ağlardan gelen veritabanı bağlantı isteklerini kabul eder ve yönetir.
DATABASE ÇÖZÜMLERİ
	Veritabanı çözümleri temel olarak OLTP (Online Transaction Processing) ve OLAP (Online Analytical Processing) olmak üzere ikiye ayrılır.
	#OLTP (Çevrimiçi İşlemsel Veri İşleme)
		Kullanıcıların sık sık veri eklediği, sildiği veya güncellediği, kısa ve hızlı işlemlerin ön planda olduğu sistemlerdir. E-ticaret siteleri, bankacılık uygulamaları gibi sistemler OLTP'ye örnektir. Çok sayıda kullanıcıya eş zamanlı işlem desteği sunar.
	#OLAP (Çevrimiçi Analitik Veri İşleme)
		Büyük miktardaki veriler üzerinde analiz yapmak, raporlar oluşturmak ve iş zekası (Business Intelligence) amaçlı kurulan sistemlerdir. Veri ambarları (Data Warehouse) bu tür sistemlere örnektir. Genellikle okuma yoğun çalışırlar.
SERVER TYPE (SQL Server Servisleri)
	#Database Engine (Veritabanı Motoru)
		İlişkisel veritabanları oluşturmayı, verileri güvenli bir şekilde depolamayı ve yönetmeyi sağlayan temel servistir. SQL Server'ın kalbidir.
	#Analysis Services (SSAS)
		OLAP ve veri madenciliği çözümleri sunar. Büyük veri kümelerini hızlı bir şekilde analiz etmek ve iş zekası raporları için küpler (cubes) oluşturmak amacıyla kullanılır.
	#Reporting Services (SSRS)
		SQL Server için kapsamlı bir raporlama platformu sunar. Kullanıma hazır araçlarla kolay ve hızlı bir şekilde statik veya interaktif raporlar oluşturulmasını sağlar.
	#Integration Services (SSIS)
		Farklı veri kaynakları arasında veri taşıma, dönüştürme ve yükleme (ETL - Extract, Transform, Load) işlemlerini otomatikleştirmek için kullanılan bir servistir.
	#Extended Events (Genişletilmiş Olaylar)
		SQL Server üzerinde gerçekleşen olayları izlemek ve performans sorunlarını teşhis etmek için kullanılan modern ve hafif bir sistemdir. Eski bir araç olan SQL Profiler'ın yerini almıştır.
SYSTEM DATABASE (Sistem Veritabanları)
	SQL Server kurulumunda, sistemin çalışması için gerekli olan Master, Model, TempDb ve Msdb adında 4 adet sistem veritabanı otomatik olarak oluşturulur.
	#Master: SQL Server'ın kullanıcı hesapları, sunucu yapılandırmaları, veritabanı bilgileri gibi tüm sistem düzeyindeki meta verilerini barındırır. Bu veritabanı olmadan SQL Server çalışamaz.
	#Model: Yeni oluşturulacak tüm kullanıcı veritabanları için bir şablon görevi görür. Bir veritabanı oluşturulduğunda, Model veritabanının bir kopyası alınır.
	#TempDb: Geçici tablolar, geçici değişkenler, sıralama (sorting) ve birleştirme (joining) gibi işlemler için kullanılan geçici verilerin tutulduğu yerdir. SQL Server her yeniden başlatıldığında sıfırlanır.
	#Msdb: SQL Server Agent servisinin kullandığı veritabanıdır. Zamanlanmış görevler (jobs), uyarılar (alerts), yedekleme ve geri yükleme geçmişi gibi bilgileri saklar.
NORMALIZATION RULES (Normalizasyon Kuralları)
	Veritabanı tasarımında performansı artırmak, veri tekrarını önlemek ve veri bütünlüğünü sağlamak için uygulanan bir dizi kuraldır.
	#: Tablolarda tekrarlanan veri gruplarından kaçınılmalıdır. Her bir hücre atomik (bölünemez) bir değer içermelidir (1. Normal Form - 1NF).
	#: Birincil anahtara (Primary Key) tam olarak bağımlı olmayan sütunlar ayrı bir tabloda tutulmalıdır (2. Normal Form - 2NF).
	#: Anahtar olmayan bir sütun, başka bir anahtar olmayan sütuna bağlı olmamalıdır (3. Normal Form - 3NF).
	#: Erişim için kilit pozisyonda bulunan ve veriyi benzersiz şekilde tanımlayan sütun(lar) Primary Key olarak tanımlanmalıdır. Eğer doğal bir anahtar yoksa, genellikle 'ID' gibi otomatik artan bir sayısal sütun Primary Key olarak kullanılır.
	#: Anahtar olmayan bir sütun ile başka bir anahtar olmayan sütun arasında doğrudan bir ilişki kurulmamalıdır. İlişkiler genellikle Primary Key ve Foreign Key üzerinden kurulur.
	ÖRNEK 1 BAŞLIĞI İLE SORGU KODLARI VERİLMİŞ OLUP VERİTABANI DersOrnekleri İÇERİSİNDEKİ Ornek1Diagram 
*/

															/*ÖRNEK 1 START*/
/*
	start - end arasındaki komutlar çalıştırılınca görülecek olan Süleyman UZUN isimli kişinin birden fazla maili olduğu için
Süleyman UZUN kişisinin İsim, Soyisim ve Doğum Tarihi verilerinin tekrarladığıdır. Dolayısıyla Normalizasyon Kurallarına 
uymayan bir tablo mantığıdır. Daha sonraki start - end arasındaki komutlar çalıştırılınca verilerin tekrar etmediği ve gerekli
komutlar ile Süleyman UZUN kişisinin maillerine ulaşabilmekteyiz.
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
	Görüldüğü üzere bir adet kişiler tablosu oluşturarak ve bu tablonun içine isim soyisim bilgilerinin yanı sıra mail adresi
bilgisini de eklediğimiz zaman verilerin tekrarlanması gibi bir sorun ile karşılaşıyoruz. Bunun sebebi ise bir kişinin birden
fazla mail adresine sahip olabilmesidir. Ayrıca bir mail adresi birden fazla kişiye ait olabilmesi mümkün değildir. Burada 1'e çok
ilişki vardır. Bu yüzden kişiler tablosunu oluşturup bir column'a primary key verip daha sonra mailler tablosu içerisinde 
UserID column ile bağladık ve bu sayede tekrar eden verilerden kurtulduk. Yukardaki örnek sorguyu Türkçe olarak okursak
"Mailler tablosundan tüm columnları eğer UserID columnu DogruNormalizasyonKisiler tablosundaki name ve surname columları süleyman
ve uzun olan kişinin ID si ile uyumluysa göster." şeklinde okunur.
*/
															/*ÖRNEK 1 END*/
/*
İLİŞKİSEL VERİ TABANI
	Söylediğimiz gibi veritabanının daha performanslı olması ve verilerin tekrarının önlenmesi için ilişkilere ihtiyaç duyarız.
İlişkiler Bire->Bir, Bire->Çok ve Çoka->Çok olmak üzere üçe ayrılır.
	Bire->Bir (1-1) İlişki
		Örneğin, bir kişinin T.C. Kimlik Numarası ile detaylı kimlik bilgileri arasında bire-bir ilişki vardır. Her kişinin sadece bir kimlik detayı olur.
	Bire->Çok (1-N) İlişki
		Bunu açıklamaya en iyi örnek yukardaki `DogruNormalizasyonKisiler` tablosu ile `Mailler` tablosu arasındaki ilişkidir. Bir kişi birden fazla maile sahip olabilir, ancak bir mail adresi sadece bir kişiye aittir.
	Çoka->Çok (N-N) İlişki
		Şarkılar ve sanatçılar verilerini tutmak istediğimizi düşünürsek; bir şarkıyı birden fazla sanatçı seslendirebilir ve bir
	sanatçı da birden fazla şarkıyı seslendirebilir. Anlaşılacağı üzere bu da n->n yani çoka çok bir ilişkidir. Bu tür ilişkilerde
	yapılması en uygun adım ise Şarkılar ve Sanatçılar tablosuna ek olarak `SanatciSarki` gibi bir ara tablo (junction table) oluşturarak, bu
	tablo üzerinde Şarkılar ve Sanatçılar tablolarının Primary Key'lerine Foreign Key ilişkisi kurmaktır.
*/

/*
PRIMARY KEY (Birincil Anahtar)
	Bir tablodaki her bir satırı benzersiz (unique) olarak tanımlayan bir veya daha fazla sütundan oluşan bir kısıtlayıcıdır (constraint).
Tekrar eden değerlere izin vermez ve `NULL` değer alamaz. Tablodaki diğer verilere hızlı erişim için birincil anahtar kullanılır.
	#Her tabloda mutlaka bir adet Primary Key olmalıdır.
	#Primary Key olarak belirtilen sütunlar `NULL` (boş) değer alamaz.
	#SQL Server Management Studio'da (SSMS) bir sütunu Primary Key yapmak için; tablo tasarım (design) ekranında ilgili sütuna sağ tıklayıp 'Set Primary Key' seçeneği kullanılır.
	#Otomatik artan bir Primary Key oluşturmak için, sütunun `Identity Specification` özelliği `(Is Identity) = Yes` olarak ayarlanır. Bu sayede her yeni kayıtta anahtar değeri otomatik olarak artar.
*/

/*
COMPOSITE KEY (Bileşik Anahtar)
	Bir tablodaki bir satırı benzersiz olarak tanımlamak için birden fazla sütunun birlikte kullanılmasıyla oluşturulan Primary Key'e Composite Key denir.
	Örneğin, bir öğrencinin bir dersten alacağı vize ve final notlarını tutan bir `Notlar` tablosu düşünelim. Bu tabloda bir öğrenci bir dersten sadece bir vize notu alabilir. Bu durumu garantilemek için `OgrenciID` ve `DersID` sütunları birlikte Primary Key (Composite Key) olarak tanımlanabilir. Bu sayede (15, 101) gibi bir öğrenci-ders ikilisi tabloya sadece bir kez eklenebilir.
*/

/*
FOREIGN KEY (Yabancı Anahtar)
	Bir tablodaki sütunun, başka bir tablonun Primary Key'i ile ilişkilendirilmesini sağlayan bir anahtardır. Bu sayede iki tablo arasında referans bütünlüğü (referential integrity) sağlanır. Örneğin, `Siparisler` tablosundaki `MusteriID` sütunu, `Musteriler` tablosunun Primary Key'ine bir Foreign Key olarak bağlanabilir. Bu, var olmayan bir müşteriye sipariş girilmesini engeller.
*/

/*
UNIQUE CONSTRAINT (Benzersiz Kısıtlayıcı)
	Primary Key olmayan bir sütuna veya sütun grubuna girilecek verilerin tekrar etmemesini, yani benzersiz olmasını sağlar. Primary Key'den farkı, bir tabloda birden fazla `UNIQUE` kısıtlayıcısı olabilir ve `UNIQUE` kısıtlayıcılı bir sütun (sadece bir tane olmak kaydıyla) `NULL` değer alabilir. Örneğin, `Kullanicilar` tablosunda `Email` sütunu `UNIQUE` olarak tanımlanabilir.
*/

/*
CHECK CONSTRAINT (Kontrol Kısıtlayıcısı)
	Bir sütuna girilecek verinin belirli bir koşulu sağlamasını zorunlu kılan bir kısıtlayıcıdır. Örneğin, bir `Urunler` tablosundaki `BirimFiyat` sütununun 0'dan büyük olması gerektiğini `(BirimFiyat > 0)` gibi bir `CHECK` kısıtlayıcısı ile garanti edebiliriz. Veya bir `Personel` tablosundaki `IseGirisTarihi`'nin `DogumTarihi`'nden sonra olması gerektiğini kontrol edebiliriz.
*/

/*
DEFAULT CONSTRAINT (Varsayılan Değer Kısıtlayıcısı)
	Bir sütuna veri girişi yapılmadığı zaman, o sütuna varsayılan (default) bir değer atanmasını sağlar. Örneğin, `Siparisler` tablosunda `SiparisTarihi` sütununa bir değer girilmezse, varsayılan olarak o anki tarihin (`GETDATE()` veya `SYSDATETIME()`) atanmasını sağlayabiliriz.
*/

/*
SORGU YAZMAK
	SQL Server Management Studio (SSMS) veya Azure Data Studio gibi bir araçta yeni bir sorgu penceresi açmak için genellikle `CTRL+N` kısayolu veya menüdeki 'New Query' butonu kullanılır.
	Sorguyu çalıştırmadan önce, hangi veritabanı üzerinde çalışacağınızı belirtmeniz gerekir. Bunu yapmanın birkaç yolu vardır:
	1. Editördeki veritabanı seçim kutusundan (Dropdown) ilgili veritabanını seçmek.
	2. Sorgu dosyasının en başına `USE [VeritabaniAdi];` komutunu eklemek.
	#USE
		Bu komut, takip eden sorguların belirtilen veritabanı bağlamında (context) çalıştırılmasını sağlar. Bu sayede o veritabanındaki tablolara doğrudan isimleriyle erişilebilir.

	Bir veritabanı seçimi yapmadan da başka bir veritabanındaki nesneye erişmek mümkündür. Bunun için `[VeritabaniAdi].[SchemaAdi].[NesneAdi]` şeklinde tam nitelikli (fully qualified) bir isimlendirme kullanılır.
	SCHEMA: Veritabanı içerisindeki nesneleri (tablolar, view'lar, prosedürler vb.) mantıksal olarak gruplandırmak için kullanılan bir yapıdır. C# dilindeki `namespace` veya klasörler gibi düşünülebilir. SQL Server'da varsayılan schema `dbo`'dur (database owner). Örneğin: `Northwind.dbo.Categories`.
	#GO
		Bu komut, bir T-SQL kod bloğunun (batch) sonunu belirtir ve SQL Server'a o bloğu çalıştırması için bir sinyal gönderir. `GO` bir T-SQL komutu değildir, SSMS gibi araçların anladığı bir ayraçtır. Özellikle değişkenlerin kapsamını (scope) yönetmek veya birden fazla DDL işlemini ayırmak için kullanılır.
*/
declare @number INT; /*Sorgu içerisinde değişken oluşturma*/
SELECT @number = 3; /*Sorgu içerisinde oluşturulan bir değişkene değer atama*/
print(@number); /*Ekrana değer basma*/
go
-- GO komutundan sonra @number değişkeni kapsam dışı kalır ve artık erişilemez.
-- Bu satır hata verecektir: "Must declare the scalar variable "@number"."
-- print(@number); 
/*
#SELECT SORGUSU
	Veritabanındaki bir veya daha fazla tablodan veri okumak (sorgulamak) için kullanılır. `SELECT` ifadesinden sonra getirilmek istenen sütun isimleri, `FROM` ifadesinden sonra ise bu sütunların bulunduğu tablo adı belirtilir.
	Tüm sütunları getirmek için `*` karakteri kullanılır. Ancak bu, özellikle geniş tablolarda performansı olumsuz etkileyebilir. En iyi pratik, sadece ihtiyaç duyulan sütunları belirtmektir.
	SSMS'te, sorgu sonuçlarını (result grid) seçip `CTRL+C` ile kopyaladığınızda veriler panoya kopyalanır. `Sağ tık -> Copy with Headers` seçeneği ile sütun başlıklarıyla birlikte kopyalayarak Excel gibi uygulamalara kolayca yapıştırabilirsiniz.
*/
use Northwind;
go
select CategoryID, CategoryName, Description from Categories;
/*
#WHERE
	`SELECT` sorgusuna bir koşul ekleyerek sadece belirli kriterlere uyan satırların getirilmesini sağlar. `FROM` ifadesinden sonra kullanılır.
*/
/*Northwind veritabanında Products tablosu üzerinde UnitPrice sütun değerinin 18'den büyük olanları getireceğiz.*/
use Northwind;
go
select ProductName, UnitPrice from Products where UnitPrice > 18; /*UnitPrice 18'den büyük ise sonuçlar getirilir.*/
/*
#BETWEEN AND
	`WHERE` koşulunda bir sütunun değerinin belirli bir aralıkta (başlangıç ve bitiş değerleri dahil) olup olmadığını kontrol etmek için kullanılır.
*/
/*Northwind veritabanında Products tablosu üzerinde UnitPrice 18 dahil ve 21 dahil aralığındaki değerleri getireceğiz.*/
use Northwind;
go
select ProductName, UnitPrice from Products where UnitPrice between 18 and 21; /*Küçük değer between'den sonra yazılır.*/
/*
#KOŞULDA FONKSİYON KULLANMA
	`WHERE` ifadesinde, sütun değerlerini bir fonksiyondan geçirerek elde edilen sonuca göre filtreleme yapılabilir.
*/
use Northwind
go
select 
    E.FirstName + ' ' + E.LastName as 'Adı Soyadı', 
    E.BirthDate as 'Doğum Tarihi', 
    YEAR(GETDATE()) - YEAR(E.BirthDate) as Yaşı, 
    E.Country as 'Ülke' 
from 
    Employees E 
where 
    YEAR(GETDATE()) - YEAR(E.BirthDate) > 65;
/*
Yukarıdaki sorguyu açıklayalım:
- `from Employees E`: `Employees` tablosuna bu sorgu içinde `E` takma adını (alias) veriyoruz. Bu, sorguyu daha okunaklı hale getirir.
- `E.FirstName + ' ' + E.LastName as 'Adı Soyadı'`: `FirstName` ve `LastName` sütunlarını bir boşlukla birleştirip, oluşan yeni sütuna `as` anahtar kelimesiyle 'Adı Soyadı' ismini veriyoruz.
- `YEAR(GETDATE()) - YEAR(E.BirthDate) as Yaşı`: `GETDATE()` fonksiyonu o anki tarihi, `YEAR()` fonksiyonu ise bir tarihin yıl kısmını verir. Bu iki değeri çıkararak kişinin yaşını hesaplıyor ve bu sütuna `Yaşı` adını veriyoruz.
- `where YEAR(GETDATE()) - YEAR(E.BirthDate) > 65`: `where` koşulunda yine aynı yaş hesaplamasını yaparak, yaşı 65'ten büyük olan çalışanları filtreliyoruz.
*/
/*
#DISTINCT
	`SELECT` ifadesinden sonra kullanıldığında, sorgu sonucunda tekrar eden satırların elenmesini ve sadece benzersiz (farklı) satırların getirilmesini sağlar.
*/
use Northwind;
go
select distinct City as Şehirler from Employees;
/*
#AND ve OR ifadeleri
	`WHERE` koşulunda birden fazla koşulu birleştirmek için kullanılır.
	- `AND`: Her iki koşulun da doğru (true) olması durumunda sonuç döner.
	- `OR`: Koşullardan en az birinin doğru (true) olması durumunda sonuç döner.
*/
/*1960 yılında İngiltere'de (UK) doğan çalışanları listeler.*/
use Northwind;
go
select * from Employees where YEAR(BirthDate) = 1960 and Country = 'UK';

/*Ürün birim fiyatı 18 veya 19 olan ürünleri listeler.*/
use Northwind
go
select * from Products 
where UnitPrice = 18.00 or UnitPrice = 19.00; /*Ondalıklı sayılarda nokta kullanılır.*/

/*Doğum yılı 1950 ile 1960 arasında olan VE işe giriş yılı 1992 ile 1994 arasında olan çalışanlar.*/
use Northwind
go
select * from Employees where YEAR(BirthDate) between 1950 and 1960 and YEAR(HireDate) between 1992 and 1994;
/*
#IN
	`WHERE` koşulunda bir sütunun değerinin, verilen listedeki değerlerden herhangi birine eşit olup olmadığını kontrol eder. Çok sayıda `OR` koşulu yazmak yerine kullanılır.
*/
use Northwind
go
select * from Employees where City in ('Seattle', 'London', 'Tacoma');
/*
#LIKE
	`WHERE` koşulunda metinsel (string) veriler içinde desen (pattern) araması yapmak için kullanılır. `LIKE` ile birlikte bazı özel karakterler (wildcards) kullanılır:
		# `%`: Sıfır, bir veya daha fazla karakteri temsil eder.
			- `'A%'`: 'A' ile başlayanlar.
			- `'%A'`: 'A' ile bitenler.
			- `'%A%'`: İçinde 'A' geçenler.
		# `_` (alt çizgi): Tek bir karakteri temsil eder.
			- `'_A%'`: İkinci harfi 'A' olanlar.
		# `[]`: Belirtilen aralık veya setteki tek bir karakteri temsil eder.
			- `'[A-C]%'`: A, B veya C ile başlayanlar.
			- `'[ABC]%'`: A, B veya C ile başlayanlar.
		# `[^]`: Belirtilen aralık veya sette OLMAYAN tek bir karakteri temsil eder.
			- `'[^A-C]%'`: A, B veya C ile başlamayanlar.
	`NOT LIKE` ifadesi ise belirtilen desene uymayan kayıtları getirir.
*/
/*Paketleme bilgisinde 'box' kelimesi geçen ürünleri listeler.*/
use Northwind
go
select ProductName as Ürün, QuantityPerUnit as 'Paket Türü' from Products where QuantityPerUnit like '%box%';
/*
#KARŞILAŞTIRMA OPERATÖRLERİ
	`WHERE` koşulunda kullanılan temel operatörlerdir:
		# `=`: Eşittir
		# `!=` veya `<>`: Eşit değildir
		# `>`: Büyüktür
		# `<`: Küçüktür
		# `>=`: Büyük eşittir
		# `<=`: Küçük eşittir
		# `IS NULL`: Değerin `NULL` (boş) olup olmadığını kontrol eder. (`= NULL` KULLANILMAZ!)
		# `IS NOT NULL`: Değerin `NULL` olmadığını kontrol eder.
	`ISNULL()` bir fonksiyon olup, bir sütun `NULL` ise onun yerine başka bir değer döndürmek için kullanılır. `ISNULL(Region, 'Bölge Yok')` ifadesi, `Region` sütunu `NULL` ise 'Bölge Yok!' metnini, değilse `Region` değerini döndürür.
*/
/*Region (Bölge) bilgisi girilmemiş (NULL) olan müşterileri listeler.*/
use Northwind
go
select CompanyName as Şirket, ISNULL(Region, 'Bölge Yok!') as Bölge from Customers where Region is null;
/*
#ORDER BY
	`SELECT` sorgusu ile elde edilen sonuç kümesini bir veya daha fazla sütuna göre sıralamak için kullanılır. Varsayılan sıralama türü artandır (`ASC`).
	# `ASC` (Ascending): Artan sıralama (A'dan Z'ye, 0'dan 9'a).
	# `DESC` (Descending): Azalan sıralama (Z'den A'ya, 9'dan 0'a).
*/
/*Çalışanları doğum tarihlerine göre (en gençten en yaşlıya) sıralar.*/
use Northwind
go
select 
    E.FirstName + ' ' + E.LastName as 'Adı Soyadı', 
    CONVERT(nvarchar(10), E.BirthDate, 104) as 'Doğum Tarihi' -- 104 formatı: dd.mm.yyyy
from 
    Employees E 
order by 
    E.BirthDate DESC;
/*
#TOP
	Sorgu sonucunda dönecek satır sayısını sınırlamak için `SELECT` ifadesinden hemen sonra kullanılır. Genellikle `ORDER BY` ile birlikte kullanılarak "en iyi N" veya "en kötü N" sonuçları elde edilir.
*/
/*En yaşlı 3 çalışanı listeler.*/
use Northwind
go
select top 3
    E.FirstName + ' ' + E.LastName as 'Adı Soyadı', 
    CONVERT(nvarchar(10), E.BirthDate, 104) as 'Doğum Tarihi' 
from 
    Employees E 
order by 
    E.BirthDate ASC; -- ASC: en eski tarihler (en yaşlılar) önce gelir.
/*
#TOP ... WITH TIES
	`TOP` ile birlikte kullanıldığında, `ORDER BY` kriterine göre son sıradaki satırla aynı değere sahip olan diğer satırları da sonuca dahil eder.
*/
/*En ucuz 12 ürünü listeler. Eğer 12. ürünle aynı fiyatta başka ürünler varsa, onları da listeye ekler.*/
use Northwind
go
select top 12 with ties 
    P.ProductName as 'Ürün İsmi', 
    P.UnitPrice as 'Birim Fiyatı'
from 
    Products P 
order by 
    P.UnitPrice asc;
/*
#DEĞİŞKENLER (VARIABLES)
	T-SQL sorguları içinde geçici olarak veri saklamak için kullanılan nesnelerdir. `@` işareti ile başlarlar.
	Tanımlama:
		`DECLARE @degisken_adi VERI_TIPI;`
	Değer Atama:
		# `SET @degisken_adi = deger;` (Tek bir değişkene değer atamak için standart yöntem)
		# `SELECT @degisken_adi = deger;` (Birden fazla değişkene aynı anda veya bir sorgu sonucundan değer atamak için kullanılabilir)
*/
go
Declare @sample_variable nvarchar(50);
Declare @sample_variable_2 nvarchar(50);
set @sample_variable = 'Bu bir test değişkenidir';
select @sample_variable_2 = 'Bu ikinci değişkendir';
select @sample_variable as 'degisken1', @sample_variable_2 as 'degisken2';
go
/*
#Tip Dönüşümü (Data Type Conversion)
	Bir veri tipindeki değeri başka bir veri tipine dönüştürmek için kullanılır.
	# `CAST(ifade AS veri_tipi)`: ANSI SQL standardı olan temel dönüşüm fonksiyonudur. Formatlama seçeneği yoktur.
	# `CONVERT(veri_tipi, ifade, [stil])`: SQL Server'a özgü, daha esnek bir fonksiyondur. Özellikle tarih ve para birimi formatlamaları için `stil` parametresi alır.
	# `TRY_CAST` ve `TRY_CONVERT`: Dönüşüm işlemi başarısız olursa hata vermek yerine `NULL` değeri döndüren daha güvenli versiyonlardır.
	# `PARSE(ifade AS veri_tipi [USING kültür])`: Metinsel bir ifadeyi tarih veya sayısal bir tipe dönüştürür. Kültür (örn: 'tr-TR') belirterek bölgesel formatlara göre dönüşüm yapabilir.
	# `TRY_PARSE`: `PARSE`'ın `NULL` döndüren güvenli versiyonudur.
*/
/*
#Transact-SQL (T-SQL)
	Microsoft'un, standart SQL'e ek olarak `IF-ELSE`, `WHILE` gibi kontrol yapıları, değişkenler, hata yönetimi gibi prosedürel programlama yetenekleri ekleyerek genişlettiği SQL lehçesidir. T-SQL komutları üç ana gruba ayrılır:
	#DML (Data Manipulation Language) - Veri İşleme Dili
		Veriler üzerinde işlem yapan komutlardır: `SELECT`, `INSERT`, `UPDATE`, `DELETE`.
	#DDL (Data Definition Language) - Veri Tanımlama Dili
		Veritabanı nesnelerini (tablo, index, view vb.) oluşturan, değiştiren veya silen komutlardır: `CREATE`, `ALTER`, `DROP`.
	#DCL (Data Control Language) - Veri Kontrol Dili
		Veritabanı erişimini ve kullanıcı yetkilerini yöneten komutlardır: `GRANT`, `DENY`, `REVOKE`.
*/

/*
#SQL Server Fonksiyonları
	1-)Tarih ve Saat Fonksiyonları (Date and Time Functions)
		# `SYSDATETIME()`: Sunucunun tarih ve saatini daha yüksek hassasiyetle döndürür. `GETDATE()`'e göre daha modern bir alternatiftir.
		# `DATEDIFF(tarih_parçası, başlangıç_tarihi, bitiş_tarihi)`: İki tarih arasındaki farkı belirtilen tarih parçası (yıl, ay, gün vb.) cinsinden döndürür.
		# `DATEADD(tarih_parçası, sayı, tarih)`: Bir tarihe belirtilen tarih parçası kadar ekleme veya çıkarma yapar.
		# `DATEPART(tarih_parçası, tarih)`: Bir tarihin belirtilen parçasını (yıl, ay, gün vb.) tamsayı olarak döndürür.
		# `DATENAME(tarih_parçası, tarih)`: Bir tarihin belirtilen parçasının adını (örn: 'Nisan', 'Pazartesi') metinsel olarak döndürür.
		# `YEAR(tarih)`, `MONTH(tarih)`, `DAY(tarih)`: Tarihin sırasıyla yıl, ay ve gününü tamsayı olarak döndürür.
		# `DATEFROMPARTS(yıl, ay, gün)`: Verilen tamsayı değerlerinden bir tarih oluşturur.
		# `ISDATE('ifade')`: Verilen ifadenin geçerli bir tarih olup olmadığını kontrol eder (1 veya 0 döner).
*/
/*1-)DATEDIFF() ile çalışanların yaşını, kaç aydır ve kaç gündür hayatta olduklarını bulma*/
use Northwind
go
select 
    FirstName + ' ' + LastName as 'Adı Soyadı', 
    DATEDIFF(YEAR, BirthDate, SYSDATETIME()) as Yıl, 
    DATEDIFF(MONTH, BirthDate, SYSDATETIME()) as Ay, 
    DATEDIFF(DAY, BirthDate, SYSDATETIME()) as Gün 
from Employees
order by Gün desc;

/*1-)DATEADD() ile sipariş tarihine 10 gün ekleme*/
use Northwind
go
select OrderDate, DATEADD(DAY, 10, OrderDate) as "Teslim Tarihi" from Orders;

/*1-)DATENAME() ile haftanın gününü Türkçe olarak alma*/
use Northwind
go
set language Turkish; /*Oturumun dilini Türkçe yapar*/
select OrderDate, DATENAME(WEEKDAY, OrderDate) as "Sipariş Günü" from Orders;
/*
#SQL Server Fonksiyonları
	2-)Kümeleme Fonksiyonları (Aggregate Functions)
	Bir grup satır üzerinde hesaplama yaparak tek bir özet değer döndüren fonksiyonlardır. `GROUP BY` ifadesi ile birlikte kullanılırlar.
	* `GROUP BY` kullanıldığında, `SELECT` listesinde ya bir kümeleme fonksiyonu içinde yer almayan her sütun `GROUP BY` listesinde de yer almalıdır.
	* Kümeleme fonksiyonları `NULL` değerleri dikkate almazlar (`COUNT(*)` hariç).
	* Kümeleme fonksiyonları ile oluşturulan sonuçları filtrelemek için `WHERE` değil, `HAVING` kullanılır.
		# `AVG(sütun)`: Sayısal bir sütundaki değerlerin ortalamasını döndürür.
		# `COUNT(sütun)`: Bir sütundaki `NULL` olmayan satırların sayısını döndürür. `COUNT(*)` ise tablodaki tüm satırların sayısını verir.
		# `SUM(sütun)`: Sayısal bir sütundaki değerlerin toplamını döndürür.
		# `MAX(sütun)` ve `MIN(sütun)`: Bir sütundaki en büyük ve en küçük değeri döndürür.
*/
/*Çalışanların yaş ortalaması*/
use Northwind
go
select AVG(DATEDIFF(YEAR, BirthDate, SYSDATETIME())) as 'Yaş Ortalaması' from Employees;

/*Her şehirdeki çalışan sayısını bulma ve sayıyı göre sıralama*/
use Northwind
go
select City as Şehir, COUNT(*) as 'Çalışan Sayısı' 
from Employees 
Group By City 
Order by 'Çalışan Sayısı' desc;
/*
#SQL Server Fonksiyonları
	3-)Metinsel Fonksiyonlar (String Functions)
		# `UPPER(metin)` ve `LOWER(metin)`: Metni tamamen büyük veya küçük harfe çevirir.
		# `SUBSTRING(metin, başlangıç, uzunluk)`: Metnin belirtilen pozisyonundan başlayarak belirtilen uzunlukta bir parçasını alır.
		# `LEN(metin)`: Metnin karakter uzunluğunu döndürür (sondaki boşluklar hariç).
		# `DATALENGTH(metin)`: Metnin byte cinsinden uzunluğunu döndürür (Unicode karakterler 2 byte yer kaplar).
		# `LEFT(metin, sayı)` ve `RIGHT(metin, sayı)`: Metnin solundan veya sağından belirtilen sayıda karakter alır.
		# `CHARINDEX(aranan, metin, [başlangıç])`: Bir metin içinde başka bir metnin başlangıç pozisyonunu arar.
		# `REPLACE(metin, eski_değer, yeni_değer)`: Metin içindeki bir karakter dizisini başka birisiyle değiştirir.
		# `TRIM(metin)`, `LTRIM(metin)`, `RTRIM(metin)`: Metnin başındaki, sonundaki veya her iki tarafındaki boşlukları temizler.
		# `CONCAT(metin1, metin2, ...)`: Birden fazla metni birleştirir. `+` operatöründen farkı, `NULL` bir değerle birleşince sonucu `NULL` yapmaz, `NULL`'ı boş metin gibi kabul eder.
		# `STRING_SPLIT(metin, ayraç)`: Bir metni belirtilen ayraca göre bölerek tek sütunlu bir tablo olarak döndürür. (SQL Server 2016 ve sonrası)
*/
/*
#HAVING
	`GROUP BY` ile gruplanmış veriler üzerinde filtreleme yapmak için kullanılır. `WHERE` ifadesi gruplama yapılmadan önce satırları filtrelerken, `HAVING` gruplama yapıldıktan sonra grupları filtreler. Bu nedenle `HAVING` içinde kümeleme fonksiyonları kullanılabilir.
*/
/*Her bir kategorideki ürün sayısını bulan ve sadece ürün sayısı 10'dan fazla olan kategorileri listeleyen sorgu.*/
use Northwind
go
select 
    C.CategoryName, 
    COUNT(P.ProductID) as 'Ürün Sayısı'
from 
    Products P
join 
    Categories C on P.CategoryID = C.CategoryID
group by 
    C.CategoryName
having 
    COUNT(P.ProductID) > 10;
/*
#SQL Server Fonksiyonları
	4-)SET İfadeleri ve Sistem Fonksiyonları
		# `SET DATEFIRST [1-7]`: Haftanın ilk gününü belirler (1: Pazartesi, 7: Pazar).
		# `SET LANGUAGE [dil]`: Oturum için dil ayarını değiştirir. Hata mesajları ve tarih formatları bu ayara göre şekillenir.
		# `@@ROWCOUNT`: Son çalıştırılan ifadeden etkilenen satır sayısını döndürür.
		# `@@ERROR`: Son çalıştırılan T-SQL ifadesinde bir hata oluştuysa hata numarasını, oluşmadıysa 0 değerini döndürür.
		# `@@IDENTITY`: Bir `INSERT` ifadesiyle en son oluşturulan identity (otomatik artan) değerini döndürür.
		# `@@SERVERNAME`: Sunucunun adını döndürür.
		# `@@VERSION`: SQL Server sürüm bilgilerini döndürür.
*/

set language Turkish;
select @@LANGUAGE as 'Oturum Dili';
/*
#SQL Server Fonksiyonları
	5-)Kullanıcı Tanımlı Fonksiyonlar (User-Defined Functions - UDF)
		Belirli bir işi yapmak üzere oluşturulan ve bir değer veya bir tablo döndürebilen yeniden kullanılabilir kod bloklarıdır.
		- **Skaler Fonksiyonlar (Scalar Functions):** Tek bir değer (int, nvarchar, money vb.) döndürürler.
		- **Tablo Değerli Fonksiyonlar (Table-Valued Functions):** Geriye bir tablo döndürürler.
	Uyarılar:
		* Fonksiyonlar içinde `INSERT`, `UPDATE`, `DELETE` gibi veri değiştirme işlemleri yapılamaz (yan etkiye (side effect) izin verilmez).
		* Fonksiyonları çağırırken genellikle schema adıyla (`dbo.`) birlikte çağırmak en iyi pratiktir.
*/
/*Skaler Fonksiyon Tanımlama: KDV'li fiyat hesaplama*/
use Northwind
go
Create Function dbo.Calculate_KDV
(
    @price money, 
    @kdvRate float
)
returns money
as
Begin
    return @price * (1 + @kdvRate);
End
go
Declare @kdvRate float = 0.18;
select 
    OrderID as ID, 
    UnitPrice as 'KDV Hariç Fiyat', 
    dbo.Calculate_KDV(UnitPrice, @kdvRate) as 'KDV Dahil Fiyat' 
from [Order Details];

/*Tablo Değerli Fonksiyon Tanımlama: Şirket adına göre müşteri listeleme*/
use Northwind
go
Create Function dbo.ListCustomersByCompanyName
(
    @CompanyName NVARCHAR(40)
)
returns Table
as
return (select * from Customers where CompanyName like '%' + @CompanyName + '%');
go
select * from dbo.ListCustomersByCompanyName('Alfreds');
/*
#KOŞUL YAPILARI
	1-)CASE ... WHEN ... THEN ... END
		Farklı koşullara göre farklı sonuçlar döndürmek için kullanılır. `SELECT` listesinde veya `ORDER BY` ifadesinde sıkça kullanılır.
		Kullanım:
			a-) Basit CASE (Eşitlik Kontrolü):
				CASE <Kontrol Edilecek Sütun>
					WHEN <Değer1> THEN <Sonuç1>
					WHEN <Değer2> THEN <Sonuç2>
					ELSE <Diğer Durumlar İçin Sonuç>
				END
			b-) Aranan CASE (Karmaşık Koşullar):
				CASE
					WHEN <Koşul1> THEN <Sonuç1>
					WHEN <Koşul2> THEN <Sonuç2>
					ELSE <Diğer Durumlar İçin Sonuç>
				END
*/
/*Ürün kategorilerinin Türkçe karşılıkları ile listelenmesi*/
use Northwind
go
select 
    CategoryName as 'İngilizce Kategori İsmi', 
    case CategoryName
        when 'Beverages' then 'İçecekler'
        when 'Condiments' then 'Çeşniler'
        when 'Confections' then 'Şekerlemeler'
        when 'Dairy Products' then 'Süt Ürünleri'
        when 'Grains/Cereals' then 'Tahıllar'
        when 'Meat/Poultry' then 'Et ve Kümes Hayvanları'
        when 'Produce' then 'Meyve & Sebze'
        when 'Seafood' then 'Deniz Ürünleri'
        else 'Bilinmiyor'
    end as 'Kategori İsmi'
from Categories;
/*
#KOŞUL YAPILARI
	2-)IF ... ELSE
		Bir koşulun sonucuna göre farklı T-SQL kod bloklarını çalıştırmak için kullanılır. `BEGIN` ve `END` blokları ile birden fazla komut gruplanabilir.
		`IF EXISTS (sorgu)` yapısı, bir alt sorgunun en az bir satır döndürüp döndürmediğini kontrol etmek için sıkça kullanılır.
*/
/*Ürünler tablosunda 'Chai' adlı bir ürün var mı?*/
use Northwind
go
if exists(select 1 from Products where ProductName = 'Chai')
begin
    print 'Chai isimli ürün bulunmaktadır!';
end
else
begin
    print 'Chai isimli ürün bulunmamaktadır!';
end
/*
#KOŞUL YAPILARI
	3-)IIF (Immediate IF)
		`CASE` ifadesinin daha kısa bir versiyonudur. Bir mantıksal ifadenin sonucuna göre iki değerden birini döndürür.
		Kullanımı: `IIF(koşul, doğruysa_dönecek_değer, yanlışsa_dönecek_değer)`
*/
/*Kategori adı 'Beverages' ise 'İçecek', değilse 'Diğer' yazan sorgu*/
use Northwind
go
select 
    CategoryName, 
    IIF(CategoryName = 'Beverages', 'İçecek', 'Diğer') as 'Tür' 
from Categories;
/*
JOIN
	İki veya daha fazla tabloyu, aralarındaki ilişkili sütunlar üzerinden birleştirerek tek bir sonuç kümesi oluşturmak için kullanılır.
	1-)INNER JOIN (veya sadece JOIN): Her iki tabloda da eşleşen kayıtları getirir.
	2-)LEFT JOIN (veya LEFT OUTER JOIN): Soldaki tablodan tüm kayıtları, sağdaki tablodan ise sadece eşleşen kayıtları getirir. Eşleşme olmayanlar için sağdaki tablonun sütunları `NULL` olur.
	3-)RIGHT JOIN (veya RIGHT OUTER JOIN): Sağdaki tablodan tüm kayıtları, soldaki tablodan ise sadece eşleşen kayıtları getirir. Eşleşme olmayanlar için soldaki tablonun sütunları `NULL` olur.
	4-)FULL OUTER JOIN: Her iki tablodaki tüm kayıtları getirir. Eşleşenleri yan yana, eşleşmeyenleri ise diğer taraf `NULL` olacak şekilde gösterir.
	5-)CROSS JOIN: İki tablonun kartezyen çarpımını oluşturur. Yani, soldaki tablonun her bir satırını sağdaki tablonun her bir satırıyla eşleştirir. Genellikle bir `ON` koşulu kullanılmaz.
*/
/*INNER JOIN: Ürünleri kategori adlarıyla birlikte listeleme*/
use Northwind
go
select 
    P.ProductName as 'Ürün İsmi',
    C.CategoryName as 'Kategori İsmi'
from 
    Products P 
inner join 
    Categories C on P.CategoryID = C.CategoryID;

/*LEFT JOIN: Hiç siparişi olmayan müşterileri bulma*/
use Northwind
go
select 
    C.CustomerID,
    C.CompanyName
from 
    Customers C
left join 
    Orders O on C.CustomerID = O.CustomerID
where
    O.OrderID is null; -- Siparişi olmayanlar (eşleşme olmayanlar)
/*
Information Schema Views
	Bir veritabanındaki meta verileri (tablolar, sütunlar, kısıtlayıcılar vb. hakkında bilgiler) sorgulamak için kullanılan standart bir view setidir.
*/
/*Northwind veritabanındaki tüm kullanıcı tablolarını listeleme*/
go
select TABLE_NAME, TABLE_TYPE from Northwind.INFORMATION_SCHEMA.TABLES where TABLE_TYPE = 'BASE TABLE';

/*Bir tablonun tüm kısıtlayıcılarını (constraints) listeleme*/
use Northwind
go
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where TABLE_NAME = 'Orders';

/*
Pencereleme Fonksiyonları (Window Functions)
	`OVER()` ifadesi ile birlikte kullanılan, mevcut satırla ilişkili bir dizi satır (pencere) üzerinde hesaplama yapan fonksiyonlardır. Kümeleme fonksiyonlarından farkı, satırları tek bir satıra indirgemezler, her satır için bir sonuç üretirler.
	`DENSE_RANK()`, `RANK()`, `ROW_NUMBER()`, `NTILE()` gibi sıralama fonksiyonları ve `LEAD()`, `LAG()` gibi kaydırma fonksiyonları bu gruba girer.
*/
/*DENSE_RANK(): Çalışanları unvanlarına göre gruplayıp her gruba bir sıra numarası verir. Aynı unvanlar aynı numarayı alır ve arada boşluk olmaz.*/
use Northwind
go
select 
    DENSE_RANK() over (order by TitleOfCourtesy) as 'Grup Numarası', 
    TitleOfCourtesy,
    FirstName + ' ' + LastName as 'Adı Soyadı'
from Employees;
