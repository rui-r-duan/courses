package ryanduan.crypto;

import java.io.IOException;
import java.util.Arrays;

public class RDUtils {
    // populate input chars from standard input into charBuffer, and return the
    // length of the input string that has been read
    public static int readInput(byte[] charBuffer) throws IOException {
        int i = 0;
        int ch;

        // -1 indicates End-Of-File
        //
        // Caution:
        // If we use a char to receive System.in.read() then we will NOT get -1
        // when it encounters End-Of-File.
        while (i < charBuffer.length && (ch = System.in.read()) != -1) {
            charBuffer[i++] = (byte)ch;
        }
        return i;
    }

    // @NotNull
    public static String byte2hex(byte[] b)
    {
        String hs = "";
        String stmp = "";
        for (int i = 0; i < b.length; i++) {
            stmp = (Integer.toHexString(b[i] & 0xFF));
            if (stmp.length() == 1) {
                hs = hs + "0" + stmp;
            } else {
                hs = hs + stmp;
            }
            if (i < b.length - 1) {
                hs = hs + ":";
            }
        }
        return hs.toUpperCase();
    }
}
