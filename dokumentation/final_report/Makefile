BUILDDIR = build
OUTDIR = pdf
TEXDIR = .
TEXFILE = final_report.tex
PDFFILE = $(addsuffix .pdf,$(basename $(TEXFILE)))

$(TEXDIR)/$(OUTDIR)/$(PDFFILE): $(TEXDIR)/$(TEXFILE) $(wildcard tex/*.tex)
	cd $(dir $<) ; mkdir -p $(BUILDDIR)
	cd $(dir $<) ; pdflatex -halt-on-error -output-directory=$(BUILDDIR) $(notdir $<)
	cd $(dir $<) ; pdflatex -halt-on-error -output-directory=$(BUILDDIR) $(notdir $<)
	cd $(dir $<) ; mkdir -p $(OUTDIR)
	cd $(dir $<) ; mv $(BUILDDIR)/$(PDFFILE) $(OUTDIR)

.PHONY: clean
clean:
	rm -rf $(TEXDIR)/$(BUILDDIR)
	rm -rf $(TEXDIR)/$(OUTDIR)

jonasclean:
	rm final_report.aux final_report.fdb_latexmk final_report.fls final_report.log final_report.synctex.gz final_report.pdf final_report.toc
