import java.io.*;
import ryanduan.crypt.MDES;

class Test_P1_2 {
    public static void main(String[] args) {
        try {
            // test MDES.f()
            int[] a = {1, 0, 1, 1, 0, 1, 0, 1};
            int[] key = {1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0};
            int[] r = MDES.f(a, key);
            MDES.printBitString(r);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }
    }
}
