begin /*12.Ünite DML INSERT, UPDATE, DELETE*/
select '12.Ünite';

begin /*Design Mode - Dizayn Modu*/
select 'Design Mode'
/*Description - Açıklama
	Dizayn modu Tablolar üzerinde yapısal değişiklikler ve veri değişiklikleri yapmamıza olanak sağlar. Bazen sorgu yazmak yerine
küçük işlemler için tablo ismine sağ tıklayarak Design Mode açılabilmektedir.
*/
end

begin /*DML Insert*/
select 'DML Insert'
/* Description - Açıklama
	Bir tabloya veri eklemek için kullanılan bir sorgu türüdür.
*/

/* How to Use This Command? - Bu Komut Nasıl Kullanılır?
Insert INTO TableName(RowName, OtherRowName, ...)
Values(ValueForRowName, ValueForOtherRowName, ...), (If you want to insert more than one data)
*/

/* Example Of Insert Command: Adding Data to Categories Table - Kategoriler Tablosuna Veri Girme */
use Northwind
Insert into Categories(CategoryName, Description)
values('NewVariable1', 'Testing Insert into Command!');
select * from Categories;

/* Conditioned Insert Command - Şarta Bağlı Insert Komutu 
	Belirli şartlar sağlanması dahilinde tabloya veri eklmek istenirse kullanılır.
*/

/* Example Of Conditioned Insert Command: Eklenecek olan kategori hali hazırda tabloda yoksa veri eklenecek.*/
declare @CategoryNameVariable nvarchar(15) = 'NewVariable2';
declare @DescriptionText nvarchar(30) = 'Testing Insert into Command!';
if not exists(select CategoryName from Categories where CategoryName = @CategoryNameVariable)
Insert into Categories(CategoryName, Description)
values(@CategoryNameVariable, @DescriptionText);
else
select 'This category already exists!' as 'Error!', * from Categories where CategoryName = @CategoryNameVariable; 

/* Table Backuping with Insert Command - Insert Komutu ile Tablo Yedekleme 
	SQL Server'da bir işlem yaparken özellikle UPDATE veya DELETE komutları ile yanlış bir sorgu ile verilerimizi riske
atabiliriz. Bu gibi durumlarda hızlıca tablodaki verileri yedeklemek isteyebiliriz. Bunun için Insert into komutu kullanılabilir.
Warning - Uyarı
	Bu yedekleme işleminde tüm özellikler yedeklenmez. Sadece veriler yedeklenmektedir.

 * How to Use This Method? - Bu Yöntem Nasıl Kullanılır?
Insert * into BackupTableName from BackupingTableName;
*/

/* Bulk Insert - Toplu Insert 
	Bir komut ile birçok veriyi aynı anda ekleyebilmek için kullanılan bir yöntemdir. Pratikte Bulk Insert yöntemini, bir tablodan
diğer tabloya veri aktarmak için kullanabiliriz.
*/

/* How to Use This Method? - Bu Komut Nasıl Kullanılır? 
Insert into BackupTableName(ColumnName, OtherColumnName)(select ColumnName, OtherColumnName from BackupingTableName)
*/

end

begin /*DML Update*/
select 'DML Update'
/* Description - Açıklama
	Tabloda daha önceden var olan bir veriyi güncellemek için kullanılır. Bu komutu kullanırken dikkat edilmesi gereken en önemli
şey where komutudur. Çünkü where komutu ile şart yazmadan güncelleme yaparsak tüm tablo etkileneceğinden ötürü verilerimiz riske
girecektir.
*/

/* How to Use This Command? - Bu Komut Nasıl Kullanılır?
update TableName set (UpdatingRowName = newValue, ...) where Conditions
*/

/* Example Of Update Command: Updating Data from Categories Table - Categories Tablosundan Veri Güncelleme */
use Northwind
update Categories set CategoryName = 'NewVariable3', Description = 'Testing Update Command!' 
where CategoryName = 'NewVariable2';
select * from Categories;

end

