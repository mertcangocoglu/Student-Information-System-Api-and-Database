using Core.Toolkit.Search;

namespace WebApiProje.Models.Request.Kimlik
{
    public class KimlikRequest : SearchDto
    {
        public long? Tc_Kimlik { get; set; }
        public string? Ad { get; set; }
        public string? Soyad { get; set; }
        public string? Eposta { get; set; }
        public string? Adres { get; set; }
        public long? Telefon { get; set; }


    }
    public class KimlikAdRequest
    {
        public long? Tc_Kimlik { get; set; }
    }
    public class KimlikBaseRequest
    {
        public long Tc_Kimlik { get; set; }
        public string Ad { get; set; }
        public string Soyad { get; set; }
        public string Eposta { get; set; }
        public string Adres { get; set; }
        public long Telefon { get; set; }

    }

}
