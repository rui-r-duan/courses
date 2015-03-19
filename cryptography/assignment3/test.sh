#!/bin/bash

java GenKey
java Digest_Sig_Enc < tryJavaSecurity.txt
java Verify_Dec
diff  decrypted.txt tryJavaSecurity.txt
