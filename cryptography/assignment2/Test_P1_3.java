import java.io.*;
import java.util.Arrays;
import ryanduan.crypt.MDES;

class Test_P1_3 {
    public static void main(String[] args) {
        // read characters from standard input
        char[] charBuffer = new char[1024];
        int len = 0;
        try {
            len = readInput(charBuffer);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("len=" + len);
        String in = new String(charBuffer, 0, len); 
        System.out.println(in);

        String key = "101101010010100101101011";
        String out = MDES.encode(in, key);
        System.out.println(out);
    }

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
}
