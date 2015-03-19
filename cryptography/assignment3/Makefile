SRCS = $(shell find . -name "*.java")

.PHONY: p1
p1: Digest_Sig_Enc.java GenKey.java Verify_Dec.java RDUtils.class
	javac Digest_Sig_Enc.java
	javac GenKey.java
	javac Verify_Dec.java

RDUtils.class: ryanduan/crypto/RDUtils.java
	javac ryanduan/crypto/RDUtils.java

TAGS: $(SRCS)
	etags $(SRCS)

.PHONY: clean
clean:
	rm -f *.class ryanduan/crypto/*.class
