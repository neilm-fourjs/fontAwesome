
PROG=fontAwesome
LIB=../g2_lib

# Default FGLDIR
#export FGLIMAGEPATH=../pics:$(FGLDIR)/lib/image2font.txt

# Fontawesome 4.7
#export FGLIMAGEPATH=../pics:../pics/image2font.txt

# Fontawesome 5
export FGLIMAGEPATH=../etc:../etc/fa5.txt

export FGLRESOURCEPATH=../etc
export FGLLDPATH=../$(LIB)/bin:$(GREDIR)/lib

all: bin/$(PROG).42r

bin/$(PROG).42r: src/*.4gl src/*.per
	gsmake $(PROG).4pw

update:
	git pull

run: bin/$(PROG).42r
	cd bin && fglrun $(PROG).42r

clean:
	rm bin/* $(LIB)/bin/*	
