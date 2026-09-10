LATEXMK ?= latexmk
LATEXMKFLAGS ?= -pdf -interaction=nonstopmode -file-line-error -synctex=1

INFUFRGS_DIR := infufrgs

# The UFRGS/ABNTeX2 template ships local .sty/.bst/.def/.bib files in
# infufrgs/inputs/ and references them without a path. latexmk's -cd chdir's
# into infufrgs/, so expose inputs/ (recursively) to TeX's search paths.
# Trailing ':' keeps the default TeX tree on the path.
export TEXINPUTS := .:./inputs//:
export BIBINPUTS := .:./inputs//:
export BSTINPUTS := .:./inputs//:

PROP_MAIN := $(INFUFRGS_DIR)/ppgc-prop-tese.tex
TESE_MAIN := $(INFUFRGS_DIR)/ppgc-tese.tex
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
