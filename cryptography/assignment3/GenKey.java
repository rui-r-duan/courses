//----------------------------------------------------------------------------
// Cryptography Assignment 3
//
// Generate a key pair which contains a public key and a private key, save them
// into files separately.
//
// @author: Rui Duan <rduan@lakeheadu.ca>
//----------------------------------------------------------------------------
import java.security.*;
import java.io.*;

public class GenKey {
    public static void main(String[] args) {
        // create and init key pair generator
        try {
            KeyPairGenerator keygen = KeyPairGenerator.getInstance("DSA");
            SecureRandom secrand = SecureRandom.getInstance("SHA1PRNG", "SUN");
            secrand.setSeed("aetf".getBytes());
            keygen.initialize(1024, secrand); // key size: 1024

            // generate public key and private key
            KeyPair keys = keygen.generateKeyPair();
            PublicKey pubkey = keys.getPublic();
            PrivateKey privkey = keys.getPrivate();

            // save keys in files
            ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream("myprivkey.dat"));
            out.writeObject(privkey);
            out.close();
            out = new ObjectOutputStream(new FileOutputStream("mypubkey.dat"));
            out.writeObject(pubkey);
            out.close();
        } catch (NoSuchAlgorithmException e) {
            System.err.println("KeyPairGenerator is not supported");
        } catch (NoSuchProviderException e) {
            System.err.println("SecureRandom of SHA1PRNG from SUN is not supported");
        } catch (FileNotFoundException e) {
            System.err.println(e.getMessage());
        } catch (IOException e) {
            System.err.println("IOException");
        }
    }
}
