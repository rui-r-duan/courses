package ryanduan.crypt;

import java.io.*;
import java.util.*;

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
}
