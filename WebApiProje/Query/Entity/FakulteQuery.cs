namespace WebApiProje.Query.Entity
{
    public class FakulteQuery
    {
        public const string GetFakulteSql = @"select * from [dbo].[fakulteler] fakulteler 
            where 1=1";

        public const string GetFakulteCountSql =
       @"select 
          COUNT(fakulteler.F_No)
          from fakulteler fakulteler
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
