# LaTeX build (PDF generation)

This repository contains two main LaTeX entrypoints (each generates a different PDF):

- `infufrgs/ppgc-prop-tese.tex`
- `infufrgs/ppgc-tese.tex`

The recommended way to build is using `latexmk` (it automatically runs the needed number of LaTeX/BibTeX passes).

## Installing LaTeX + dependencies

### Option A (recommended): TeX Live

Install **TeX Live** with a reasonably complete set of packages (the “full” install is the easiest way to avoid missing-package errors).

- **Linux**
  - Install via your distro packages (names vary), e.g. TeX Live + extra collections.
  - Ensure `latexmk` is installed (often a separate package).

- **macOS**
  - Install **MacTeX** (TeX Live distribution for macOS). It includes `latexmk`.

- **Windows**
  - Install **TeX Live** (recommended for reproducibility), selecting a full or large installation.

### Option B: MiKTeX (Windows-friendly)

Install **MiKTeX** and enable “install missing packages on the fly” in MiKTeX Console.

Note: on Windows, `latexmk` requires a Perl interpreter. If you see an error like “MiKTeX could not find the script engine 'perl'”, install Perl (e.g. Strawberry Perl) or use the manual build commands below.

### Required tools

You should have these commands available in your terminal:

- `pdflatex`
- `bibtex`
- `latexmk` (recommended)

If your installation is incomplete, builds may fail with “File `...sty` not found”. In that case, install the missing LaTeX packages (or switch to a full TeX Live / MacTeX install).

## Building the PDFs

From the **repository root**:

```bash
make prop
make tese
```

On **Windows**, `make` is not available by default. You can either:

- run `latexmk` directly (no `make` needed), or
- install `make` (so the commands above work).

Artifacts (PDF and auxiliary files) will be generated under `infufrgs/`.

If you don’t have `make`, you can run `latexmk` directly:

```bash
latexmk -cd -pdf -interaction=nonstopmode -file-line-error -synctex=1 ppgc-prop-tese.tex
latexmk -cd -pdf -interaction=nonstopmode -file-line-error -synctex=1 ppgc-tese.tex
```

If `latexmk` is not available, you can build manually (run from inside `infufrgs/`):

```bash
pdflatex -interaction=nonstopmode -file-line-error -synctex=1 ppgc-prop-tese.tex
bibtex ppgc-prop-tese
pdflatex -interaction=nonstopmode -file-line-error -synctex=1 ppgc-prop-tese.tex
pdflatex -interaction=nonstopmode -file-line-error -synctex=1 ppgc-prop-tese.tex

pdflatex -interaction=nonstopmode -file-line-error -synctex=1 ppgc-tese.tex
bibtex ppgc-tese
pdflatex -interaction=nonstopmode -file-line-error -synctex=1 ppgc-tese.tex
pdflatex -interaction=nonstopmode -file-line-error -synctex=1 ppgc-tese.tex
```

### Installing `make` on Windows (optional)

- **MSYS2 (recommended)**
  - Install MSYS2, then install `make` in the MSYS2 shell and run the build from there.

- **Chocolatey**
  - Install a package that provides GNU Make.

- **Git for Windows / Git Bash**
  - Some setups include `make`, but often they do not. If `make` is missing, prefer MSYS2.

## Cleaning build artifacts

From the repository root:

```bash
make clean
```

## Troubleshooting

- **Missing `.sty` / `.cls` files**
  - Install the missing package via your TeX distribution.
  - Prefer a “full” TeX Live/MacTeX install if you want fewer manual steps.

- **Bibliography not updating**
  - Use `latexmk` (it will run BibTeX as needed).
  - Or run `make clean` and build again.
