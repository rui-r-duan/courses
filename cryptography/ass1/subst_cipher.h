#ifndef SUBST_CIPHER_H
#define SUBST_CIPHER_H

#define NUM_CHARS 29

typedef struct _Key
{
    char p[NUM_CHARS];           /* plaintext chars */
    char c[NUM_CHARS];           /* ciphertext chars */
} Key;

void list_chars(char* buf, int len);
int subst_enc(Key* k, const char* pb, char* cb, int buflen);
int subst_dec(Key* k, const char* cb, char* pb, int buflen);

#endif
