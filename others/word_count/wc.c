/*------------------------------------------------------------------------------
  Count words, lines and paragraphs.

  A word begins with a nonblank, ends before a whitespace (including '\n') or
  EOF.

  A line begins with a nonblank, ends before '\n' or EOF.

  A paragraph begins with a nonblank, ends with two or more successive '\n' or
  line_end with EOF.

  @author: Ryan Duan
------------------------------------------------------------------------------*/

#include <stdio.h>

#define TRUE (1)
#define FALSE (0)

typedef struct _Data {
    int is_eof;
    int is_begin_word;
    int is_end_word;
    int is_begin_line;
    int is_end_line;
    int is_begin_para;
    int is_end_para;

    int n_words;
    int n_lines;
    int n_paras;
    int prev;                   /* prev char */
    int curr;                   /* current char */
    int has_been_putback;
} Data;

void incWords(Data* pd)
{
    pd->n_words += 1;
}

void incLines(Data* pd)
{
    pd->n_lines += 1;
}

void incParas(Data* pd)
{
    pd->n_paras += 1;
}

void read_char(FILE* pIn, Data* pd)
{
    pd->prev = pd->curr;
    if (pd->has_been_putback) {
        pd->curr = pd->prev;
        pd->has_been_putback = FALSE;
    }
    else {
        pd->curr = fgetc(pIn);
    }
}

void putback_char(Data* pd)
{
    pd->has_been_putback = TRUE;
}

void begin_word(Data* pd)
{
    pd->is_begin_word = TRUE;
    pd->is_end_word = FALSE;
}

void end_word(Data* pd)
{
    pd->is_begin_word = FALSE;
    pd->is_end_word = TRUE;
    incWords(pd);
}

void begin_line(Data* pd)
{
    pd->is_begin_line = TRUE;
    pd->is_end_line = FALSE;
}

void end_line(Data* pd)
{
    pd->is_begin_line = FALSE;
    pd->is_end_line = TRUE;
    incLines(pd);
}

void begin_para(Data* pd)
{
    pd->is_begin_para = TRUE;
    pd->is_end_para = FALSE;
}

void end_para(Data* pd)
{
    pd->is_begin_para = FALSE;
    pd->is_end_para = TRUE;
    incParas(pd);
}

void process_whitespaces(FILE* pIn, Data* pd)
{
    if (pd->is_begin_word) {
        end_word(pd);
    }

    while (pd->curr != EOF && pd->curr != '\n' && isspace(pd->curr)) {
        read_char(pIn, pd);
    } 

    /* now pd->curr is not a whitespace or newline */
    if (pd->curr == EOF) {
        pd->is_eof = TRUE;
    }
    else if (pd->curr == '\n') {
        /* handler for the case: newline surrounded by whitespaces */
        if (pd->is_begin_line) {
            end_line(pd);
        }
        if (pd->prev == '\n' && pd->curr == '\n' && pd->is_begin_para) {
            end_para(pd);
        }
    }
    else {                      /* other non-blank char */
        if (!pd->is_begin_word) {
            begin_word(pd);
        }
        putback_char(pd);
    }
}

void process_nonblanks(FILE* pIn, Data* pd)
{
    if (!pd->is_begin_word) {
        begin_word(pd);
    }
    if (!pd->is_begin_line) {
        begin_line(pd);
    }
    if (!pd->is_begin_para) {
        begin_para(pd);
    }

    do {
        read_char(pIn, pd);
    } while (pd->curr != EOF && pd->curr != '\n' && !isspace(pd->curr));

    if (pd->curr == EOF) {
        pd->is_eof = TRUE;
    }
    else if (pd->curr != '\n') { /* other whitespace */
        putback_char(pd);
    }
}

void printTotal(Data* pd)
{
    printf("words: %d, lines: %d, paragraphs: %d\n", pd->n_words,
           pd->n_lines, pd->n_paras);
}

void initialize(Data* pd) {
    pd->is_eof = FALSE;
    pd->is_begin_word = FALSE;
    pd->is_end_word = FALSE;
    pd->is_begin_line = FALSE;
    pd->is_end_line = FALSE;
    pd->is_begin_para = FALSE;
    pd->is_end_para = FALSE;
    pd->n_words = 0;
    pd->n_lines = 0;
    pd->n_paras = 0;
    pd->prev = 0;
    pd->curr = 0;
    pd->has_been_putback = FALSE;
}

void eol_handler(Data* pd) {
    if (pd->is_begin_word) {
        end_word(pd);
    }
    if (pd->is_begin_line) {
        end_line(pd);
    }
    if (pd->prev == '\n' && pd->curr == '\n' && pd->is_begin_para) {
        end_para(pd);
    }
}

void eof_handler(Data* pd) {
    if (pd->is_begin_word) {
        end_word(pd);
    }
    if (pd->is_begin_line) {
        end_line(pd);
    }
    if (pd->is_begin_para) {
        end_para(pd);
    }
}

int main(int argc, char*argv[])
{
    Data data;
    FILE* pIn;
    if (argc == 2) {
        pIn = fopen(argv[1], "r");
        if (NULL == pIn) {
            perror("Failed to open the file");
        }
    }
    else if (argc == 1) {
        pIn = stdin;
    }

    initialize(&data);

    while (!data.is_eof) {
        read_char(pIn, &data);
        if (data.curr == EOF) {
            data.is_eof = TRUE;
            break;
        }
        else if (isspace(data.curr)) { /* whitespace and newline */
            process_whitespaces(pIn, &data);
        }
        else {
            process_nonblanks(pIn, &data);
        }
        if (data.curr == '\n') {
            eol_handler(&data);
        }
    }
    /* EOF handler */
    eof_handler(&data);

    printTotal(&data);

    if (pIn != stdin) {
        fclose(pIn);
    }

    return 0;
}
