#ifndef VIGENERE_H
#define VIGENERE_H

#define NUM_CHARS 26

int vigenere_enc(const char* key, int keylen, const char* pb, char* cb, int buflen);
int vigenere_dec(const char* key, int keylen, const char* cb, char* pb, int buflen);

char char_code(char c);
char code_char(char c);

#endif
