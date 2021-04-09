
FGLRUN = fglrun
FGLCOMP = fglcomp -Dgenero$(GENVER) $(PPARG)
FGLLINK = fgl2p $(PPARG)
FGLMKMSG = fglmkmsg
FGLMKSTR = fglmkstr
FGLFORM = fglform -Dgenero$(GENVER) $(PPARG)
FGLRUN = fglrun

#----------------

.SUFFIXES: .4gl .42m .per .42f .42r .str .42s .java .class

.4gl.42m:
	$(FGLCOMP) -c -W all $<

.per.42f:
	$(FGLFORM) -M $<

.msg.hlp:
	$(FGLMKMSG) $*.msg $*.hlp

.str.42s:
	$(FGLMKSTR) $*.str $*.42s

.java.class:
	javac -classpath .:$(FGLDIR)/lib/fgl.jar $<


#----------------

4GLOBJ = 42m
FRMOBJ = 42f
4GLRUN = 42r
4GLLIB = 42x

ifndef GSRCS
GSRCS=$(wildcard *.4gl)
endif

ifndef GOBJS
GOBJS=$(patsubst %.4gl,%.42m,$(GSRCS))
endif

ifndef FSRCS
FSRCS=$(wildcard *.per)
endif

ifndef FOBJS
FOBJS=$(patsubst %.per,%.42f,$(FSRCS))
endif

ifndef SSTRS
SSTRS=$(wildcard *.str)
endif

ifndef SOBJS
SOBJS=$(patsubst %.str,%.42s,$(SSTRS))
endif


ifdef SUBDIRS

all:: subdirs $(EXTRA_TARGETS) $(PRG1) $(PRG2) $(PRG3) $(PRG4) $(PRG5) $(PRG6) \
							$(PRG7) $(PRG8) $(PRG9) $(PRG10) $(PRG11) $(PRG12) $(PRGOTH) \
			allforms allstrs

subdirs::
	@for i in $(SUBDIRS) ;\
	do \
	echo "making" subdirs "in $$i...";\
	$(MAKE) -C $$i $(MFLAGS) all || exit; \
	done

else

all:: $(EXTRA_TARGETS) $(PRG1) $(PRG2) $(PRG3) $(PRG4) $(PRG5) $(PRG6) \
			$(PRG7) $(PRG8) $(PRG9) $(PRG10) $(PRG11) $(PRG12) $(PRGOTH) \
			allforms allstrs $(allextra)

endif

allforms:: $(FOBJS)
	@echo "All Forms build finished."

allmods:: $(GOBJS)
	@echo "All 4gls build finished."

allstrs:: $(SOBJS)
	@echo "All Strings build finished."

$(genlib): $(GENLIBOBJ)
	$(FGLLINK) -o $@ $^

$(PRG1): $(deps1) $(fgl_obj1) $(fgl_frm1) $(genlib) $(lib1)
	$(FGLLINK) -o $@ $(fgl_obj1) $(genlib) $(lib1)

$(PRG2): $(deps2) $(fgl_obj2) $(fgl_frm2) $(genlib) $(lib2)
	$(FGLLINK) -o $@ $(fgl_obj2) $(genlib) $(lib2)

$(PRG3): $(deps3) $(fgl_obj3) $(fgl_frm3) $(genlib) $(lib3)
	$(FGLLINK) -o $@ $(fgl_obj3) $(genlib) $(lib3)

$(PRG4): $(deps4) $(fgl_obj4) $(fgl_frm4) $(genlib) $(lib4)
	$(FGLLINK) -o $@ $(fgl_obj4) $(genlib) $(lib4)

$(PRG5): $(deps5) $(fgl_obj5) $(fgl_frm5) $(genlib) $(lib5)
	$(FGLLINK) -o $@ $(fgl_obj5) $(genlib) $(lib5)

$(PRG6): $(deps6) $(fgl_obj6) $(fgl_frm6) $(genlib) $(lib6)
	$(FGLLINK) -o $@ $(fgl_obj6) $(genlib) $(lib6)

$(PRG7): $(deps7) $(fgl_obj7) $(fgl_frm7) $(genlib) $(lib7)
	$(FGLLINK) -o $@ $(fgl_obj7) $(genlib) $(lib7)

$(PRG8): $(deps8) $(fgl_obj8) $(fgl_frm8) $(genlib) $(lib8)
	$(FGLLINK) -o $@ $(fgl_obj8) $(genlib) $(lib8)

$(PRG9): $(deps9) $(fgl_obj9) $(fgl_frm9) $(genlib) $(lib9)
	$(FGLLINK) -o $@ $(fgl_obj9) $(genlib) $(lib9)

$(PRG10): $(deps10) $(fgl_obj10) $(fgl_frm10) $(genlib) $(lib10)
	$(FGLLINK) -o $@ $(fgl_obj10) $(genlib) $(lib10)

$(PRG11): $(deps11) $(fgl_obj11) $(fgl_frm11) $(genlib) $(lib11)
	$(FGLLINK) -o $@ $(fgl_obj11) $(genlib) $(lib11)

$(PRG12): $(deps12) $(fgl_obj12) $(fgl_frm12) $(genlib) $(lib12)
	$(FGLLINK) -o $@ $(fgl_obj12) $(genlib) $(lib12)

run: $(PRG1)
	$(FGLRUN) $(PRG1) $(ARG1) $(ARG2) $(ARG3) $(ARG4) $(ARG5)

run2: $(PRG2)
	$(FGLRUN) $(PRG2) $(ARG1) $(ARG2) $(ARG3) $(ARG4) $(ARG5)

run3: $(PRG3)
	$(FGLRUN) $(PRG3) $(ARG1) $(ARG2) $(ARG3)

run4: $(PRG4)
	$(FGLRUN) $(PRG4) $(ARG1) $(ARG2) $(ARG3)

run5: $(PRG5)
	$(FGLRUN) $(PRG5) $(ARG1) $(ARG2) $(ARG3)

run6: $(PRG6)
	$(FGLRUN) $(PRG6) $(ARG1) $(ARG2) $(ARG3)

run7: $(PRG7)
	$(FGLRUN) $(PRG7) $(ARG1) $(ARG2) $(ARG3)

run8: $(PRG8)
	$(FGLRUN) $(PRG8) $(ARG1) $(ARG2) $(ARG3)

clean:
	find . -name \*.42? -exec rm {} \; ;\
	find . -name \*.4go -exec rm {} \; ;\
	find . -name \*.4gi -exec rm {} \; ;\
	find . -name \*.4ge -exec rm {} \; ;\
	rm -f *.class ;\
	$(cleanextra)

