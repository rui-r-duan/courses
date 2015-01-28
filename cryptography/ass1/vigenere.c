#include "vigenere.h"
#include <stdio.h>
#include <string.h>

char char_code(char c)
{
    return c - 'a';
}

char code_char(char c)
{
    return c + 'a';
}

int vigenere_enc(const char* key, int keylen, const char* pb, char* cb, int buflen)
{
    return 0;
}

int vigenere_dec(const char* key, int keylen, const char* cb, char* pb, int buflen)
{
    int i, k;
    memset((void*)pb, 0, buflen);
    for (i = 0; cb[i] != '\0' && i < buflen; ++i) {
        char c = char_code(cb[i]) - char_code(key[(k+i)%keylen]);
        if (c >= 0) {
            c = c % 26;
        } else {
            c = c + 26;
        }
        pb[i] = code_char(c);
    }
    return 0;
}