begin /*DML Delete*/
select 'DML Delete'
/* Description - Açıklama
	Tablodaki verileri silmek için kullanılır. Burada da update sorgusunda olduğu gibi where ifadesi kritik bir öneme sahiptir.
Aksi halde tüm verilerimiz silinebilir.
Warning - Uyarı
	Delete sorgusu ile tablodan silinen column'ların Identity özelliği var olan bir satır için(örneğin Primary Key CategoryID)
Identity değeri kaldığı yerden devam edecktir. Örn; son eklenen verinin CategoryID'si 9 olsun. Bu veri silindikten sonra yeni
eklenen verinin CategoryID'si 10 olacaktır. 9 değil!

BEST PRACTICE - 2026 Güncellemesi:
	- DELETE işlemi öncesi harici bir WHERE koşulu testi yapın
	- Büyük silme işlemleri için DELETE yerine Archive tablo yapısı düşünün
	- DELETE yerine soft delete (flag tabanlı) yaklaşım daha güvenlidir
	- Önemli işlemlerde Transaction ile sarmalayın (BEGIN TRANSACTION/ROLLBACK)
	- Foreign Key constraints kontrol edin - cascade silme riski
*/

/* How to Use This Command? - Bu Komut Nasıl Kullanılır?
delete from TableName where Conditions
*/

/* Example with Safety Check - Güvenli Delete Örneği */
use Northwind
-- İlk önce silinecek verileri kontrol et
select * from Categories where CategoryID = 9;
-- Eminse sil
delete from Categories where CategoryID = 9;
select * from Categories;

/* Example Of Delete Command: Deleting Data from Categories Table - Categories Tablosundan Veri Silme*/
use Northwind
Delete from Categories where CategoryID = 9;
select * from Categories;

begin /*Truncate Command*/
select 'Truncate Command'
/* Description - Açıklama
	Bir tablodan tüm verileri silmek ve Identity değerlerini sıfırlamak için kullanılır.
*/

/* How to Use This Command? - Bu Komut Nasıl Kullanılır.
Truncate Table TableName;
*/

end

begin /*Transaction Control - İşlem Kontrolü (2026 Güncellemesi)*/
select 'Transaction Control'
/* Description - Açıklama
	Transaction bir veya birden fazla SQL işlemini lojik bir birim olarak yönetir. BEGIN TRANSACTION ile başlatılır,
COMMIT ile yapılır, ROLLBACK ile geri alınır. DML işlemlerinin veri bütünlüğünü korumak için KRITIK öneme sahiptir.
	
Properties - Özellikler:
	- Atomicity (Bütünlük): İşlem tamamen yapılır veya hiç yapılmaz
	- Consistency (Tutarlılık): Veri tutarlılığı korunur
	- Isolation (İzolasyon): İşlemler birbirini etkilemez
	- Durability (Dayanıklılık): Tamamlanan işlem kalıcı olur (ACID)
*/

/* Example Of Transaction - Transaction Örneği */
use Northwind
Begin Transaction
	Begin Try
		Insert into Categories(CategoryName, Description) 
		values('Test Category', 'Testing Transaction');
		Update Categories Set CategoryName = 'Updated Category' 
		where CategoryName = 'Test Category';
		Commit Transaction
		select 'Transaction Başarılı' as Mesaj
	End Try
	Begin Catch
		Rollback Transaction
		select 'Hata oluştu, işlem geri alındı: ' + ERROR_MESSAGE() as HataMesaji
	End Catch

end

begin /*Error Handling - Hata Yönetimi (2026 Güncellemesi)*/
select 'Error Handling - TRY-CATCH'
/* Description - Açıklama
	TRY-CATCH bloğu verileri yönetirken oluşabilecek hataları kontrol etmeyi sağlar. BEGIN TRY'de kodunuz çalışır,
hata oluşursa BEGIN CATCH'e atlar. ERROR_MESSAGE(), ERROR_NUMBER(), ERROR_LINE() ile hata detaylarını alabilirsiniz.
	
Properties - Özellikler:
	- Error handling Production kodda ZORUNLUDUR
	- Hataların detaylı loglanmasını sağlar
	- Uygulamanın çökmesini önler
	- Database integrity'i korur
*/

/* Example Of TRY-CATCH */
use Northwind
Begin Try
	Declare @CategoryID int = 999;
	Select * from Categories where CategoryID = @CategoryID;
	
	-- Hata yaratacak işlem
	Update Categories Set CategoryID = null where CategoryID = 1;
End Try
Begin Catch
	Select 
		ERROR_NUMBER() as HataNumarası,
		ERROR_MESSAGE() as HataMesaji,
		ERROR_LINE() as HataSatırı,
		ERROR_PROCEDURE() as HataYapıldığıProcedure
