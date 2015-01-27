ass1_prob1: ass1_prob1.o crypt_utils.o subst_cipher.o
	gcc -g -o $@ $^

%.o: %.c
	gcc -g -c $<

.PHONY: clean
clean:
	rm -f *.exe *.o
