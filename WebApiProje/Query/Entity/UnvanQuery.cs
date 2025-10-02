namespace WebApiProje.Query.Entity
{
    public class UnvanQuery
    {
        public const string GetUnvanSql = @"select * from [dbo].[unvanlar] unvanlar 
            where 1=1";

        public const string GetUnvanCountSql =
       @"select 
          COUNT(unvanlar.Unvan_No)
          from unvanlar unvanlar
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
