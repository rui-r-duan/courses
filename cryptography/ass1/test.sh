#!/bin/bash

./substcipher --genkey key

# test 1
./substcipher --enc encout1 --key key input1
./substcipher --dec decout1 --key key encout1
diff decout1 input1
if [ $? -eq 0 ]; then
    echo test 1 passed.
else
    echo test 1 FAILED.
fi

# test 2
./substcipher --enc encout2 --key key input2
./substcipher --dec decout2 --key key encout2
diff decout2 input2
if [ $? -eq 0 ]; then
    echo test 2 passed.
else
    echo test 2 FAILED.
fi

# test 3
./gentestfile > largeinput

./substcipher --enc enclargeout --key key largeinput
./substcipher --dec declargeout --key key enclargeout
diff declargeout largeinput > diffout
if [ $? -eq 0 ]; then
    echo large file test passed.
    rm diffout
else
    echo large file test FAILED.
fi

# test 4
./substcipher --enc --key key input_invalid
