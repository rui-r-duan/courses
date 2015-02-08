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

    private static int[] bitmasks = {
        0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01
    };

    // @Nullable: null check must be done in client code
    // O(1)
    private static Integer charToInt(char c) {
        return m.get(c);
    }

    // @NotNull
    // O(1)
    private static char intToChar(int a) {
        return rm[a];
    }

    // Note:
    // I could have used Integer.toBinaryString(int i) to return a String,
    // but that function do not allow me to control the length of the output.
    //
    // This function can control the length of output range from 1 to 8.
    //
    // Example 1:
    // if a = 9 (bin: 1001), and outputLength = 2, then
    // output should be its lower part: 01
    //
    // Example 2:
    // if a = 10 (bin: 1010), and outputLength = 5, then
    //
    // @return: binary string representation of the integer
    //
    // @NotNull: no need to check new fail with null check, because
    //           if new fails, Java will throw OutOfMemoryError.
    //
    private static int[] intToBinaryStr(int a, int outputLength) {
        // new int[0] is legal in Java, but we do not allow outputLength == 0
        // because it is meaningless
        assert outputLength >= 1 && outputLength <= 8 : outputLength;

        int[] s = new int[outputLength];
        int maskIndex = bitmasks.length - outputLength;
        for (int i = 0; i < outputLength; i++) {
            // high bits of the integer are pushed in the array first
            int mask = bitmasks[maskIndex++];
            s[i] = (a & mask) >> (outputLength - i - 1);
        }
        return s;
    }

    // expand 8 bit string to 12 bit string
    // @NotNull
    private static int[] expand(int[] a) {
        if (a.length != 8) {
            // it is a runtime exception, do not need to declare in the method
            // signature
            throw new IllegalArgumentException("length of input string must be 8, but now it is " + a.length);
        }
        int[] r = new int[12];
        boolean shouldAppend = false;
        for (int i = 0, j = 8;
             i < a.length; i++) {
            r[i] = a[i];
            if (shouldAppend) {
                r[j++] = a[i];
            }
            shouldAppend = !shouldAppend;
        }
        return r;
    }

    // @param: int[] a: 12-bit string
    // @return: two int[6] (two 6-bit strings)
    // @NotNull
    private static int[][] split12Bit(int[] a) {
        int[][] r = new int[2][6];
        int k = 0;
        for (int i = 0; i < r.length; i++) {
            for (int j = 0; j < r[i].length; j++) {
                r[i][j] = a[k++];
            }
        }
        return r;
    }

    private static int bitStrToInt(int[] a) {
        int s = 0;
        for (int i = 0; i < a.length; i++) {
            s += a[i] * Math.pow(2, (a.length - i - 1));
        }
        return s;
    }

    // @NotNull
    private static int[] bitStrXOR(int[] a, int[] b) {
        assert a.length == b.length
            : "a.length: " + a.length + ", b.length: " + b.length;

        int[] r = new int[a.length];
        for (int i = 0; i < a.length; i++) {
            r[i] = a[i] ^ b[i];
        }
        return r;
    }

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
        int row = bitStrToInt(rowStr);
        int col = bitStrToInt(colStr);

        // S-Box's index begins from 0
        int t = sbox[row][col];
        // System.out.println("s-box val = " + t);
        r = intToBinaryStr(t, 4);
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
        int[] eak = bitStrXOR(ea, key);
        int[][] b = split12Bit(eak);
        int[] sboxout1 = sboxTransform(b[0], S1); // output 4-bit string
        int[] sboxout2 = sboxTransform(b[1], S2); // output 4-bit string
        int[] output = concatIntArray(sboxout1, sboxout2);
        return output;
    }

    // @param: char[] txt: input
    // @param: int[] code: output
    private static void txtToCode(char[] txt, int[] code) {
        assert txt.length * 5 <= code.length :
        "txt.length=" + txt.length + ", code.length=" + code.length +
            ": (txt.length * 5) must less than or equal to code.length!";

        int codeIndex = 0;
        for (int i = 0; i < txt.length; i++) {
            Integer a = charToInt(txt[i]);
            int[] r = intToBinaryStr(a, 5);
            // append the content of r to code
            for (int j = 0; j < 5; j++) {
                code[codeIndex++] = r[j];
            }
        }
    }

    // @param: int[] code: input
    // @param: char[] txt: output
    //
    // @pre: it is used to translate encrypted or decrypted bit string to text
    //       so the input code must be multiple of 16.
    //
    private static void codeToTxt(int[] code, char[] txt) {
        assert code.length % 16 == 0 :
        "code.length: " + code.length + " is not multiple of 16";

        // each block is 5-bit which corresponds to a char
        //
        // Note: if code.length = 528
        int cntBlocks = code.length / 5;
        for (int i = 0; i < cntBlocks; i++) {
            int[] b = Arrays.copyOfRange(code, i*5, (i+1)*5);
            int a = bitStrToInt(b);
            txt[i] = intToChar(a);
        }
    }

    private static int[][] toInternalKey(String key)
    {
        int[][] k = new int[2][12];
        int c = 0;
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 12; j++) {
                char ch = key.charAt(c++);
                if (ch == '1') {
                    k[i][j] = 1;
                } else if (ch == '0') {
                    k[i][j] = 0;
                } else {
                    throw new IllegalArgumentException("bad key digit: " + ch);
                }
            }
        }
        return k;
    }

    public static String encrypt(String in, String key) {
        return MDES_Framework(in, key, 'e');
    }

    public static String decrypt(String in, String key) {
        return MDES_Framework(in, key, 'd');
    }

    // @param: char encOrDec:
    //         if 'e' then do encryption, if 'd' then do decryption.
    //
    private static String MDES_Framework(String in, String key, char encOrDec) {
        assert key.length() == 24 && (encOrDec == 'e' || encOrDec == 'd');

        int [][] internalKey = toInternalKey(key);

        // Convert chars to bit string (using int array to simulate it) one
        // char is converted to 5 bits.

        // Bit buffer length should be multiple of 16, and must contain all the
        // code for all the characters.
        int bitBufLen = ((int)Math.ceil((double)in.length() * 5 / 16)) * 16;
        int[] bitStr = new int[bitBufLen];

        // padding with 0 in the end of the bit string
        Arrays.fill(bitStr, 0);

        // turn char string into binary code (bit string)
        txtToCode(in.toCharArray(), bitStr);
        printBitString(bitStr);
        int[] outBitStr = {0};  // initialize to int[1] that contains only 0
        if (encOrDec == 'e') {
            outBitStr = encryptInternal(bitStr, internalKey);
        } else if (encOrDec == 'd') {
            outBitStr = decryptInternal(bitStr, internalKey);
        } else { // do nothing
        }
        printBitString(outBitStr);
        char[] txt = new char[in.length()];
        codeToTxt(outBitStr, txt);

        return new String(txt);
    }

    // @param: int[] bs: bit string of length that is multiple of 16
    // @param: int[][] key: int[2][12] two 12-bit keys
    private static int[] encryptInternal(int[] bs, int[][] key) {
        assert bs.length % 16 == 0;

        int[] result = new int[bs.length];
        int resultOffset = 0;

        // divide bs[] into 16-bit string blocks,
        // process each block,
        // each i is used as a counter for one block (16 bit)
        int cnt = bs.length / 16;     // count of blocks

        // used as encoding storage for each block
        int[][] L = new int[3][8];
        int[][] R = new int[3][8];

        for (int i = 0; i < cnt; i++) {
            // two-pass encrypt for each block
            int[] L0 = Arrays.copyOfRange(bs, i*2*8, (i*2+1)*8);
            int[] R0 = Arrays.copyOfRange(bs, (i*2+1)*8, (i*2+2)*8);
            encryptKernel(L0, R0, key, L, R);
            // populate result[] with the encrypted block
            resultOffset = copyIntArrIntoArr(result, resultOffset, L[2]);
            resultOffset = copyIntArrIntoArr(result, resultOffset, R[2]);
        }
        return result;
    }

    // @input: L0 and R0: each one is an 8-bit string
    // @input: int[][] key: int[2][12] two 12-bit keys
    // @output: L and R: each one is int[3][8],
    //          L[2] and R[2] togeher are the encryption result of L0 and R0
    //
    private static void encryptKernel(int[] L0, int[] R0, int[][] key,
                                      int[][] L, int[][] R) {
        L[0] = L0;
        R[0] = R0;
        for (int i = 1; i <= 2; i++) {
            L[i] = Arrays.copyOf(R[i-1], 8);
            R[i] = bitStrXOR(L[i-1], f(R[i-1], key[i-1]));
        }
    }

    // It is a framework similar to encryptInternal(), so refer to its comment.
    private static int[] decryptInternal(int[] bs, int[][] key) {
        assert bs.length % 16 == 0;
        int[] result = new int[bs.length];
        int resultOffset = 0;
        int cnt = bs.length / 16;
        int[][] L = new int[3][8];
        int[][] R = new int[3][8];
        for (int i = 0; i < cnt; i++) {
            int[] L2 = Arrays.copyOfRange(bs, i*2*8, (i*2+1)*8);
            int[] R2 = Arrays.copyOfRange(bs, (i*2+1)*8, (i*2+2)*8);
            decryptKernel(L2, R2, key, L, R);
            resultOffset = copyIntArrIntoArr(result, resultOffset, L[0]);
            resultOffset = copyIntArrIntoArr(result, resultOffset, R[0]);
        }
        return result;
    }

    private static void decryptKernel(int[] L2, int[] R2, int[][] key,
                                      int[][] L, int[][] R) {
        L[2] = L2;
        R[2] = R2;
        for (int i = 2; i >= 1; i--) {
            R[i-1] = L[i];
            L[i-1] = bitStrXOR(R[i], f(R[i-1], key[i-1]));
        }
    }

    private static int copyIntArrIntoArr(int[] target, int targetOffset,
                                         int[] src) {
        for (int i = 0; i < src.length; i++) {
            target[targetOffset++] = src[i];
        }
        return targetOffset;
    }

    private static void printBitString(int[] a) {
        for (int i : a) {
            System.out.print(i);
        }
        System.out.println();
    }
}
