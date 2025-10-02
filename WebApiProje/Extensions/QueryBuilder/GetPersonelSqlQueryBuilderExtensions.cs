using System.Text;
using WebApiProje.Query.Entity;
using Core.Extensions;
using WebApiProje.Models.Request.Personel;

namespace WebApiProje.Extensions.QueryBuilder
{
    public class GetPersonelSqlQueryBuilderExtensions
    {
        public static string GetPersonelSqlQuery(PersonelRequest request)
        {
            var stringBuilder = new StringBuilder(PersonelQuery.GetPersonelSql);

            var countStringBuilder = new StringBuilder(PersonelQuery.GetPersonelCountSql);

            var whereClauses = new List<string>();
            

            if (request.Sicil_No.IsNotNull() && request.Sicil_No.IsNotDefault())
            {
                whereClauses.Add($"personeller.Sicil_No= '{request.Sicil_No}'");
            }
            if (request.TC_Kimlik.IsNotNull() && request.TC_Kimlik.IsNotDefault())
            {
                whereClauses.Add($"personeller.TC_Kimlik= '{request.TC_Kimlik}'");
            }

            if (request.Unvan_No.IsNotNull() && request.TC_Kimlik.IsNotDefault())
            {
                whereClauses.Add($"personeller.Unvan_No like '%{request.Unvan_No}%'");
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
                    case "sicil_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY personeller.Sicil_No {request.OrderBy.Type}");
                            break;
                        }
                    case "tc_kimlik" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY personeller.TC_Kimlik {request.OrderBy.Type}");
                            break;
                        }
                    case "b_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY personeller.B_No {request.OrderBy.Type}");
                            break;
                        }
                    case "a_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY personeller.A_No {request.OrderBy.Type}");
                            break;
                        }
                    case "unvan_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY personeller.Unvan_No {request.OrderBy.Type}");
                            break;
                        }

                    default:
                        {
                            stringBuilder.Append(" ORDER BY personeller.TC_Kimlik ASC");
                            break;
                        }
                }
            }
            else
            {
                stringBuilder.Append(" ORDER BY personeller.TC_Kimlik ASC");
            }

            stringBuilder.Append($" OFFSET {request.StartIndex} ROWS FETCH NEXT {(request.MaxCount.IsNotDefault() ? request.MaxCount : 41)} ROWS ONLY;");

            stringBuilder.Append(countStringBuilder);
            return stringBuilder.ToString();
        }
    }
}
