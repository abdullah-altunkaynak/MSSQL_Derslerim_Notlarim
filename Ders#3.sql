begin /* 18. Ünite Stored Procedure */
select '18. Ünite'
/* Description - Açıklama
    Stored Procedure (SP), veritabanı sunucusunda tutulan, ilk çalıştırıldığında derlenen ve execution plan'ı 
önbelleğe (cache) alınan SQL programcıklarıdır. İstemci (Client) SP çağırdığında, sorgu istemci tarafında değil
sunucu tarafında işletilir ve sadece sonuçlar ağ üzerinden döner.

Stored Procedure Properties - Özellikler:
    # Parametre (Input/Output) alabilir ve döndürebilirler.
    # Ağ (Network) trafiğini yormazlar. Özellikle C# backend uygulamalarından milyonlarca satır veri çekerken hayat kurtarır.
    # SQL Injection saldırılarına karşı doğal bir koruma sağlarlar (parametreleştirilmiş sorgu yapısı sayesinde).
    # İş kurallarını veritabanında merkezi bir yerde tutmayı sağlarlar.
    # View'lardan farklı olarak DML (Insert, Update, Delete) işlemleri yapabilir ve dışarıdan parametre alabilirler.
*/

/* BEST PRACTICE: Modern Stored Procedure Oluşturma */
go
-- Önceden DROP edip CREATE etmek yerine artık CREATE OR ALTER kullanıyoruz.
Create Or Alter Procedure usp_CalculateOrderDiscount
(
    @DiscountThreshold float = 0.15 -- Default değer alan parametre
)
As
Begin
    -- C# (Dapper/ADO.NET) tarafına gereksiz "X rows affected" mesajlarının gidip 
    -- performansı düşürmesini engellemek için ZORUNLU standart:
    Set NoCount On; 

    Begin Try
        Select 
            OrderID, 
            UnitPrice as [İndirimsiz Fiyat], 
            ROUND(SUM((1 - Discount) * UnitPrice), 2) as [İndirimli Fiyat], 
            Discount
        From [Order Details] 
        Where Discount >= @DiscountThreshold
        Group By OrderID, UnitPrice, Discount 
        Order By Discount desc, [İndirimsiz Fiyat] desc;
    End Try
    Begin Catch
        -- Backend'e anlamlı hata fırlatma
        Throw 51000, 'İndirim hesaplanırken veritabanı tarafında bir hata oluştu.', 1;
    End Catch
End;
go

/* Calling Created Procedure - Procedure Çağırma */
-- Parametresiz çağırım (Default 0.15 kullanır)
Exec usp_CalculateOrderDiscount;

-- Parametreli çağırım
Exec usp_CalculateOrderDiscount @DiscountThreshold = 0.20;

end
go

begin /* 19. Ünite Trigger */
select '19. Ünite'
/* Description - Açıklama
    Bir tabloda gerçekleşen DML (INSERT, UPDATE, DELETE) olaylarını dinleyen ve otomatik tetiklenen yapılardır.
İşlem öncesi (INSTEAD OF) veya işlem sonrası (AFTER) çalışabilirler.
    
    Sanal Tablolar:
    - INSERTED: Yeni eklenen veya güncellenen verinin yeni halini tutar.
    - DELETED: Silinen veya güncellenen verinin eski halini tutar.

    MODERN MİMARİ NOTU: Günümüz projelerinde Trigger kullanımı olabildiğince azaltılmalıdır. İş kuralları (Business Logic)
    genelde backend uygulamalarına (Domain Events vb.) kaydırılmıştır. Trigger'lar sadece çok kritik audit (loglama) 
    veya backend'in atlayamayacağı kesin veri bütünlüğü kuralları için tercih edilmelidir, çünkü debug edilmesi zordur.
*/