End Catch

/* Real-World Pattern - Gerçek Dünya Örneği */
use Northwind
Begin Transaction
	Begin Try
		-- Tüm silme işlemi transactional olarak yapılır
		Delete from Categories where CategoryID = 10;
		Delete from Employees where EmployeeID = 1;
		Commit Transaction
		select 'Tüm işlemler başarılı' as Sonuç
	End Try
	Begin Catch
		Rollback Transaction
		select 'HATA! Hiçbir işlem yapılmadı: ' + ERROR_MESSAGE() as HataBilgisi
	End Catch

end

/* Delete Duplicate Data Method - Tekrar Eden Verileri Silme Metodu
	Bazı durumlarda bir tabloya insert komutu ile veya Edit Top 200 Rows seçeneği ile tabloda bulunan bir veriyi ekleyebiliriz.
örn; bir kullanıcı hali hazırda varken onun var olduğunu bilmeden ekleme yapabiliriz. Bu durumlarda bu yöntem kullanılır.
*/

/* Example Of Duplicate Data Method: Adding Duplicate Data to Categories and Deleting This Duplicate Data - Categories Tablosuna
Tekrar Eden Veriler Girilmesi ve Bu Tekrar Eden Verilerin Silinmesi */
use Northwind
Insert into Categories(CategoryName, Description)
Values('NewVariable3', 'Testing Update Command!'), ('NewVariable3', 'Testing Update Command!')
Delete from Categories where Not CategoryID
In(
	select Min(CategoryID) as MinumumID from Categories C Group By CategoryName
)
select * from Categories;

begin /*Modern Duplicate Deletion Method - CTE ve ROW_NUMBER ile (2026 Güncellemesi)*/
select 'Modern Duplicate Deletion with CTE and Window Functions'
/* Description - Açıklama
	CTE (Common Table Expression) ile define ettiğimiz sorguyu daha okunabilir ve yönetilebilir hale getirebiliriz.
ROW_NUMBER() window function ise tekrar eden kayıtları sıralamada çok etkilidir. Bu kombinasyon duplicate silme işini
jamodern ve anlaşılır kılar.
*/

/* Modern Example - Daha Temiz ve Performanslı */
use Northwind
Begin Try
	-- Böyle ekleyelim (test için)
	Insert into Categories(CategoryName, Description)
	Values('DuplicateTest', 'Version1'), ('DuplicateTest', 'Version2'), ('DuplicateTest', 'Version3');
	
	-- CTE ile düzgün şekilde silelim
	;With DuplicateCTE as (
		Select 
			CategoryID,
			ROW_NUMBER() Over (Partition By CategoryName Order By CategoryID) as RowNum
		From Categories
	)
	Delete from DuplicateCTE 
	Where RowNum > 1;
	
	select 'Duplicate silme başarılı' as Mesaj
	select * from Categories where CategoryName = 'DuplicateTest';
End Try
Begin Catch
	select 'Hata: ' + ERROR_MESSAGE() as HataMesaji
End Catch

end

end
go

begin /*15.Ünite View ve Tablo Görünümleri*/
select '13.Ünite'
/* Description - Açıklama
	Bir veya birden fazla tablodan, ihtiyaç duyulan verileri almamıza yarayan sanal tablolardır. Normal şartlarda bir tablo sadece
kendi verilerini tutabilirken, view birçok tablonun verilerini tutabilmektedir. View de tablolar gibi satır ve sütunlardan 
oluşur.
*/

/* View Properties - View Özellikleri
	# Sanal Tablolar gibi düşünülebilir.
	# View içerikleri sorgulanabilmektedir.
	# View üzerinden DML işlemleri yapılabilir.
	# View üzerinden yapılan DML işlemleri direkt olarak tablolara yansıtılır.
	# View tablo/tablolara bağlı olarak çalışır. Böylece veri bütünlüğü korunmuş olur.
	# View ile tabloların veri erişimini sınırlandırabiliriz.
	# Karmaşık sorgu sonuçlarına ulaşmak için view tablo olarak kullanılabilir.
	# View ile tablo arasında ilişkisel bütünlük yoksa, view veri girişini reddeder.
	# View veri saklamaz. Tablodan veya birçok tablodan yapılan sorgular neticesinde tabloya bağlı olarak çalışır.
	# View tabloya bağlı çalıştığı için bağlı olduğu tablo silinir ise view hiçbir şey görüntülemez.
	# View ile paramtre kullanılamaz. Yani; koşul ifadesinde SQL Parametrelerini kullanamayız.
	# View ile view üzerinden parametre alabilen bir sorgu yazmak mümkündür. Bunun için SQL Procedure kullanılır.
	# View için index tanımlamak da mümkündür.
*/

