using TaskManagement.DAL;
using TaskManagement.Models;

namespace TaskManagement.GraphQL;

public class Mutation
{
    [GraphQLDescription("Создать задачу")]
    public async Task<TaskItem> AddTask(string title, [Service] TaskDbContext db)
    {
        var task = new TaskItem { Title = title };
        db.Tasks.Add(task);
        await db.SaveChangesAsync();
        return task;
    }

    [GraphQLDescription("Обновить задачу")]
    public async Task<TaskItem?> UpdateTask(Guid id, string? title, string? description, [Service] TaskDbContext db)
    {
        var task = await db.Tasks.FindAsync(id);
        if (task == null) return null;

        task.Title = title ?? task.Title;
        task.Description = description ?? task.Description;

        await db.SaveChangesAsync();
        return task;
    }

    [GraphQLDescription("Удалить задачу")]
    public async Task<bool> DeleteTask(Guid id, [Service] TaskDbContext db)
    {
        var task = await db.Tasks.FindAsync(id);
        if (task == null) return false;

        db.Tasks.Remove(task);
        await db.SaveChangesAsync();
        return true;
    }
}