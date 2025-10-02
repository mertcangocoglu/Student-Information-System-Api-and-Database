namespace WebApiProje.Query.Entity
{
    public class PersonelQuery
    {
        public const string GetPersonelSql = @"select * from [dbo].[personeller] personeller 
            where 1=1";

        public const string GetPersonelCountSql =
       @"select 
          COUNT(personeller.Sicil_No)
          from personeller personeller
          WHERE 1=1";

        //public const string InsertYemekSql = @"INSERT INTO Yemek (KategoriId,Adi) 
        //                OUTPUT INSERTED.* 
        //                VALUES(@KategoriId,@Adi)";

        //public const string UpdateYemekSql = @"UPDATE Yemek SET KategoriId=@KategoriId,Adi=@Adi 
        //                OUTPUT INSERTED.*
        //                WHERE Id=@Id";

        //public const string DeleteYemekSql = @"DELETE FROM Yemek  WHERE Id = @Id";
    }
}
