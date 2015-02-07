import java.io.*;
import ryanduan.crypt.MDES;

class Test_P1_2 {
    public static void main(String[] args) {
        try {
            int[] a = {1, 0, 1, 1, 0, 1, 0, 1};
            int[] r = MDES.expand(a);
            for (int j : r) {
                System.out.print(j);
            }
            System.out.println();
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }
    }
}
