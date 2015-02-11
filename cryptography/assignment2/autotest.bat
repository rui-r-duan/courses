echo "---- Test MDES Encryption and Decryption ----"
java Test_P1_3 < input1
java Test_P1_3 < input2
java Test_P1_3 < input3
java Test_P1_3 < input4
java Test_P1_3 < input_void
java Test_P1_3 < input_invalid

echo "---- Test CBC Mode ----"
java Test_P2_CBC < input1
java Test_P2_CBC < input2
java Test_P2_CBC < input3
java Test_P2_CBC < input4
java Test_P2_CBC < input_void
java Test_P2_CBC < input_invalid

echo "---- Test CTR Mode ----"
java Test_P2_CTR < input1
java Test_P2_CTR < input2
java Test_P2_CTR < input3
java Test_P2_CTR < input4
java Test_P2_CTR < input_void
java Test_P2_CTR < input_invalid

echo "---- Test Hash ----"
java TestHash < input1
java TestHash < input2
java TestHash < input3
java TestHash < input4
java TestHash < input_void
java TestHash < input_invalid

echo "---- Test Birthday Attack ----"
java BirthdayAttack < input1
