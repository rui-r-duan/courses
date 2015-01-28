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

void print_key(Key* pk, FILE* out)
{
    int i;
    for (i = 0; i < NUM_CHARS; ++i) {
        fputc(pk->p[i], out);
    }
    fputc('\n', out);
    for (i = 0; i < NUM_CHARS; ++i) {
        fputc(pk->c[i], out);
    }
}

/* return the length of the string that has been read in */
size_t read_to_buf(char* buf, int buflen, FILE* in)
{
    int i;
    char c;
    for (i = 0; i < buflen - 1 && (c = fgetc(in)) != EOF; ++i) {
        buf[i] = c;
    }
    buf[i] = '\0';
    return i;               /* string length */
}

void print_usage(void)
{
    printf("Usage:\n");
    printf("substcipher --genkey keyfile\n");
    printf("substcipher --enc [outfile] --key keyfile inputfile\n");
    printf("substcipher --dec [outfile] --key keyfile inputfile\n");
}

void gen_key(FILE* keyfile)
{
    memset((void*)key.p, 0, NUM_CHARS);
    memset((void*)key.c, 0, NUM_CHARS);
    list_chars(key.p, NUM_CHARS);
    if (gen_permutation(key.p, key.c, NUM_CHARS) == 0) {
        print_key(&key, keyfile);
    }
}

int read_key(FILE* keyfile)
{
    int i;
    for (i = 0; i < NUM_CHARS; ++i) {
        key.p[i] = fgetc(keyfile);
    }
    fgetc(keyfile);             /* '\n' */
    for (i = 0; i < NUM_CHARS; ++i) {
        key.c[i] = fgetc(keyfile);
    }
}

int encrypt(FILE* keyfile, FILE* in, FILE* enc_out)
{
    int result;

    memset((void*)plaintext_buf, 0, BUF_LEN);

    read_key(keyfile);

    while (read_to_buf(plaintext_buf, BUF_LEN, in) != 0) {
        result = subst_enc(&key, plaintext_buf, ciphertext_buf, BUF_LEN);
        if (result == 0) {
            fprintf(enc_out, "%s", ciphertext_buf);
        } else if (result == -1) {     /* unknown character */
            printf("unknown character encountered\n");
            return result;
        }
    }
    return result;
}

int decrypt(FILE* keyfile, FILE* in, FILE* dec_out)
{
    int result;

    memset((void*)ciphertext_buf, 0, BUF_LEN);

    read_key(keyfile);

    while (read_to_buf(ciphertext_buf, BUF_LEN, in) != 0) {
        result = subst_dec(&key, ciphertext_buf, plaintext_buf, BUF_LEN);
        if (result == 0) {
            fprintf(dec_out, "%s", plaintext_buf);
        } else if (result == -1) {  /* unkown character */
            printf("unknown character encountered\n");
        }
    }
    return result;
}

int main(int argc, char* argv[])
{
    int result = 0;
    FILE* input = NULL;
    FILE* key_in = NULL;
    FILE* key_out = NULL;
    FILE* enc_out = stdout;
    FILE* dec_out = stdout;

    if (argc == 3 && strcmp(argv[1], "--genkey") == 0) {
        key_out = fopen(argv[2], "w");
        if (NULL == key_out) {
            return -1;
        }
        gen_key(key_out);
        fclose(key_out);
        return 0;
    } else if (argc == 5 &&
               strcmp(argv[1], "--enc") == 0 &&
               strcmp(argv[2], "--key") == 0) {
        key_in = fopen(argv[3], "r");
        input = fopen(argv[4], "r");
        if (NULL == key_in || NULL == input) {
            return -1;
        }
        result = encrypt(key_in, input, stdout);
        fclose(input);
        fclose(key_in);
        return result;
    } else if (argc == 6 &&
               strcmp(argv[1], "--enc") == 0 &&
               strcmp(argv[3], "--key") == 0) {
        key_in = fopen(argv[4], "r");
        input = fopen(argv[5], "r");
        enc_out = fopen(argv[2], "w");
        if (NULL == key_in || NULL == input || NULL == enc_out) {
            return -1;
        }
        result = encrypt(key_in, input, enc_out);
        fclose(enc_out);
        fclose(input);
        fclose(key_in);
        return result;
    } else if (argc == 5 &&
               strcmp(argv[1], "--dec") == 0 &&
               strcmp(argv[2], "--key") == 0) {
        key_in = fopen(argv[3], "r");
        input = fopen(argv[4], "r");
        if (NULL == key_in || NULL == input) {
            return -1;
        }
        decrypt(key_in, input, stdout);
        fclose(input);
        fclose(key_in);
        return 0;
    } else if (argc == 6 &&
               strcmp(argv[1], "--dec") == 0 &&
               strcmp(argv[3], "--key") == 0) {
        key_in = fopen(argv[4], "r");
        input = fopen(argv[5], "r");
        dec_out = fopen(argv[2], "w");
        if (NULL == key_in || NULL == input || NULL == dec_out) {
            return -1;
        }
        result = decrypt(key_in, input, dec_out);
        fclose(dec_out);
        fclose(input);
        fclose(key_in);
        return result;
    } else {
        print_usage();
        return 0;
    }

    return 0;
}
