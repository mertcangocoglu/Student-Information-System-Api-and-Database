using Core.DataAccess.Dapper;
using Core.Toolkit.Results;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using WebApiProje.Extensions.QueryBuilder;
using WebApiProje.Models.Entity;
using WebApiProje.Models.Request.Dto;
using WebApiProje.Models.Request.Ders;
using WebApiProje.Query.Entity;


namespace WebApiProje.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DersController : ControllerBase
    {
        private readonly IDbConnection _dbConnection;
        private IConfiguration _configuration;
        public DersController(IDbConnection dbConnection, IConfiguration configuration)
        {
            _dbConnection = dbConnection;
            _configuration = configuration;
        }

        [Consumes("application/json")]
        [Produces("application/json", "text/plain")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<IEnumerable<Ders>>))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        [HttpGet("/ders/search")]
        public async Task<IActionResult> Search([FromQuery] DersRequest request)
        {
            var records = await new DapperRepository(_dbConnection).GetMultipleAsync(
                 GetDersSqlQueryBuilderExtensions
                .GetDersSqlQuery(request));

            var datas = await records.ReadAsync<Ders>();
            var count = await records.ReadFirstOrDefaultAsync<int>();


            var result = new SuccessDataResult<IEnumerable<Ders>>(datas, count);
            if (result.IsSuccess)
            {
                return Ok(result);
            }

            return NotFound(result);
        }

        //[Consumes("application/json")]
        //[Produces("application/json", "text/plain")]
        //[ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<Bolum>))]
        //[ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        //[HttpPost("/kategori/insert")]
        //public async Task<IActionResult> insert(KategoriAdiRequest request)
        //{
        //    var record = await new DapperRepository(_dbConnection).QueryFirstOrDefaultAsync<Bolum>(
        //         KategoriQuery
        //        .InsertKategoriSql,request);


        //    var result = new SuccessDataResult<Bolum>(record);
        //    if (result.IsSuccess)
        //    {
        //        return Ok(result);
        //    }

        //    return NotFound(result);
        //}

        //[Consumes("application/json")]
        //[Produces("application/json", "text/plain")]
        //[ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<Bolum>))]
        //[ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        //[HttpPost("/kategori/update")]
        //public async Task<IActionResult> update(KategoriBaseRequest request)
        //{
        //    var record = await new DapperRepository(_dbConnection).QueryFirstOrDefaultAsync<Bolum>(
        //         KategoriQuery
        //        .UpdateKategoriSql, request);


        //    var result = new SuccessDataResult<Bolum>(record);
        //    if (result.IsSuccess)
        //    {
        //        return Ok(result);
        //    }

        //    return NotFound(result);
        //}

        //[Consumes("application/json")]
        //[Produces("application/json", "text/plain")]
        //[ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<Bolum>))]
        //[ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        //[HttpPost("/kategori/delete")]
        //public async Task<IActionResult> delete(IdRequest request)
        //{
        //    int rowsAffected  = await new DapperRepository(_dbConnection).ExecuteAsync(
        //         KategoriQuery
        //        .DeleteKategoriSql, request);


        //    var result = new SuccessDataResult<int>(rowsAffected);
        //    if (result.IsSuccess)
        //    {
        //        return Ok(result);
        //    }

        //    return NotFound(result);
        //}
    }
}
