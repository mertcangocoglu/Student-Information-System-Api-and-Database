using System.Text;
using WebApiProje.Query.Entity;
using Core.Extensions;
using WebApiProje.Models.Request.Kimlik;

namespace WebApiProje.Extensions.QueryBuilder
{
    public class GetKimlikSqlQueryBuilderExtensions
    {
        public static string GetKimlikSqlQuery(KimlikRequest request)
        {
            var stringBuilder = new StringBuilder(KimlikQuery.GetKimlikSql);

            var countStringBuilder = new StringBuilder(KimlikQuery.GetKimlikCountSql);

            var whereClauses = new List<string>();
            

            if (request.Tc_Kimlik.IsNotNull() && request.Tc_Kimlik.IsNotDefault())
            {
                whereClauses.Add($"kimlik.Tc_Kimlik= '{request.Tc_Kimlik}'");
            }
            
            if (!string.IsNullOrEmpty(request.Ad) && request.Ad.IsNotDefault())
            {
                whereClauses.Add($"kimlik.Ad like '%{request.Ad}%'");
            }

            if (!string.IsNullOrEmpty(request.Soyad) && request.Soyad.IsNotDefault())
            {
                whereClauses.Add($"kimlik.Soyad like '%{request.Soyad}%'");
            }

            if (!string.IsNullOrEmpty(request.Eposta) && request.Eposta.IsNotDefault())
            {
                whereClauses.Add($"kimlik.Eposta like '%{request.Eposta}%'");
            }

            if (!string.IsNullOrEmpty(request.Adres) && request.Adres.IsNotDefault())
            {
                whereClauses.Add($"kimlik.Adres like '%{request.Adres}%'");
            }

            if (request.Telefon.IsNotNull() && request.Telefon.IsNotDefault())
            {
                whereClauses.Add($"kimlik.Telefon= '{request.Telefon}'");
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
                switch (request.OrderBy.Name.ToLower())
                {
                    case "tc_kimlik" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY kimlik.Tc_Kimlik {request.OrderBy.Type}");
                            break;
                        }
                    case "ad" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY kimlik.Ad {request.OrderBy.Type}");
                            break;
                        }
                    case "soyad" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY kimlik.Soyad {request.OrderBy.Type}");
                            break;
                        }
                    case "eposta" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY kimlik.Eposta {request.OrderBy.Type}");
                            break;
                        }
                    case "adres" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY kimlik.Adres {request.OrderBy.Type}");
                            break;
                        }
                    case "telefon" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY kimlik.Telefon {request.OrderBy.Type}");
                            break;
                        }

                    default:
                        {
                            stringBuilder.Append(" ORDER BY kimlik.Tc_Kimlik ASC");
                            break;
                        }
                }
            }
            else
            {
                stringBuilder.Append(" ORDER BY kimlik.Tc_Kimlik ASC");
            }

            stringBuilder.Append($" OFFSET {request.StartIndex} ROWS FETCH NEXT {(request.MaxCount.IsNotDefault() ? request.MaxCount : 61)} ROWS ONLY;");

            stringBuilder.Append(countStringBuilder);
            return stringBuilder.ToString();
        }
    }
}
