permcipher: ass1_prob2.o crypt_utils.o perm_cipher.o
	gcc -g -o $@ $^

av: ass1_prob3.o vigenere.o
	gcc -g -O2 -o $@ $^

substcipher: ass1_prob1.o crypt_utils.o subst_cipher.o
	gcc -g -O2 -o $@ $^

%.o: %.c
	gcc -g -O2 -c $<

gentestfile: gen_large_test_file.o crypt_utils.o subst_cipher.o
	gcc -g -o $@ $^

.PHONY: test
test: substcipher gentestfile

.PHONY: clean
clean:
	rm -f *.exe *.o
