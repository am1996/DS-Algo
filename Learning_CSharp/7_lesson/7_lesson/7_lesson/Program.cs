using System.Security.Cryptography;

namespace Learning_CSharp
{
    class FileEncrypter
    {
        private static readonly string Password = "MySuperSecretPassword";
        private static readonly int KeySize = 256;        // AES-256
        private static readonly int DerivationIterations = 10000;
        private static readonly int BlockSize = 128;      // AES block size

        public static void EncryptFile(string infile, string outfile)
        {
            // Implementation for encrypting the file
            if (string.IsNullOrEmpty(infile))
            {
                throw new ArgumentException("File path cannot be null or empty.", nameof(infile));
            }
            byte[] salt = RandomNumberGenerator.GetBytes(32);
            // Continue with encryption process
            var key = new Rfc2898DeriveBytes(Password, salt, DerivationIterations);
            using (var output = new FileStream(outfile, FileMode.Create))
            {
                output.Write(salt, 0, salt.Length);
                using (var aes = Aes.Create())
                {
                    aes.Key = key.GetBytes(KeySize / 8);
                    aes.Mode = CipherMode.CBC;
                    aes.Padding = PaddingMode.PKCS7;
                    aes.GenerateIV();
                    output.Write(aes.IV, 0, aes.IV.Length);

                    using (var cryptoStream = new CryptoStream(output, aes.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        using (var input = new FileStream(infile, FileMode.Open))
                        {
                            input.CopyTo(cryptoStream);
                        }
                    }
                }
            }
            Console.WriteLine($"Encrypted: {infile} → {outfile}");
        }

        public static byte[] DecryptFile(string infile)
        {
            // Implementation for decrypting the file
            if (string.IsNullOrEmpty(infile))
            {
                throw new ArgumentException("File path cannot be null or empty.", nameof(infile));
            }
            byte[] salt = new byte[32];
            byte[] iv = new byte[16];
            using (var input = new FileStream(infile, FileMode.Open))
            {
                input.Read(salt, 0, salt.Length);
                input.ReadExactly(iv);
                using (var aes = Aes.Create())
                {
                    aes.Key = new Rfc2898DeriveBytes(Password, salt, DerivationIterations).GetBytes(KeySize / 8);
                    aes.IV = iv;
                    aes.Mode = CipherMode.CBC;
                    aes.Padding = PaddingMode.PKCS7;
                    using (var cryptoStream = new CryptoStream(input, aes.CreateDecryptor(), CryptoStreamMode.Read))
                    {
                        using (var output = new MemoryStream())
                        {
                            cryptoStream.CopyTo(output);
                            return output.ToArray();
                        }
                    }
                }
            }
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length < 2)
            {
                Console.WriteLine("Usage: Learning_CSharp <encrypt|decrypt> <input file> [output file]");
                return;
            }

            string command = args[0].ToLower();
            string inputFile = args[1];
            string outputFile = args.Length > 2 ? args[2] : $"{inputFile}.enc";

            try
            {
                if (command == "encrypt")
                {
                    FileEncrypter.EncryptFile(inputFile, outputFile);
                }
                else if (command == "decrypt")
                {
                    byte[] decryptedData = FileEncrypter.DecryptFile(inputFile);
                    File.WriteAllBytes(outputFile, decryptedData);
                    Console.WriteLine($"Decrypted: {inputFile} → {outputFile}");
                }
                else
                {
                    Console.WriteLine("Invalid command. Use 'encrypt' or 'decrypt'.");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
            }
        }
    }
}