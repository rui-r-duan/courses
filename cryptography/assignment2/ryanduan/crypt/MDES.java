package ryanduan.crypt;

import java.util.*;

class MDES {
    private static char[] table = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ', '.',
        '?', '(', ')'
    };

    private static Map<Character, Integer> m;
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

    private static int charToInt(char c) {
        return m.get(c);
    }

    private static int[] intToBinaryStr(int a) {
        // Only need 5 bit string for all the characters.
        int[] s = new int[5];
        for (int i = 0; i < 5; i++) {
            s[i] = (a & bitmasks[i]) >> (4 - i);
        }
        return s;
    }

    public static void main(String[] args) {
        for (char key : m.keySet()) {
            int [] r = intToBinaryStr(charToInt(key));
            for (int i : r) {
                System.out.print(i);
            }
            System.out.println("\t" + key);
        }
    }
}
