//----------------------------------------------------------------------------
// Cryptography Assignment 3
//
// Verify the signature, and decrypt the cipher text.
//
// @author: Rui Duan <rduan@lakeheadu.ca>
//----------------------------------------------------------------------------
import java.security.*;
import javax.crypto.*;
import javax.crypto.spec.*;
import java.io.*;
import ryanduan.crypto.RDUtils;

public class Verify_Dec {
    public static void main(String[] args) {
        // Verify
        try {
            // read public key for verification
            ObjectInputStream ois = new ObjectInputStream(new FileInputStream("mypubkey.dat"));
            PublicKey mypubkey = (PublicKey)ois.readObject();
            ois.close();

            // read signature and the received message
            ois = new ObjectInputStream(new FileInputStream("myinfo.dat"));
            String msg = (String)ois.readObject();
            byte[] sigbytes = (byte[])ois.readObject();
            ois.close();

            // verify
            Signature sig = Signature.getInstance("SHA1withDSA");
            sig.initVerify(mypubkey);
            sig.update(msg.getBytes());
            boolean isAccurate = sig.verify(sigbytes);

            System.out.println("Verification result: "
                               + (isAccurate ? "TRUE" : "FALSE"));
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Decrypt
        try {
            // read secret key
            ObjectInputStream ois = new ObjectInputStream(new FileInputStream("cipherkey.dat"));
            Key cipherKey = (Key)ois.readObject();
            ois.close();

            // read encrypted data
            ois = new ObjectInputStream(new FileInputStream("encrypted.dat"));
            byte[] encrypted = (byte[])ois.readObject();
            ois.close();

            // decrypt
            Cipher cipher = Cipher.getInstance("DESede/CBC/PKCS5Padding");
            IvParameterSpec iv = new IvParameterSpec(new byte[8]);
            cipher.init(Cipher.DECRYPT_MODE, cipherKey, iv);
            byte[] decrypted = cipher.doFinal(encrypted);
            
            // save decrypted
            PrintWriter out = new PrintWriter("decrypted.txt");
            out.print(new String(decrypted));
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
