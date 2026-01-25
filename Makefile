LATEXMK ?= latexmk
LATEXMKFLAGS ?= -pdf -interaction=nonstopmode -file-line-error -synctex=1

INFUFRGS_DIR := infufrgs

PROP_MAIN := ppgc-prop-tese.tex
TESE_MAIN := ppgc-tese.tex

.PHONY: all prop tese clean

all: prop tese

prop:
	$(LATEXMK) -cd $(LATEXMKFLAGS) $(PROP_MAIN)

tese:
	$(LATEXMK) -cd $(LATEXMKFLAGS) $(TESE_MAIN)

clean:
	$(LATEXMK) -cd -C $(PROP_MAIN)
	$(LATEXMK) -cd -C $(TESE_MAIN)
