using System;
using System.Security.Cryptography;
using System.Text;

namespace _5_lesson{
  class Program{
    public static void Main(string[] args){
      int[] a = [1,2,3,4,5,6,7,8,9,10];
      int[] b = [1,2,3,4,5,6,7,8,9,10];

      a.Zip(b,(x,y)=>x*y).ToList().ForEach(Console.WriteLine);
      int[] c = a.Skip(3).Take(4).ToArray();
      c.ToList().ForEach(Console.WriteLine);
    }
  }
}