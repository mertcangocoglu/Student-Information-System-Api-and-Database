using System.Text;
using WebApiProje.Query.Entity;
using Core.Extensions;
using WebApiProje.Models.Request.Ogrenci;
using WebApiProje.Models.Request.Dto;

namespace WebApiProje.Extensions.QueryBuilder
{
    public class GetRestoranSearchSqlQueryBuilderExtensions
    {
        public static string GetRestoranSearchSqlQuery(RestoranSearchRequest request)
        {
            var stringBuilder = new StringBuilder(RestoranSearchQuery.GetRestoranSearchSql);

            var countStringBuilder = new StringBuilder(RestoranSearchQuery.GetRestoranSearchCountSql);

            var whereClauses = new List<string>();
            

            if (request.KategoriId.IsNotNull() && request.KategoriId.IsNotDefault())
            {
                whereClauses.Add($"RestoranYemek.KategoriId= '{request.KategoriId}'");
            }
            if (request.YemekId.IsNotNull() && request.YemekId.IsNotDefault())
            {
                whereClauses.Add($"RestoranYemek.YemekId= '{request.YemekId}'");
            }
            if (request.SehirId.IsNotNull() && request.SehirId.IsNotDefault())
            {
                whereClauses.Add($"Restoran.SehirId= '{request.SehirId}'");
            }
            if (request.IlceId.IsNotNull() && request.IlceId.IsNotDefault())
            {
                whereClauses.Add($"Restoran.IlceId= '{request.IlceId}'");
            }
            if (request.RestoranId.IsNotNull() && request.RestoranId.IsNotDefault())
            {
                whereClauses.Add($"Restoran.Id= '{request.RestoranId}'");
            }
            if (!string.IsNullOrEmpty(request.YemekAdi) && request.YemekAdi.IsNotDefault())
            {
                whereClauses.Add($"Yemek.Adi like '%{request.YemekAdi}%'");
            }
            if (!string.IsNullOrEmpty(request.RestoranAdi) && request.RestoranAdi.IsNotDefault())
            {
                whereClauses.Add($"Restoran.Adi like '%{request.RestoranAdi}%'");
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
                    case "id" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY Restoran.Id {request.OrderBy.Type}");
                            break;
                        }
                    case "sehirid" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY Restoran.SehirId {request.OrderBy.Type}");
                            break;
                        }
                    case "adi" when request.OrderBy.Type.IsNotNull():
                        {
                            stringBuilder.Append($" ORDER BY Restoran.Adi {request.OrderBy.Type}");
                            break;
                        }
                   
                    default:
                        {
                            stringBuilder.Append(" ORDER BY Restoran.Adi ASC");
                            break;
                        }
                }
            }
            else
            {
                stringBuilder.Append(" ORDER BY Restoran.Adi ASC");
            }

            stringBuilder.Append($" OFFSET {request.StartIndex} ROWS FETCH NEXT {(request.MaxCount.IsNotDefault() ? request.MaxCount : 25)} ROWS ONLY;");

            stringBuilder.Append(countStringBuilder);
            return stringBuilder.ToString();
        }
    }
}
