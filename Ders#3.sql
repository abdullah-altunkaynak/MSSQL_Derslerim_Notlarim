begin /*18. Ünite Stored Procedure*/
select '18. Ünite'
/* Description - Açýklama
	Stored Procedure, Server tarafýndan tutlan, bir kez derlendikten sonra tekrar derlenmeyen sorgu yapýlarýdýr. Client, Serverdan
Stored Procedure çaðýrdýðý zaman bu procedure client tarafýnda deðil Server tarafýnda iþletilir.
*/

/* Stored Procedure Properties - Stored Procedure Özellikleri
	# Parametre içerebilirler.
	# Zamanlanmýþ görev olarak atanabilirler.
	# Bir Stored Procedure ile Insert iþlemi yaptýktan sonra Select sorgusunun otomatik olarak devreye girmesini saðlarsak, 
	  eklenen kayýtlarýn da Insert sonrasý görünümünü elde edebiliriz.
	# Network Trafiðini yormazlar. Injection'lara karþý parametreli olarak yazýlýrlar. Böylece güvenlik saðlanýr. Yazým þekli olarak
	  View yapýsýna benzesede View'lar parametre alamazlar.
*/

/* Example Of Stored Procedure */
use Northwind;
declare @DiscountRate smallint = 15;
Execute('Alter Procedure OrderDiscount as
select OrderID, UnitPrice as ''Ýndirimsiz Fiyat'', ROUND(SUM((1 - Discount) * UnitPrice), 2) as ''Ýndirimli Fiyat'', Discount
from [Order Details] Group By OrderID, UnitPrice, Discount Order By Discount desc, ''Ýndirimsiz Fiyat'' desc');


/* Calling Created Procedure */
Exec OrderDiscount;
end
go

begin /*19. Ünite Trigger*/
select '19. Ünite'
/* Description - Açýklama
	Bir tabloda gerçekleþen DML olaylarýný takip etme yeteneðine sahip olan yapýlardýr. Örneðin; tabloya ürün barkodu okutulduðunda
kdv fiyatý da sipariþ tablosuna eklensin vb. durumlar için kullanýlabilir. Trigger iþlemi sanal tablolar üzerinden iþlem görür.
Ekleme iþlemi için Inserted, Silme iþlemi için Deleted sanal tablosu kullanýlýr. Update iþlemi için ise update edilen verinin eski
hali Deleted tablosunda yer alýr. Ayrýca trigger bir iþlem olduktan sonra, kendini çaðýran iþlemi rollback edebilir.
*/

/* Example Of Instead Of Trigger: Trigger that does not allow deleting data from categories table - Categories tablosundan veri
silinmesine izin vermeyen trigger */
use Northwind
Execute('
Create Trigger NotAllowDeletingDataFromCategories
on Categories
Instead Of Delete as
RollBack Tran');
Enable Trigger NotAllowDeletingDataFromCategories on Categories /*Or Disable*/
Delete from Categories where CategoryName = 'NewValue1' or CategoryName = 'NewValue2';
select * from Categories;

/* Example Of After Trigger */
use Northwind
Execute('
Create Trigger UpdateDescriptionWhenInsertedCategoryName
on Categories
After Insert as
Update Categories set Description = ''Updated with Trigger!'' where Description is Null');
Insert into Categories(CategoryName)
Values ('NewValue1'), ('NewValue2');
select * from Categories;

end
go

begin /*20. Ünite Transaction*/
select '20. Ünite'

/* Warning - Uyarý
	Begin Transaction kapatýlmasý gerekmektedir. Rollback veya Commit ile kapatmayý unutmayýnýz.
*/

begin transaction
update Categories set CategoryName = 'Abdullah';
select * from Categories;
Save tran updatiin
/* Güncelleme yanlýþ ve geri çevirmek istiyorsak*/
Rollback tran
select * from Categories;

/* Güncelleme doðru ve onaylanmasýný istiyorsak*/
Commit tran
select * from Categories

end
