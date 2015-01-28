#include "perm_cipher.h"
#include <string.h>

/* note: buffers must be large enough to contain enough padding */
int perm_enc(const char* k, int keylen, const char* pb, char* cb, int buflen)
{
    int i;                      /* iterate over plaintext */
    int j;                      /* iterate over key */
    int strlength;
    memset((void*)cb, 0, buflen);
    strlength = strlen(pb);
    for (i = 0; pb[i] != '\0' && i < buflen; i += keylen) {
        for (j = 0; j < keylen; ++j) {
            int t = k[j];
            if (i+t >= strlength) {
                cb[i+j] = 1; /* padding is 1 */
            } else {
                cb[i+j] = pb[i+t];
            }
        }
    }
    return 0;
}

/* note: buffers must be large enough to contain enough padding */
int perm_dec(const char* k, int keylen, const char* cb, char* pb, int buflen)
{
    int i;                      /* iterate over ciphertext */
    int j;                      /* iterate over key */
    memset((void*)pb, 0, buflen);
    for (i = 0; cb[i] != '\0' && i < buflen; i += keylen) {
        for (j = 0; j < keylen; ++j) {
            int t = k[j];
            pb[i+t] = cb[i+j];
        }
    }    
    return 0;
}
