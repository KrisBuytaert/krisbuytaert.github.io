ALL:
	rm index.html
	sgml2html -I NCD-HOWTO.sgml
	ln -s NCD-HOWTO.html index.html
	sgml2latex NCD-HOWTO.sgml
	dvipdf NCD-HOWTO.dvi
