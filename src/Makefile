NAME=dslm

default: $(NAME).pdf

$(NAME).pdf:  $(NAME).tex
	latexmk -pdf $(NAME).tex

$(NAME).tex: $(NAME).lhs $(NAME).format dslmagda.format $(NAME).bib
	lhs2TeX --poly $(NAME).lhs > $(NAME).tex

clean:
	- rm *.ptb *.pag *.aux *.bbl *.blg *.fdb_latexmk *.log $(NAME).tex $(NAME).pdf *.idx *.ilg *.ind *.toc *~ *.vrb *.snm *.fls *.nav *.out

.PHONY: www

www: ${PREPRINT}
	cp ${PREPRINT} ~/jobb/www/www.cse.chalmers.se/papers/
	unison jobb

PREPRINT = Jansson_Einardottir_Ionescu_DSLsofMath_TFPIE_2018_paper_preprint.pdf

${PREPRINT}: ${NAME}.pdf
	ln -s ${NAME}.pdf ${PREPRINT}

# URL: http://www.cse.chalmers.se/~patrikj/papers/Jansson_Einardottir_Ionescu_DSLsofMath_TFPIE_2018_paper_preprint.pdf

upload: DSLsofMath.zip

DSLsofMath.zip: dslm.tex
	-mkdir DSLsofMath
	cp dslm.bib ../eptcsstyle/eptcs.cls ../eptcsstyle/eptcs.bst DSLsofMath/
	sed s+../eptcsstyle/eptcs+eptcs+g dslm.tex > DSLsofMath/dslm.tex
	(cd DSLsofMath; latexmk -pdf)
	zip -r DSLsofMath DSLsofMath
