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

PREPRINT = Jansson_Einarsdottir_Ionescu_DSLsofMath_TFPIE_2018_paper_preprint.pdf

${PREPRINT}: ${NAME}.pdf
	ln -s ${NAME}.pdf ${PREPRINT}

# URL: http://www.cse.chalmers.se/~patrikj/papers/Jansson_Einarsdottir_Ionescu_DSLsofMath_TFPIE_2018_paper_preprint.pdf

upload: DSLsofMath.zip

DSLsofMath.zip: dslm.tex
	-mkdir DSLsofMath
	cp dslm.bib eptcs.cls eptcs.bst DSLsofMath/
	(cd DSLsofMath && latexmk -pdf && latexmk -c)
	zip -r DSLsofMath DSLsofMath
