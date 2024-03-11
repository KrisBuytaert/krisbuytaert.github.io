ALL:
	rm index.html
	sgml2html -I NC-HOWTO.sgml
	ln -s NC-HOWTO.html index.html
	sgml2latex NC-HOWTO.sgml
	dvipdf NC-HOWTO.dvi
