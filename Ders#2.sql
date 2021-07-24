begin /*12.Ünite DML INSERT, UPDATE, DELETE*/
select '12.Ünite';

begin /*Design Mode - Dizayn Modu*/
select 'Design Mode'
/*Description - Açýklama
	Dizayn modu Tablolar üzerinde yapýsal deðiþiklikler ve veri deðiþklikleri yapmamýza olanak saðlar. Bazen sorgu yazmak yerine
küçük iþlemler için tablo ismine sað týklayarak Design Mode açýlabilmektedir.
*/
end

begin /*DML Insert*/
select 'DML Insert'
/* Description - Açýklama
	Bir tabloya veri eklemek için kullanýlan bir sorgu türüdür.
*/

/* How to Use This Command? - Bu Komut Nasýl Kullanýlýr?
Insert INTO TableName(RowName, OtherRowName, ...)
Values(ValueForRowName, ValueForOtherRowName, ...), (If you want to insert more than one data)
*/

/* Example Of Insert Command: Adding Data to Categories Table - Katagoriler Tablosuna Veri Girme */
use Northwind
Insert into Categories(CategoryName, Description)
values('NewVariable1', 'Testing Insert into Command!');
select * from Categories;

/* Conditioned Insert Command - Þarta Baðlý Insert Komutu 
	Belirli þartlar saðlanmasý dahilinde tabloya veri eklmek istenirse kullanýlýr.
*/

/* Example Of Conditioned Insert Command: Eklenecek olan kategori hali hazýrda tabloda yoksa veri eklenecek.*/
declare @CategoryNameVariable nvarchar(15) = 'NewVariable2';
declare @DescriptionText nvarchar(30) = 'Testing Insert into Command!';
if not exists(select CategoryName from Categories where CategoryName = @CategoryNameVariable)
Insert into Categories(CategoryName, Description)
values(@CategoryNameVariable, @DescriptionText);
else
select 'This category already exists!' as 'Error!', * from Categories where CategoryName = @CategoryNameVariable; 

/* Table Backuping with Insert Command - Insert Komutu ile Tablo Yedekleme 
	SQL Server'da bir iþlem yaparken özellikle UPDATE veya DELETE komutlarý ile yanlýþ bir sorgu ile verilerimizi riske
atabiliriz. Bu gibi durularda hýzlýca tablodaki verileri yedeklemek isteyebiliriz. Bunun için Insert into komutu kullanýlabilir.
Warning - Uyarý
	Bu yedekleme iþleminde tüm özellikler yedeklenmez. Sadece veriler yedeklenmektedir.

 * How to Use This Method? - Bu Yöntem Nasýl Kullanýlýr?
Insert * into BackupTableName from BackupingTableName;
*/

/* Bulk Insert - Toplu Insert 
	Bir komut ile birçok veriyi ayný anda ekleyebilmek için kullanýlan bir yöntemdir. Pratikte Bulk Insert yöntemini, bir tablodan
diðer tabloya veri aktarmak için kullanabiliriz.
*/

/* How to Use This Method? - Bu Komut Nasýl Kullanýlýr? 
Insert into BackupTableName(ColumnName, OtherColumnName)(select ColumnName, OtherColumnName from BackupingTableName)
*/

end

begin /*DML Update*/
select 'DML Update'
/* Description - Açýklama
	Tabloda daha önceden var olan bir veriyi güncellemek için kullanýlýr. Bu komutu kullanýrken dikkat edilmesi gereken en önemli
þey where komutudur. Çünkü where komutu ile þart yazmadan güncelleme yaparsak tüm tablo etkileneðinden ötürü verilerimiz riske
girecektir.
*/

/* How to Use This Command? - Bu Komut Nasýl Kullanýlýr?
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
/* Description - Açýklama
	Tablodaki verileri silmek için kullanýlýr. Burada da update sorgusunda olduðu gibi where ifadesi kritik bir öneme sahiptir.
Aksi halde tüm verilerimiz silinebilir.
Warning - Uyarý
	Delete sorgusu ile tablodan silinen column'larýn Identity özelliði var olan bir satýrý için(Örneðin Primary Key CategoryID)
Identity deðeri kaldýðý yerden devam edecktir. Örn; son eklenen verinin CategoryID'si 9 olsun. Bu veri silindikten sonra yeni
eklenen verinin CategoryID'si 10 olacaktýr. 9 deðil!
*/

/* How to Use This Command? - Bu Komut Nasýl Kullanýlýr?
delete from TableName where Conditions
*/

/* Example Of Delete Command: Deleting Data from Categories Table - Categories Tablosundan Veri Silme*/
use Northwind
Delete from Categories where CategoryID = 9;
select * from Categories;

begin /*Truncate Command*/
select 'Truncate Command'
/* Description - Açýklama
	Bir tablodan tüm verileri silmek ve Identity deðerlerini sýfýrlamak için kullanýlýr.
*/

/* How to Use This Command? - Bu Komut Nasýl Kullanýlýr.
Truncate Table TableName;
*/

end

