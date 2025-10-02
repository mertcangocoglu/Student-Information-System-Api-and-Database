using Core.Toolkit.Search;

namespace WebApiProje.Models.Request.Unvan
{
    public class UnvanRequest : SearchDto
    {
        public int? Unvan_No { get; set; }
        public string? Unvan_Ad { get; set; }

    }
    public class UnvanAdRequest
    {
        public string Unvan_Ad { get; set; }
    }
    public class UnvanBaseRequest
    {
        public int Unvan_No { get; set; }
        public string Unvan_Ad { get; set; }
    }

}
