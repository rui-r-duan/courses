import java.io.*;
import java.util.Arrays;
import ryanduan.crypt.CTR;
import ryanduan.crypt.MDES;
import ryanduan.crypt.RDUtils;

class Test_P2_CTR {
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
        int[] iv = CTR.genIV();
        int[] encout = CTR.encrypt(code, RDUtils.convKeyBits_StrToInt(key), iv);
        RDUtils.printBitString(encout);
        int[] decout = CTR.decrypt(encout, RDUtils.convKeyBits_StrToInt(key), iv);
        RDUtils.printBitString(decout);

        // bit string to text
        char[] txt = MDES.codeToTxt(decout);
        System.out.println(txt);
    }
}
