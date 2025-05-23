using System;
using System.Diagnostics;

namespace _1_Lesson;

class Circle{
  public int Diameter{get;set;}
  public Circle(int d){
    this.Diameter = d;
  }
  public static Circle operator +(Circle c1,Circle c2){
    return new Circle(c1.Diameter+c2.Diameter);
  }
}

static class CircleExtension{
  static int getDiameter(this Circle c){
    return c.Diameter;
  }
}

class Program{
  public static void Main(string[] args){
    object[] i = [1,2,3,4,"hello",5.5];
    byte[] bytes = [0x45,0xB,0xC];
    Dictionary<string, string> aq = new Dictionary<string, string> {
        { "1", "hello" },
        { "2", "world" }
    };
    Console.WriteLine(aq["1"]);
    foreach(object j in i){
      Console.WriteLine(j);
    }
    File.WriteAllText("text.txt","hello world",System.Text.Encoding.UTF8);
    Circle c1 = new(10);
    Circle c2 = new(20);
    Circle c3 = c1+c2;
    File.WriteAllBytes("textbytes.txt",bytes);
    byte[] bbb = File.ReadAllBytes("textbytes.txt");
    Console.WriteLine(bytes);
  }
}