import java.io.*;
import ryanduan.crypt.MDES;

class Test_P1_1 {
    public static void main(String[] args) {
        int ch;
        try {
            while ((ch = System.in.read()) != -1) { // -1 indicates End-Of-File
                Integer i = MDES.charToInt((char)ch);
                if (i == null) {
                    System.err.println("cannot encrypt: " + (char)ch);
                    return;
                }

                int[] r = MDES.intToBinaryStr(i, 5);
                if (r == null) {
                    System.err.println("Failed to new Object");
                    return;
                }

                System.out.print((char)ch + "\t");
                MDES.printBitString(r);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
