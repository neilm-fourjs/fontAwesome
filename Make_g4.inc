
#.SUFFIXES: .4gl .42m .per .42f .42r .str .42s .java .class

FGLCOMP = fglcomp -Dgenero$(GENVER) $(PPARG) --resolve-calls 
FGLLINK = fgl2p $(PPARG)
FGLFORM = fglform

export FGLSOURCEPATH=$(SRC)
export FGLLDPATH=$(BIN):$(GREDIR)/lib

prg_srcs = $(notdir $(prg_src))
prg_obj = $(patsubst %.4gl, %.42m, $(prg_srcs))
prg_objs = $(addprefix $(BIN)/, $(prg_obj))
prg_pers = $(notdir $(prg_per))
prg_frm = $(patsubst %.per, %.42f, $(prg_pers))
prg_frms = $(addprefix $(BIN)/, $(prg_frm))

all: $(lib) $(prg_objs) $(prg_frms)

g2_lib:
	cd ../g2_lib && make

$(BIN)/%.42m: $(SRC)/%.4gl
	$(FGLCOMP) -o $(BIN) $<

$(BIN)/%.42f: $(SRC)/%.per
	$(FGLFORM) -M $< && mv $(SRC)/*.42f $(BIN)

clean:
	find $(BIN) -name \*.42? -delete
	find . -name \*.42? -delete
	find . -name \*.err -delete

debug: 
	@echo SRC=$(SRC)
	@echo
	@echo lib_src=$(lib_src)
	@echo
	@echo lib_srcs=$(lib_srcs)
	@echo
	@echo lib_obj=$(lib_obj)
	@echo
	@echo lib_objs=$(lib_objs)
	@echo
	@echo lib_per=$(lib_per)

