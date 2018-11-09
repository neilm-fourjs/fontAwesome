
PROG=fontAwesome
LIB=gl_lib

export FGLIMAGEPATH=../pics:$(FGLDIR)/lib/image2font.txt
export FGLRESOURCEPATH=../$(LIB)/etc
export FGLLDPATH=../$(LIB)/bin:$(GREDIR)/lib

all: bin/$(PROG).42r

bin/$(PROG).42r: $(LIB)/bin/$(LIB).42x
	gsmake $(PROG).4pw

$(LIB)/bin/$(LIB).42x:
	cd $(LIB) && gsmake $(LIB).4pw

update:
	git pull
	git submodule foreach git pull origin master

run: bin/$(PROG).42r
	cd bin && fglrun $(PROG).42r

clean:
	rm bin/* $(LIB)/bin/*	
