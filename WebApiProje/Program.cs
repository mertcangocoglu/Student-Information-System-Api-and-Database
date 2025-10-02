using System.Data.SqlClient;
using System.Data;
using WebApiProje.IoC;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


//sonradan eklenenler start

builder.Services.AddScoped<IDbConnection>(_ => new SqlConnection(
builder.Configuration.GetConnectionString("DbLocalConnection")));
builder.Services.AddHttpContextAccessor();
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowOrigin",
        builder => builder.AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader()
            .AllowAnyOrigin());
});

//sonradan eklenenler end

var app = builder.Build();

// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
    app.UseSwagger();
    app.UseSwaggerUI();
//}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();


//sonradan eklenenler start
ServiceTool.ServiceProvider = app.Services;
var configurationManager = app.Services.GetService<ConfigurationManager>();

app.UseCors(b => b
            .WithOrigins("http://domain.com",
                "http://domain2.com",
                "http://localhost:7116",
                "https://localhost:7116",
                "http://localhost:5209",
                "https://localhost:3000",
                "http://localhost:3000",
                "http://127.0.0.1:5500"
               )
            .AllowAnyMethod()
            .AllowAnyHeader()
            .AllowAnyOrigin()
        );




//sonradan eklenenler end
app.Run();
