📘 Ultimate T-SQL Developer Handbook (From Zero to Architecture)

Bölüm 1: Temel Sorgulama ve Filtreleme (DQL)

1.1. Mantıksal Sıralama (Logical Query Processing)

Yazdığın kod yukarıdan aşağıya çalışmaz. SQL Engine sorguyu şu sırayla işler:
FROM ➡️ ON ➡️ JOIN ➡️ WHERE ➡️ GROUP BY ➡️ HAVING ➡️ SELECT ➡️ DISTINCT ➡️ ORDER BY

-----------------------------------------------------------------------------------------------------------------------------------------------------



1.2. SELECT, WHERE ve Mantıksal Operatörler

SELECT DISTINCT Column1, Column2 
FROM dbo.MyTable
WHERE Column1 = 'Active' 
  AND Column2 IN ('TypeA', 'TypeB')     -- Liste içi kontrol
  AND Price BETWEEN 100 AND 500         -- Aralık kontrolü (Sınırlar dahil)
  AND Description LIKE '[A-Z]%'        -- A'dan Z'ye harfle başlayanlar
  AND UpdatedAt IS NOT NULL;            -- NULL kontrolü

-----------------------------------------------------------------------------------------------------------------------------------------------------



1.3. GROUP BY ve HAVING Filtrelemesi

⚠️ Kritik Kural: WHERE ham veriyi (satırları) filtreler; HAVING ise gruplanmış ve aggregate edilmiş veriyi filtreler.

SELECT CategoryID, COUNT(*) as TotalProducts, AVG(UnitPrice) as AvgPrice
FROM dbo.Products
WHERE UnitsInStock > 0 -- Önce ham veriyi filtrele
GROUP BY CategoryID
HAVING AVG(UnitPrice) > 50; -- Sadece ortalaması 50'den büyük grupları getir

-----------------------------------------------------------------------------------------------------------------------------------------------------



Bölüm 2: SQL Fonksiyonları ve Veri Tipleri

2.1. String Fonksiyonları (Hap Şablonlar)

SELECT 
    TRIM(FirstName) as CleanName,                         -- Boşlukları temizler
    SUBSTRING(Title, 1, 5) as ShortTitle,                 -- 1. karakterden başla 5 karakter al
    CHARINDEX('@', Email) as AtSignIndex,                 -- Karakterin konumunu bulur
    REPLACE(Phone, ' ', '') as CompactPhone,              -- Karakter değiştirme
    CONCAT(FirstName, ' ', LastName) as FullName;         -- Güvenli birleştirme (NULL ezer)

-----------------------------------------------------------------------------------------------------------------------------------------------------



2.2. Date & Time Fonksiyonları (Modern Dönüşümler)

SELECT 
    GETDATE() as CurrentDateTime,                                      -- Anlık zaman
    DATEADD(day, 30, GETDATE()) as NextMonth,                         -- 30 gün ekle
    DATEDIFF(year, BirthDate, GETDATE()) as Age,                      -- İki tarih farkı
    EOMONTH(GETDATE()) as EndOfThisMonth,                             -- Ayın son gününü bulur
    FORMAT(GETDATE(), 'dd-MM-yyyy HH:mm') as FormattedDate,           -- Custom format (Yavaştır!)
    CONVERT(nvarchar, GETDATE(), 104) as FastTurkishDate;              -- 'dd.mm.yyyy' (Çok hızlı!)

-----------------------------------------------------------------------------------------------------------------------------------------------------



2.3. NULL ve Koşul Fonksiyonları

SELECT 
    ISNULL(Region, 'No Region') as SafeRegion,            -- NULL ise default değer bas
    COALESCE(CellPhone, HomePhone, 'No Phone') as Contact,-- İlk NULL olmayan değeri döner
    
    -- Satır Bazlı İf-Else (CASE WHEN)
    CASE 
        WHEN UnitsInStock = 0 THEN 'Out of Stock'
        WHEN UnitsInStock < 10 THEN 'Critical'
        ELSE 'Normal'
    END as StockStatus
