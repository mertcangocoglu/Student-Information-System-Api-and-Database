using Core.DataAccess.Dapper;
using Core.Toolkit.Results;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using WebApiProje.Extensions.QueryBuilder;
using WebApiProje.Models.Dto;
using WebApiProje.Models.Entity;
using WebApiProje.Models.Request.Bolum;
using WebApiProje.Models.Request.Dto;
using WebApiProje.Query.Entity;


namespace WebApiProje.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DersKayitController : ControllerBase
    {
        private readonly IDbConnection _dbConnection;
        private IConfiguration _configuration;
        public DersKayitController(IDbConnection dbConnection, IConfiguration configuration)
        {
            _dbConnection = dbConnection;
            _configuration = configuration;
        }

        [Consumes("application/json")]
        [Produces("application/json", "text/plain")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<IEnumerable<DersKayit>>))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        [HttpGet("/derskayit/search")]
        public async Task<IActionResult> Search([FromQuery] DersKayitSearchRequest request)
        {
            var records = await new DapperRepository(_dbConnection).GetMultipleAsync(
                 GetDersKayitSearchSqlQueryBuilderExtensions
                .GetDersKayitSearchSqlQuery(request));

            var datas = await records.ReadAsync<DersKayitSearchDto>();
            var count = await records.ReadFirstOrDefaultAsync<int>();

            var result = new SuccessDataResult<IEnumerable<DersKayitSearchDto>>(datas, count);
            if (result.IsSuccess)
            {
                return Ok(result);
            }

            return NotFound(result);
        }

        
    }
}
