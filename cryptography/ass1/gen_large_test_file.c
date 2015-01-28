#include <stdio.h>
#include "crypt_utils.h"
#include "subst_cipher.h"

char a[NUM_CHARS] = {0};
char b[NUM_CHARS] = {0};

int main(void)
{
    int i;
    int j;
    list_chars(a, NUM_CHARS);
    for (i = 0; i < 1000; ++i) {
        if (gen_permutation(a, b, NUM_CHARS) == 0) {
            for (j = 0; j < NUM_CHARS; ++j) {
                putchar(b[j]);
            }
        }
    }
    return 0;
}