/* How to Use This Object? - Bu Nesne Nasıl Kullanılır?
create View ViewName as Select Columns from TableName (where if you have condition) 
*/

/* Example Of Create View */
use Northwind
Execute('Create View CatView as select * from Categories');
select * from dbo.CatView;
/* Create view komutu sorgudaki ilk ve son komut olması gereklidir. Yani temiz bir sql sorgusu veya Execute metodu ile 
çalıştırılmalıdır. Ya da go ifadesi ile biri create ifadesinin üstüne diğeri ise create ifadesinin altına olmak üzere temiz
bir sql sorgusu elde edilebilir. Dolayısıyla create view ifadesi çalışacaktır.*/

/* Example Of Alter View */
use Northwind
/*
Warning - Uyarı
	Order By ifadesi create/alter view işlemindeki select sorgusunda direkt olarak kullanılamamaktadır. TOP, OFFSET gibi ifadeler
ile birlikte kullanılabilir. Ayrıca view select sorgusunda da kullanılabilmektedir.
*/
Execute('Create View CatView as (select top (select Count(*) from Employees) * from Employees order by City)'); /*View güncelleme*/
select * from dbo.CatView;

/* Example Of Drop View */
Drop View dbo.CatView;

use Northwind;
Insert into CatView(CategoryName, Description)
Values('NewVariable3', 'Testing Update Command!');
Update CatView set CategoryName = 'NewVariable1', Description = 'Testing Update Command on View!'
where CategoryName = 'NewVariable3';
select COUNT(*) from Categories;

/* View Control with 'With Check Option' - 'With Check Option' ile View Kontrolü
	Bir View oluşurken where ifadesi ile belirtilen koşul dahilinde oluşan View o veri listesini içerir. Sonuç olarak şarta göre
View oluşturabiliriz. Fakat extra olarak Create View ifadesinin en alt kısmına With Check Option ifadesini eklememiz gerekmektedir.
*/

/* Example Of With Check Option */
use Northwind;
select * from CatView;
select * from Products;
Execute('Alter View [dbo].[CatView] as (select * from Products P where P.CategoryID =
(select CategoryID from Categories where CategoryName = ''Condiments'' )) With Check Option');
select * from CatView;
begin /*Indexed Views - View Performance Optimization (2026 Güncellemesi)*/
select 'Indexed Views - Materialized Views'
/* Description - Açıklama
	Normal bir view sanal tablo gibi davranırken, indexed view gerçekten fiziksel veriler tutar (materialized).
Çok sık sorgulanacak complex view'ler için Index oluşturarak performance'ı dramatik olarak artırabiliriz.

Requirements - Şartlar:
	- Enterprise veya Developer edition SQL Server
	- View deterministic olmalı (aynı inputta aynı output)
	- AVG, MIN, MAX, COUNT(*) gibi aggregate functions doğru şekilde handle edilmeli
	- Schema binding kullanılmalı
*/

