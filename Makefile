LATEXMK ?= latexmk
LATEXMKFLAGS ?= -pdf -interaction=nonstopmode -file-line-error -synctex=1

INFUFRGS_DIR := infufrgs

PROP_MAIN := ppgc-prop-tese.tex
TESE_MAIN := ppgc-tese.tex
PRES_MAIN := presentation/presentation.tex

.PHONY: all prop tese presentation clean clean-presentation

all: prop tese presentation

prop:
	$(LATEXMK) -cd $(LATEXMKFLAGS) $(PROP_MAIN)

tese:
	$(LATEXMK) -cd $(LATEXMKFLAGS) $(TESE_MAIN)

presentation:
	$(LATEXMK) -cd $(LATEXMKFLAGS) $(PRES_MAIN)

clean-presentation:
	$(LATEXMK) -cd -c $(PRES_MAIN)

clean:
	$(LATEXMK) -cd -C $(PROP_MAIN)
	$(LATEXMK) -cd -C $(TESE_MAIN)
	$(MAKE) clean-presentation
