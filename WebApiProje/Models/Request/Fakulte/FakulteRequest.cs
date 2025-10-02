using Core.Toolkit.Search;

namespace WebApiProje.Models.Request.Fakulte
{
    public class FakulteRequest : SearchDto
    {
        public int? F_No { get; set; }
        public string? F_Ad { get; set; }
        public string? Adres { get; set; }
        

    }
    public class FakulteAdRequest
    {
        public string F_Ad { get; set; }
    }
    public class FakulteBaseRequest
    {
        public int F_No { get; set; }
        public string F_Ad { get; set; }
        public string Adres { get; set; }
    }

}
