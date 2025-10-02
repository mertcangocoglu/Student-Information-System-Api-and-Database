namespace WebApiProje.Models.Entity
{
    public class Ogrenci
    {
        public long Ogrenci_No { get; set; }
        public long TC_Kimlik { get; set; }
        public int B_No { get; set; }
        public DateTime K_Tarih { get; set; }
        public string K_Tur {  get; set; }
        public DateTime M_Tarih { get; set; }
        public float GNO { get; set; }
        public bool Durum { get; set; }
    }
}
