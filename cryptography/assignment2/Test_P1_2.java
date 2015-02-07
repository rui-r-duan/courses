import java.io.*;
import ryanduan.crypt.MDES;

class Test_P1_2 {
    public static void main(String[] args) {
        try {
            // test MDES.intToBinaryStr()
            MDES.printBitString(MDES.intToBinaryStr(9, 2));
            MDES.printBitString(MDES.intToBinaryStr(10, 5));
            // MDES.printBitString(MDES.intToBinaryStr(10, 9));

            // test MDES.expand()
            int[] a = {1, 0, 1, 1, 0, 1, 0, 1};
            int[] r = MDES.expand(a);
            if (r == null) {
                System.err.println("Failed to new Object");
                return;
            }
            MDES.printBitString(r);

            // test MDES.split12Bit()
            int[][] b = MDES.split12Bit(r);
            if (b == null) {
                System.err.println("Failed to new Object");
                return;
            }
            for (int[] i : b) {
                MDES.printBitString(i);
            }

            // test MDES.sboxTransform()
            int[] sboxout1 = MDES.sboxTransform(b[0], MDES.S1);
            int[] sboxout2 = MDES.sboxTransform(b[1], MDES.S2);
            if (sboxout1 == null || sboxout2 == null) {
                System.err.println("Failed to new Object");
                return;
            }
            MDES.printBitString(sboxout1);
            MDES.printBitString(sboxout2);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }
    }
}
