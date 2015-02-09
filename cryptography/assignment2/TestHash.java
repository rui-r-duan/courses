import ryanduan.crypt.Hash;
import ryanduan.crypt.MDES;
import ryanduan.crypt.RDUtils;
import java.io.*;

class TestHash {
    public static void main(String[] args) {
        // read characters from standard input
        char[] inputBuffer = new char[1024];
        int len = 0;
        try {
            len = RDUtils.readInput(inputBuffer);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String in = new String(inputBuffer, 0, len); 
        System.out.println(in);

        // text to bit string
        int[] code = MDES.txtToCode(in.toCharArray());
        MDES.printBitString(code);

        // compute hash
        int[] hash = Hash.computeHash(code);
        MDES.printBitString(hash);
    }
}
