all: Hash.class MDES.class CTR.class RDUtils.class
	javac TestHash.java

test3: MDES.class RDUtils.class
	javac Test_P1_3.java

CBCtest: MDES.class CBC.class
	javac Test_P2_CBC.java

CTRtest: MDES.class CTR.class RDUtils.class
	javac Test_P2_CTR.java

MDES.class:
	javac ryanduan/crypt/MDES.java

CBC.class:
	javac ryanduan/crypt/CBC.java

CTR.class:
	javac ryanduan/crypt/CTR.java

Hash.class:
	javac ryanduan/crypt/Hash.java

RDUtils.class:
	javac ryanduan/crypt/RDUtils.java

test1: MDES.class
	javac Test_P1_1.java

test2: MDES.class
	javac Test_P1_2.java


.PHONY: clean
clean:
	rm -f *.class ryanduan/crypt/*.class
