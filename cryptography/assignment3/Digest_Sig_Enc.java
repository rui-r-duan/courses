import java.security.*;
import java.io.*;
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

        // compute MD5 digest
        System.out.println();
        System.out.print("MD5 Digest: ");
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(inputBuffer);
            byte[] dg = md.digest();
            System.out.println(RDUtils.byte2hex(dg));
        } catch (NoSuchAlgorithmException e) {
            System.err.println("I'm sorry, but MD5 is not supported");
        }


        try {
            // Read private key for signature
            ObjectInputStream ins = new ObjectInputStream(new FileInputStream("myprivkey.dat"));
            PrivateKey myprivkey = (PrivateKey)ins.readObject();
            ins.close();

            // sign
            Signature sig = Signature.getInstance("SHA1withDSA");
            sig.initSign(myprivkey);
            sig.update(in.getBytes());
            byte[] signed = sig.sign();

            // save the message and the signature in file "myinfo.dat"
            ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream("myinfo.dat"));
            out.writeObject(in);
            out.writeObject(signed);
            out.close();
        } catch (NoSuchAlgorithmException e) {
            System.err.println("No such algorithm: SHA1withDSA");
        } catch (FileNotFoundException e) {
            System.err.println("file not found: myinfo.dat");
        } catch (IOException e) {
            System.err.println(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
