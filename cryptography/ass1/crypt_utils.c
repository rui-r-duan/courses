#include "crypt_utils.h"
#include <string.h>
#include <time.h>

int gen_permutation(const char* input, char* output, int length)
{
    int i;
    int r;
    char temp;
    memcpy(output, input, sizeof(char)*length);
    srand(time(NULL));
    for (i = length-1; i >= 0; --i) {
        r = rand() % length;
        temp = output[i];
        output[i] = output[r];
        output[r] = temp;
    }
    return 0;
}
