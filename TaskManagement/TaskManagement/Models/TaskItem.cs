using System.ComponentModel.DataAnnotations;

namespace TaskManagement.Models;

public class TaskItem
{
    /// <summary>
    /// ID задачи
    /// </summary>
    public int Id { get; set; }

    /// <summary>
    /// Название задачи
    /// </summary>
    [MaxLength(120)]
    public string Title { get; set; } = "";
    
    /// <summary>
    /// Описание задачи
    /// </summary>
    [MaxLength(200)]
    public string Description { get; set; } = "";
}