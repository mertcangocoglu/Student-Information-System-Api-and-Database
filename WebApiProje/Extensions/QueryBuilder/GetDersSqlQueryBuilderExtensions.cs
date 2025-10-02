using System.Text;
using WebApiProje.Query.Entity;
using Core.Extensions;
using WebApiProje.Models.Request.Ders;

namespace WebApiProje.Extensions.QueryBuilder
{
    public class GetDersSqlQueryBuilderExtensions
    {
        public static string GetDersSqlQuery(DersRequest request)
        {
            var stringBuilder = new StringBuilder(DersQuery.GetDersSql);

            var countStringBuilder = new StringBuilder(DersQuery.GetDersCountSql);

            var whereClauses = new List<string>();
            

            if (!string.IsNullOrEmpty(request.D_Kod) && request.D_Kod.IsNotDefault())
            {
                whereClauses.Add($"dersler.D_Kod= '{request.D_Kod}'");
            }
            
            if (!string.IsNullOrEmpty(request.D_Ad) && request.D_Ad.IsNotDefault())
            {
                whereClauses.Add($"dersler.D_Ad like '%{request.D_Ad}%'");
            }

            if (request.B_No.IsNotNull() && request.B_No.IsNotDefault())
            {
                whereClauses.Add($"dersler.B_No= '{request.B_No}'");
            }

            if (request.Yariyil.IsNotNull() && request.Yariyil.IsNotDefault())
            {
                whereClauses.Add($"dersler.Yariyil= '{request.Yariyil}'");
            }

            if (request.AKTS.IsNotNull() && request.AKTS.IsNotDefault())
            {
                whereClauses.Add($"dersler.AKTS= '{request.AKTS}'");
            }


            if (!string.IsNullOrEmpty(request.D_Tur) && request.D_Tur.IsNotDefault())
            {
                whereClauses.Add($"dersler.D_Tur like '%{request.D_Tur}%'");
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
                    case "d_kod" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY dersler.D_Kod {request.OrderBy.Type}");
                            break;
                        }
                    case "d_ad" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY dersler.D_Ad {request.OrderBy.Type}");
                            break;
                        }
                    case "b_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY dersler.B_No {request.OrderBy.Type}");
                            break;
                        }
                    case "yariyil" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY dersler.Yariyil {request.OrderBy.Type}");
                            break;
                        }
                    case "akts" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY dersler.AKTS {request.OrderBy.Type}");
                            break;
                        }
                    case "d_tur" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY dersler.D_Tur {request.OrderBy.Type}");
                            break;
                        }

                    default:
                        {
                            stringBuilder.Append(" ORDER BY dersler.D_Kod ASC");
                            break;
                        }
                }
            }
            else
            {
                stringBuilder.Append(" ORDER BY dersler.D_Kod ASC");
            }

            stringBuilder.Append($" OFFSET {request.StartIndex} ROWS FETCH NEXT {(request.MaxCount.IsNotDefault() ? request.MaxCount : 70)} ROWS ONLY;");

            stringBuilder.Append(countStringBuilder);
            return stringBuilder.ToString();
        }
    }
}
