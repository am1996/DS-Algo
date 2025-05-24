using System;

namespace _3_lesson;

public class Program{
    public static void Main(string[] args){
        IEnumerable<int> numbers = Enumerable.Range(1,200);
        IQueryable<int> numbers2 = numbers.AsQueryable();
        var result = from number in numbers where number%6==3 select number;
        foreach(int i in result){
          Console.WriteLine(i);
        }
    }
}