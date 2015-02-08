import java.io.*;
import ryanduan.crypt.MDES;
import ryanduan.crypt.CBC;

class Test_P2 {
    public static void main(String[] args) {
        MDES.printBitString(CBC.genIV());
    }
}
