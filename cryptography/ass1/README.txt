Environment for building and running:
MinGW and gcc

--------------------------------
Program 1 Sample Usage
--------------------------------
$> make substcipher
$> substcipher --genkey key
$> substcipher --enc encout1_prob1 --key key input1
$> substcipher --dec decout1_prob1 --key key encout1_prob1
$> make test
$> ./test.sh # auto test

--------------------------------
Program 2 Sample Usage
--------------------------------
$> make permcipher
$> permcipher --genkey key --keylen 6
$> permcipher --enc encout1_prob2 --key key input1
$> permcipher --dec decout1_prob2 --key key encout1_prob2

--------------------------------
Program 3 Sample Usage
--------------------------------
$> make av
$> av cipher1
