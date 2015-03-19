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
            
            // print decrypted
            System.out.print(new String(decrypted));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
