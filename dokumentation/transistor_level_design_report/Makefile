BUILDDIR = build
OUTDIR = pdf
TEXDIR = .
TEXFILE = transistor_level_design_report.tex
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
	rm transistor_level_design_report.aux transistor_level_design_report.fdb_latexmk transistor_level_design_report.fls transistor_level_design_report.log transistor_level_design_report.synctex.gz transistor_level_design_report.pdf transistor_level_design_report.toc
