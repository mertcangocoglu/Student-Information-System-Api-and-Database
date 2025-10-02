using Core.Toolkit.Search;

namespace WebApiProje.Models.Request.Ders
{
    public class DersRequest : SearchDto
    {
        public string? D_Kod { get; set; }

        public string? D_Ad { get; set; }
        public int? B_No { get; set; }
        public int? Yariyil { get; set; }
        public int?   AKTS { get; set; }
        public string? D_Tur { get; set; }

    }
    public class DersAdRequest
    {
        public string D_Ad { get; set; }
    }
    public class DersBaseRequest
    {
        public string D_Kod { get; set; }

        public string D_Ad { get; set; }
        public int B_No { get; set; }
        public int Yariyil { get; set; }
        public int AKTS { get; set; }
        public string D_Tur { get; set; }
    }

}
