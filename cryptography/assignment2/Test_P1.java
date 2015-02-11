import java.io.*;
import ryanduan.crypt.MDES;
import ryanduan.crypt.RDUtils;

class Test_P1 {
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
        RDUtils.printBitString(code);

        // encryption and decryption
        String key = "101101010010100101101011";
        int[] encout = MDES.encrypt(code, RDUtils.strBitsToIntBits(key));
        RDUtils.printBitString(encout);
        int[] decout = MDES.decrypt(encout, RDUtils.strBitsToIntBits(key));
        RDUtils.printBitString(decout);

        // bit string to text
        char[] txt = MDES.codeToTxt(decout);
        System.out.println(txt);
    }
}
