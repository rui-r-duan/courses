/* Problem 2 of Cryptography Assignment 1

   Permutation Cipher Encryption and Decription

   Write computer programs for the Permutation Cipher based on Z29 as in
   Problem 1. In encryption program, the inputs are a value of m, a permutation
   as the key and the plaintext, and the output is the ciphertext. Write the
   decryption program accordingly. Try your programs by some text. Note that
   since m and the length of plaintext is not fixed, paddings might be added to
   the end of plaintext by the program. You may think about what kind padding
   is better for the security and design your paddings.

   Encrypt for lower case letters.

   @author: Ryan Duan
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include "subst_cipher.h"
#include "crypt_utils.h"

#define BUF_LEN  1024

/* Global variables */
char key[NUM_CHARS];           /* program limit: max key length is NUM_CHARS */
char plaintext_buf[BUF_LEN + NUM_CHARS]; /* + NUM_CHARS in order to contain enough paddings */
char ciphertext_buf[BUF_LEN + NUM_CHARS];

void print_key(char* pk, int keylen, FILE* out)
{
    int i;
    fprintf(out, "%d\n\n", keylen);
    for (i = 0; i < keylen-1; ++i) {
        fprintf(out, "%d ", key[i]);
    }
    fprintf(out, "%d", key[i]);
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
    printf("permcipher --genkey keyfile --keylen len\n");
    printf("permcipher --enc [outfile] --key keyfile inputfile\n");
    printf("permcipher --dec [outfile] --key keyfile inputfile\n");
}

void gen_key(FILE* keyfile, int keylen)
{
    char input[keylen];
    int i;
    assert(keylen <= NUM_CHARS);
    for (i = 0; i < keylen; ++i) {
        input[i] = i;
    }
    if (gen_permutation(input, key, keylen) == 0) {
        print_key(key, keylen, keyfile);
    }
}

/* return key length */
int read_key(FILE* keyfile)
{
    int keylen;
    int i;
    memset((void*)key, 0, sizeof(key));
    fscanf(keyfile, "%d\n\n", &keylen);
    for (i = 0; i < keylen - 1; ++i) {
        fscanf(keyfile, "%d ", &key[i]);
    }
    fscanf(keyfile, "%d", &key[i]);
    return keylen;
}

int encrypt(FILE* keyfile, FILE* in, FILE* enc_out)
{
    int result;
    int keylen;

    memset((void*)plaintext_buf, 0, BUF_LEN);

    keylen = read_key(keyfile);

    while (read_to_buf(plaintext_buf, BUF_LEN, in) != 0) {
        result = perm_enc(key, keylen, plaintext_buf, ciphertext_buf, BUF_LEN);
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
    int keylen;

    memset((void*)ciphertext_buf, 0, BUF_LEN);

    keylen = read_key(keyfile);

    while (read_to_buf(ciphertext_buf, BUF_LEN, in) != 0) {
        result = perm_dec(key, keylen, ciphertext_buf, plaintext_buf, BUF_LEN);
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

    if (argc == 5 && strcmp(argv[1], "--genkey") == 0 &&
        strcmp(argv[3], "--keylen") == 0) {
        key_out = fopen(argv[2], "w");
        if (NULL == key_out) {
            return -1;
        }
        gen_key(key_out, atoi(argv[4]));
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
