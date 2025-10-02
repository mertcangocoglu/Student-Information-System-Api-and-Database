namespace WebApiProje.Query.Entity
{
    public class KimlikQuery
    {
        public const string GetKimlikSql = @"select * from [dbo].[kimlik] kimlik 
            where 1=1";

        public const string GetKimlikCountSql =
       @"select 
          COUNT(kimlik.Tc_Kimlik)
          from kimlik kimlik
          WHERE 1=1";

        //public const string InsertSehirSql = @"INSERT INTO Sehir (Adi) 
        //                OUTPUT INSERTED.* 
        //                VALUES(@Adi)";

        //public const string UpdateSehirSql = @"UPDATE Sehir SET Adi=@Adi 
        //                OUTPUT INSERTED.*
        //                WHERE Id=@Id";

        //public const string DeleteSehirSql = @"DELETE FROM Sehir  WHERE Id = @Id";
    }
}
