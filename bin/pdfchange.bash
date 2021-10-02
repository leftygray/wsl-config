#!/bin/bash
#
# This script contains a set of functions for manipulating PDF files. 

rpo() {
	# Remove first page from a pdf. Useful for academic papers with journal info junk on the
	# front. 

	pdftk "$1" cat 2-end output temp.pdf
	mv temp.pdf "$1"
}

rlp() {
	# Remove last page from a PDF. Useful for academic papers with journal info junk on the last page

	pdftk "$1" cat 1-r2 output temp.pdf
	mv temp.pdf "$1"
}

spdf() {
	# Uses pdftk to burst a pdf document into single pages

	pdftk "$1" burst
}
