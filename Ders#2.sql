begin /*12.�nite DML INSERT, UPDATE, DELETE*/
select '12.�nite';

begin /*Design Mode - Dizayn Modu*/
select 'Design Mode'
/*Description - A��klama
	Dizayn modu Tablolar �zerinde yap�sal de�i�iklikler ve veri de�i�klikleri yapmam�za olanak sa�lar. Bazen sorgu yazmak yerine
k���k i�lemler i�in tablo ismine sa� t�klayarak Design Mode a��labilmektedir.
*/
end

begin /*DML Insert*/
select 'DML Insert'
/* Description - A��klama
	Bir tabloya veri eklemek i�in kullan�lan bir sorgu t�r�d�r.
*/

/* How to Use This Command? - Bu Komut Nas�l Kullan�l�r?
Insert INTO TableName(RowName, OtherRowName, ...)
Values(ValueForRowName, ValueForOtherRowName, ...), (If you want to insert more than one data)
*/

/* Example Of Insert Command: Adding Data to Categories Table - Katagoriler Tablosuna Veri Girme */
use Northwind
Insert into Categories(CategoryName, Description)
values('NewVariable1', 'Testing Insert into Command!');
select * from Categories;

/* Conditioned Insert Command - �arta Ba�l� Insert Komutu 
	Belirli �artlar sa�lanmas� dahilinde tabloya veri eklmek istenirse kullan�l�r.
*/

/* Example Of Conditioned Insert Command: Eklenecek olan kategori hali haz�rda tabloda yoksa veri eklenecek.*/
declare @CategoryNameVariable nvarchar(15) = 'NewVariable2';
declare @DescriptionText nvarchar(30) = 'Testing Insert into Command!';
if not exists(select CategoryName from Categories where CategoryName = @CategoryNameVariable)
Insert into Categories(CategoryName, Description)
values(@CategoryNameVariable, @DescriptionText);
else
select 'This category already exists!' as 'Error!', * from Categories where CategoryName = @CategoryNameVariable; 

/* Table Backuping with Insert Command - Insert Komutu ile Tablo Yedekleme 
	SQL Server'da bir i�lem yaparken �zellikle UPDATE veya DELETE komutlar� ile yanl�� bir sorgu ile verilerimizi riske
atabiliriz. Bu gibi durularda h�zl�ca tablodaki verileri yedeklemek isteyebiliriz. Bunun i�in Insert into komutu kullan�labilir.
Warning - Uyar�
	Bu yedekleme i�leminde t�m �zellikler yedeklenmez. Sadece veriler yedeklenmektedir.

 * How to Use This Method? - Bu Y�ntem Nas�l Kullan�l�r?
Insert * into BackupTableName from BackupingTableName;
*/

/* Bulk Insert - Toplu Insert 
	Bir komut ile bir�ok veriyi ayn� anda ekleyebilmek i�in kullan�lan bir y�ntemdir. Pratikte Bulk Insert y�ntemini, bir tablodan
di�er tabloya veri aktarmak i�in kullanabiliriz.
*/

/* How to Use This Method? - Bu Komut Nas�l Kullan�l�r? 
Insert into BackupTableName(ColumnName, OtherColumnName)(select ColumnName, OtherColumnName from BackupingTableName)
*/

end

begin /*DML Update*/
select 'DML Update'
/* Description - A��klama
	Tabloda daha �nceden var olan bir veriyi g�ncellemek i�in kullan�l�r. Bu komutu kullan�rken dikkat edilmesi gereken en �nemli
�ey where komutudur. ��nk� where komutu ile �art yazmadan g�ncelleme yaparsak t�m tablo etkilene�inden �t�r� verilerimiz riske
girecektir.
*/

/* How to Use This Command? - Bu Komut Nas�l Kullan�l�r?
update TableName set (UpdatingRowName = newValue, ...) where Conditions
*/

/* Example Of Update Command: Updating Data from Categories Table - Categories Tablosundan Veri G�ncelleme */
use Northwind
update Categories set CategoryName = 'NewVariable3', Description = 'Testing Update Command!' 
where CategoryName = 'NewVariable2';
select * from Categories;

end

begin /*DML Delete*/
select 'DML Delete'
/* Description - A��klama
	Tablodaki verileri silmek i�in kullan�l�r. Burada da update sorgusunda oldu�u gibi where ifadesi kritik bir �neme sahiptir.
Aksi halde t�m verilerimiz silinebilir.
Warning - Uyar�
	Delete sorgusu ile tablodan silinen column'lar�n Identity �zelli�i var olan bir sat�r� i�in(�rne�in Primary Key CategoryID)
Identity de�eri kald��� yerden devam edecktir. �rn; son eklenen verinin CategoryID'si 9 olsun. Bu veri silindikten sonra yeni
eklenen verinin CategoryID'si 10 olacakt�r. 9 de�il!
*/

/* How to Use This Command? - Bu Komut Nas�l Kullan�l�r?
delete from TableName where Conditions
*/

/* Example Of Delete Command: Deleting Data from Categories Table - Categories Tablosundan Veri Silme*/
use Northwind
Delete from Categories where CategoryID = 9;
select * from Categories;

begin /*Truncate Command*/
select 'Truncate Command'
/* Description - A��klama
	Bir tablodan t�m verileri silmek ve Identity de�erlerini s�f�rlamak i�in kullan�l�r.
*/

/* How to Use This Command? - Bu Komut Nas�l Kullan�l�r.
Truncate Table TableName;
*/

end

