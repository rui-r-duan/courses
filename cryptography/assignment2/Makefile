SRCS = $(shell find . -name "*.java")

.PHONY: testhash
testhash: TestHash.java Hash.class CTR.class MDES.class RDUtils.class
	javac TestHash.java

.PHONY: test3
test3: TEst_P1_3.java MDES.class RDUtils.class
	javac Test_P1_3.java

.PHONY: testCBC
testCBC: tEst_P2_CBC.java CBC.class MDES.class RDUtils.class
	javac Test_P2_CBC.java

.PHONY: testCTR
testCTR: Test_P2_CTR.java CTR.class MDES.class RDUtils.class
	javac Test_P2_CTR.java

.PHONY: birthdayAttack
birthdayAttack: BirthdayAttack.java MDES.class CTR.class Hash.class \
		RDUtils.class
	javac BirthdayAttack.java

MDES.class: ryanduan/crypt/MDES.java RDUtils.class
	javac ryanduan/crypt/MDES.java

CBC.class: ryanduan/crypt/CBC.java MDES.class RDUtils.class
	javac ryanduan/crypt/CBC.java

CTR.class: ryanduan/crypt/CTR.java MDES.class RDUtils.class
	javac ryanduan/crypt/CTR.java

Hash.class: ryanduan/crypt/Hash.java MDES.class CTR.class RDUtils.class
	javac ryanduan/crypt/Hash.java

RDUtils.class: ryanduan/crypt/RDUtils.java
	javac ryanduan/crypt/RDUtils.java

TAGS: $(SRCS)
	etags $(SRCS)

.PHONY: clean
clean:
	rm -f *.class ryanduan/crypt/*.class
