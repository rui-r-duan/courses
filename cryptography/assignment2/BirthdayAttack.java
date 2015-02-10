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
        System.out.println(in);

        String[] varMsgs = genVariations(in, MDES.BLOCK_SIZE);
        ArrayList<MsgRecord> mrList = new ArrayList<MsgRecord>(varMsgs.length);
        for (int i = 0; i < varMsgs.length; i++) {

            // text to bit string
            int[] code = MDES.txtToCode(varMsgs[i].toCharArray());

            // compute hash
            int[] hash = Hash.computeHash(code);

            mrList.add(new MsgRecord(varMsgs[i],
                                       RDUtils.intBitsToStrBits(hash)));
        }

        System.out.println("---- Messages with their Hashes (sorted) -----");
        mrList.sort(new MsgRecordComparator());
        for (MsgRecord r : mrList) {
            System.out.println(r.getMessage());
            System.out.println(r.getHash());
        }
    }

    // Generate 2^(m/2) variations of the input message.
    //
    // @NotNull
    // @param: String msg: original message
    // @param: int m: hash value bit-length
    private static String[] genVariations(String msg, int m) {
        int n = (int)Math.pow(2.0, (m / 2.0)); 
        String[] r = new String[n];

        System.out.println("n=" + n);
        for (int i = 0; i < n; i++) {
            StringBuilder sb = new StringBuilder(msg);
            for (int j = 0; j < 4; j++) {
                int randomIndex = (int)(Math.random() * 32);
                int randomCode = (int)(Math.random() * 32);
                sb.setCharAt(randomIndex, MDES.intToChar(randomCode));
            }
            r[i] = sb.toString();
        }
        return r;
    }

    private static void printMsgRecords(ArrayList<MsgRecord> list) {
        
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

    // public int compareTo(MsgRecord obj) {
    //     int[] intBitsHash_this = RDUtils.strBitsToIntBits(this.hash);
    //     int hashVal_this = RDUtils.bitStrToInt(intBitsHash_this);
    //     int[] intBitsHash_obj = RDUtils.strBitsToIntBits(obj.getHash());
    //     int hashVal_obj = rDUtils.bitStrToInt(intBitsHash_obj);
    //     return hashVal_this - hashVal_obj; // ascending order
    // }
}

class MsgRecordComparator implements Comparator<MsgRecord> {
    public int compare(MsgRecord o1, MsgRecord o2) {
        return o1.getHash().compareTo(o2.getHash());
    }
}
