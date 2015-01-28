/* Problem 3 of Cryptography Assignment 1

   attack for Vigenère Cipher

   only process lower case letters on Z_26 character set

   compile with --std=c99 option

   @author: Ryan Duan
*/

#include <stdio.h>
#include <string.h>
#include <assert.h>

char table[5][1024];

#define BUF_LEN 1024
char buf[1024];

char key[5] = { 0 };

#define NUM_CHARS 26
int count[NUM_CHARS] = { 0 };
double freq[NUM_CHARS] = { 0.0 };

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
        printf("%c\n", buf[index]);
    }
    /* for (i = 0; i < NUM_CHARS; ++i) { */
    /*     freq[i] = count[i] / (double)strlength; */
    /* } */
}

/* calculate the index of coincidence of the r-th row of the table (buf) */
/* use global variables */
double calc_Ic(int m, int r, const char* buf, int strlength)
{
    int i;
    int sum;
    assert(r < m && r > 0);
    memset((void*)count, 0, sizeof(count));
    char_count_for_seq(count, buf, r, m, strlength);
    for (i = 0; i < NUM_CHARS; ++i) {
        sum += count[i] * (count[i] - 1);
    }
    return (double)sum / (strlength * (strlength - 1));
}

/* use global variables */
void fill_table()
{
    int i, j;
    memset((void*)table, 0, sizeof(table));
    strncpy(&table[0][0], buf, BUF_LEN);
}

int main(int argc, char* argv[])
{
    int i;
    FILE* in = fopen(argv[1], "r");
    if (NULL == in) {
        return -1;
    }
    while (read_to_buf(buf, BUF_LEN, in)) {
        /* fill_table(); */
        int r;
        int strlength = strlen(buf);
        for (r = 0; r < 1; r++) {
            printf("Ic_row_1: %f\n", calc_Ic(2, r, buf, strlength));
        }
    }
    fclose(in);
    return 0;
}
