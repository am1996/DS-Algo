using System;
using System.IO;
using System.Threading.Tasks;

namespace _2_Lesson;

public class AsyncLogger : IDisposable
{
    private StreamWriter _writer;

    public AsyncLogger(string filePath)
    {
        _writer = new StreamWriter(filePath, append: true)
        {
            AutoFlush = true
        };
    }

    public async Task LogAsync(string message)
    {
        await _writer.WriteLineAsync($"{DateTime.Now}: {message}");
    }

    public void Dispose()
    {
        _writer?.Dispose();
    }
}