FROM dbo.Products;

-----------------------------------------------------------------------------------------------------------------------------------------------------



Bölüm 3: Tablo İlişkileri ve Küme İşlemleri (JOINs & Set Operators)

3.1. JOIN Türleri Hızlı Şeması

-- INNER JOIN: Her iki tabloda da eşleşen kayıtları getirir
SELECT P.ProductName, C.CategoryName 
FROM dbo.Products P
INNER JOIN dbo.Categories C ON P.CategoryID = C.CategoryID;


-- LEFT JOIN: Soldaki tablonun tamamını, sağdaki tablonun eşleşenlerini getirir (Eşleşmeyenlere NULL basar)
SELECT C.CategoryName, P.ProductName 
FROM dbo.Categories C
LEFT JOIN dbo.Products P ON C.CategoryID = P.CategoryID;


-- CROSS JOIN: Kartezyen çarpım yapar (Her satırı diğer tablonun tüm satırlarıyla eşler)
SELECT Name, Number FROM dbo.Users CROSS JOIN dbo.Numbers;

-----------------------------------------------------------------------------------------------------------------------------------------------------



3.2. Küme Operatörleri (UNION vs EXCEPT)

-- UNION ALL: İki sorguyu direkt birleştirir (Çok hızlıdır, duplicate kayıtları temizlemez)
SELECT Email FROM dbo.Customers
UNION ALL
SELECT Email FROM dbo.Employees;


-- UNION: Birleştirir ve duplicate satırları silip DISTINCT yapar (Daha yavaştır)
-- EXCEPT: İlk sorguda olup ikinci sorguda olmayan benzersiz satırları getirir
SELECT CustomerID FROM dbo.Customers
EXCEPT
SELECT CustomerID FROM dbo.Orders;

-----------------------------------------------------------------------------------------------------------------------------------------------------



Bölüm 4: DML (Veri Manipülasyonu) ve Tablo Tasarımı

4.1. Güvenli Insert / Update / Delete Şablonları

-- 1. Güvenli Toplu Aktarım (Select Into)
SELECT * INTO dbo.LogTable_Backup FROM dbo.LogTable WHERE LogDate < '2026-01-01';


-- 2. Bulk Insert Şablonu
INSERT INTO dbo.ArchiveCategories(CategoryID, CategoryName)
SELECT CategoryID, CategoryName FROM dbo.Categories WHERE IsActive = 0;


-- 3. Güvenli Güncelleme (Her zaman PK ve Kontrol Listesi ile)
UPDATE dbo.Products 
SET UnitPrice = UnitPrice * 1.10 
WHERE ProductID = 5 AND IsDiscontinued = 0;

-----------------------------------------------------------------------------------------------------------------------------------------------------



4.2. Gelişmiş Tablo DDL Özellikleri

CREATE TABLE dbo.AdvancedOrders (
    OrderID int IDENTITY(1,1) PRIMARY KEY,
    SubTotal decimal(18,2) NOT NULL,
    TaxRate as (SubTotal * 0.20) PERSISTED,  -- Computed Column: Fiziksel olarak diske yazılır
    Status bit DEFAULT 1 NOT NULL,           -- Default Constraint
    TrackingCode varchar(20) NULL,
    
    CONSTRAINT CK_SubTotal_Positive CHECK (SubTotal > 0) -- Veri Doğrulama Kontrolü
);

-- NULL Hariç Benzersiz (Unique) Yapma (Modern Best Practice)
CREATE UNIQUE NONCLUSTERED INDEX IX_Orders_TrackingCode_NonNull
ON dbo.AdvancedOrders(TrackingCode) WHERE TrackingCode IS NOT NULL;

-----------------------------------------------------------------------------------------------------------------------------------------------------



