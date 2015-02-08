import java.io.*;
import java.util.Arrays;
import ryanduan.crypt.CBC;

class Test_P2 {
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
        int[] iv = CBC.genIV();
        String encout = CBC.CBC_Framework(in, key, iv, 'e');
        System.out.println(encout);
        String decout = CBC.CBC_Framework(encout, key, iv, 'd');
        System.out.println(decout);
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
