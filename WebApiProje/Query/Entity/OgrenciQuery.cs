namespace WebApiProje.Query.Entity
{
    public class OgrenciQuery
    {
        public const string GetOgrenciSql = @"select * from [dbo].[ogrenci_kayit] ogrenci_kayit 
            where 1=1";

        public const string GetOgrenciCountSql =
       @"select 
          COUNT(ogrenci_kayit.Ogrenci_No)
          from ogrenci_kayit ogrenci_kayit
          WHERE 1=1";

        //public const string InsertIlceSql = @"INSERT INTO Ilce (SehirId,Adi) 
        //                OUTPUT INSERTED.* 
        //                VALUES(@SehirId,@Adi)";

        //public const string UpdateIlceSql = @"UPDATE Ilce SET SehirId=@SehirId,Adi=@Adi 
        //                OUTPUT INSERTED.*
        //                WHERE Id=@Id";

        //public const string DeleteIlceSql = @"DELETE FROM Ilce  WHERE Id = @Id";
    }
}
