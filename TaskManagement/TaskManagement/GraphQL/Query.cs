using Microsoft.EntityFrameworkCore;
using TaskManagement.DAL;
using TaskManagement.Models;

namespace TaskManagement.GraphQL;

public class Query
{
    [UseSorting]
    [UseFiltering]
    [GraphQLDescription("Получение задач")]
    public IQueryable<TaskItem> GetTasks([Service] TaskDbContext db) =>
        db.Tasks.AsNoTracking();
}