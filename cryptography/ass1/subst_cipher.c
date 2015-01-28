#include "subst_cipher.h"
#include <stdio.h>
#include <string.h>
#include <assert.h>

/* only for this problem, so 'len' is always 29 */
void list_chars(char* buf, int len)
{
    int i;
    assert(len > 26);
    assert(len == 29);
    for (i = 0; i < 26; ++i) {
        buf[i] = 'a' + i;
    }
    buf[i++] = ' ';             /* index = 26 */
    buf[i++] = ',';             /* index = 27 */
    buf[i] = '.';               /* index = 28 */
    assert(i == 28);
}

/* return 0 if encrypt successfully,
   return -1 if unknown character is encountered
*/
int subst_enc(Key* k, const char* pb, char* cb, int buflen)
{
    int i;
    memset((void*)cb, 0, buflen);
    for (i = 0; pb[i] != '\0' && i < buflen; ++i) {
        if (pb[i] == ' ') {
            cb[i] = k->c[26];
        } else if (pb[i] == ',') {
            cb[i] = k->c[27];
        } else if (pb[i] == '.') {
            cb[i] = k->c[28];
        } else if (pb[i] >= 'a' && pb[i] <= 'z') {
            cb[i] = k->c[pb[i]-'a'];
        } else {
            fprintf(stderr,
                    "UNKNOWN CHARACTER: '%c' cannot be encrypted!\n", pb[i]);
            return -1;
        }
    }
    return 0;
}

int subst_dec(Key* k, const char* cb, char* pb, int buflen)
{
    int i;
    int j;
    memset((void*)pb, 0, buflen);

    for (i = 0; cb[i] != '\0' && i < buflen; ++i) {
        /* get the index of cb[i] in the key */
        for (j = 0; j < NUM_CHARS; ++j) {
            if (k->c[j] == cb[i]) { /* j is the index */
                break;
            }
        }
        if (j == NUM_CHARS) {
            /* the char cb[i] was not found in the key */
            fprintf(stderr,
                    "UNKNOWN CHARACTER: '%c' (pos: %d) cannot be decrypted!\n", cb[i], i);
            return -1;
        }
        pb[i] = k->p[j];

    }
    return 0;
}
