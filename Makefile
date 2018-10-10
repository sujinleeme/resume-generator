#!make

all: build pdf

build:
	mkdir -p out
	cp -r static/ out/static/

	pandoc --section-divs -s ./content/resume.md -H ./templates/header.html -c static/resume.css -o ./out/resume.html
	pandoc --section-divs -s ./content/letter.md -H ./templates/header.html -c static/letter.css -o ./out/letter.html
	pandoc --section-divs -s ./content/references.md -H ./templates/header.html -c static/references.css -o ./out/references.html

pdf: build
	phantomjs bin/rasterize.js out/resume.html out/resume.pdf 0.7
	phantomjs bin/rasterize.js out/references.html out/references.pdf 0.8
	phantomjs bin/rasterize.js out/letter.html out/letter.pdf 0.8
