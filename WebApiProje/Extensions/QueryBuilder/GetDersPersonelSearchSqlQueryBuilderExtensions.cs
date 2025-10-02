using System.Text;
using WebApiProje.Query.Entity;
using Core.Extensions;
using WebApiProje.Models.Request.Unvan;
using WebApiProje.Models.Request.Dto;

namespace WebApiProje.Extensions.QueryBuilder
{
    public class GetDersPersonelSearchSqlQueryBuilderExtensions
    {
        public static string GetDersPersonelSearchSqlQuery(DersPersonelSearchRequest request)
        {
            var stringBuilder = new StringBuilder(DersPersonelSearchQuery.GetDersPersonelSearchSql);

            var countStringBuilder = new StringBuilder(DersPersonelSearchQuery.GetDersPersonelSearchCountSql);

            var whereClauses = new List<string>();
            

            if (request.Kayit_No.IsNotNull() && request.Kayit_No.IsNotDefault())
            {
                whereClauses.Add($"dersler_personeller.Kayit_No= '{request.Kayit_No}'");
            }
            if (!string.IsNullOrEmpty(request.D_Kod) && request.D_Kod.IsNotDefault())
            {
                whereClauses.Add($"dersler_personeller.D_Kod= '{request.D_Kod}'");
            }
            if (!string.IsNullOrEmpty(request.D_Ad) && request.D_Ad.IsNotDefault())
            {
                whereClauses.Add($"dersler.D_Ad= '{request.D_Ad}'");
            }
            if (!string.IsNullOrEmpty(request.Sicil_No) && request.Sicil_No.IsNotDefault())
            {
                whereClauses.Add($"dersler_personeller.Sicil_No= '{request.Sicil_No}'");
            }
            if (!string.IsNullOrEmpty(request.Ad_Soyad) && request.Ad_Soyad.IsNotDefault())
            {
                whereClauses.Add($"kimlik.Ad + ' ' +kimlik.Soyad like '%{request.Ad_Soyad}%'");
            }
            if (request.Unvan_No.IsNotNull() && request.Unvan_No.IsNotDefault())
            {
                whereClauses.Add($"personeller.Unvan_No= '{request.Unvan_No}'");
            }
            if (!string.IsNullOrEmpty(request.Unvan_Ad) && request.Unvan_Ad.IsNotDefault())
            {
                whereClauses.Add($"unvanlar.Unvan_Ad like '%{request.Unvan_Ad}%'");
            }
            if (!string.IsNullOrEmpty(request.B_Ad) && request.B_Ad.IsNotDefault())
            {
                whereClauses.Add($"bolumler.B_Ad like '%{request.B_Ad}%'");
            }
            if (!string.IsNullOrEmpty(request.Eposta) && request.Eposta.IsNotDefault())
            {
                whereClauses.Add($"kimlik.eposta like '%{request.Eposta}%'");
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
                            stringBuilder.Append($" ORDER BY dersler_personeller.Kayit_No {request.OrderBy.Type}");
                            break;
                        }
                    case "d_kod" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY dersler_personeller.D_Kod {request.OrderBy.Type}");
                            break;
                        }
                    case "d_ad" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY dersler.D_Ad {request.OrderBy.Type}");
                            break;
                        }
                    case "sicil_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY dersler_personeller.Sicil_No {request.OrderBy.Type}");
                            break;
                        }
                    case "ad_soyad" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY kimlik.Ad + ' ' + kimlik.Soyad {request.OrderBy.Type}");
                            break;
                        }
                    case "unvan_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY personeller.Unvan_No {request.OrderBy.Type}");
                            break;
                        }

                    case "unvan_ad" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY unvanlar.Unvan_Ad {request.OrderBy.Type}");
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
                            stringBuilder.Append(" ORDER BY dersler_personeller.Kayit_No ASC");
                            break;
                        }
                }
            }
            else
            {
                stringBuilder.Append(" ORDER BY dersler_personeller.Kayit_No ASC");
            }

            stringBuilder.Append($" OFFSET {request.StartIndex} ROWS FETCH NEXT {(request.MaxCount.IsNotDefault() ? request.MaxCount : 100)} ROWS ONLY;");

            stringBuilder.Append(countStringBuilder);
            return stringBuilder.ToString();
        }
    }
}