/* Delete Duplicate Data Method - Tekrar Eden Verileri Silme Metodu
	Bazý durumlarda bir tabloya insert komutu ile veya Edit Top 200 Rows seçeneði ile tabloda bulunan bir veriyi ekleyebiliriz.
Örn; bir kullanýcý hali hazýrda varken onun var olduðunu bilmeden ekleme yapabiliriz. Bu durumlarda bu yöntem kullanýlýr.
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
end

end
go

begin /*15.Ünite View ve Tablo Görünümleri*/
select '13.Ünite'
/* Description - Açýklama
	Bir veya birden fazla tablodan, ihtiyaç duyulan verileri almamýza yarayan sanal tablolardýr. Normal þartlarda bir tablo sadece
kendi verilerini tutabilirken, view birçok tablonun verilerini tutabilmektedir. View de tablolar gibi satýr ve sütunlardan 
oluþur.
*/

/* View Properties - View Özellikleri
	# Sanal Tablolar gibi düþünülebilir.
	# View içerikleri sorgulanabilmektedir.
	# View üzerinden DML iþlemleri yapýlabilir.
	# View üzerinden yapýlan DML iþlemleri direkt olarak tablolara yansýtýlýr.
	# View tablo/tablolara baðlý olarak çalýþýr. Böylece veri bütünlüðü korunmuþ olur.
	# View ile tablolarýn veri eriþimini sýnýrlandýrabiliriz.
	# Karmaþýk sorgu sonuçlarýna ulaþmak için view tablo olarak kullanýlabilðir.
	# View ile tablo arasýnda iliþkisel bütünlük yoksa, view veri giriþini reddeder.
	# View veri saklamaz. Tablodan veya birçok tablodan yapýlan sorgular neticesinde tabloya baðlý olarak çalýþýr.
	# View tabloya baðlý çalýþtýðý için baðlý olduðu tablo silinir ise view hiçbir þey görüntülemez.
	# View ile paramtre kullanýlamaz. Yani; koþul ifadesinde SQL Parametrelerini kullanamayýz.
	# View ile view üzerinden parametre alabilen bir sorgu yazmak mümkündür. Bunun için SQL Procedure kullanýlýr.
	# View için index tanýmlamak da mümkündür.
*/

/* How to Use This Object? - Bu Nesne Nasýl Kullanýlýr?
create View ViewName as Select Columns from TableName (where if you have condition) 
*/

/* Example Of Create View */
use Northwind
Execute('Create View CatView as select * from Categories');
select * from dbo.CatView;
/* Create view komutu sorgudaki ilk ve son komut olmasý gereklidir. Yani temiz bir sql sorgusu veya Execute metodu ile 
çalýþtýrýlmalýdýr. Ya da go ifadesi ile biri create ifadesinin üstüne diðeri ise create ifadesinin altýna olmak üzere temiz
bir sql sorgusu elde edilebilir. Dolayýsýyla create view ifadesi çalýþacaktýr.*/

/* Example Of Alter View */
use Northwind
/*
Warning - Uyarý
	Order By ifadesi create/alter view iþlemindeki select sorgusunda direkt olarak kullanýlamamaktadýr. TOP, OFFSET gibi ifadeler
ile birlikte kullanýlabilir. Ayrýca view select sorgusunda da kullanýlabilmektedir.
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

/* View Control with 'With Check Option' - 'With Check Option' ile View Kontrölü
	Bir View oluþurken where ifadesi ile belirtilen koþul dahilinde oluþan View o veri listesini içerir. Sonuç olarak þarta göre
View oluþturabiliriz. Fakat extra olarak Create View ifadesinin en alt kýsmýna With Check Option ifadesini eklememiz gerekmektedir.
*/

/* Example Of With Check Option */
use Northwind;
select * from CatView;
select * from Products;
Execute('Alter View [dbo].[CatView] as (select * from Products P where P.CategoryID =
(select CategoryID from Categories where CategoryName = ''Condiments'' )) With Check Option');
select * from CatView;

end
go

begin /*16. Ünite Tables For DDL*/
select '16. Ünite'
/* Description - Açýklama
	Bir tablo oluþturmak için Object Explorer sekmesi üzerinden mouse ile veri eklenebileceði gibi DDL ismini verdiðimiz T-SQL
komutlarý ile de tablo oluþturabiliriz. DDL ile Create Table diyerek tablo oluþturabilir, Alter Table diyerek güncelleyebilir,
Drop Table diyerek tabloyu kaldýrabilir ve Create Index diyerek tabloda index oluþturabiliriz.
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
	('Abdullah', 'ALTUNKAYNAK', null, '18971448530', 1),
	('Hakan', 'ÇELEBÝ', '26.08.2000', '14501321120', 1),
	('Halil Emre', 'BALABAN', '04.06.2001', '10991407078', 1),
	('Furkan', 'YAVUZASLAN', '26.02.2001', '56419210806', 1),
	('Eslem Nisa', 'TÜRK', '01.05.2015', '32521051888', 0),
	('Zeynep Yaren', 'ALTUNKAYNAK', '22.01.2014', '18952245310', 0);

select UserName Ýsim, UserSurname Soyisim, BirthDate 'Doðum Tarihi', TC, 
case Sex 
when 0 then 'Kadýn'
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

end
go

begin /*17. Ünite Unýon, Dense Rank*/
select '17. Ünite'
/* Description - Açýklama
	Genel olarak sorgularý birleþtirerek kullanmamýza olanak saðlar. Birleþtirn verilerin sütun sayýlarý ve veri tipleri ayný
olmalýdýr.
*/

/* Example Of Union All Operator */
Execute('Alter View CatView as select CategoryID, CategoryName, Description from Categories
Union All
select ProductID, ProductName, QuantityPerUnit from Products');
select * from CatView;

end
go