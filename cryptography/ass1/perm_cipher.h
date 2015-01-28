#ifndef PERM_CIPHER_H
#define PERM_CIPHER_H

#define NUM_CHARS 29

int perm_enc(const char* k, int keylen, const char* pb, char* cb, int buflen);
int perm_dec(const char* k, int keylen, const char* cb, char* pb, int buflen);

#endif  /* PERM_CIPHER_H */
