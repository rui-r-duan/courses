SRCS = $(shell find . -name "*.java")

.PHONY: testhash
testhash: Hash.class MDES.class CTR.class RDUtils.class
	javac TestHash.java

.PHONY: test3
test3: MDES.class RDUtils.class
	javac Test_P1_3.java

.PHONY: testCBC
testCBC: MDES.class CBC.class
	javac Test_P2_CBC.java

.PHONY: testCTR
testCTR: MDES.class CTR.class RDUtils.class
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

TAGS: $(SRCS)
	etags $(SRCS)

.PHONY: clean
clean:
	rm -f *.class ryanduan/crypt/*.class
