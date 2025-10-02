namespace WebApiProje.Query.Entity
{
    public class BolumQuery
    {
        public const string GetBolumSql = @"select * from [dbo].[bolumler] bolumler 
            where 1=1";

        public const string GetBolumCountSql =
       @"select 
          COUNT(bolumler.B_No)
          from bolumler bolumler
          WHERE 1=1";

        //public const string InsertKategoriSql = @"INSERT INTO Kategori (Adi) 
        //                OUTPUT INSERTED.* 
        //                VALUES(@Adi)";

        //public const string UpdateKategoriSql = @"UPDATE Kategori SET Adi=@Adi 
        //                OUTPUT INSERTED.*
        //                WHERE Id=@Id";

        //public const string DeleteKategoriSql = @"DELETE FROM Kategori  WHERE Id = @Id";
    }
}
