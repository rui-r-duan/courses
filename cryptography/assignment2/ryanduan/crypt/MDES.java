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

    private static final Map<Character, Integer> m;
    static {
        m = new HashMap<Character, Integer>();
        m.put('a', 0); m.put('b', 1); m.put('c', 2); m.put('d', 3);
        m.put('e', 4); m.put('f', 5); m.put('g', 6); m.put('h', 7);
        m.put('i', 8); m.put('j', 9); m.put('k', 10); m.put('l', 11);
        m.put('m', 12); m.put('n', 13); m.put('o', 14); m.put('p', 15);
        m.put('q', 16); m.put('r', 17); m.put('s', 18); m.put('t', 19);
        m.put('u', 20); m.put('v', 21); m.put('w', 22); m.put('x', 23);
        m.put('y', 24); m.put('z', 25); m.put(' ', 26); m.put('.', 27);
        m.put(',', 28); m.put('?', 29); m.put('(', 30); m.put(')', 31);
    }

    private static int bitmasks[] = {
        0x10, 0x08, 0x04, 0x02, 0x01
    };

    // return value can be null
    public static Integer charToInt(char c) {
        return m.get(c);
    }

    public static int[] intToBinaryStr(int a) {
        // Only need 5 bit string for all the characters.
        int[] s = new int[5];
        for (int i = 0; i < 5; i++) {
            // high bits in the integer are pushed in the array first
            s[i] = (a & bitmasks[i]) >> (4 - i);
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

    
}