/* Example Of Indexed View */
use Northwind
Begin Try
	-- Önce schema binding ile view oluştur
	Execute ('Create View vwCategoriesWithProducts
	With SchemaBinding as
	Select 
		C.CategoryID,
		C.CategoryName,
		Count_Big(*) as ProductCount,
		Sum(IsNull(P.UnitsInStock, 0)) as TotalStock
	From dbo.Categories C
	Left Join dbo.Products P on C.CategoryID = P.CategoryID
	Group By C.CategoryID, C.CategoryName');
	
	-- Üzerine Unique Clustered Index oluştur
	Create Unique Clustered Index IX_vwCategoriesWithProducts 
	On vwCategoriesWithProducts(CategoryID);
	
	select 'Indexed View oluşturuldu' as Mesaj
End Try
Begin Catch
	select 'Indexed View oluşturma hatası: ' + ERROR_MESSAGE() as Hata
End Catch

end

end
go

begin /*JSON Support in SQL Server (2026 Güncellemesi)*/
select '15.5 Ünite - JSON Functions'
/* Description - Açıklama
	SQL Server 2016+ JSON desteği ile ilişkisel verileri JSON formatında sorgulayabilir ve JSON'u relational veri olarak
kullanabiliriz. Modern REST API'ler ve web uygulamaları için çok yararlıdır.
*/

/* Example: JSON Path Expression */
use Northwind
Declare @jsonData nvarchar(max) = '
{
	"employee": {
		"id": 1,
		"name": "Abdullah",
		"salary": 5000,
		"skills": ["SQL", "C#", "Azure"]
	}
}'

Select 
	JSON_VALUE(@jsonData, '$.employee.id') as EmployeeID,
	JSON_VALUE(@jsonData, '$.employee.name') as EmployeeName,
	JSON_VALUE(@jsonData, '$.employee.salary') as Salary,
	JSON_QUERY(@jsonData, '$.employee.skills') as Skills

/* Example: Converting Table to JSON */
use Northwind
Select Top 5
	EmployeeID,
	FirstName,
	LastName,
	Title
From Employees
For JSON Path
end
go

begin /*16. Ünite Tables For DDL*/
select '16. Ünite'
/* Description - Açıklama
	Bir tablo oluşturmak için Object Explorer sekmesi üzerinden mouse ile veri eklenebileceği gibi DDL ismini verdiğimiz T-SQL
komutları ile de tablo oluşturabiliriz. DDL ile Create Table diyerek tablo oluşturabilir, Alter Table diyerek güncelleyebilir,
Drop Table diyerek tabloyu kaldırabilir ve Create Index diyerek tabloda index oluşturabiliriz.
*/

/* Example Of Create Table */
use Northwind;
set DateFormat DMY;
Create Table TestUserTable(
	[ID] int Primary Key Identity(1, 1),
	[UserName] nvarchar(50) Not Null,
	[UserSurname] nvarchar(50) Not Null,
	[BirthDate] date Null Default(Convert(date, '14.06.1999', 104)),
	[TC] varchar(11) Not Null Unique,
	[Sex] bit Not Null,
	Constraint ck_BirthDateTestUser Check(BirthDate <= GetDate() and BirthDate >= Convert(date, '01.01.1900', 104)),
	Constraint ck_TC Check(TC Like '[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][02468]'),
	/*Foreign Key
	IfThisIsAForeignKey int Not Null Foreign Key References Products(ProductID) */
);

Insert into TestUserTable(UserName, UserSurname, BirthDate, TC, Sex)
Values
	('Abdullah', 'ALTUNKAYNAK', null, '111', 1),
	('Hakan', 'ÇELEBİ', '26.08.2000', '222', 1),
	('Halil Emre', 'BALABAN', '04.06.2001', '333', 1),
	('Furkan', 'YAVUZASLAN', '26.02.2001', '444', 1),
	('Eslem Nisa', 'TÜRK', '01.05.2015', '555', 0),
	('Zeynep Yaren', 'ALTUNKAYNAK', '22.01.2014', '666', 0);

select UserName İsim, UserSurname Soyisim, BirthDate 'Doğum Tarihi', TC, 
case Sex 
when 0 then 'Kadın'
when 1 then 'Erkek'
end 'Cinsiyet'
from TestUserTable

/*Alter Table TestUserTable
Add Constraint ck_test Check(ConstraintText)
Add Foreign Key (Sex) references Products(ProductID),
Alter Column Sex nvarchar(5),
Drop Column Sex
Add NewColumn int Not Null
Drop Constraint ck_test;*/

/*Drop Table TestUserTable;*/

begin /*Advanced Table Features - İleri Tablo Özellikleri (2026 Güncellemesi)*/
select 'Advanced Table Design'

/* Computed Columns - Hesaplanmış Sütunlar */
use Northwind
Begin Try
	Create Table AdvancedUserTable(
		[ID] int Primary Key Identity(1, 1),
		[FirstName] nvarchar(50) Not Null,
		[LastName] nvarchar(50) Not Null,
		[FullName] as (FirstName + ' ' + LastName) Persisted, -- Persisted = Fiziksel olarak depolanır
		[BirthDate] date Not Null,
		[Age] as (DATEDIFF(Year, BirthDate, GetDate())), -- Her sorgulandığında hesaplanır
		[CreatedDate] datetime Default GetDate(),
		[UpdatedDate] datetime Default GetDate()
	);
	
	Insert into AdvancedUserTable(FirstName, LastName, BirthDate)
	Values('Abdullah', 'Altunkaynak', '1999-06-14');
	
	Select * from AdvancedUserTable;
End Try
Begin Catch
	select 'Hata: ' + ERROR_MESSAGE() as Mesaj
End Catch

/* DEFAULT Constraints - Modern Best Practices */
use Northwind
Begin Try
	Create Table OrderLog(
		LogID int Primary Key Identity(1, 1),
		OrderID int Not Null,
		OrderDate date Default GetDate(), -- Tarih otomatik ayarlanır
		IsProcessed bit Default 0, -- Boolean default false
		ProcessedAt datetime Null,
		LogMessage nvarchar(max) Not Null,
		CreatedAt datetime Default GetDate()
	);
	
	Insert into OrderLog(OrderID, LogMessage) 
	Values(1, 'Order başlatıldı');
	
	Select * from OrderLog;
End Try
Begin Catch
	select 'Hata: ' + ERROR_MESSAGE() as Mesaj
End Catch

/* CHECK Constraint - Veri Doğrulaması */
-- Örnek: Salary'nin pozitif olmasını zorunlu kıl
/*
Create Table Employee_Advanced(
	EmployeeID int Primary Key,
	EmployeeName nvarchar(50),
	Salary decimal(10,2),
	Constraint ck_SalaryPositive Check(Salary > 0),
	Constraint ck_SalaryMax Check(Salary <= 1000000)
);
*/

/* UNIQUE Constraint with Filtered Index - 2026 Best Practice */
-- Null hariç tutulan UNIQUE constraint
/*
Create Table User_Email(
	UserID int Primary Key,
	Email nvarchar(100),
	Constraint UQ_Email_NotNull Unique (Email) Where Email is Not Null
);
*/

/* NULL Handling Best Practices */
use Northwind
Begin Try
	Create Table SmartNullHandling(
		ID int Primary Key Identity(1,1),
		-- NULL'u baştan reddediyoruz
		RequiredField nvarchar(100) Not Null,
		-- NULL ise default değer
		OptionalValue nvarchar(100) Null Default 'Unknown',
		-- ISNULL ile kontrol
		SafeValue nvarchar(100) Null
	);
End Try
Begin Catch
	select 'Hata: ' + ERROR_MESSAGE() as Mesaj
End Catch

end

/*Drop Table AdvancedUserTable;
Drop Table OrderLog;
Drop Table SmartNullHandling;*/

/*Alter Table TestUserTable
Add Constraint ck_test Check(ConstraintText)
Add Foreign Key (Sex) references Products(ProductID),
Alter Column Sex nvarchar(5),
Drop Column Sex
Add NewColumn int Not Null
Drop Constraint ck_test;*/

/*Drop Table TestUserTable;*/

end
go

begin /*17. Ünite Union, Dense Rank*/
select '17. Ünite'
/* Description - Açıklama
	Genel olarak sorguları birleştirerek kullanmamıza olanak sağlar. Birleştirilen verilerin sütun sayıları ve veri tipleri aynı
olmalıdır.
*/

/* Example Of Union All Operator */
Execute('Alter View CatView as select CategoryID, CategoryName, Description from Categories
Union All
select ProductID, ProductName, QuantityPerUnit from Products');
select * from CatView;
/* UNION vs UNION ALL - Fark */
use Northwind
-- UNION: Dublicate satırları filtreler (daha yavaş ama temiz)
Select CustomerID from Customers
Union 
Select EmployeeID from Employees;

-- UNION ALL: Dublikatlı dahil (daha hızlı)
Select CustomerID from Customers
Union All
Select EmployeeID from Employees;

end
go

begin /*CTE - Common Table Expressions (2026 Güncellemesi - MODERN SQL)*/
select 'CTE - Common Table Expressions'
/* Description - Açıklama
	CTE'ler (WITH ... AS ifadesi) kompleks sorguları daha readable ve maintainable bir şekilde yazabilmemizi sağlar.
Geçici named sorgu sonucu (temporary result set) olarak düşünülebilir ve sadece ilişkili SELECT/INSERT/UPDATE/DELETE sorgusunda kullanılır.

Properties - Özellikler:
	- Code readability önemli ölçüde artırır
	- Subquery alternatifi olarak daha temiz yazılır
	- Recursive CTE ile hierarchical data işlenebilir
	- Performance'ı subquery'lerle aynı olsa da anlaşılırlığı çok daha iyidir
	- Multiple CTE'ler birbiri ardına tanımlanabilir
*/

/* Simple CTE Example - Basit CTE Örneği */
use Northwind
;With EmployeeCTE as (
	Select 
		EmployeeID,
		FirstName + ' ' + LastName as FullName,
		Title,
		HireDate
	From Employees
	Where HireDate >= '1992-01-01'
)
Select * from EmployeeCTE;

/* Multiple CTEs - Birden Fazla CTE */
use Northwind
;With CategorySales as (
	Select 
		C.CategoryID,
		C.CategoryName,
		Sum(IsNull(P.UnitsInStock, 0)) as TotalUnits
	From Categories C
	Left Join Products P on C.CategoryID = P.CategoryID
	Group By C.CategoryID, C.CategoryName
),
TopCategories as (
	Select Top 5 * from CategorySales
	Order By TotalUnits Desc
)
Select * from TopCategories;

/* Recursive CTE - Hierarchy Örneği */
use Northwind
;With ReportingHierarchy as (
	-- Anchor Member (Temel Sorgu)
	Select 
		EmployeeID,
		FirstName,
		LastName,
		ReportsTo,
		0 as Level
	From Employees
	Where ReportsTo is Null -- Başkan
	
	Union All
	
	-- Recursive Member
	Select 
		E.EmployeeID,
		E.FirstName,
		E.LastName,
		E.ReportsTo,
		RH.Level + 1
	From Employees E
	Join ReportingHierarchy RH on E.ReportsTo = RH.EmployeeID
	Where RH.Level < 10 -- Sonsuz loop'u önle
)
Select * from ReportingHierarchy
Order By Level, EmployeeID;

end
go

begin /*Window Functions for Analytics (2026 Güncellemesi)*/
select 'Window Functions - ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD'
/* Description - Açıklama
	Window functions bir satırdan başlayarak çevresi (window) içinde hesaplamalar yapabilmemizi sağlar.
GROUP BY'den farkı: GROUP BY satırları azaltırken, window functions özgün satırları korur.

Most Used Functions:
	- ROW_NUMBER(): Her satıra unique sıra numarası verir
	- RANK(): Aynı değerlere aynı rank verir, boşluk kalır
	- DENSE_RANK(): Aynı değerlere aynı rank verir, boşluk kalmaz
	- LAG(): Önceki satırın değerini getirir
	- LEAD(): Sonraki satırın değerini getirir
	- PARTITION BY: Gruplar içinde ayrı olarak hesaplar
*/

/* ROW_NUMBER Example */
use Northwind
Select 
	EmployeeID,
	FirstName,
	Salary,
	ROW_NUMBER() Over (Order By Salary Desc) as SalaryRank
From Employees;

/* RANK vs DENSE_RANK */
use Northwind
With SampleData as (
	Select 'Ahmet' as Name, 100 as Score
	Union All Select 'Betül', 100
	Union All Select 'Cüneyt', 90
	Union All Select 'Derya', 90
	Union All Select 'Emre', 85
)
Select 
	Name,
	Score,
	Rank() Over (Order By Score Desc) as RankPosition,
	Dense_Rank() Over (Order By Score Desc) as DenseRankPosition
From SampleData;

/* LAG ve LEAD - Series Comparison */
use Northwind
Select 
	EmployeeID,
	FirstName,
	HireDate,
	LAG(HireDate) Over (Order By HireDate) as PreviousHireDate,
	LEAD(HireDate) Over (Order By HireDate) as NextHireDate
From Employees;

end
go

begin /*Performance Best Practices - Performans İpuçları (2026 Güncellemesi)*/
select 'SQL Server Performance Best Practices'

/* 1. WHERE Clause Optimization */
-- KÖTÜ: Fonksiyon sütunda uygulanmış
use Northwind
Declare @SearchDate date = '2023-01-01'
-- ❌ Performans Kötü
-- Select * from Orders where Year(OrderDate) = Year(@SearchDate)

-- ✅ Performans İyi (Index kullanabilir)
Select * from Orders where OrderDate >= @SearchDate 
and OrderDate < DateAdd(Day, 1, @SearchDate)

/* 2. Sütun Seçimi */
-- ❌ KÖTÜ: Select *
-- Select * from Employees where Salary > 5000

-- ✅ İYİ: İhtiyaçlı sütunları seç
Select EmployeeID, FirstName, LastName, Salary 
from Employees where Salary > 5000

/* 3. NOT IN vs NOT EXISTS */
use Northwind
-- ❌ KÖTÜ: NOT IN (NULL varsa sorun)
-- Select * from Customers where CustomerID Not In (Select CustomerID from Orders)

-- ✅ İYİ: NOT EXISTS
Select C.* from Customers C 
where Not Exists(Select 1 from Orders O where O.CustomerID = C.CustomerID)

/* 4. LEFT JOIN vs INNER JOIN */
use Northwind
-- ✅ Yalnızca ilişkili kayıtları isterseniz INNER JOIN
Select C.CompanyName, O.OrderID, O.OrderDate
from Customers C
Inner Join Orders O on C.CustomerID = O.CustomerID;

-- ✅ Tüm customers'ı istiyorsanız (sipaş olmayan dahil) LEFT JOIN
Select C.CompanyName, O.OrderID, O.OrderDate
from Customers C
Left Join Orders O on C.CustomerID = O.CustomerID;

/* 5. Index Strategy - İndeks Strateji */
-- ① Sık sorgulanacak sütunlar
-- ② WHERE ve JOIN sütunları
-- ③ ORDER BY sütunları
-- ④ Foreign Keys
-- Bunlar üzerine index oluştur, ancak:
-- ⚠️ Index'te INSERT, UPDATE, DELETE işlemleri yavaşlatır
-- ⚠️ Çok fazla index memory tüketir

/* 6. Avoid Using correlated subqueries */
use Northwind
-- ❌ KÖTÜ: Correlated subquery (her satır için subquery çalışır)
-- Select EmployeeID, FirstName,
--   (Select Count(*) from Orders o where o.EmployeeID = e.EmployeeID) as OrderCount
-- From Employees e

-- ✅ İYİ: JOIN ile aggregate
Select E.EmployeeID, E.FirstName, Count(O.OrderID) as OrderCount
From Employees E
Left Join Orders O on E.EmployeeID = O.EmployeeID
Group By E.EmployeeID, E.FirstName

/* 7. EXPLAIN PLAN - Sorgu Analizi */
-- SQL Server'da sorgu öncesi Ctrl+L veya Query → Display Estimated Execution Plan
-- Costly operations'ı gösterir:
-- - Table Scan (kötü, full scan yapıyor)
-- - Clustered Index Scan (orta seviye)
-- - Index Seek (çok iyi, doğrudan veri bulur)
-- - Hash Match (JOIN için; big data'da problem olabilir)

end
go

begin /*Naming Conventions & Code Standards (2026 Güncellemesi)*/
select 'SQL Code Standards'

/* Standard Naming Conventions - Adlandırma Kuralları */
/*
Tables:     PascalCase (Employees, Categories)
Columns:    PascalCase (EmployeeID, FirstName)
Procedures: usp_ActionObject (usp_GetEmployees, usp_InsertOrder)
Functions:  udf_DescriptiveName (udf_CalculateAge)
Views:      vw_DescriptiveName (vw_ActiveEmployees)
Triggers:   tr_TableAction (tr_Orders_AfterInsert)
Indexes:    IX_Table_Column (IX_Employees_LastName)
Constraints: PK_Table, FK_Table_RefTable, UQ_Table_Column, CK_Table_Condition
*/

/* Code Organization Standards */
/*
1. Always use BEGIN TRY-CATCH for error handling
2. Always use transactions for critical operations
3. Use meaningful variable names (@CustomerID not @c)
4. Add helpful comments/documentation
5. Use SET NOCOUNT ON at procedure start
6. Always specify column names in INSERT (not INSERT INTO VALUES)
7. Avoid Select * (performance, maintenance issues)
8. Use CTE instead of nested subqueries
9. Default NULL handling: use IsNull() or Coalesce()
10. Schema prefix always: dbo.TableName not TableName
*/
end
go