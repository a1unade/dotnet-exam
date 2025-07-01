using Microsoft.EntityFrameworkCore;
using TaskManagement.DAL;
using TaskManagement.Extensions;
using TaskManagement.GraphQL;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddScoped<Migrator>();

builder.Services.AddDbContext<TaskDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("Postgres")));

builder.Services
    .AddGraphQLServer()
    .AddQueryType<Query>()
    .AddMutationType<Mutation>()
    .AddFiltering()
    .AddSorting();

builder.Services.AddCors(options =>
{
    options.AddPolicy("CorsPolicy",
        b => b.AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader());
});

var app = builder.Build();

using var scoped = app.Services.CreateScope();
var migrator = scoped.ServiceProvider.GetRequiredService<Migrator>();
await migrator.MigrateAsync();

app.UseCors("CorsPolicy");
app.UseExceptionMiddleware();
app.MapGraphQL();

app.Run();