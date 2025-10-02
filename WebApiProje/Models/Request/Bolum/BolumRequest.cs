using Core.Toolkit.Search;

namespace WebApiProje.Models.Request.Bolum
{
    public class BolumRequest : SearchDto
    {
        public int? B_No { get; set; }
        public string? B_Ad { get; set; }
        public int? F_No { get; set; }
        public int? Tur_No { get; set; }
        public int? BB_Sicil_No { get; set; }

    }
    public class BolumAdRequest
    {
        public string B_Ad { get; set; }
    }
    public class BolumBaseRequest
    {
        public int B_No { get; set; }
        public string B_Ad { get; set; }
        public int F_No { get; set; }
        public int Tur_No { get; set; }
        public int BB_Sicil_No { get; set; }
    }

}
