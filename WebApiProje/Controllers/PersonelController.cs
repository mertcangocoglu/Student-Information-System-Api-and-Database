using Core.DataAccess.Dapper;
using Core.Toolkit.Results;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using WebApiProje.Extensions.QueryBuilder;
using WebApiProje.Models.Entity;
using WebApiProje.Models.Request.Ders;
using WebApiProje.Models.Request.Dto;
using WebApiProje.Models.Request.Personel;
using WebApiProje.Query.Entity;


namespace WebApiProje.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PersonelController : ControllerBase
    {
        private readonly IDbConnection _dbConnection;
        private IConfiguration _configuration;
        public PersonelController(IDbConnection dbConnection, IConfiguration configuration)
        {
            _dbConnection = dbConnection;
            _configuration = configuration;
        }

        [Consumes("application/json")]
        [Produces("application/json", "text/plain")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<IEnumerable<Personel>>))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        [HttpGet("/personel/search")]
        public async Task<IActionResult> Search([FromQuery] PersonelRequest request)
        {
            var records = await new DapperRepository(_dbConnection).GetMultipleAsync(
                 GetPersonelSqlQueryBuilderExtensions
                .GetPersonelSqlQuery(request));

            var datas = await records.ReadAsync<Personel>();
            var count = await records.ReadFirstOrDefaultAsync<int>();

            var result = new SuccessDataResult<IEnumerable<Personel>>(datas, count);
            if (result.IsSuccess)
            {
                return Ok(result);
            }

            return NotFound(result);
        }

        //[Consumes("application/json")]
        //[Produces("application/json", "text/plain")]
        //[ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<Personel>))]
        //[ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        //[HttpPost("/Yemek/insert")]
        //public async Task<IActionResult> insert(YemekAdiRequest request)
        //{
        //    var record = await new DapperRepository(_dbConnection).QueryFirstOrDefaultAsync<Personel>(
        //         YemekQuery
        //        .InsertYemekSql,request);


        //    var result = new SuccessDataResult<Personel>(record);
        //    if (result.IsSuccess)
        //    {
        //        return Ok(result);
        //    }

        //    return NotFound(result);
        //}

        //[Consumes("application/json")]
        //[Produces("application/json", "text/plain")]
        //[ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<Personel>))]
        //[ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        //[HttpPost("/Yemek/update")]
        //public async Task<IActionResult> update(YemekBaseRequest request)
        //{
        //    var record = await new DapperRepository(_dbConnection).QueryFirstOrDefaultAsync<Personel>(
        //         YemekQuery
        //        .UpdateYemekSql, request);


        //    var result = new SuccessDataResult<Personel>(record);
        //    if (result.IsSuccess)
        //    {
        //        return Ok(result);
        //    }

        //    return NotFound(result);
        //}

        //[Consumes("application/json")]
        //[Produces("application/json", "text/plain")]
        //[ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<Personel>))]
        //[ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        //[HttpPost("/Yemek/delete")]
        //public async Task<IActionResult> delete(IdRequest request)
        //{
        //    int rowsAffected  = await new DapperRepository(_dbConnection).ExecuteAsync(
        //         YemekQuery
        //        .DeleteYemekSql, request);


        //    var result = new SuccessDataResult<int>(rowsAffected);
        //    if (result.IsSuccess)
        //    {
        //        return Ok(result);
        //    }

        //    return NotFound(result);
        //}
    }
}
