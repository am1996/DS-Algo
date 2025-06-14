using System;
using System.Security.Cryptography;
using System.Text;

namespace _5_lesson{
  class Program{
    public static string GenerateNTLMHash(string Password){
      byte[] bytes = Encoding.Unicode.GetBytes("Password");
      using var md4 = new MD4();
      return BitConverter.ToString(md4.ComputeHash(bytes)).Replace("-","").ToLower();
    }
    public static void Main(string[] args){
      Console.WriteLine(GenerateNTLMHash("Password"));
    }
  }
}