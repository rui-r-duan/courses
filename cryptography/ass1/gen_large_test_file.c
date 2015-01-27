#include <stdio.h>
#include "crypt_utils.h"
#include "subst_cipher.h"

char a[NUM_CHAR] = {0};
char b[NUM_CHAR] = {0};

int main(void)
{
    int i;
    int j;
    list_chars(a, NUM_CHAR);
    for (i = 0; i < 100000; ++i) {
        if (gen_permutation(a, b, NUM_CHAR) == 0) {
            for (j = 0; j < NUM_CHAR; ++j) {
                putchar(b[j]);
            }
        }
    }
    return 0;
}
