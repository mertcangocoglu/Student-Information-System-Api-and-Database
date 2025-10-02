using Core.Toolkit.Search;

namespace WebApiProje.Models.Request.Dto
{
    public class DersPersonelSearchRequest : SearchDto
    {
        public int? Kayit_No { get; set; }
        public string? D_Kod { get; set; }
        public string? D_Ad { get; set; }
        public string? Sicil_No { get; set; }
        public string? Ad_Soyad { get; set; }
        public int? Unvan_No { get; set; }
        public string? Unvan_Ad { get; set; }
        public string? B_Ad { get; set; }
        public string? Eposta { get; set; }
        public int? D_No { get; set; }
        public string? Donem { get; set; }

    }
}
