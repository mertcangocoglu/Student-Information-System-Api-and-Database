using System.Text;
using WebApiProje.Query.Entity;
using Core.Extensions;
using WebApiProje.Models.Request.Fakulte;

namespace WebApiProje.Extensions.QueryBuilder
{
    public class GetFakulteSqlQueryBuilderExtensions
    {
        public static string GetFakulteSqlQuery(FakulteRequest request)
        {
            var stringBuilder = new StringBuilder(FakulteQuery.GetFakulteSql);

            var countStringBuilder = new StringBuilder(FakulteQuery.GetFakulteCountSql);

            var whereClauses = new List<string>();
            

            if (request.F_No.IsNotNull() && request.F_No.IsNotDefault())
            {
                whereClauses.Add($"fakulteler.F_No= '{request.F_No}'");
            }
            
            if (!string.IsNullOrEmpty(request.F_Ad) && request.F_Ad.IsNotDefault())
            {
                whereClauses.Add($"fakulteler.F_Ad like '%{request.F_Ad}%'");
            }

            if (!string.IsNullOrEmpty(request.Adres) && request.Adres.IsNotDefault())
            {
                whereClauses.Add($"fakulteler.Adres like '%{request.Adres}%'");
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
                    case "f_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY fakulteler.F_No {request.OrderBy.Type}");
                            break;
                        }
                    case "f_ad" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY fakulteler.F_Ad {request.OrderBy.Type}");
                            break;
                        }
                    case "adres" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY fakulteler.Adres {request.OrderBy.Type}");
                            break;
                        }

                    default:
                        {
                            stringBuilder.Append(" ORDER BY fakulteler.F_No ASC");
                            break;
                        }
                }
            }
            else
            {
                stringBuilder.Append(" ORDER BY fakulteler.F_No ASC");
            }

            stringBuilder.Append($" OFFSET {request.StartIndex} ROWS FETCH NEXT {(request.MaxCount.IsNotDefault() ? request.MaxCount : 37)} ROWS ONLY;");

            stringBuilder.Append(countStringBuilder);
            return stringBuilder.ToString();
        }
    }
}
