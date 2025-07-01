using Microsoft.EntityFrameworkCore;
using TaskManagement.Models;

namespace TaskManagement.DAL;

public class TaskDbContext : DbContext
{
    public TaskDbContext(DbContextOptions<TaskDbContext> options) : base(options) {}

    public DbSet<TaskItem> Tasks => Set<TaskItem>();
}
