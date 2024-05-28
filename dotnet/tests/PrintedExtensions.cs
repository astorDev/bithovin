namespace Bithovin.Tests;

public static class PrintedExtensions
{
    public static T Printed<T>(this T arg, string? name = null)
    {
        Console.WriteLine();
        
        if (name == null)
        {
            Console.WriteLine(arg);    
        }
        else
        {
            Console.WriteLine($"{name}: {arg}");
        }
        
        return arg;
    }
}