Bölüm 5: İleri Seviye Sorgulama (Analitik & Modern SQL)

5.1. CTE (Common Table Expressions) & Raporlama Şablonu

;WITH MonthlySales_CTE AS (
    SELECT EmployeeID, YEAR(OrderDate) as SalesYear, MONTH(OrderDate) as SalesMonth, SUM(Freight) as TotalFreight
    FROM dbo.Orders
    GROUP BY EmployeeID, YEAR(OrderDate), MONTH(OrderDate)
)
SELECT EmployeeID, SalesYear, SalesMonth, TotalFreight 
FROM MonthlySales_CTE 
WHERE TotalFreight > 1000;

-----------------------------------------------------------------------------------------------------------------------------------------------------



5.2. Window Functions (Analitik Sıralama ve Akış)

SELECT 
    ProductID, CategoryID, UnitPrice,
    ROW_NUMBER() OVER (PARTITION BY CategoryID ORDER BY UnitPrice DESC) as RowNum,    -- Grup içi 1,2,3 sıra
    DENSE_RANK() OVER (PARTITION BY CategoryID ORDER BY UnitPrice DESC) as DenseRank, -- Eşit fiyata aynı sıra, atlama yapmaz
    LAG(UnitPrice) OVER (PARTITION BY CategoryID ORDER BY UnitPrice ASC) as PrevPrice, -- Bir önceki ucuz ürün fiyatı
    LEAD(UnitPrice) OVER (PARTITION BY CategoryID ORDER BY UnitPrice ASC) as NextPrice -- Bir sonraki pahalı ürün fiyatı
FROM dbo.Products;

-----------------------------------------------------------------------------------------------------------------------------------------------------



5.3. JSON Manipülasyonu (API Geliştiricileri İçin)

-- 1. JSON Veriyi Tabloya Kırma (Parsing)
DECLARE @json nvarchar(max) = '[{"Id":10,"Role":"Admin"},{"Id":11,"Role":"User"}]';

SELECT Id, Role 
FROM OPENJSON(@json) 
WITH (Id int '$.Id', Role nvarchar(50) '$.Role');

-- 2. Tabloyu JSON Çıktı Yapma
SELECT ProductID, ProductName FROM dbo.Products FOR JSON PATH, ROOT('ProductList');

-----------------------------------------------------------------------------------------------------------------------------------------------------



Bölüm 6: Programlanabilir Nesneler ve Hata Yönetimi

6.1. Güvenli Stored Procedure Standart Şablonu

