// Mini DES (Data Encryption Standard) Simulation
//
// Use integer 1 or 0 to simulate a bit, so a bit string is simulated by an int
// string.
//
// @author: Ryan Duan

package ryanduan.crypt;

import java.util.*;

public class MDES {
    private static final char[] table = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ', '.',
        '?', '(', ')'
    };

    public static final int[][] S1 = {
        {15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10},
        {3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5},
        {0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15},
        {13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9}
    };

    public static final int[][] S2 = {
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

    private static int bitmasks[] = {
        0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01
    };

    // return value can be null
    public static Integer charToInt(char c) {
        return m.get(c);
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
    public static int[] intToBinaryStr(int a, int outputLength) {
        assert outputLength >= 1 && outputLength <= 8 : outputLength;

        // new int[0] is legal in Java, but we do not allow outputLength == 0
        // because it is meaningless
        int[] s = new int[outputLength];
        if (s == null) {
            return null;
        }
        for (int i = 0, maskIndex = bitmasks.length - outputLength;
             i < outputLength; i++) {
            // high bits of the integer are pushed in the array first
            int mask = bitmasks[maskIndex++];
            s[i] = (a & mask) >> (outputLength - i - 1);
        }
        return s;
    }

    // expand 8 bit string to 12 bit string
    public static int[] expand(int[] a) {
        if (a.length != 8) {
            // it is a runtime exception, do not need to declare in the method
            // signature
            throw new IllegalArgumentException("length of input string must be 8, but now it is " + a.length);
        }
        int[] r = new int[12];
        if (r == null) {
            return null;
        }
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
    public static int[][] split12Bit(int[] a) {
        int[][] r = new int[2][6];
        if (r == null) {
            return null;
        }
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

    private static int[] bitStrXOR(int[] a, int[] b) {
        assert a.length == b.length : "a.length: " + a.length + ", b.length: " + b.length;

        int[] r = new int[a.length];
        for (int i = 0; i < a.length; i++) {
            r[i] = a[i] ^ b[i];
        }
        return r;
    }

    // @param: int[] a: 8-bit string
    // @return: 4-bit string (possible 'null' if new int[] fails)
    public static int[] sboxTransform(int[] a, int[][] sbox) {
        int[] r = new int[4];
        int[] rowStr = new int[2];
        int[] colStr = new int[4];
        if (r == null || rowStr == null || colStr == null) {
            return null;
        }
        rowStr[0] = a[0];
        rowStr[1] = a[5];
        colStr[0] = a[1];
        colStr[1] = a[2];
        colStr[2] = a[3];
        colStr[3] = a[4];
        int row = bitStrToInt(rowStr);
        int col = bitStrToInt(colStr);
        // printBitString(rowStr);
        // printBitString(colStr);
        // System.out.println("row=" + row + ", col=" + col);

        // S-Box's index begins from 0
        int t = sbox[row][col];
        // System.out.println("s-box val = " + t);
        r = intToBinaryStr(t, 4);
        return r;
    }

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
    public static int[] f(int[] a, int[] key) {
        int[] ea = expand(a);
        if (ea == null) {
            return null;
        }

        int[] eak = bitStrXOR(ea, key);
        if (eak == null) {
            return null;
        }

        int[][] b = split12Bit(eak);
        if (b == null) {
            return null;
        }

        int[] sboxout1 = sboxTransform(b[0], S1);
        int[] sboxout2 = sboxTransform(b[1], S2);
        if (sboxout1 == null || sboxout2 == null) {
            return null;
        }
        int[] output = concatIntArray(sboxout1, sboxout2);
        return output;
    }

    public static void printBitString(int[] a) {
        for (int i : a) {
            System.out.print(i);
        }
        System.out.println();
    }
}
