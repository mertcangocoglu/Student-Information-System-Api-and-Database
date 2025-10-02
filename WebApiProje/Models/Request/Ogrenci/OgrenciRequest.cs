using Core.Toolkit.Search;

namespace WebApiProje.Models.Request.Ogrenci
{
    public class OgrenciRequest : SearchDto
    {
        public long? Ogrenci_No { get; set; }
        public long? Tc_Kimlik { get; set; }
        public int? B_No { get; set; }
        public int? GNO { get; set; }
    }
    public class OgrenciAdiRequest
    {
        public long Tc_Kimlik  { get; set; }
    }
   
    public class OgrenciBaseRequest
    {
        public long Ogrenci_No { get; set; }
        public long Tc_Kimlik { get; set; }
        public int B_No { get; set; }
        public int GNO { get; set; }
    }

}
