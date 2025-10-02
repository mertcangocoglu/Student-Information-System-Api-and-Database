namespace WebApiProje.Models.Dto
{
    public class DersKayitSearchDto
    {
        public int Kayit_No { get; set; }
        public long Ogrenci_No { get; set; }
        public string Ad_Soyad { get; set; }
        public string D_Kod { get; set; }
        public string D_Ad { get; set; }
        public int Vize { get; set; }
        public int Final { get; set; }
        public int Uygulama { get; set; }
        public int Butunleme { get; set; }
        public int Ortalama { get; set; }
        public bool Durum { get; set; }
        public int D_No { get; set; }
        public string Donem { get; set; }
        public string B_Ad { get; set; }
        public string Eposta { get; set; }
    }
}
