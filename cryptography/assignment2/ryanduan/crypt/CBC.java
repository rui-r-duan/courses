// CBC (cipher block chaining) mode for
// MDES (Mini Data Encryption Standard) Simulator
//
// @author: Ryan Duan

package ryanduan.crypt;

public class CBC {
    // generate initialization vector
    // @NotNull
    public static int[] genIV() {
        int[] v = new int[MDES.BLOCK_SIZE];
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
        return CBC_Framework(bitstring, key, iv, 'e');
    }

    // @NotNull
    public static int[] decrypt(int[] bitstring, int[] key, int[] iv) {
        assert key.length == MDES.KEY_LEN * MDES.ENC_PASSES;
        return CBC_Framework(bitstring, key, iv, 'd');
    }

    // @NotNull
    private static int[] CBC_Framework(int[] in, int[] key,
                                       int[] iv, char encOrDec) {
        assert encOrDec == 'e' || encOrDec == 'd';

        if (in.length == 0) {   // void input
            return in;
        }

        int[][] internalKey = RDUtils.divideBitStrIntoBlocks(key, MDES.KEY_LEN);

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

    // @NotNull
    private static int[] encryptInternal(int[] bs, int[][] key, int[] iv) {
        assert bs.length % MDES.BLOCK_SIZE == 0;

        int[] result = new int[bs.length];

        int[][] xs = RDUtils.divideBitStrIntoBlocks(bs, MDES.BLOCK_SIZE);
        int[][] ys = new int[xs.length][MDES.BLOCK_SIZE];

        int[] t = RDUtils.bitStrXOR(iv, xs[0]);
        ys[0] = MDES.encryptKernel(t, key);
        int resultOffset = RDUtils.copyIntArrIntoArr(result, 0, ys[0]);

        for (int i = 1; i < xs.length; i++) {
            t = RDUtils.bitStrXOR(ys[i-1], xs[i]);
            ys[i] = MDES.encryptKernel(t, key);

            // populate result[] with the encrypted block
            resultOffset = RDUtils.copyIntArrIntoArr(result, resultOffset, ys[i]);
        }
        return result;
    }

    // @NotNull
    private static int[] decryptInternal(int[] bs, int[][] key, int[] iv) {
        assert bs.length % MDES.BLOCK_SIZE == 0;

        int[] result = new int[bs.length];

        int[][] ys = RDUtils.divideBitStrIntoBlocks(bs, MDES.BLOCK_SIZE);
        int[][] xs = new int[ys.length][MDES.BLOCK_SIZE];

        int[] t = MDES.decryptKernel(ys[0], key);
        xs[0] = RDUtils.bitStrXOR(t, iv);
        int resultOffset = RDUtils.copyIntArrIntoArr(result, 0, xs[0]);

        for (int i = 1; i < ys.length; i++) {
            t = MDES.decryptKernel(ys[i], key);
            xs[i] = RDUtils.bitStrXOR(t, ys[i-1]);

            // populate result[] with the decrypted block
            resultOffset = RDUtils.copyIntArrIntoArr(result, resultOffset, xs[i]);
        }
        return result;
    }
}
