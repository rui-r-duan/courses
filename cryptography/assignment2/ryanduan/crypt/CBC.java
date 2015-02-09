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
        for (int i = 0; i < 16; i++) {
            v[i] = randInt & 0x1;
            randInt = randInt >> 1;
        }
        return v;
    }

    // @NotNull
    public static int[] encrypt(int[] bitstring, int[] key, int[] iv) {
        return CBC_Framework(bitstring, key, iv, 'e');
    }

    // @NotNull
    public static int[] decrypt(int[] bitstring, int[] key, int[] iv) {
        return CBC_Framework(bitstring, key, iv, 'd');
    }

    // @NotNull
    private static int[] CBC_Framework(int[] in, int[] key,
                                       int[] iv, char encOrDec) {
        assert key.length == MDES.ENC_PASSES * MDES.KEY_LEN
            && (encOrDec == 'e' || encOrDec == 'd');

        if (in.length == 0) {   // void input
            return in;
        }

        int [][] internalKey = MDES.divideBitStrIntoBlocks(key, MDES.KEY_LEN);

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

        int[][] xs = MDES.divideBitStrIntoBlocks(bs, MDES.BLOCK_SIZE);
        int[][] ys = new int[xs.length][MDES.BLOCK_SIZE];

        int[] t = MDES.bitStrXOR(iv, xs[0]);
        ys[0] = MDES.encryptKernel(t, key);
        int resultOffset = MDES.copyIntArrIntoArr(result, 0, ys[0]);

        for (int i = 1; i < xs.length; i++) {
            t = MDES.bitStrXOR(ys[i-1], xs[i]);
            ys[i] = MDES.encryptKernel(t, key);

            // populate result[] with the encrypted block
            resultOffset = MDES.copyIntArrIntoArr(result, resultOffset, ys[i]);
        }
        return result;
    }

    private static int[] decryptInternal(int[] bs, int[][] key, int[] iv) {
        assert bs.length % MDES.BLOCK_SIZE == 0;

        int[] result = new int[bs.length];

        int[][] ys = MDES.divideBitStrIntoBlocks(bs, MDES.BLOCK_SIZE);
        int[][] xs = new int[ys.length][MDES.BLOCK_SIZE];

        int[] t = MDES.decryptKernel(ys[0], key);
        xs[0] = MDES.bitStrXOR(t, iv);
        int resultOffset = MDES.copyIntArrIntoArr(result, 0, xs[0]);

        for (int i = 1; i < ys.length; i++) {
            t = MDES.decryptKernel(ys[i], key);
            xs[i] = MDES.bitStrXOR(t, ys[i-1]);

            // populate result[] with the decrypted block
            resultOffset = MDES.copyIntArrIntoArr(result, resultOffset, xs[i]);
        }
        return result;
    }
}
