using System;
using System.Diagnostics;
using System.Text;
using System.Text.Json;

namespace _2_Lesson;

class Program{
  public static async Task Main(string[] args){
    using HttpClient client = new HttpClient();
    string response = await client.GetAsync("https://jsonplaceholder.typicode.com/todos/").Result.EnsureSuccessStatusCode().Content.ReadAsStringAsync();
    
  }
}