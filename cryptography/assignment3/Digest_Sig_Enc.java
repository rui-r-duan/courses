//----------------------------------------------------------------------------
// Cryptography Assignment 3
//
// Compute MD5 digest and SHA-1 with DSA signature, and encrypt the message
// using CBC mode of DES-EDE.
//
// @author: Rui Duan <rduan@lakeheadu.ca>
//----------------------------------------------------------------------------
import java.security.*;
import javax.crypto.*;
import javax.crypto.spec.*;
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

        // Sign
        try {
            // read private key for signature
            ObjectInputStream ins = new ObjectInputStream(new FileInputStream("myprivkey.dat"));
            PrivateKey myprivkey = (PrivateKey)ins.readObject();
            ins.close();

            // sign
            Signature sig = Signature.getInstance("SHA1withDSA");
            sig.initSign(myprivkey);
            sig.update(in.getBytes());
            byte[] signature = sig.sign();

            // save the message and the signature in file
            ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream("myinfo.dat"));
            out.writeObject(in); // emulate that the client receives this string
            out.writeObject(signature);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Encrypt
        try {
            // generate secret key for DES-EDE (TripleDES)
            KeyGenerator kg = KeyGenerator.getInstance("DESede");
            kg.init(168, new SecureRandom());
            Key cipherKey = kg.generateKey();

            // save the secret key
            ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream("cipherkey.dat"));
            out.writeObject(cipherKey);
            out.close();

            // encrypt
            Cipher cipher = Cipher.getInstance("DESede/CBC/PKCS5Padding");
            IvParameterSpec iv = new IvParameterSpec(new byte[8]);
            cipher.init(Cipher.ENCRYPT_MODE, cipherKey, iv);
            byte[] encrypted = cipher.doFinal(in.getBytes());

            // save encrypted data
            out = new ObjectOutputStream(new FileOutputStream("encrypted.dat"));
            out.writeObject(encrypted);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