/* Example 1: INSTEAD OF Trigger - Silme İşlemini Engelleme (Soft Delete Alternatifi) */
go
Create Or Alter Trigger trg_Categories_PreventDelete
on Categories
Instead Of Delete
As
Begin
    Set NoCount On;
    
    -- Eğer silinmeye çalışılan kayıtlar varsa işlemi geri al ve hata fırlat
    If Exists (Select 1 From deleted)
    Begin
        Raiserror ('Categories tablosundan fiziksel silme işlemi yapılamaz! Lütfen pasife çekin (IsActive = 0).', 16, 1);
        Rollback Transaction;
    End
End;
go

-- Test: Silmeyi Deneme
-- Delete from Categories where CategoryID = 1; -- Bu sorgu hata verecek ve çalışmayacaktır.

/* Example 2: AFTER Trigger - Insert İşleminde Otomatik Veri Doldurma */
go
Create Or Alter Trigger trg_Categories_AutoUpdateDescription
on Categories
After Insert
As
Begin
    Set NoCount On;

    -- Sadece yeni eklenen (inserted) ve Description'ı boş olan kayıtları güncelle
    Update C 
    Set Description = 'Sistem tarafından otomatik oluşturuldu: ' + Convert(nvarchar, GetDate(), 120)
    From Categories C
    Inner Join inserted i on C.CategoryID = i.CategoryID
    Where C.Description is Null;
End;
go

-- Test: Veri Ekleme
Insert into Categories(CategoryName) Values ('TestTriggerKategori');
select * from Categories where CategoryName = 'TestTriggerKategori';

end
go

begin /* 20. Ünite Transaction Management (Modern Yaklaşım) */
select '20. Ünite'

/* Description - Açıklama
    İlişkisel veritabanlarının kalbi olan ACID prensiplerini sağlar. Birbirine bağlı birden fazla SQL komutunun
ya "hepsinin başarılı olmasını" ya da "hiçbirinin yapılmamasını" garanti eder. C# tarafında Entity Framework 
Core'un `SaveChanges()` metodunun arka planda yaptığı işlemin saf SQL halidir.

UYARI: Transaction'lar açık unutulursa (Commit veya Rollback edilmezse) tablolar "Lock" yer ve tüm sistem
kilitlenebilir (Deadlock). Bu yüzden mutlaka TRY-CATCH ile kullanılmalıdır.
*/

go
/* BEST PRACTICE: Güvenli Transaction Şablonu */
Create Or Alter Procedure usp_SafeCategoryTransfer
(
    @OldCategoryID int,
    @NewCategoryID int
)
As
Begin
    Set NoCount On;
    -- İzolasyon seviyesi (Gerekirse Serializable yapılabilir)
    Set Transaction Isolation Level Read Committed;

    Begin Try
        Begin Transaction;

        -- 1. İşlem: Ürünlerin kategorisini güncelle
        Update Products 
        Set CategoryID = @NewCategoryID 
        Where CategoryID = @OldCategoryID;

        -- 2. İşlem: Eski kategoriyi pasife çek (Trigger izin vermediği için fiziksel silmiyoruz)
        Update Categories
        Set Description = 'PASİF KATEGORİ'
        Where CategoryID = @OldCategoryID;

        -- Eğer her iki işlem de hatasız buraya kadar gelirse onayla ve kaydet
        Commit Transaction;
        Print 'İşlem başarıyla tamamlandı.';
        
    End Try
    Begin Catch
        -- Eğer transaction hala açıksa (hata alındıysa) geri al
        If @@TRANCOUNT > 0
        Begin
            Rollback Transaction;
        End
        
        -- Hatayı okuyup loglama veya backend'e fırlatma
        Declare @ErrorMessage nvarchar(4000) = ERROR_MESSAGE();
        Declare @ErrorSeverity int = ERROR_SEVERITY();
        Declare @ErrorState int = ERROR_STATE();
        
        Raiserror (@ErrorMessage, @ErrorSeverity, @ErrorState);
    End Catch
End;
go

end