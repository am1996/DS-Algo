using System;
using System.Diagnostics;

namespace _1_Lesson;

class Program{
  public static void Main(string[] args){
    Console.WriteLine("Hello, World!");
    Process p = Process.Start("bash", "-c echo Hello World");
    File.WriteAllText("test.txt","hello world");
  }
}