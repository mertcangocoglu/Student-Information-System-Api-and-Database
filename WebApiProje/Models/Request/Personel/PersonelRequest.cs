using Core.Toolkit.Search;

namespace WebApiProje.Models.Request.Personel
{
    public class PersonelRequest : SearchDto
    {
        public int? Sicil_No { get; set; }
        public long? TC_Kimlik { get; set; }
        public int? B_No { get; set; }
        public int? A_No { get; set; }
        public int? Unvan_No { get; set; }
    }
    public class PersonelAdiRequest
    {
        public long? TC_Kimlik { get; set; }
        public int Sicil_No { get; set; }
    }
   
    public class PersonelBaseRequest
    {
        public int Sicil_No { get; set; }
        public long TC_Kimlik { get; set; }
        public int B_No { get; set; }
        public int A_No { get; set; }
        public int Unvan_No { get; set; }
    }

}
