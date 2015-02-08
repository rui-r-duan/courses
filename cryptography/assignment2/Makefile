all: MDES.class CTR.class
	javac Test_P2_CTR.java

test1: MDES.class
	javac Test_P1_1.java

test2: MDES.class
	javac Test_P1_2.java

test3: MDES.class
	javac Test_P1_3.java

CBCtest: MDES.class CBC.class
	javac Test_P2_CBC.java

MDES.class:
	javac ryanduan/crypt/MDES.java

CBC.class:
	javac ryanduan/crypt/CBC.java

CTR.class:
	javac ryanduan/crypt/CTR.java

.PHONY: clean
clean:
	rm -f *.class ryanduan/crypt/*.class
