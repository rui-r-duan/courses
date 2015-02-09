import java.io.*;
import java.util.Arrays;
import ryanduan.crypt.CBC;
import ryanduan.crypt.MDES;
import ryanduan.crypt.RDUtils;

class Test_P2_CBC {
    public static void main(String[] args) {
        // read characters from standard input
        char[] charBuffer = new char[1024];
        int len = 0;
        try {
            len = RDUtils.readInput(charBuffer);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String in = new String(charBuffer, 0, len); 
        System.out.println(in);

        // text to bit string
        int[] code = MDES.txtToCode(in.toCharArray());
        RDUtils.printBitString(code);

        // encryption and decryption
        String key = "101101010010100101101011";
        int[] iv = CBC.genIV();
        int[] encout = CBC.encrypt(code, RDUtils.convKeyBits_StrToInt(key), iv);
        RDUtils.printBitString(encout);
        int[] decout = CBC.decrypt(encout, RDUtils.convKeyBits_StrToInt(key), iv);
        RDUtils.printBitString(decout);

        // bit string to text
        char[] txt = MDES.codeToTxt(decout);
        System.out.println(txt);
    }
}
