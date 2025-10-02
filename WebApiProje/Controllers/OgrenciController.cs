using Core.DataAccess.Dapper;
using Core.Toolkit.Results;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using WebApiProje.Extensions.QueryBuilder;
using WebApiProje.Models.Entity;
using WebApiProje.Models.Request.Ders;
using WebApiProje.Models.Request.Dto;
using WebApiProje.Models.Request.Ogrenci;
using WebApiProje.Query.Entity;


namespace WebApiProje.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class OgrenciController : ControllerBase
    {
        private readonly IDbConnection _dbConnection;
        private IConfiguration _configuration;
        public OgrenciController(IDbConnection dbConnection, IConfiguration configuration)
        {
            _dbConnection = dbConnection;
            _configuration = configuration;
        }

        [Consumes("application/json")]
        [Produces("application/json", "text/plain")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<IEnumerable<Ogrenci>>))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        [HttpGet("/ogrenci/search")]
        public async Task<IActionResult> Search([FromQuery] OgrenciRequest request)
        {
            var records = await new DapperRepository(_dbConnection).GetMultipleAsync(
                 GetOgrenciSqlQueryBuilderExtensions
                .GetOgrenciSqlQuery(request));

            var datas = await records.ReadAsync<Ogrenci>();
            var count = await records.ReadFirstOrDefaultAsync<int>();

            var result = new SuccessDataResult<IEnumerable<Ogrenci>>(datas, count);
            if (result.IsSuccess)
            {
                return Ok(result);
            }

            return NotFound(result);
        }

        //[Consumes("application/json")]
        //[Produces("application/json", "text/plain")]
        //[ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<Ogrenci>))]
        //[ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        //[HttpPost("/Ogrenci/insert")]
        //public async Task<IActionResult> insert(OgrenciAdiRequest request)
        //{
        //    var record = await new DapperRepository(_dbConnection).QueryFirstOrDefaultAsync<Ogrenci>(
        //         OgrenciQuery
        //        .InsertOgrenciSql,request);


        //    var result = new SuccessDataResult<Ilce>(record);
        //    if (result.IsSuccess)
        //    {
        //        return Ok(result);
        //    }

        //    return NotFound(result);
        //}

        //[Consumes("application/json")]
        //[Produces("application/json", "text/plain")]
        //[ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<Ilce>))]
        //[ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        //[HttpPost("/Ilce/update")]
        //public async Task<IActionResult> update(IlceBaseRequest request)
        //{
        //    var record = await new DapperRepository(_dbConnection).QueryFirstOrDefaultAsync<Ilce>(
        //         OgrenciQuery
        //        .UpdateIlceSql, request);


        //    var result = new SuccessDataResult<Ilce>(record);
        //    if (result.IsSuccess)
        //    {
        //        return Ok(result);
        //    }

        //    return NotFound(result);
        //}

        //[Consumes("application/json")]
        //[Produces("application/json", "text/plain")]
        //[ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IDataResult<Ilce>))]
        //[ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(Core.Toolkit.Results.IResult))]
        //[HttpPost("/Ilce/delete")]
        //public async Task<IActionResult> delete(IdRequest request)
        //{
        //    int rowsAffected  = await new DapperRepository(_dbConnection).ExecuteAsync(
        //         OgrenciQuery
        //        .DeleteIlceSql, request);


        //    var result = new SuccessDataResult<int>(rowsAffected);
        //    if (result.IsSuccess)
        //    {
        //        return Ok(result);
        //    }

        //    return NotFound(result);
        //}
    }
}
