using System.Text;
using WebApiProje.Query.Entity;
using Core.Extensions;
using WebApiProje.Models.Request.Ogrenci;

namespace WebApiProje.Extensions.QueryBuilder
{
    public class GetOgrenciSqlQueryBuilderExtensions
    {
        public static string GetOgrenciSqlQuery(OgrenciRequest request)
        {
            var stringBuilder = new StringBuilder(OgrenciQuery.GetOgrenciSql);

            var countStringBuilder = new StringBuilder(OgrenciQuery.GetOgrenciCountSql);

            var whereClauses = new List<string>();
            

            if (request.Ogrenci_No.IsNotNull() && request.Ogrenci_No.IsNotDefault())
            {
                whereClauses.Add($"ogrenci_kayit.Ogrenci_No= '{request.Ogrenci_No}'");
            }
            if (request.Tc_Kimlik.IsNotNull() && request.Tc_Kimlik.IsNotDefault())
            {
                whereClauses.Add($"ogrenci_kayit.Tc_Kimlik= '{request.Tc_Kimlik}'");
            }

            if (request.B_No.IsNotNull() && request.B_No.IsNotDefault())
            {
                whereClauses.Add($"kimlik.Ad like '%{request.B_No}%'");
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
                    case "ogrenci_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ogrenci_kayit.Ogrenci_No {request.OrderBy.Type}");
                            break;
                        }
                    case "tc_kimlik" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ogrenci_kayit.Tc_Kimlik {request.OrderBy.Type}");
                            break;
                        }
                    case "b_no" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ogrenci_kayit.B_No {request.OrderBy.Type}");
                            break;
                        }
                    case "gno" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY ogrenci_kayit.GNO {request.OrderBy.Type}");
                            break;
                        }
                   
                    default:
                        {
                            stringBuilder.Append(" ORDER BY ogrenci_kayit.B_No ASC");
                            break;
                        }
                }
            }
            else
            {
                stringBuilder.Append(" ORDER BY ogrenci_kayit.B_No ASC");
            }

            stringBuilder.Append($" OFFSET {request.StartIndex} ROWS FETCH NEXT {(request.MaxCount.IsNotDefault() ? request.MaxCount : 25)} ROWS ONLY;");

            stringBuilder.Append(countStringBuilder);
            return stringBuilder.ToString();
        }
    }
}
