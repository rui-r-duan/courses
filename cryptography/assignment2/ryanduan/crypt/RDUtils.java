package ryanduan.crypt;

import java.io.IOException;
import java.util.Arrays;

public class RDUtils {
    // populate input chars from standard input into charBuffer, and return the
    // length of the input string that has been read
    public static int readInput(char[] charBuffer) throws IOException {
        int i = 0;
        int ch;

        // -1 indicates End-Of-File
        //
        // Caution:
        // If we use a char to receive System.in.read() then we will NOT get -1
        // when it encounters End-Of-File.
        while (i < charBuffer.length && (ch = System.in.read()) != -1) {
            charBuffer[i++] = (char)ch;
        }
        return i;
    }

    // @NotNull
    public static int[] addPadding(int[] bs, int blocksize) {
        if (bs.length % blocksize == 0) {
            return bs;
        } else {
            // bit buffer length should be multiple of BLOCK_SIZE
            double t = (double)bs.length / blocksize;
            int bitBufLen = ((int)Math.ceil(t)) * blocksize;
            int[] code = new int[bitBufLen];

            // padding with 0 in the end of the bit string
            Arrays.fill(code, 0);

            // copy
            for (int i = 0; i < bs.length; i++) {
                code[i] = bs[i];
            }
            return code;
        }
    }

    // ----------------------------------------------------------------
    // Note:
    // I could have used Integer.toBinaryString(int i) to return a String,
    // but that function do not allow me to control the length of the output.
    //
    // This function can control the length of output range from 0 to 32.
    //
    // Example 1:
    // if a = 9 (bin: 1001), and outputLength = 2, then
    // output should be its lower part: 01
    //
    // Example 2:
    // if a = 10 (bin: 1010), and outputLength = 5, then
    // output should be be 01010
    // ----------------------------------------------------------------
    //
    // @param: int a: a positive integer
    // @param: int outputLength: >=0 and <= 32
    //
    // @return: binary string representation of the integer
    //
    // @NotNull: no need to check new fail with null check, because
    //           if new fails, Java will throw OutOfMemoryError.
    //
    static int[] intToBitStr(int a, int outputLength) {
        assert outputLength >= 0 && outputLength <= 32 : outputLength;

        int[] s = new int[outputLength];
        for (int i = outputLength - 1; i >= 0; i--) {
            // high bits of the integer are pushed in the array first
            s[i] = a & 0x1;
            a = a >> 1;
        }
        return s;
    }

    static int bitStrToInt(int[] a) {
        int s = 0;
        for (int i = 0; i < a.length; i++) {
            s += a[i] * Math.pow(2, (a.length - i - 1));
        }
        return s;
    }

    // @NotNull
    static int[] bitStrXOR(int[] a, int[] b) {
        assert a.length == b.length
            : "a.length: " + a.length + ", b.length: " + b.length;

        int[] r = new int[a.length];
        for (int i = 0; i < a.length; i++) {
            r[i] = a[i] ^ b[i];
        }
        return r;
    }

    // @NotNull
    static int[][] divideBitStrIntoBlocks(int[] bs, int blocksize) {
        assert bs.length % blocksize == 0;
        int n = bs.length / blocksize;
        int[][] r = new int[n][blocksize];
        for (int i = 0; i < n; i++) {
            r[i] = Arrays.copyOfRange(bs, i*blocksize, (i+1)*blocksize);
        }
        return r;
    }

    // @NotNull
    public static int[] strBitsToIntBits(String bits) {
        byte[] bytes = bits.getBytes();
        int[] k = new int[bytes.length];
        int c = 0;
        for (int i = 0; i < bytes.length; i++) {
            char ch = (char)bytes[i];
            if (ch == '1') {
                k[i] = 1;
            } else if (ch == '0') {
                k[i] = 0;
            } else {
                throw new IllegalArgumentException("bad bit: " + ch);
            }
        }
        return k;
    }

    public static String intBitsToStrBits(int[] bits) {
        char[] cs = new char[bits.length];
        for (int i = 0; i < bits.length; i++) {
            cs[i] = (bits[i] == 1 ? '1' : '0');
        }
        return new String(cs);
    }

    public static void printBitString(int[] a) {
        if (a.length == 0) {
            return;
        }
        for (int i : a) {
            System.out.print(i);
        }
        System.out.println();
    }

    static int copyIntArrIntoArr(int[] target, int targetOffset,
                                 int[] src) {
        for (int i = 0; i < src.length; i++) {
            target[targetOffset++] = src[i];
        }
        return targetOffset;
    }
}