/* Delete Duplicate Data Method - Tekrar Eden Verileri Silme Metodu
	Baz� durumlarda bir tabloya insert komutu ile veya Edit Top 200 Rows se�ene�i ile tabloda bulunan bir veriyi ekleyebiliriz.
�rn; bir kullan�c� hali haz�rda varken onun var oldu�unu bilmeden ekleme yapabiliriz. Bu durumlarda bu y�ntem kullan�l�r.
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

begin /*15.�nite View ve Tablo G�r�n�mleri*/
select '13.�nite'
/* Description - A��klama
	Bir veya birden fazla tablodan, ihtiya� duyulan verileri almam�za yarayan sanal tablolard�r. Normal �artlarda bir tablo sadece
kendi verilerini tutabilirken, view bir�ok tablonun verilerini tutabilmektedir. View de tablolar gibi sat�r ve s�tunlardan 
olu�ur.
*/

/* View Properties - View �zellikleri
	# Sanal Tablolar gibi d���n�lebilir.
	# View i�erikleri sorgulanabilmektedir.
	# View �zerinden DML i�lemleri yap�labilir.
	# View �zerinden yap�lan DML i�lemleri direkt olarak tablolara yans�t�l�r.
	# View tablo/tablolara ba�l� olarak �al���r. B�ylece veri b�t�nl��� korunmu� olur.
	# View ile tablolar�n veri eri�imini s�n�rland�rabiliriz.
	# Karma��k sorgu sonu�lar�na ula�mak i�in view tablo olarak kullan�labil�ir.
	# View ile tablo aras�nda ili�kisel b�t�nl�k yoksa, view veri giri�ini reddeder.
	# View veri saklamaz. Tablodan veya bir�ok tablodan yap�lan sorgular neticesinde tabloya ba�l� olarak �al���r.
	# View tabloya ba�l� �al��t��� i�in ba�l� oldu�u tablo silinir ise view hi�bir �ey g�r�nt�lemez.
	# View ile paramtre kullan�lamaz. Yani; ko�ul ifadesinde SQL Parametrelerini kullanamay�z.
	# View ile view �zerinden parametre alabilen bir sorgu yazmak m�mk�nd�r. Bunun i�in SQL Procedure kullan�l�r.
	# View i�in index tan�mlamak da m�mk�nd�r.
*/

/* How to Use This Object? - Bu Nesne Nas�l Kullan�l�r?
create View ViewName as Select Columns from TableName (where if you have condition) 
*/

/* Example Of Create View */
use Northwind
Execute('Create View CatView as select * from Categories');
select * from dbo.CatView;
/* Create view komutu sorgudaki ilk ve son komut olmas� gereklidir. Yani temiz bir sql sorgusu veya Execute metodu ile 
�al��t�r�lmal�d�r. Ya da go ifadesi ile biri create ifadesinin �st�ne di�eri ise create ifadesinin alt�na olmak �zere temiz
bir sql sorgusu elde edilebilir. Dolay�s�yla create view ifadesi �al��acakt�r.*/

/* Example Of Alter View */
use Northwind
/*
Warning - Uyar�
	Order By ifadesi create/alter view i�lemindeki select sorgusunda direkt olarak kullan�lamamaktad�r. TOP, OFFSET gibi ifadeler
ile birlikte kullan�labilir. Ayr�ca view select sorgusunda da kullan�labilmektedir.
*/
Execute('Create View CatView as (select top (select Count(*) from Employees) * from Employees order by City)'); /*View g�ncelleme*/
select * from dbo.CatView;

/* Example Of Drop View */
Drop View dbo.CatView;

use Northwind;
Insert into CatView(CategoryName, Description)
Values('NewVariable3', 'Testing Update Command!');
Update CatView set CategoryName = 'NewVariable1', Description = 'Testing Update Command on View!'
where CategoryName = 'NewVariable3';
select COUNT(*) from Categories;

/* View Control with 'With Check Option' - 'With Check Option' ile View Kontr�l�
	Bir View olu�urken where ifadesi ile belirtilen ko�ul dahilinde olu�an View o veri listesini i�erir. Sonu� olarak �arta g�re
View olu�turabiliriz. Fakat extra olarak Create View ifadesinin en alt k�sm�na With Check Option ifadesini eklememiz gerekmektedir.
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

begin /*16. �nite Tables For DDL*/
select '16. �nite'
/* Description - A��klama
	Bir tablo olu�turmak i�in Object Explorer sekmesi �zerinden mouse ile veri eklenebilece�i gibi DDL ismini verdi�imiz T-SQL
komutlar� ile de tablo olu�turabiliriz. DDL ile Create Table diyerek tablo olu�turabilir, Alter Table diyerek g�ncelleyebilir,
Drop Table diyerek tabloyu kald�rabilir ve Create Index diyerek tabloda index olu�turabiliriz.
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
	('Hakan', '�ELEB�', '26.08.2000', '222', 1),
	('Halil Emre', 'BALABAN', '04.06.2001', '333', 1),
	('Furkan', 'YAVUZASLAN', '26.02.2001', '444', 1),
	('Eslem Nisa', 'T�RK', '01.05.2015', '555', 0),
	('Zeynep Yaren', 'ALTUNKAYNAK', '22.01.2014', '666', 0);

select UserName �sim, UserSurname Soyisim, BirthDate 'Do�um Tarihi', TC, 
case Sex 
when 0 then 'Kad�n'
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

begin /*17. �nite Un�on, Dense Rank*/
select '17. �nite'
/* Description - A��klama
	Genel olarak sorgular� birle�tirerek kullanmam�za olanak sa�lar. Birle�tirn verilerin s�tun say�lar� ve veri tipleri ayn�
olmal�d�r.
*/

/* Example Of Union All Operator */
Execute('Alter View CatView as select CategoryID, CategoryName, Description from Categories
Union All
select ProductID, ProductName, QuantityPerUnit from Products');
select * from CatView;

end
go