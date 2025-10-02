using Core.DataAccess.Dapper;
using Core.Toolkit.Results;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using WebApiProje.Extensions.QueryBuilder;
using WebApiProje.Models.Entity;
using WebApiProje.Models.Request.Ders;
using WebApiProje.Models.Request.Dto;
using WebApiProje.Models.Request.Kimlik;
using WebApiProje.Query.Entity;


namespace WebApiProje.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KimlikController : ControllerBase
    {
        private readonly IDbConnection _dbConnection;
        private IConfiguration _configuration;
        public KimlikController(IDbConnection dbConnection, IConfiguration configuration)
        {
            _dbConnection = dbConnection;
            _configuration = configuration;
        }

        [Consumes("application/json")]
        [Produces("application/json", "text/plain")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<IEnumerable<Kimlik>>))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        [HttpGet("/kimlik/search")]
        public async Task<IActionResult> Search([FromQuery] KimlikRequest request)
        {
            var records = await new DapperRepository(_dbConnection).GetMultipleAsync(
                 GetKimlikSqlQueryBuilderExtensions
                .GetKimlikSqlQuery(request));

            var datas = await records.ReadAsync<Kimlik>();
            var count = await records.ReadFirstOrDefaultAsync<int>();

            var result = new SuccessDataResult<IEnumerable<Kimlik>>(datas, count);
            if (result.IsSuccess)
            {
                return Ok(result);
            }

            return NotFound(result);
        }

        //[Consumes("application/json")]
        //[Produces("application/json", "text/plain")]
        //[ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<Kimlik>))]
        //[ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        //[HttpPost("/Sehir/insert")]
        //public async Task<IActionResult> insert(SehirAdiRequest request)
        //{
        //    var record = await new DapperRepository(_dbConnection).QueryFirstOrDefaultAsync<Kimlik>(
        //         SehirQuery
        //        .InsertSehirSql,request);


        //    var result = new SuccessDataResult<Kimlik>(record);
        //    if (result.IsSuccess)
        //    {
        //        return Ok(result);
        //    }

        //    return NotFound(result);
        //}

        //[Consumes("application/json")]
        //[Produces("application/json", "text/plain")]
        //[ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<Kimlik>))]
        //[ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        //[HttpPost("/Sehir/update")]
        //public async Task<IActionResult> update(SehirBaseRequest request)
        //{
        //    var record = await new DapperRepository(_dbConnection).QueryFirstOrDefaultAsync<Kimlik>(
        //         SehirQuery
        //        .UpdateSehirSql, request);


        //    var result = new SuccessDataResult<Kimlik>(record);
        //    if (result.IsSuccess)
        //    {
        //        return Ok(result);
        //    }

        //    return NotFound(result);
        //}

        //[Consumes("application/json")]
        //[Produces("application/json", "text/plain")]
        //[ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<Kimlik>))]
        //[ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        //[HttpPost("/Sehir/delete")]
        //public async Task<IActionResult> delete(IdRequest request)
        //{
        //    int rowsAffected  = await new DapperRepository(_dbConnection).ExecuteAsync(
        //         SehirQuery
        //        .DeleteSehirSql, request);


        //    var result = new SuccessDataResult<int>(rowsAffected);
        //    if (result.IsSuccess)
        //    {
        //        return Ok(result);
        //    }

        //    return NotFound(result);
        //}
    }
}
