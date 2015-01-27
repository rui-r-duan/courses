/* Problem 1 of Cryptography Assignment 1

   Substitution Cipher Encryption and Decription

   Write computer programs for the Substitution Cipher based on Z29 which is
   corresponding to 26 alphabetic characters, space (26), and "," (27)
   "."(28). The key is a random permutation PI on Z29. Write down encryption
   and decryption programs.  Select a paragraph of text (I don't think any two
   people will choose a same paragraph if they choose independently) and
   encrypt it using your encryption algorithm. Then use your decryption program
   to check the correctness. You can use Java, C or other computer
   languages. Record your plaintext, ciphertext and the key PI in your answer
   sheet.

   Encrypt for lower case letters.

   @author: Ryan Duan
*/

#include <stdio.h>
#include <string.h>
#include "subst_cipher.h"
#include "crypt_utils.h"

#define BUF_LEN  1024

/* Global variables */
Key key;
char plaintext_buf[BUF_LEN];
char ciphertext_buf[BUF_LEN];

void print_key(Key* pk)
{
    print_array(pk->p, NUM_CHAR);
    print_array(pk->c, NUM_CHAR);
}

/* return EOF if it encounters EOF, otherwise return the string length */
size_t read_to_buf(char* buf, int buflen)
{
    int i;
    char c;
    for (i = 0; (c = getchar()) != EOF && i < buflen - 1; ++i) {
        buf[i] = c;
    }
    buf[i] = '\0';
    if (c == EOF) {
        return EOF;
    } else {
        return i;               /* string length */
    }
}

int main(int argc, char* argv[])
{
    int result = 0;

    memset((void*)key.p, 0, NUM_CHAR);
    memset((void*)key.c, 0, NUM_CHAR);
    memset((void*)plaintext_buf, 0, BUF_LEN);
    memset((void*)ciphertext_buf, 0, BUF_LEN);

    /* generate a key and print it*/
    list_chars(key.p, NUM_CHAR);
    if (gen_permutation(key.p, key.c, NUM_CHAR) == 0) {
        print_key(&key);
    }

    /* seperate the key and the plaintext output */
    putchar('\n');

    /* read plaintext into buffer */
    read_to_buf(plaintext_buf, BUF_LEN);

    /* encrypt the plaintext in the buffer and output it */
    result = subst_enc(&key, plaintext_buf, ciphertext_buf, BUF_LEN);
    if (result == 0) {
        printf("%s\n", ciphertext_buf);
    } else if (result == -1) {     /* unknown character */
        printf("unknown character encountered\n");
    }

    /* seperate the ciphertext from the decrypted plaintext */
    putchar('\n');

    /* decrypt the ciphertext in the buffer and output it */
    result = subst_dec(&key, ciphertext_buf, plaintext_buf, BUF_LEN);
    if (result == 0) {
        printf("%s\n", plaintext_buf);
    } else if (result == -1) {  /* unkown character */
        printf("unknown character encountered\n");
    }

    return 0;
}
