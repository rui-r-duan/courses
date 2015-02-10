// Mini DES (Data Encryption Standard) Simulation
//
// Use integer 1 or 0 to simulate a bit, so a bit string is simulated by an int
// string.
//
// @author: Ryan Duan

package ryanduan.crypt;

import java.util.*;

public class MDES {
    private static final int[][] S1 = {
        {15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10},
        {3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5},
        {0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15},
        {13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9}
    };

    private static final int[][] S2 = {
        {7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15},
        {13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9},
        {10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4},
        {3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14}
    };

    private static final Map<Character, Integer> m;
    static {
        HashMap<Character, Integer> hm = new HashMap<Character, Integer>();
        hm.put('a', 0); hm.put('b', 1); hm.put('c', 2); hm.put('d', 3);
        hm.put('e', 4); hm.put('f', 5); hm.put('g', 6); hm.put('h', 7);
        hm.put('i', 8); hm.put('j', 9); hm.put('k', 10); hm.put('l', 11);
        hm.put('m', 12); hm.put('n', 13); hm.put('o', 14); hm.put('p', 15);
        hm.put('q', 16); hm.put('r', 17); hm.put('s', 18); hm.put('t', 19);
        hm.put('u', 20); hm.put('v', 21); hm.put('w', 22); hm.put('x', 23);
        hm.put('y', 24); hm.put('z', 25); hm.put(' ', 26); hm.put('.', 27);
        hm.put(',', 28); hm.put('?', 29); hm.put('(', 30); hm.put(')', 31);
        m = Collections.unmodifiableMap(hm);
    }
    // reverse map
    private static final char rm[] = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ', '.',
        ',', '?', '(', ')'
    };

    static final int ENC_PASSES = 2;
    public static final int BLOCK_SIZE = 16;
    static final int HALF_BLOCK_SIZE = BLOCK_SIZE / 2;
    static final int KEY_LEN = 12;
    static final int NUM_CHAR_BITS = 5;

    // @Nullable: null check must be done in client code
    // O(1)
    public static Integer charToInt(char c) {
        return m.get(c);
    }

    // @NotNull
    // O(1)
    public static char intToChar(int a) {
        return rm[a];
    }

    // expand string of HALF_BLOCK_SIZE to string of KEY_LEN
    // @NotNull
    private static int[] expand(int[] a) {
        if (a.length != HALF_BLOCK_SIZE) {
            // it is a runtime exception, do not need to declare in the method
            // signature
            throw new
                IllegalArgumentException("length of input string must be "
                                         + HALF_BLOCK_SIZE +
                                         ", but now it is " + a.length);
        }
        int[] r = new int[KEY_LEN];
        boolean shouldAppend = false;
        for (int i = 0, j = HALF_BLOCK_SIZE; i < a.length; i++) {
            r[i] = a[i];
            if (shouldAppend) {
                r[j++] = a[i];
            }
            shouldAppend = !shouldAppend;
        }
        return r;
    }

    // @param: int[] a: string of length KEY_LEN
    // @return: two int[KEY_LEN/2]
    // @NotNull
    private static int[][] splitIntoHalves(int[] a) {
        assert a.length % 2 == 0;

        int[][] r = new int[2][KEY_LEN / 2];
        int k = 0;
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < KEY_LEN / 2; j++) {
                r[i][j] = a[k++];
            }
        }
        return r;
    }

    // Caution: specialized for this S1 and S2 (size fixed)
    //
    // @param: int[] a: 8-bit string
    // @return: 4-bit string (possible 'null' if new int[] fails)
    // @NotNull
    private static int[] sboxTransform(int[] a, int[][] sbox) {
        int[] r = new int[4];
        int[] rowStr = new int[2];
        int[] colStr = new int[4];
        rowStr[0] = a[0];
        rowStr[1] = a[5];
        colStr[0] = a[1];
        colStr[1] = a[2];
        colStr[2] = a[3];
        colStr[3] = a[4];
        int row = RDUtils.bitStrToInt(rowStr);
        int col = RDUtils.bitStrToInt(colStr);

        // S-Box's index begins from 0
        int t = sbox[row][col];
        r = RDUtils.intToBitStr(t, 4);
        return r;
    }

    // @NotNull
    private static int[] concatIntArray(int[] a, int[] b) {
        int[] r = new int[a.length + b.length];
        int i = 0;
        for (int j = 0; j < a.length; j++) {
            r[i] = a[j];
            r[i + a.length] = b[j];
            i++;
        }
        return r;
    }

    // @param: int[] a: 8-bit string
    // @param: int[] key: 12-bit string
    // @return: int[] : 8-bit string
    // @NotNull
    private static int[] f(int[] a, int[] key) {
        int[] ea = expand(a);
        int[] eak = RDUtils.bitStrXOR(ea, key);
        int[][] b = splitIntoHalves(eak);
        int[] sboxout1 = sboxTransform(b[0], S1); // output 4-bit string
        int[] sboxout2 = sboxTransform(b[1], S2); // output 4-bit string
        int[] output = concatIntArray(sboxout1, sboxout2);
        return output;
    }

    // Convert chars to bit string (using int array to simulate it).
    // Each char is converted to (NUM_CHAR_BITS) bits.
    //
    // @param: char[] txt: English text
    // @return: int[] : bit string
    //
    // @NotNull
    public static int[] txtToCode(char[] txt) {
        int[] code = new int[NUM_CHAR_BITS * txt.length];
        int codeIndex = 0;
        for (int i = 0; i < txt.length; i++) {
            Integer a = charToInt(txt[i]);
            if (a == null) {
                System.out.println(txt[i] + " is not a valid character as input");
                return new int[0];
            }
            int[] r = RDUtils.intToBitStr(a, NUM_CHAR_BITS);
            // append the content of r to code
            for (int j = 0; j < NUM_CHAR_BITS; j++) {
                code[codeIndex++] = r[j];
            }
        }
        return code;
    }

    // @param: int[] code: input bit string
    // @return: char[]: English text
    //
    // @pre: it is used to translate encrypted or decrypted bit string to text
    //       so the input code must be multiple of BLOCK_SIZE.
    // @NotNull
    public static char[] codeToTxt(int[] code) {
        assert code.length % BLOCK_SIZE == 0 :
        "code.length: " + code.length + " is not multiple of " + BLOCK_SIZE;

        // each block is of lengt NUM_CHAR_BITS which corresponds to a char
        //
        // Caution: for example, if code.length == 528, the last 3 bits will be
        // disgarded
        int cntBlocks = code.length / NUM_CHAR_BITS;
        char[] txt = new char[cntBlocks];
        for (int i = 0; i < cntBlocks; i++) {
            int[] b = Arrays.copyOfRange(code, i*NUM_CHAR_BITS, (i+1)*NUM_CHAR_BITS);
            int a = RDUtils.bitStrToInt(b);
            txt[i] = intToChar(a);
        }
        return txt;
    }

    // @param: String bitstring: input as bit string
    // @param: String key: input as binary string of length 24
    // @NotNull
    public static int[] encrypt(int[] bitstring, int[] key) {
        assert key.length == KEY_LEN * ENC_PASSES;
        return MDES_Framework(bitstring, key, 'e');
    }

    // @param: String bitstring: input as bit string
    // @param: String key: input as binary string of length 24
    // @NotNull
    public static int[] decrypt(int[] bitstring, int[] key) {
        assert key.length == KEY_LEN * ENC_PASSES;
        return MDES_Framework(bitstring, key, 'd');
    }

    // @param: char encOrDec:
    //         if 'e' then do encryption, if 'd' then do decryption.
    // @NotNull
    private static int[] MDES_Framework(int[] in, int[] key, char encOrDec) {
        assert encOrDec == 'e' || encOrDec == 'd';

        if (in.length == 0) {   // void input
            return in;
        }

        int [][] internalKey = RDUtils.divideBitStrIntoBlocks(key, KEY_LEN);

        int[] bitStr = RDUtils.addPadding(in, BLOCK_SIZE);

        // encrypt or decrypt bit string
        int[] outBitStr = {0};  // initialize to int[1] that contains only 0
        if (encOrDec == 'e') {
            outBitStr = encryptInternal(bitStr, internalKey);
        } else if (encOrDec == 'd') {
            outBitStr = decryptInternal(bitStr, internalKey);
        } else { // do nothing
        }

        return outBitStr;
    }

    // @param: int[] bs: bit string of length that is multiple of 16
    // @param: int[][] key: int[ENC_PASSES][KEY_LEN], each pass uses a KEY_LEN key
    // @NotNull
    private static int[] encryptInternal(int[] bs, int[][] key) {
        assert bs.length % BLOCK_SIZE == 0;

        int[] result = new int[bs.length];

        int[][] blocks = RDUtils.divideBitStrIntoBlocks(bs, BLOCK_SIZE);

        int resultOffset = 0;
        for (int i = 0; i < blocks.length; i++) {
            int[] encBlock = encryptKernel(blocks[i], key);

            // populate result[] with the encrypted block
            resultOffset = RDUtils.copyIntArrIntoArr(result, resultOffset, encBlock);
        }
        return result;
    }

    // @param: int[] block: a block of bit string of length BLOCK_SIZE
    // @param: int[][] key: int[ENC_PASSES][KEY_LEN],
    //                      each pass uses a different key
    // @return: int[]: a block of encrypted bit string of length BLOCK_SIZE
    // @NotNull
    static int[] encryptKernel(int[] blk, int[][] key) {
        int[] L0 = Arrays.copyOfRange(blk, 0, HALF_BLOCK_SIZE);
        int[] R0 = Arrays.copyOfRange(blk, HALF_BLOCK_SIZE, 2*HALF_BLOCK_SIZE);
        int[][] L = new int[ENC_PASSES + 1][HALF_BLOCK_SIZE];
        int[][] R = new int[ENC_PASSES + 1][HALF_BLOCK_SIZE];

        L[0] = L0;
        R[0] = R0;
        for (int i = 1; i <= ENC_PASSES; i++) {
            L[i] = Arrays.copyOf(R[i-1], HALF_BLOCK_SIZE);
            R[i] = RDUtils.bitStrXOR(L[i-1], f(R[i-1], key[i-1]));
        }

        int[] e = concatIntArray(L[ENC_PASSES], R[ENC_PASSES]);
        return e;
    }

    // It is a framework similar to encryptInternal(), so refer to its comment.
    // @NotNull
    private static int[] decryptInternal(int[] bs, int[][] key) {
        assert bs.length % BLOCK_SIZE == 0;

        int[] result = new int[bs.length];

        int[][] blocks = RDUtils.divideBitStrIntoBlocks(bs, BLOCK_SIZE);

        int resultOffset = 0;
        for (int i = 0; i < blocks.length; i++) {
            int[] decBlock = decryptKernel(blocks[i], key);

            // populate result[] with the decrypted block
            resultOffset = RDUtils.copyIntArrIntoArr(result, resultOffset, decBlock);
        }
        return result;
    }

    // @NotNull
    static int[] decryptKernel(int[] blk, int[][] key) {
        int[] Ln = Arrays.copyOfRange(blk, 0, HALF_BLOCK_SIZE);
        int[] Rn = Arrays.copyOfRange(blk, HALF_BLOCK_SIZE, 2*HALF_BLOCK_SIZE);
        int[][] L = new int[ENC_PASSES + 1][HALF_BLOCK_SIZE];
        int[][] R = new int[ENC_PASSES + 1][HALF_BLOCK_SIZE];

        L[ENC_PASSES] = Ln;
        R[ENC_PASSES] = Rn;
        for (int i = ENC_PASSES; i >= 1; i--) {
            R[i-1] = L[i];
            L[i-1] = RDUtils.bitStrXOR(R[i], f(R[i-1], key[i-1]));
        }

        int[] e = concatIntArray(L[0], R[0]);
        return e;
    }
}
