using System;
using System.Security.Cryptography;

namespace _5_lesson{
    public class MD4 : HashAlgorithm
    {
        private uint A, B, C, D;
        private uint[] X = new uint[16];
        private byte[] buffer;
        private long count;
        private int bufferLength;

        public MD4()
        {
            buffer = new byte[64];
            Initialize();
        }

        public override void Initialize()
        {
            count = 0;
            bufferLength = 0;
            A = 0x67452301;
            B = 0xefcdab89;
            C = 0x98badcfe;
            D = 0x10325476;
        }

        protected override void HashCore(byte[] array, int ibStart, int cbSize)
        {
            int offset = 0;

            while (cbSize > 0)
            {
                int space = 64 - bufferLength;
                int copy = (cbSize < space) ? cbSize : space;

                Buffer.BlockCopy(array, ibStart + offset, buffer, bufferLength, copy);
                bufferLength += copy;
                offset += copy;
                cbSize -= copy;

                if (bufferLength == 64)
                {
                    ProcessBlock();
                    bufferLength = 0;
                }
            }
        }

        protected override byte[] HashFinal()
        {
            long bitCount = count * 8;
            buffer[bufferLength++] = 0x80;

            if (bufferLength > 56)
            {
                while (bufferLength < 64) buffer[bufferLength++] = 0;
                ProcessBlock();
                bufferLength = 0;
            }

            while (bufferLength < 56) buffer[bufferLength++] = 0;

            for (int i = 0; i < 8; i++)
                buffer[bufferLength++] = (byte)(bitCount >> (8 * i));

            ProcessBlock();

            byte[] result = new byte[16];
            Array.Copy(BitConverter.GetBytes(A), 0, result, 0, 4);
            Array.Copy(BitConverter.GetBytes(B), 0, result, 4, 4);
            Array.Copy(BitConverter.GetBytes(C), 0, result, 8, 4);
            Array.Copy(BitConverter.GetBytes(D), 0, result, 12, 4);
            return result;
        }

        private void ProcessBlock()
        {
            count += 64;

            for (int i = 0; i < 16; i++)
                X[i] = BitConverter.ToUInt32(buffer, i * 4);

            uint a = A, b = B, c = C, d = D;

            void R1(ref uint a, uint b, uint c, uint d, int k, int s)
            {
                a = RotateLeft(a + F(b, c, d) + X[k], s);
            }

            void R2(ref uint a, uint b, uint c, uint d, int k, int s)
            {
                a = RotateLeft(a + G(b, c, d) + X[k] + 0x5a827999, s);
            }

            void R3(ref uint a, uint b, uint c, uint d, int k, int s)
            {
                a = RotateLeft(a + H(b, c, d) + X[k] + 0x6ed9eba1, s);
            }

            // Round 1
            R1(ref a, b, c, d, 0, 3); R1(ref d, a, b, c, 1, 7); R1(ref c, d, a, b, 2, 11); R1(ref b, c, d, a, 3, 19);
            R1(ref a, b, c, d, 4, 3); R1(ref d, a, b, c, 5, 7); R1(ref c, d, a, b, 6, 11); R1(ref b, c, d, a, 7, 19);
            R1(ref a, b, c, d, 8, 3); R1(ref d, a, b, c, 9, 7); R1(ref c, d, a, b, 10, 11); R1(ref b, c, d, a, 11, 19);
            R1(ref a, b, c, d, 12, 3); R1(ref d, a, b, c, 13, 7); R1(ref c, d, a, b, 14, 11); R1(ref b, c, d, a, 15, 19);

            // Round 2
            R2(ref a, b, c, d, 0, 3); R2(ref d, a, b, c, 4, 5); R2(ref c, d, a, b, 8, 9); R2(ref b, c, d, a, 12, 13);
            R2(ref a, b, c, d, 1, 3); R2(ref d, a, b, c, 5, 5); R2(ref c, d, a, b, 9, 9); R2(ref b, c, d, a, 13, 13);
            R2(ref a, b, c, d, 2, 3); R2(ref d, a, b, c, 6, 5); R2(ref c, d, a, b, 10, 9); R2(ref b, c, d, a, 14, 13);
            R2(ref a, b, c, d, 3, 3); R2(ref d, a, b, c, 7, 5); R2(ref c, d, a, b, 11, 9); R2(ref b, c, d, a, 15, 13);

            // Round 3
            R3(ref a, b, c, d, 0, 3); R3(ref d, a, b, c, 8, 9); R3(ref c, d, a, b, 4, 11); R3(ref b, c, d, a, 12, 15);
            R3(ref a, b, c, d, 2, 3); R3(ref d, a, b, c, 10, 9); R3(ref c, d, a, b, 6, 11); R3(ref b, c, d, a, 14, 15);
            R3(ref a, b, c, d, 1, 3); R3(ref d, a, b, c, 9, 9); R3(ref c, d, a, b, 5, 11); R3(ref b, c, d, a, 13, 15);
            R3(ref a, b, c, d, 3, 3); R3(ref d, a, b, c, 11, 9); R3(ref c, d, a, b, 7, 11); R3(ref b, c, d, a, 15, 15);

            A += a; B += b; C += c; D += d;
        }

        private static uint F(uint x, uint y, uint z) => (x & y) | (~x & z);
        private static uint G(uint x, uint y, uint z) => (x & y) | (x & z) | (y & z);
        private static uint H(uint x, uint y, uint z) => x ^ y ^ z;

        private static uint RotateLeft(uint x, int n) => (x << n) | (x >> (32 - n));

        public override int HashSize => 128;
    }
}
