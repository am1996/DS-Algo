using System;
using System.Net.Sockets;
class Program{
  public static void Main(string[] args){
    string ip = "8.8.8.8";
    int port = 53;
    TcpClient client = new TcpClient(ip,port);
    NetworkStream stream = client.GetStream();
    StreamReader reader = new StreamReader(stream);
    while(reader.Peek()>=0){
      Console.WriteLine(reader.ReadLine());
    }
    reader.Close();
    client.Close();
  }
}