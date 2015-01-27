#ifndef SUBST_CIPHER_H
#define SUBST_CIPHER_H

#define NUM_CHAR 29

typedef struct _Key
{
    char p[NUM_CHAR];           /* plaintext chars */
    char c[NUM_CHAR];           /* ciphertext chars */
} Key;

void list_chars(char* buf, int len);
int subst_enc(Key* k, const char* pb, char* cb, int buflen);
int subst_dec(Key* k, const char* cb, char* pb, int buflen);

#endif
