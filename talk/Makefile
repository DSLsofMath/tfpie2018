NAME=WG2.1_Brandenburg_Jansson_slides
# NAME=tfpie2018slides

default: $(NAME).pdf

$(NAME).pdf:  $(NAME).tex
	latexmk -pdf $(NAME).tex

$(NAME).tex: $(NAME).lhs $(NAME).format dslmagda.format
	lhs2TeX --poly $(NAME).lhs > $(NAME).tex

clean:
	- rm *.ptb *.pag *.aux *.bbl *.blg *.fdb_latexmk *.log $(NAME).tex $(NAME).pdf *.idx *.ilg *.ind *.toc *~ *.vrb *.snm *.fls *.nav *.out
