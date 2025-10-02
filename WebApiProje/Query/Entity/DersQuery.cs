namespace WebApiProje.Query.Entity
{
    public class DersQuery
    {
        public const string GetDersSql = @"select * from [dbo].[dersler] dersler 
            where 1=1";

        public const string GetDersCountSql =
       @"select 
          COUNT(dersler.D_Kod)
          from dersler dersler
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
