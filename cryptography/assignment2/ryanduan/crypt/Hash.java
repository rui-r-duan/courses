// Hash (Counter) mode for
// MDES (Mini Data Encryption Standard) Simulator
//
// @author: Ryan Duan

package ryanduan.crypt;

import java.util.*;
import ryanduan.crypt.MDES;
import ryanduan.crypt.CTR;

public class Hash {

    private static final int KEY_SIZE = 24;
    private static final int[] INIT_VECTOR = new int[MDES.BLOCK_SIZE];

    // input plaintext (bitstring), output MDES.BLOCK_SIZE hash bit string.
    public static int[] computeHash(int[] bitstring) {
        int[] hash = new int[MDES.BLOCK_SIZE];

        // divide input as KEY_SIZE blocks and they will be used as keys
        int[][] keys = MDES.divideBitStrIntoBlocks(bitstring, KEY_SIZE);

        int n = keys.length;

        int[] iv = CTR.genIV();

        int[][] outs = new int[n][MDES.BLOCK_SIZE];
        Arrays.fill(INIT_VECTOR, 0);
        outs[0] = CTR.decrypt(INIT_VECTOR, keys[0], iv);
        for (int i = 1; i < n; i++) {
            outs[i] = CTR.decrypt(outs[i-1], keys[i], iv);
        }

        return outs[n];
    }
}
