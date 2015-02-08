// CBC (cipher block chaining) mode for
// MDES (Mini Data Encryption Standard) Simulator
//
// @author: Ryan Duan

package ryanduan.crypt;

import java.util.*;

public class CBC {
    // generate initialization vector
    public static int[] genIV() {
        int[] v = new int[16];
        int randInt = (int)(Math.random() * 65521); // 65521 is a prime!
        System.out.println(randInt);
        for (int i = 0; i < 16; i++) {
            v[i] = randInt & 0x1;
            randInt = randInt >> 1;
        }
        return v;
    }
}
