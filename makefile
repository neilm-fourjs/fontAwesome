
PROJ=fontAwesome
BASE=$(PWD)

# fontAwesome 4.7
#export FGLIMAGEPATH=$(BASE)/etc:$(FGLDIR)/etc/image2font.txt

# fontAwesome 5
#export FGLIMAGEPATH=$(BASE)/etc:$(BASE)/etc/fa5.txt

# fontAwesome + Material Design Regular
#export FGLIMAGEPATH=$(BASE)/etc:$(BASE)/etc/image2font2.txt

# Google Material Design Regular
export FGLIMAGEPATH=$(BASE)/etc:$(BASE)/etc/gmdi.txt

# Material Design Web
#export FGLIMAGEPATH=$(BASE)/etc:$(BASE)/etc/mdi.txt


export FGLRESOURCEPATH=$(BASE)/etc
export FGLLDPATH=$(TRG):$(GREDIR)/lib
export FJS_GL_DBGLEV=1

BIN = ../njm_app_bin
SRC = ./src
lib = g2_lib
prg_src = $(wildcard src/*.4gl)
prg_per = $(wildcard src/*.per)

include ./Make_g4.inc

#all: $(TRG)/$(PROG).42r

#$(TRG)/$(PROG).42r: src/*.4gl src/*.per
#	gsmake $(PROJ).4pw

update:
	git pull

run: $(BIN)/$(PROJ).42m
	cd $(BIN) && fglrun $(PROJ)

runfa5: $(BIN)/$(PROJ).42m
	export FGLIMAGEPATH=$(BASE)/etc:$(BASE)/etc/fa5.txt && cd $(BIN) && fglrun $(PROJ)

rundef: $(BIN)/$(PROJ).42m
	export FGLIMAGEPATH=$(BASE)/etc:$(BASE)/etc/image2font.txt && cd $(BIN) && fglrun $(PROJ)

