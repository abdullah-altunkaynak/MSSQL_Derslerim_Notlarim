begin /*18. �nite Stored Procedure*/
select '18. �nite'
/* Description - A��klama
	Stored Procedure, Server taraf�ndan tutlan, bir kez derlendikten sonra tekrar derlenmeyen sorgu yap�lar�d�r. Client, Serverdan
Stored Procedure �a��rd��� zaman bu procedure client taraf�nda de�il Server taraf�nda i�letilir.
*/

/* Stored Procedure Properties - Stored Procedure �zellikleri
	# Parametre i�erebilirler.
	# Zamanlanm�� g�rev olarak atanabilirler.
	# Bir Stored Procedure ile Insert i�lemi yapt�ktan sonra Select sorgusunun otomatik olarak devreye girmesini sa�larsak, 
	  eklenen kay�tlar�n da Insert sonras� g�r�n�m�n� elde edebiliriz.
	# Network Trafi�ini yormazlar. Injection'lara kar�� parametreli olarak yaz�l�rlar. B�ylece g�venlik sa�lan�r. Yaz�m �ekli olarak
	  View yap�s�na benzesede View'lar parametre alamazlar.
*/

/* Example Of Stored Procedure */
use Northwind;
declare @DiscountRate smallint = 15;
Execute('Alter Procedure OrderDiscount as
select OrderID, UnitPrice as ''�ndirimsiz Fiyat'', ROUND(SUM((1 - Discount) * UnitPrice), 2) as ''�ndirimli Fiyat'', Discount
from [Order Details] Group By OrderID, UnitPrice, Discount Order By Discount desc, ''�ndirimsiz Fiyat'' desc');


/* Calling Created Procedure */
Exec OrderDiscount;
end
go

begin /*19. �nite Trigger*/
select '19. �nite'
/* Description - A��klama
	Bir tabloda ger�ekle�en DML olaylar�n� takip etme yetene�ine sahip olan yap�lard�r. �rne�in; tabloya �r�n barkodu okutuldu�unda
kdv fiyat� da sipari� tablosuna eklensin vb. durumlar i�in kullan�labilir. Trigger i�lemi sanal tablolar �zerinden i�lem g�r�r.
Ekleme i�lemi i�in Inserted, Silme i�lemi i�in Deleted sanal tablosu kullan�l�r. Update i�lemi i�in ise update edilen verinin eski
hali Deleted tablosunda yer al�r. Ayr�ca trigger bir i�lem olduktan sonra, kendini �a��ran i�lemi rollback edebilir.
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

begin /*20. �nite Transaction*/
select '20. �nite'

/* Warning - Uyar�
	Begin Transaction kapat�lmas� gerekmektedir. Rollback veya Commit ile kapatmay� unutmay�n�z.
*/

begin transaction
update Categories set CategoryName = 'Abdullah';
select * from Categories;
Save tran updatiin
/* G�ncelleme yanl�� ve geri �evirmek istiyorsak*/
Rollback tran
select * from Categories;

/* G�ncelleme do�ru ve onaylanmas�n� istiyorsak*/
Commit tran
select * from Categories

end
