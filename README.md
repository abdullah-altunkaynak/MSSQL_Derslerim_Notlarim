# MSSQL Ders Notlarım

Bu repo, Microsoft SQL Server ve T-SQL üzerine kişisel ders notlarımı içermektedir.

## Ders 1: Temel Kavramlar ve Sorgulama

-   **Ünite 1: Veritabanı Temelleri**
    -   Veritabanı nedir? (RDBMS, NoSQL, Cloud)
    -   SQL Server Mimarisi ve Servisleri (Database Engine, SSAS, SSRS, SSIS)
    -   Sistem Veritabanları (Master, Model, TempDb, Msdb)
    -   Normalizasyon Kuralları
-   **Ünite 2: Temel Sorgulama**
    -   `SELECT` ile veri çekme
    -   `WHERE` ile veri filtreleme (`BETWEEN`, `IN`, `LIKE`)
    -   `ORDER BY` ile veri sıralama
-   **Ünite 3: Veri Tipleri ve Fonksiyonlar**
    -   Temel Veri Tipleri ve Tip Dönüşümü (`CAST`, `CONVERT`, `TRY_CAST`)
    -   T-SQL'e Giriş (DML, DDL, DCL)
    -   SQL Server Fonksiyonları (Tarih, Metin, Aggregate)
-   **Ünite 4: Gelişmiş Sorgulama**
    -   `GROUP BY` ve `HAVING` ile veri gruplama
    -   `JOIN` ile tabloları birleştirme (`INNER`, `LEFT`, `RIGHT`, `FULL OUTER`)
    -   Koşul Yapıları (`CASE`, `IIF`)
-   **Ünite 5: Veritabanı Nesneleri ve Meta Veri**
    -   Constraint (Kısıtlayıcı) ve Identity Kullanımı
    -   Information Schema View'ları ile meta veri sorgulama

## Ders 2: Veri Yönetimi ve İleri Konular

-   **Ünite 6: Veri Manipülasyonu (DML)**
    -   `INSERT` ile veri ekleme
    -   `UPDATE` ile veri güncelleme
    -   `DELETE` ile veri silme
-   **Ünite 7: Performans ve İzleme**
    -   Extended Events (Genişletilmiş Olaylar) ile sunucu izleme (Eski `SQL Profiler` yerine)
-   **Ünite 8: Geliştirme Araçları**
    -   SQL Snippets ve Ayarlar
-   **Ünite 9: Veritabanı Nesneleri**
    -   View (Görünüm) Oluşturma ve Kullanımı
    -   DDL Komutları ile Tablo Yönetimi
-   **Ünite 10: İleri Sorgulama Teknikleri**
    -   `UNION` ve `UNION ALL` ile sonuç kümelerini birleştirme
    -   Pencereleme Fonksiyonları (`DENSE_RANK`, `ROW_NUMBER`)

## Ders 3: Programlama ve Yönetim

-   **Ünite 11: T-SQL Programlama**
    -   Stored Procedure (Saklı Yordam) oluşturma ve kullanma
    -   Trigger (Tetikleyici) oluşturma ve yönetme
-   **Ünite 12: Transaction Yönetimi**
    -   `BEGIN`, `COMMIT`, `ROLLBACK` ile atomik işlemler
-   **Ünite 13: Veritabanı Yönetimi**
    -   Veritabanı Yedekleme (Backup) ve Geri Yükleme (Restore)

## Ders 4: İleri Düzey Yönetim ve Entegrasyon

-   **Ünite 14: Otomasyon ve Arama**
    -   SQL Server Agent ile görev zamanlama
    -   Full-Text Search ile gelişmiş metin arama
-   **Ünite 15: Veri Aktarımı ve Analiz**
    -   Veri İçeri/Dışarı Aktarma (Import/Export)
    -   SQL Server Analysis Services (SSAS) ile Veri Analizi
    -   SQL Server Reporting Services (SSRS) ile Raporlama

## Ders 5: Uygulama Geliştirme

-   **Ünite 16: .NET ile Veritabanı Erişimi**
    -   C# ve ADO.NET ile SQL Server bağlantısı
    -   ASP.NET uygulamalarında veritabanı işlemleri
-   **Ünite 17: Office Entegrasyonu**
    -   Excel üzerinden SQL Server verilerine bağlanma

## Ders 6: Modern SQL Server Özellikleri

-   **Ünite 18: Performans Optimizasyonu**
    -   In-Memory OLTP (Hekaton) ile yüksek performanslı tablolar
-   **Ünite 19: Veri Güvenliği**
    -   Dynamic Data Masking (Dinamik Veri Maskeleme)
    -   Always Encrypted (Her Zaman Şifreli)
-   **Ünite 20: Modern Veri Yapıları**
    -   JSON Veri Desteği
    -   Temporal Tables (Zamana Bağlı Tablolar)
-   **Ünite 21: Diğer Konular**
    -   Çeşitli modern SQL Server özellikleri
