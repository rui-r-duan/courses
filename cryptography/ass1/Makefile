ass1_prob1: ass1_prob1.o crypt_utils.o subst_cipher.o
	gcc -g -o $@ $^

%.o: %.c
	gcc -g -c $<

gentestfile: gen_large_test_file.o crypt_utils.o subst_cipher.o
	gcc -g -o $@ $^

.PHONY: clean
clean:
	rm -f *.exe *.o
