namespace WebApiProje.Query.Entity
{
    public class DersKayitSearchQuery
    {
        public const string GetDersKayitSearchSql = @"select 
             ders_kayit.Kayit_No AS Kayit_No,
             ders_kayit.Ogrenci_No AS Ogrenci_No,
             kimlik.Ad + ' ' +kimlik.Soyad AS Ad_Soyad,
             ders_kayit.D_Kod,
             dersler.D_Ad,
             ders_kayit.Vize,
             ders_kayit.Final,
             ders_kayit.Uygulama,
             ders_kayit.Butunleme,
             (ders_kayit.Vize*0.4)+(ders_kayit.Final*0.6) AS Ortalama,
             ders_kayit.Durum,
             ders_kayit.D_No,
             donemler.Donem,
             bolumler.B_Ad,
             kimlik.eposta
             from [dbo].[ders_kayit] ders_kayit
             INNER JOIN ogrenci_kayit ogrenci_kayit ON ders_kayit.Ogrenci_No=ogrenci_kayit.Ogrenci_No
             INNER JOIN kimlik kimlik on ogrenci_kayit.Tc_Kimlik=kimlik.Tc_Kimlik
             INNER JOIN dersler dersler ON ders_kayit.D_Kod=dersler.D_Kod
             INNER JOIN bolumler bolumler ON ogrenci_kayit.B_No=bolumler.B_No
             INNER JOIN donemler donemler ON ders_kayit.D_No=donemler.D_No
            where 1=1";

        public const string GetDersKayitSearchCountSql =
       @"select 
            COUNT(ders_kayit.Kayit_No)
            from [dbo].[ders_kayit] ders_kayit
            INNER JOIN ogrenci_kayit ogrenci_kayit ON ders_kayit.Ogrenci_No=ogrenci_kayit.Ogrenci_No
            INNER JOIN kimlik kimlik on ogrenci_kayit.Tc_Kimlik=kimlik.Tc_Kimlik
            INNER JOIN dersler dersler ON ders_kayit.D_Kod=dersler.D_Kod
            INNER JOIN bolumler bolumler ON ogrenci_kayit.B_No=bolumler.B_No
            INNER JOIN donemler donemler ON ders_kayit.D_No=donemler.D_No
          WHERE 1=1";

      
    }
}
