using Core.DataAccess.Dapper;
using Core.Toolkit.Results;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using WebApiProje.Extensions.QueryBuilder;
using WebApiProje.Models.Dto;
using WebApiProje.Models.Entity;
using WebApiProje.Models.Request.Dto;
using WebApiProje.Query.Entity;


namespace WebApiProje.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RestoranController : ControllerBase
    {
        private readonly IDbConnection _dbConnection;
        private IConfiguration _configuration;
        public RestoranController(IDbConnection dbConnection, IConfiguration configuration)
        {
            _dbConnection = dbConnection;
            _configuration = configuration;
        }

        [Consumes("application/json")]
        [Produces("application/json", "text/plain")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<IEnumerable<Restoran>>))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        [HttpPost("/restoran/search")]
        public async Task<IActionResult> Search(RestoranSearchRequest request)
        {
            var records = await new DapperRepository(_dbConnection).GetMultipleAsync(
                 GetRestoranSearchSqlQueryBuilderExtensions
                .GetRestoranSearchSqlQuery(request));

            var datas = await records.ReadAsync<RestoranSearchDto>();
            var count = await records.ReadFirstOrDefaultAsync<int>();

            var result = new SuccessDataResult<IEnumerable<RestoranSearchDto>>(datas, count);
            if (result.IsSuccess)
            {
                return Ok(result);
            }

            return NotFound(result);
        }

        
    }
}
