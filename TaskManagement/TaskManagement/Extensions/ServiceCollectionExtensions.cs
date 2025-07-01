using TaskManagement.Middleware;

namespace TaskManagement.Extensions;

public static class ServiceCollectionExtensions
{
    public static IApplicationBuilder UseExceptionMiddleware(this IApplicationBuilder builder)
    {
        return builder.UseMiddleware<ExceptionMiddleware>();
    }
}