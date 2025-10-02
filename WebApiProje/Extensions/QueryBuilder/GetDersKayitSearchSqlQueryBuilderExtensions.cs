using System.Text;
using WebApiProje.Query.Entity;
using Core.Extensions;
using WebApiProje.Models.Request.Ders;
using WebApiProje.Models.Request.Dto;

namespace WebApiProje.Extensions.QueryBuilder
{
    public class GetDersKayitSearchSqlQueryBuilderExtensions
    {
        public static string GetDersKayitSearchSqlQuery(DersKayitSearchRequest request)
        {
            var stringBuilder = new StringBuilder(DersKayitSearchQuery.GetDersKayitSearchSql);

            var countStringBuilder = new StringBuilder(DersKayitSearchQuery.GetDersKayitSearchCountSql);

            var whereClauses = new List<string>();
            

            if (request.Kayit_No.IsNotNull() && request.Kayit_No.IsNotDefault())
            {
                whereClauses.Add($"ders_kayit.Kayit_No= '{request.Kayit_No}'");
            }
            if (!string.IsNullOrEmpty(request.Ogrenci_No) && request.Ogrenci_No.IsNotDefault())
            {
                whereClauses.Add($"ders_kayit.Ogrenci_No= '{request.Ogrenci_No}'");
            }
            if (!string.IsNullOrEmpty(request.Ad_Soyad) && request.Ad_Soyad.IsNotDefault())
            {
                whereClauses.Add($"kimlik.Ad + ' ' +kimlik.Soyad like '%{request.Ad_Soyad}%'");
            }
            if (request.D_Kod.IsNotNull() && request.D_Kod.IsNotDefault())
            {
                whereClauses.Add($"ders_kayit.D_Kod= '{request.D_Kod}'");
            }
            if (!string.IsNullOrEmpty(request.D_Ad) && request.D_Ad.IsNotDefault())
            {
                whereClauses.Add($"ders_kayit.D_Ad like '%{request.D_Ad}%'");
            }
            if (request.Vize.IsNotNull() && request.Vize.IsNotDefault())
            {
                whereClauses.Add($"ders_kayit.Vize= '{request.Vize}'");
            }
            if (request.Final.IsNotNull() && request.Final.IsNotDefault())
            {
                whereClauses.Add($"ders_kayit.Final= '{request.Final}'");
            }
            if (request.Uygulama.IsNotNull() && request.Uygulama.IsNotDefault())
            {
                whereClauses.Add($"ders_kayit.Uygulama= '{request.Uygulama}'");
            }
            if (request.Butunleme.IsNotNull() && request.Butunleme.IsNotDefault())
            {
                whereClauses.Add($"ders_kayit.Butunleme= '{request.Butunleme}'");
            }
            if (request.Ortalama.IsNotNull() && request.Ortalama.IsNotDefault())
            {
                whereClauses.Add($"(ders_kayit.Vize*0.4)+(ders_kayit.Final*0.6)= '{request.Ortalama}'");
            }
            if (request.Durum.IsNotNull() && request.Durum.IsNotDefault())
            {
                whereClauses.Add($"ders_kayit.Durum= '{request.Durum}'");
            }
            if (request.D_No.IsNotNull() && request.D_No.IsNotDefault())
            {
                whereClauses.Add($"ders_kayit.D_No= '{request.D_No}'");
            }
            if (!string.IsNullOrEmpty(request.Donem) && request.Donem.IsNotDefault())
            {
                whereClauses.Add($"donemler.Donem like '%{request.Donem}%'");
            }
            if (!string.IsNullOrEmpty(request.B_Ad) && request.B_Ad.IsNotDefault())
            {
                whereClauses.Add($"bolumler.B_Ad like '%{request.B_Ad}%'");
            }
            if (!string.IsNullOrEmpty(request.Eposta) && request.Eposta.IsNotDefault())
            {
                whereClauses.Add($"bolumler.eposta like '%{request.Eposta}%'");
            }




            if (whereClauses.Any())
            {
                foreach (var whereClause in whereClauses)
                {
                    stringBuilder.Append($" AND {whereClause}");
                    countStringBuilder.Append($" AND {whereClause}");
                }
            }
            if (request.OrderBy.IsNotNull())
            {
                switch (request.OrderBy.Name)
                {
                    case "kayit_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ders_kayit.Kayit_No {request.OrderBy.Type}");
                            break;
                        }
                    case "ogrenci_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ders_kayit.Ogrenci_No {request.OrderBy.Type}");
                            break;
                        }
                    case "ad_soyad" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY kimlik.Ad + ' ' + kimlik.Soyad {request.OrderBy.Type}");
                            break;
                        }
                    case "d_kod" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ders_kayit.D_Kod {request.OrderBy.Type}");
                            break;
                        }
                    case "d_ad" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY dersler.D_Ad {request.OrderBy.Type}");
                            break;
                        }
                    case "vize" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ders_kayit.Vize {request.OrderBy.Type}");
                            break;
                        }
                    case "final" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ders_kayit.Final {request.OrderBy.Type}");
                            break;
                        }
                    case "uygulama" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ders_kayit.Uygulama {request.OrderBy.Type}");
                            break;
                        }
                    case "butunleme" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ders_kayit.Butunleme {request.OrderBy.Type}");
                            break;
                        }
                    case "ortalama" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY (ders_kayit.Vize*0.4)+(ders_kayit.Final*0.6) {request.OrderBy.Type}");
                            break;
                        }
                    case "durum" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ders_kayit.Durum {request.OrderBy.Type}");
                            break;
                        }
                    case "d_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ders_kayit.D_No {request.OrderBy.Type}");
                            break;
                        }
                    case "donem" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY donemler.donem {request.OrderBy.Type}");
                            break;
                        }
                    case "b_ad" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY bolumler.B_Ad {request.OrderBy.Type}");
                            break;
                        }
                    case "eposta" when request.OrderBy.Type.IsNotNull(): 
                        {
                            stringBuilder.Append($" ORDER BY kimlik.eposta {request.OrderBy.Type}");
                            break;
                        }

                    default:
                        {
                            stringBuilder.Append(" ORDER BY ders_kayit.Kayit_No ASC");
                            break;
                        }
                }
            }
            else
            {
                stringBuilder.Append(" ORDER BY ders_kayit.Kayit_No ASC");
            }

            stringBuilder.Append($" OFFSET {request.StartIndex} ROWS FETCH NEXT {(request.MaxCount.IsNotDefault() ? request.MaxCount : 660)} ROWS ONLY;");

            stringBuilder.Append(countStringBuilder);
            return stringBuilder.ToString();
        }
    }
}
