using System.Text;
using WebApiProje.Query.Entity;
using Core.Extensions;
using WebApiProje.Models.Request.Unvan;

namespace WebApiProje.Extensions.QueryBuilder
{
    public class GetUnvanSqlQueryBuilderExtensions
    {
        public static string GetUnvanSqlQuery(UnvanRequest request)
        {
            var stringBuilder = new StringBuilder(UnvanQuery.GetUnvanSql);

            var countStringBuilder = new StringBuilder(UnvanQuery.GetUnvanCountSql);

            var whereClauses = new List<string>();
            

            if (request.Unvan_No.IsNotNull() && request.Unvan_No.IsNotDefault())
            {
                whereClauses.Add($"unvanlar.Unvan_No= '{request.Unvan_No}'");
            }
            
            if (!string.IsNullOrEmpty(request.Unvan_Ad) && request.Unvan_Ad.IsNotDefault())
            {
                whereClauses.Add($"unvanlar.Unvan_Ad like '%{request.Unvan_Ad}%'");
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
                    case "unvan_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY unvanlar.Unvan_No {request.OrderBy.Type}");
                            break;
                        }
                    case "unvan_ad" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY unvanlar.Unvan_Ad {request.OrderBy.Type}");
                            break;
                        }
                    default:
                        {
                            stringBuilder.Append(" ORDER BY unvanlar.Unvan_No ASC");
                            break;
                        }
                }
            }
            else
            {
                stringBuilder.Append(" ORDER BY unvanlar.Unvan_No ASC");
            }

            stringBuilder.Append($" OFFSET {request.StartIndex} ROWS FETCH NEXT {(request.MaxCount.IsNotDefault() ? request.MaxCount : 13)} ROWS ONLY;");

            stringBuilder.Append(countStringBuilder);
            return stringBuilder.ToString();
        }
    }
}
