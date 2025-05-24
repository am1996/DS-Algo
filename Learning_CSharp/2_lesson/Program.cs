using System;
using System.Diagnostics;
using System.Text;
using System.Text.Json;

namespace _2_Lesson;
record Todo(int userId, int id, string title, bool completed);
class Program{
  public static async Task Main(string[] args){
    using HttpClient client = new HttpClient();
    string response = await client.GetAsync("https://jsonplaceholder.typicode.com/todos/").Result.EnsureSuccessStatusCode().Content.ReadAsStringAsync();
    List<Todo> todo = JsonSerializer.Deserialize<List<Todo>>(response);
    Console.WriteLine(todo[0]);
  }
}