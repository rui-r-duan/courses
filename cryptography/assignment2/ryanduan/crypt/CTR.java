// CTR (Counter) mode for
// MDES (Mini Data Encryption Standard) Simulator
//
// @author: Ryan Duan

package ryanduan.crypt;

import java.util.*;

public class CTR {
    // generate initialization vector
    public static int[] genIV() {
        int[] v = new int[16];
        int randInt = (int)(Math.random() * 65521); // 65521 is a prime!
        for (int i = 0; i < 16; i++) {
            v[i] = randInt & 0x1;
            randInt = randInt >> 1;
        }
        return v;
    }

    // @NotNull
    public static int[] encrypt(int[] bitstring, int[] key, int[] iv) {
        assert key.length == MDES.KEY_LEN * MDES.ENC_PASSES;
        return CTR_Framework(bitstring, key, iv, 'e');
    }

    // @NotNull
    public static int[] decrypt(int[] bitstring, int[] key, int[] iv) {
        assert key.length == MDES.KEY_LEN * MDES.ENC_PASSES;
        return CTR_Framework(bitstring, key, iv, 'd');
    }

    // @NotNull
    private static int[] CTR_Framework(int[] in, int[] key,
                                       int[] iv, char encOrDec) {
        assert encOrDec == 'e' || encOrDec == 'd';

        if (in.length == 0) {   // void input
            return in;
        }

        int [][] internalKey = RDUtils.divideBitStrIntoBlocks(key, MDES.KEY_LEN);

        int[] bitStr = RDUtils.addPadding(in, MDES.BLOCK_SIZE);

        // encrypt or decrypt bit string
        int[] outBitStr = {0};  // initialize to int[1] that contains only 0
        if (encOrDec == 'e') {
            outBitStr = encryptInternal(bitStr, internalKey, iv);
        } else if (encOrDec == 'd') {
            outBitStr = decryptInternal(bitStr, internalKey, iv);
        } else { // do nothing
        }

        return outBitStr;
    }

    private static int[] encryptInternal(int[] bs, int[][] key, int[] iv) {
        assert bs.length % MDES.BLOCK_SIZE == 0;

        int[] result = new int[bs.length];

        int[][] xs = RDUtils.divideBitStrIntoBlocks(bs, MDES.BLOCK_SIZE);
        int[][] ys = new int[xs.length][MDES.BLOCK_SIZE];

        int[] t;
        int c = RDUtils.bitStrToInt(iv);
        int[] cstr;
        int resultOffset = 0;
        for (int i = 0; i < xs.length; i++) {
            t = MDES.encryptKernel(RDUtils.intToBitStr(c + i, MDES.BLOCK_SIZE),
                                   key);
            ys[i] = RDUtils.bitStrXOR(xs[i], t);

            // populate result[] with the encrypted block
            resultOffset = MDES.copyIntArrIntoArr(result, resultOffset, ys[i]);
        }
        return result;
    }

    private static int[] decryptInternal(int[] bs, int[][] key, int[] iv) {
        return encryptInternal(bs, key, iv);
    }
}
