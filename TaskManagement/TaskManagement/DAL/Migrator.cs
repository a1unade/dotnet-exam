using Microsoft.EntityFrameworkCore;

namespace TaskManagement.DAL;

public class Migrator(TaskDbContext context, ILogger<Migrator> logger)
{
    public async Task MigrateAsync()
    {
        try
        {
            await context.Database.MigrateAsync().ConfigureAwait(false);
        }
        catch (Exception e)
        {
            logger.LogError(e, e.Message);
            throw;
        }
    }
}