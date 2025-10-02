using Core.DataAccess.Dapper;
using Core.Toolkit.Results;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using WebApiProje.Extensions.QueryBuilder;
using WebApiProje.Models.Dto;
using WebApiProje.Models.Entity;
using WebApiProje.Models.Request.Unvan;
using WebApiProje.Models.Request.Dto;
using WebApiProje.Query.Entity;


namespace WebApiProje.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DersPersonelController : ControllerBase
    {
        private readonly IDbConnection _dbConnection;
        private IConfiguration _configuration;
        public DersPersonelController(IDbConnection dbConnection, IConfiguration configuration)
        {
            _dbConnection = dbConnection;
            _configuration = configuration;
        }

        [Consumes("application/json")]
        [Produces("application/json", "text/plain")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<IEnumerable<DersPersonel>>))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        [HttpGet("/derspersonel/search")]
        public async Task<IActionResult> Search([FromQuery] DersPersonelSearchRequest request)
        {
            var records = await new DapperRepository(_dbConnection).GetMultipleAsync(
                 GetDersPersonelSearchSqlQueryBuilderExtensions
                .GetDersPersonelSearchSqlQuery(request));

            var datas = await records.ReadAsync<DersPersonelSearchDto>();
            var count = await records.ReadFirstOrDefaultAsync<int>();

            var result = new SuccessDataResult<IEnumerable<DersPersonelSearchDto>>(datas, count);
            if (result.IsSuccess)
            {
                return Ok(result);
            }

            return NotFound(result);
        }

        
    }
}
