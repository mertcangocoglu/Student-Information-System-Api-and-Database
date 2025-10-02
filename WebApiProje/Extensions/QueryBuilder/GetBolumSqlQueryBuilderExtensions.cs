using System.Text;
using WebApiProje.Query.Entity;
using Core.Extensions;
using WebApiProje.Models.Request.Bolum;

namespace WebApiProje.Extensions.QueryBuilder
{
    public class GetBolumSqlQueryBuilderExtensions
    {
        public static string GetBolumSqlQuery(BolumRequest request)
        {
            var stringBuilder = new StringBuilder(BolumQuery.GetBolumSql);

            var countStringBuilder = new StringBuilder(BolumQuery.GetBolumCountSql);

            var whereClauses = new List<string>();
            

            if (request.B_No.IsNotNull() && request.B_No.IsNotDefault())
            {
                whereClauses.Add($"bolumler.B_No= '{request.B_No}'");
            }
            
            if (!string.IsNullOrEmpty(request.B_Ad) && request.B_Ad.IsNotDefault())
            {
                whereClauses.Add($"bolumler.B_Ad like '%{request.B_Ad}%'");
            }

            if (request.F_No.IsNotNull() && request.F_No.IsNotDefault())
            {
                whereClauses.Add($"bolumler.F_No= '{request.F_No}'");
            }

            if (request.Tur_No.IsNotNull() && request.Tur_No.IsNotDefault())
            {
                whereClauses.Add($"bolumler.Tur_No= '{request.Tur_No}'");
            }

            if (request.BB_Sicil_No.IsNotNull() && request.BB_Sicil_No.IsNotDefault())
            {
                whereClauses.Add($"bolumler.BB_Sicil_No= '{request.BB_Sicil_No}'");
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
                    case "b_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY bolumler.B_No {request.OrderBy.Type}");
                            break;
                        }
                    case "b_ad" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY bolumler.B_Ad {request.OrderBy.Type}");
                            break;
                        }
                    case "f_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY bolumler.F_No {request.OrderBy.Type}");
                            break;
                        }
                    case "tur_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY bolumler.Tur_No {request.OrderBy.Type}");
                            break;
                        }
                    case "bb_sicil_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY bolumler.BB_Sicil_No {request.OrderBy.Type}");
                            break;
                        }

                    default:
                        {
                            stringBuilder.Append(" ORDER BY bolumler.B_No ASC");
                            break;
                        }
                }
            }
            else
            {
                stringBuilder.Append(" ORDER BY bolumler.B_No ASC");
            }

            stringBuilder.Append($" OFFSET {request.StartIndex} ROWS FETCH NEXT {(request.MaxCount.IsNotDefault() ? request.MaxCount : 25)} ROWS ONLY;");

            stringBuilder.Append(countStringBuilder);
            return stringBuilder.ToString();
        }
    }
}
