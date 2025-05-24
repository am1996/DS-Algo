using System;
using System.Diagnostics;
using System.Text;
using System.Text.Json;
using HtmlAgilityPack;
using System;
using System.Linq;

namespace _2_Lesson;
record Todo(int userId, int id, string title, bool completed);
class Program{
  public static async Task Main(string[] args){
    using HttpClient client = new HttpClient();
    string response = await client.GetAsync("https://jsonplaceholder.typicode.com/todos/").Result.EnsureSuccessStatusCode().Content.ReadAsStringAsync();
    List<Todo> todo = JsonSerializer.Deserialize<List<Todo>>(response);
    Console.WriteLine(todo[0]);
    string response2 = await client.GetAsync("https://wuzzuf.net/search/jobs/?a=hpb&q=web%20developer&start=19").Result.EnsureSuccessStatusCode().Content.ReadAsStringAsync();
    var htmlDoc = new HtmlDocument();
    htmlDoc.LoadHtml(response2);
    var jobs = htmlDoc.DocumentNode.SelectNodes("//div[@class='css-1gatmva e1v1l3u10']");
    foreach(var job in jobs){
      Console.WriteLine(job.InnerText);
    }
  }
}