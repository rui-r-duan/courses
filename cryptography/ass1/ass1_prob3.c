/* Problem 3 of Cryptography Assignment 1

   attack for Vigenère Cipher

   only process lower case letters on Z_26 character set

   @author: Ryan Duan
*/

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <assert.h>
#include "vigenere.h"

#define BUF_LEN 1024
char buf[1024];
char plaintext[1024];

int count[NUM_CHARS] = { 0 };
int count2[NUM_CHARS] = { 0 };
char key[NUM_CHARS] = { 0 };    /* at most NUM_CHARS length */

/*
  if we set MAX_M larger, there might be more m that satisfies 0.065 test, they
  are multiples of the correct m
 */
#define MAX_M 9
/* 8+7+...+1=36, 36 combinations for 0<= i<j <=MAX_M-1 */
#define MAX_COMBINATION 36
double ic[MAX_M][MAX_M] = { 0.0 };
double avg_ic[MAX_M] = { 0.0 };
typedef struct _Pair {
    int i;
    int j;
} Pair;
Pair combinations[MAX_COMBINATION];
double mic[MAX_COMBINATION][NUM_CHARS] = { 0.0 }; /* column are for different shift g */
int g_array[MAX_COMBINATION] = { 0 };
int key_equation[MAX_M] = { 0 };

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
                        int g,   /* shift */
                        int len) /* string length of the whole string in buf */
{
    int i;
    int index = 0;
    *n = 0;
    for (i = 0; (index = r + i * m) < len; ++i) {
        ++ charcnt [ (char_code(buf[index]) + g) % 26 ];
        ++(*n);
    }
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
    char_count_for_seq(count, &n, buf, r, m, 0, strlength);
    for (i = 0; i < NUM_CHARS; ++i) {
        sum += count[i] * (count[i] - 1);
    }
    return (double)sum / (n * (n - 1));
}

/* Use global variables */
void calc_avg_Ic()
{
    int m, i;
    double s = 0;
    for (m = 1; m <= MAX_M; ++m) {
        s = 0;
        for (i = 0; i < m; ++i) {
            s += ic[m-1][i];
        }
        avg_ic[m-1] = s / m;
    }
}

/* use global variables */
int find_key_len()
{
    int m;
    double min_diff = 100.0;
    int result = -1;
    for (m = 1; m <= MAX_M; ++m) {
        double diff = fabs(avg_ic[m-1] - 0.065);
        if (diff < min_diff) {
            min_diff = diff;
            result = m;
        }
    }
    return result;
}

void calc_mic(int m, const char* buf, int strlength)
{
    int i, j;
    int g;                      /* shift */
    int ni, nj;
    int c = 0;                  /* counter for combinations */
    memset((void*)combinations, 0, sizeof(Pair)*MAX_COMBINATION);
    for (i = 0; i < m-1; ++i) {
        for (j = i+1; j < m; ++j) {
            for (g = 0; g < NUM_CHARS; ++g) {
                int sum = 0;
                int k;
                memset((void*)count, 0, sizeof(count));
                memset((void*)count2, 0, sizeof(count2));
                char_count_for_seq(count, &ni, buf, i, m, 0, strlength);
                char_count_for_seq(count2, &nj, buf, j, m, g, strlength);
                for (k = 0; k < NUM_CHARS; ++k) {
                    sum += count[k] * count2[k];
                }
                mic[c][g] = (double)sum / (ni * nj);
            }
            combinations[c].i = i;
            combinations[c].j = j;
            ++c;
        }
    }
}

/* use global variables */
void find_g(int m)
{
    int s = 0;
    int k;
    /* for key length == m, the number of (i,j) combinations is s */
    for (k = m-1; k > 0; --k) {
        s += k;
    }
    for (k = 0; k < s; ++k) {   /* iterate over all (i,j) combinations */
        int g;
        double min_diff = 100.0;
        for (g = 0; g < NUM_CHARS; ++g) {
            double diff = fabs(mic[k][g] - 0.065);
            if (diff < min_diff) {
                min_diff = diff;
                g_array[k] = g;
            }
        }
    }
}

void calc_key_equation(int m)
{
    int i;
    printf("key_equation[0] = 0\n");
    for (i = 1; i < m; ++i) {
        key_equation[i] = 26 - g_array[i-1];
        printf("key_equation[%d] = %d\n", i, key_equation[i]);
    }
    printf("\n");
}

void try_keys(int m)
{
    int i, j;
    FILE* out = NULL;
    char filename[8] = { 0 };
    for (i = 0; i < 26; ++i) {
        key[0] = 'a' + i;
        for (j = 1; j < m; ++j) {
            key[j] = code_char((char_code(key[0]) + key_equation[j]) % 26);
        }
        printf("=== key: %s\n", key);
        (void)vigenere_dec(key, m, buf, plaintext, BUF_LEN);
        sprintf(filename, "vig_out%02d", i);
        printf("%s\n", filename);
        printf("%s\n\n", plaintext);
    }
}

int main(int argc, char* argv[])
{
    int i;
    int r;                  /* row in table */
    int m;                  /* step */
    int strlength;
    FILE* in = fopen(argv[1], "r");
    if (NULL == in) {
        return -1;
    }
    (void)read_to_buf(buf, BUF_LEN, in);
    strlength = strlen(buf);
    for (m = 1; m <= MAX_M; ++m) {
        for (r = 0; r < m; ++r) {
            ic[m-1][r] = calc_Ic(m, r, buf, strlength);
        }
    }
    calc_avg_Ic();
    m = find_key_len();
    printf("key length = %d\n", m);
    calc_mic(m, buf, strlength);
    find_g(m);
    calc_key_equation(m);
    try_keys(m);

    fclose(in);
    return 0;
}
