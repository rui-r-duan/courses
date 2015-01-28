/* Problem 3 of Cryptography Assignment 1

   attack for Vigenère Cipher

   only process lower case letters on Z_26 character set

   @author: Ryan Duan
*/

#include <stdio.h>
#include <string.h>
#include <assert.h>

#define BUF_LEN 1024
char buf[1024];

#define NUM_CHARS 26
int count[NUM_CHARS] = { 0 };
char key[NUM_CHARS] = { 0 };    /* at most NUM_CHARS length */

inline char char_code(char c)
{
    return c - 'a';
}

inline char code_char(char c)
{
    return c + 'a';
}

/* Return the length of the string that has been read in */
size_t read_to_buf(char* buf, int buflen, FILE* in)
{
    int i;
    char c;
    for (i = 0; i < buflen - 1 && (c = fgetc(in)) != EOF; ++i) {
        buf[i] = c;
    }
    buf[i] = '\0';
    return i;               /* string length */
}

void char_count_for_seq(int charcnt[], /* output: char count */
                        int* n,        /* output: str length of the sequence */
                        const char* buf,
                        int r,   /* row (begin from 0) of table in algorithm */
                        int m,   /* step */
                        int len) /* string length of the whole string in buf */
{
    int i;
    int index = 0;
    *n = 0;
    for (i = 0; (index = r + i * m) < len; ++i) {
        ++ charcnt [ char_code(buf[index]) ];
        ++(*n);
        /* printf("%c ", buf[index]); */
    }
    putchar('\n');
}

/* calculate the index of coincidence of the r-th row of the table (buf) */
/* use global variables */
double calc_Ic(int m, int r, const char* buf, int strlength)
{
    int i;
    int sum = 0;
    int n;
    assert(r < m && r >= 0);
    memset((void*)count, 0, sizeof(count));
    char_count_for_seq(count, &n, buf, r, m, strlength);
    /* printf("n = %d\n", n); */
    for (i = 0; i < NUM_CHARS; ++i) {
        /* printf("count[i] = %d\n", count[i]); */
        sum += count[i] * (count[i] - 1);
    }
    return (double)sum / (n * (n - 1));
}

int main(int argc, char* argv[])
{
    int i;
    FILE* in = fopen(argv[1], "r");
    if (NULL == in) {
        return -1;
    }
    while (read_to_buf(buf, BUF_LEN, in)) {
        int r;
        int m;
        int strlength = strlen(buf);
        for (m = 2; m < 6; ++m) {
            printf("\n -- m = %d\n", m);
            for (r = 0; r < m; ++r) {
                printf("Ic_row[%d]: %f\n", r, calc_Ic(m, r, buf, strlength));
            }
        }
    }
    fclose(in);
    return 0;
}
