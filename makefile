
PROG=fontAwesome
LIB=../g2_lib
BASE=$(PWD)
TRG=../njm_app_bin

# Default FGLDIR
#export FGLIMAGEPATH=../pics:$(FGLDIR)/lib/image2font.txt

# Fontawesome 4.7
#export FGLIMAGEPATH=../pics:../pics/image2font.txt

# Fontawesome 5
export FGLIMAGEPATH=$(BASE)/etc:$(BASE)/etc/fa5.txt
export FGLRESOURCEPATH=$(BASE)/etc
export FGLLDPATH=$(TRG):$(GREDIR)/lib
export FJS_GL_DBGLEV=1

all: $(TRG)/$(PROG).42r

$(TRG)/$(PROG).42r: src/*.4gl src/*.per
	gsmake $(PROG).4pw

update:
	git pull

run: $(TRG)/$(PROG).42r
	cd $(TRG) && fglrun $(PROG).42r

clean:
	gsmake -c $(PROG).4pw
