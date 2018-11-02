
export FGLRESOURCEPATH=../etc
export FGLIMAGEPATH=../pics:$(FGLDIR)/lib/image2font.txt
export FGLLDPATH=../gl_lib/bin
PROG=fontAwesome

all: update bin/$(PROG).42r

bin/$(PROG).42r:
	gsmake $(PROG).4pw

update:
	git pull
	git submodule foreach git pull origin master

run: bin/$(PROG).42r
	cd bin && fglrun $(PROG).42r
