BUILDDIR = build
OUTDIR = pdf
TEXDIR = tex
TEXFILE = projektplan.tex
PDFFILE = $(addsuffix .pdf,$(basename $(TEXFILE)))

$(TEXDIR)/$(OUTDIR)/$(PDFFILE): $(TEXDIR)/$(TEXFILE) $(wildcard $(TEXDIR)/*.tex)
	cd $(dir $<) ; mkdir -p $(BUILDDIR)
	cd $(dir $<) ; pdflatex -halt-on-error -output-directory=$(BUILDDIR) $(notdir $<)
	cd $(dir $<) ; pdflatex -halt-on-error -output-directory=$(BUILDDIR) $(notdir $<)
	cd $(dir $<) ; mkdir -p $(OUTDIR)
	cd $(dir $<) ; mv $(BUILDDIR)/$(PDFFILE) $(OUTDIR)

.PHONY: clean
clean:
	rm -rf $(TEXDIR)/$(BUILDDIR)
	rm -rf $(TEXDIR)/$(OUTDIR)