CREATE OR ALTER PROCEDURE dbo.usp_ProcessOrder
    @OrderID int,
    @UserID int,
    @ResponseMsg nvarchar(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON; -- Network yükünü ve gereksiz veri mesajlarını keser (Zorunlu)
    
    BEGIN TRY
        IF NOT EXISTS(SELECT 1 FROM dbo.Orders WHERE OrderID = @OrderID)
        BEGIN
            SET @ResponseMsg = 'Sipariş bulunamadı.';
            RETURN;
        END

        -- İşlem kodları buraya...
        SET @ResponseMsg = 'Başarılı';
    END TRY
    BEGIN CATCH
        SET @ResponseMsg = 'Hata Kodu: ' + CAST(ERROR_NUMBER() as nvarchar) + ' - ' + ERROR_MESSAGE();
        -- Log tablosuna yazma komutları eklenebilir.
    END CATCH
END;

-----------------------------------------------------------------------------------------------------------------------------------------------------



6.2. Trigger Yönetimi (Güvenli Audit Log Şablonu)

CREATE OR ALTER TRIGGER dbo.trg_Products_AuditLog
ON dbo.Products
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Sadece UnitPrice değiştiğinde log at
    IF UPDATE(UnitPrice)
    BEGIN
        INSERT INTO dbo.AuditLog(ProductID, OldPrice, NewPrice, ChangedBy, ChangedAt)
        SELECT d.ProductID, d.UnitPrice, i.UnitPrice, SUSER_SNAME(), GETDATE()
        FROM deleted d
        INNER JOIN inserted i ON d.ProductID = i.ProductID;
    END
END;

-----------------------------------------------------------------------------------------------------------------------------------------------------



Bölüm 7: İşlem Yönetimi ve Güvenlik (Transactions & System Management)

7.1. Kusursuz Transaction Şablonu (Kilitlenmeyi Önleyen)

-- Okuma kilit tipini ayarla (Deadlock ihtimalini düşürür)
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION;
BEGIN TRY
    
    -- 1. İşlem
    UPDATE dbo.BankAccounts SET Balance = Balance - 500 WHERE AccountID = 1;
    -- 2. İşlem
    UPDATE dbo.BankAccounts SET Balance = Balance + 500 WHERE AccountID = 2;

    COMMIT TRANSACTION;
    PRINT 'Transfer Başarılı.';
END TRY
BEGIN CATCH
    -- Açık transaction kaldıysa Rollback yap
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    -- Hatayı backend'e (C# / API) fırlat
    THROW 52000, 'Kritik Hata: İşlemler geri alındı.', 1;
END CATCH;

-----------------------------------------------------------------------------------------------------------------------------------------------------



7.2. Linked Server Sorgulama Standartları

Uzak sunuculardan veri çekerken iki yöntem vardır:

-- Yöntem A: 4 Nokta Sentaksı (Büyük tablolarda YAVAŞTIR, tüm veriyi süzerken lokal sunucuyu yorar)
SELECT * FROM [UZAK_SERVER_IP_VEYA_NAME].[DatabaseName].[dbo].[TableName] WHERE ID = 5;

-- Yöntem B: OPENQUERY (Çok HIZLIDIR, sorgu karşı sunucuda çalışır, sadece filtrelenmiş sonuç locali yormadan gelir)
SELECT * FROM OPENQUERY([UZAK_SERVER_IP_VEYA_NAME], 'SELECT ID, Name FROM DatabaseName.dbo.TableName WHERE ID = 5');

-- Yöntem C: Exec()
EXEC('SELECT * FROM TABLO_ADI') AT UZAKSUNUCUADI

-----------------------------------------------------------------------------------------------------------------------------------------------------



7.3. SQL Server Agent Jobs (Zamanlanmış Görevleri Yönetme)

Job'ları T-SQL ile tetiklemek veya geçmişini izlemek için bu sistem tablolarını kullanabilirsin:

-- 1. Bir Job'ı Kodla Manuel Tetikleme (Asenkron Çalışır)
EXEC msdb.dbo.sp_start_job @job_name = 'DAPPER_Data_Archive_Job';

-- 2. Başarısız Olan Agent Job'ları Listeleme
SELECT 
    j.name AS JobName,
    h.step_name AS StepName,
    msdb.dbo.agent_datetime(h.run_date, h.run_time) AS RunDateTime,
    h.message AS ErrorMessage
FROM msdb.dbo.sysjobs j
INNER JOIN msdb.dbo.sysjobhistory h ON j.job_id = h.job_id
WHERE h.run_status = 0 -- 0 = Failed, 1 = Succeeded
ORDER BY RunDateTime DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------------



Bölüm 8: Performans ve Optimizasyon El Notları

SARGable Sorgular: Kolonların üzerine fonksiyon giydirme. WHERE DATEPART(year, OrderDate) = 2026 YANLIŞTIR; WHERE OrderDate >= '2026-01-01' AND OrderDate < '2027-01-01' DOĞRUDUR.

Execution Plan Analizi: Sorguyu seçip Ctrl + L tuşlarına bas. Table Scan görüyorsan veritabanı tüm diski tarıyordur. Hemen filtre kolonuna NONCLUSTERED INDEX at. Hedefin her zaman Index Seek olmalıdır.

Correlated Subquery Ölümcüldür: SELECT kolonlarının içine parantez açıp başka tablodan COUNT(*) çekme (her satır için o sorgu baştan döner). Bunun yerine ana sorguya LEFT JOIN ile bağla ve aggregate et.

-----------------------------------------------------------------------------------------------------------------------------------------------------


🚀 BÖLÜM 0: HIZLI KOPYALA-YAPIŞTIR ŞABLONLARI (FAST-USE)

0.1. Çoklu Tablo Bağlama Şablonu (Multi-Table JOIN)

Sıklıkla ana tabloya bağlı ara tabloları ve onlara bağlı detay tablolarını (Örn: Sipariş -> Ürün -> Kategori) bağlarken kullanılır. LEFT JOIN kullanırken eşleşmeyen kayıtlar için ISNULL veya COALESCE ile default değer basmayı unutma.

SELECT 
    O.OrderID,
    O.OrderDate,
    C.CustomerName,
    P.ProductName,
    ISNULL(Cat.CategoryName, 'Kategorisiz') as CategoryName -- Sol tabloda var sağda yoksa NULL ezme
FROM dbo.Orders O
INNER JOIN dbo.Customers C ON O.CustomerID = C.CustomerID
INNER JOIN dbo.OrderDetails OD ON O.OrderID = OD.OrderID
INNER JOIN dbo.Products P ON OD.ProductID = P.ProductID
LEFT JOIN dbo.Categories Cat ON P.CategoryID = Cat.CategoryID -- Kategorisi silinmiş ürünler de gelsin diye LEFT
WHERE O.Status = 1;

-----------------------------------------------------------------------------------------------------------------------------------------------------



0.2. DECLARE + CTE (WITH) Kombinasyonu

Dışarıdan parametre alan ve bu parametreleri karmaşık bir alt sorgu kümesine (CTE) besleyen, backend servislerinin (API) veritabanı tarafındaki prototip şablonudur.

-- 1. Değişkenleri Tanımla
DECLARE @TargetStatus int = 2;
DECLARE @MinAmount decimal(18,2) = 1500.00;

-- 2. CTE Yapısını Kur ve Değişkenleri İçine Göm
;WITH FilteredSales_CTE AS (
    SELECT 
        CustomerID,
        SUM(TotalAmount) as TotalSpend,
        COUNT(OrderID) as OrderCount
    FROM dbo.Orders
    WHERE [Status] = @TargetStatus
    GROUP BY CustomerID
)
-- 3. CTE Sonucunu Hemen Altında Kullan
SELECT 
    C.CustomerName,
    S.TotalSpend,
    S.OrderCount
FROM FilteredSales_CTE S
INNER JOIN dbo.Customers C ON S.CustomerID = C.CustomerID
WHERE S.TotalSpend >= @MinAmount
ORDER BY S.TotalSpend DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------------



0.3. Tarih Aralığı ile Güvenli Sorgu Çekmek (SARGable Date Range)

⚠️ Kritik Bilgi: BETWEEN kullanımı datetime tipinde günün son saniyelerindeki verileri (23:59:59) bazen yakalayamayabilir. En güvenli ve performanslı (Index dostu) tarih aralığı sorgulama yöntemi >= ve < operatörleridir.

DECLARE @StartDate datetime = '2026-06-01 00:00:00';
DECLARE @EndDate datetime = '2026-07-01 00:00:00'; -- Temmuz dahil değil, Haziran'ın son salisesine kadar alır

SELECT OrderID, OrderDate, TotalAmount
FROM dbo.Orders
WHERE OrderDate >= @StartDate 
  AND OrderDate < @EndDate; -- Bir sonraki ayın ilk gününden KÜÇÜK olanlar (Haziran ayının tamamı)

-----------------------------------------------------------------------------------------------------------------------------------------------------



0.4. İç Sorgu (Derived Table) ile Tablo Oluşturup Kullanma

Bir sorgunun sonucunu sanal bir tabloymuş gibi FROM ifadesine gömüp, dışarıdaki sorguda bu sanal tabloya filtre veya JOIN uygulamak için kullanılır.

SELECT 
    DerivedTable.CategoryID,
    DerivedTable.MaxPrice,
    P.ProductName
FROM (
    -- İç sorgu: Her kategorinin en pahalı ürün fiyatını bulur
    SELECT CategoryID, MAX(UnitPrice) as MaxPrice 
    FROM dbo.Products 
    GROUP BY CategoryID
) as DerivedTable -- İç sorguya mutlaka bir takma isim (Alias) verilmelidir!
INNER JOIN dbo.Products P 
    ON P.CategoryID = DerivedTable.CategoryID 
   AND P.UnitPrice = DerivedTable.MaxPrice; -- Fiyatı en yüksek olan ürün adını eşle

-----------------------------------------------------------------------------------------------------------------------------------------------------



0.5. Çeşitli HAVING Kullanımları (Gelişmiş Gruplama Filtreleri)

HAVING sadece adet kontrolü için değil, mantıksal oranlar veya dinamik eşikler için de harika çözümler sunar.

-- Senaryo A: Tekrar eden (Duplicate) kayıtları bulma
SELECT Email, COUNT(*) as KayitSayisi
FROM dbo.Users
GROUP BY Email
HAVING COUNT(*) > 1;

-- Senaryo B: Siparişlerinin en az %20'si iptal edilmiş müşterileri bulma
SELECT CustomerID, COUNT(*) as ToplamSiparis
FROM dbo.Orders
GROUP BY CustomerID
HAVING SUM(CASE WHEN [Status] = 'Cancelled' THEN 1 ELSE 0 END) >= (COUNT(*) * 0.20);

-- Senaryo C: Toplam cirosu, tüm mağaza ortalamasından büyük olan şubeler
SELECT StoreID, SUM(Revenue) as StoreTotal
FROM dbo.DailySales
GROUP BY StoreID
HAVING SUM(Revenue) > (SELECT AVG(Revenue) FROM dbo.DailySales); -- HAVING içinde Subquery kullanımı

-----------------------------------------------------------------------------------------------------------------------------------------------------

0.6. Gelen Veriye Göre Farklı İşlem Yaptırmak (Dinamik Mantık)

Veritabanından veri çekerken satır bazlı karar vermek için CASE WHEN (Inline Logic); Script yazarken veya Procedure içinde akışı değiştirmek için IF-ELSE (Procedural Logic) kullanılır.

Yöntem A: Satır Bazlı Değişim (Sorgu İçinde CASE WHEN)

SELECT 
    ProductID,
    ProductName,
    UnitsInStock,
    -- Gelen verinin durumuna göre metinsel veya mantıksal çıktı üretme
    CASE 
        WHEN UnitsInStock = 0 THEN 'STOKTA YOK'
        WHEN UnitsInStock BETWEEN 1 AND 10 THEN 'KRİTİK SEVİYE'
        WHEN UnitsInStock > 50 THEN 'FAZLA STOK'
        ELSE 'NORMAL'
    END as StockAlertColumn
FROM dbo.Products;


Yöntem B: Akış Kontrolü (Script/Procedure İçinde IF-ELSE)

DECLARE @TotalUsers int;
SELECT @TotalUsers = COUNT(*) FROM dbo.Users;

-- Gelen toplam veriye göre arka planda farklı SQL bloklarını tetikleme
IF @TotalUsers > 100000
BEGIN
    PRINT 'Veri seti büyük. Performans modu aktif ediliyor...';
    -- Büyük tablo için optimize edilmiş index ve sorgu setleri çalıştırılabilir
END
ELSE
BEGIN
    PRINT 'Veri seti normal standartlarda.';
    -- Standart operasyonlar
END

-----------------------------------------------------------------------------------------------------------------------------------------------------
