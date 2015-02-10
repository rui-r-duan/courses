// Demo of Birthday Attack
//
// The hash function is of m-bit length.
//     m = 16 (MDES.BLOCK_SIZE)
//
// @author: Ryan Duan

import ryanduan.crypt.Hash;
import ryanduan.crypt.MDES;
import ryanduan.crypt.RDUtils;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;

class BirthdayAttack {
    private static final String faultMsg = "cryptography is an important tool for network security.  but there are other issues for network security.";

    public static void main(String[] args) {
        // read characters from standard input
        char[] inputBuffer = new char[1024];
        int len = 0;
        try {
            len = RDUtils.readInput(inputBuffer);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String in = new String(inputBuffer, 0, len); 
        System.out.println("---- input message ----");
        System.out.println(in);

        // get variations, compute their hashes, and add to list, sort the list
        String[] varMsgs = getEnoughVariations(in, MDES.BLOCK_SIZE);
        ArrayList<MsgRecord> mrList = new ArrayList<MsgRecord>(varMsgs.length);
        for (int i = 0; i < varMsgs.length; i++) {
            // text to bit string
            int[] code = MDES.txtToCode(varMsgs[i].toCharArray());

            // compute hash
            int[] hash = Hash.computeHash(code);

            mrList.add(new MsgRecord(varMsgs[i],
                                     RDUtils.intBitsToStrBits(hash)));
        }
        mrList.sort(new MsgRecordComparator());

        System.out.println("---- Message Variations with their Hashes (sorted) -----");
        System.out.println("---- " + mrList.size() + " variations ----");
        for (MsgRecord r : mrList) {
            System.out.println(r.getMessage());
            System.out.println(r.getHash());
        }

        // try 1000 times to find x' such that x' != x and h(x') == h(x)
        System.out.println("---- fault message ----");
        System.out.println(faultMsg);
        System.out.println("---- Now try 1000 times ----");
        for (int j = 0; j < 1000; j++) {
            String v = genVariation(faultMsg); // candidate for x'
            int[] hash = Hash.computeHash(MDES.txtToCode(v.toCharArray()));
            String h = RDUtils.intBitsToStrBits(hash);
            int index = findHashInList(h, mrList);
            if (index != -1) {
                System.out.println("--------------------------------");
                System.out.println("find it: index = " + index);
                System.out.println("hash: " + h); // h(x) that is == h(x')
                System.out.println("authentic message:");
                System.out.println(mrList.get(index).getMessage()); // x
                System.out.println("fault message:");
                System.out.println(v); // x'
            }
        }
    }

    // Return index of the matched record in the list,
    // if not found return -1.
    private static int findHashInList(String hash, ArrayList<MsgRecord> list) {
        int index = -1;
        for (int i = 0; i < list.size(); i++) {
            MsgRecord m = list.get(i);
            if (m.getHash().equals(hash)) {
                return i;
            }
        }
        // it comes here if not found
        return index;
    }

    // Generate 2^(m/2) variations of the input message.
    //
    // @NotNull
    // @param: String msg: original message
    // @param: int m: hash value bit-length
    private static String[] getEnoughVariations(String msg, int m) {
        int n = (int)Math.pow(2.0, (m / 2.0)); 
        String[] r = new String[n];
        for (int i = 0; i < n; i++) {
            r[i] = genVariation(msg);
        }
        return r;
    }

    private static String genVariation(String msg) {
        StringBuilder sb = new StringBuilder(msg);
        for (int j = 0; j < 4; j++) {
            int randomIndex = (int)(Math.random() * 32);
            int randomCode = (int)(Math.random() * 32);
            sb.setCharAt(randomIndex, MDES.intToChar(randomCode));
        }
        return sb.toString();
    }
}

class MsgRecord {
    private String msg;         // message in English text
    private String hash;        // hash string in bits format

    public MsgRecord(String s, String h) {
        msg = s;
        hash = h;
    }

    public String getMessage() {
        return msg;
    }

    public String getHash() {
        return hash;
    }
}

class MsgRecordComparator implements Comparator<MsgRecord> {
    public int compare(MsgRecord o1, MsgRecord o2) {
        return o1.getHash().compareTo(o2.getHash());
    }
}
