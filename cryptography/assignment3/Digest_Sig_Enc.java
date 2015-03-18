import java.security.*;
import java.io.IOException;
import ryanduan.crypto.RDUtils;

public class Digest_Sig_Enc {
    public static void main(String[] args) {
        // read characters from standard input
        byte[] inputBuffer = new byte[1024];
        int len = 0;
        try {
            len = RDUtils.readInput(inputBuffer);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String in = new String(inputBuffer, 0, len); 
        System.out.print(in);

        try {
            MessageDigest md = MessageDigest.getInstance("MD5");

            md.update(inputBuffer);
            byte[] dg = md.digest();
            System.out.print(RDUtils.byte2hex(dg));
        } catch (NoSuchAlgorithmException e) {
            System.err.println("I'm sorry, but MD5 is not supported");
        }
    }
}
