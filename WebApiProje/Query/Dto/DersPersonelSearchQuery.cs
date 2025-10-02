namespace WebApiProje.Query.Entity
{
    public class DersPersonelSearchQuery
    {
        public const string GetDersPersonelSearchSql = @"select 
             dersler_personeller.Kayit_No AS Kayit_No,
             dersler_personeller.D_Kod AS D_Kod,
             kimlik.Ad + ' ' +kimlik.Soyad AS Ad_Soyad,
             dersler_personeller.Sicil_No,
             dersler.D_Ad,
             personeller.Unvan_No,
             unvanlar.Unvan_Ad,
             bolumler.B_Ad,
             dersler_personeller.D_No,
             donemler.Donem,
             kimlik.eposta
             from [dbo].[dersler_personeller] dersler_personeller
             INNER JOIN personeller personeller ON dersler_personeller.Sicil_No=personeller.Sicil_No
             INNER JOIN kimlik kimlik ON personeller.TC_Kimlik=kimlik.Tc_Kimlik
             INNER JOIN dersler dersler ON dersler_personeller.D_Kod=dersler.D_Kod
             INNER JOIN unvanlar unvanlar ON personeller.Unvan_No=unvanlar.Unvan_No
             INNER JOIN bolumler bolumler ON personeller.B_No=bolumler.B_No
             INNER JOIN donemler donemler ON dersler_personeller.D_No=donemler.D_No
            where 1=1";

        public const string GetDersPersonelSearchCountSql =
       @"select 
            COUNT(dersler_personeller.Kayit_No)
            from [dbo].[dersler_personeller] dersler_personeller
            INNER JOIN personeller personeller ON dersler_personeller.Sicil_No=personeller.Sicil_No
            INNER JOIN kimlik kimlik ON personeller.TC_Kimlik=kimlik.Tc_Kimlik
            INNER JOIN dersler dersler ON dersler_personeller.D_Kod=dersler.D_Kod
            INNER JOIN unvanlar unvanlar ON personeller.Unvan_No=unvanlar.Unvan_No
            INNER JOIN bolumler bolumler ON personeller.B_No=bolumler.B_No
            INNER JOIN donemler donemler ON dersler_personeller.D_No=donemler.D_No
          WHERE 1=1";

      
    }
}
