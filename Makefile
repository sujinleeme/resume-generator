#!make
CURRENT_BRANCH = $(shell git name-rev --name-only HEAD)
OUPUT_DIR = out
BUILD_DIR = public
ifndef CURRENT_BRANCH
CURRENT_BRANCH = $(error Could not get current branch.)
endif

DATE=$(shell date +%F)

ifeq ($(OS),Windows_NT)
    RM = cmd //C del //Q //F
    RRM = cmd //C rmdir //Q //S
else
    RM = rm -rf
    RRM = rm -f -r
endif

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

gh-page:
	git checkout -b gh-pages 
	git push --set-upstream origin gh-pages
	git checkout ${CURRENT_BRANCH}

deploy: build
	@echo "Cleaning $(BUILD_DIR)"
	pandoc --section-divs -s ./content/resume.md -H ./templates/header.html -c static/resume.css -o ./index.html
	git checkout gh-pages
	-rsync -a --delete --exclude=.* --exclude=.git --exclude=static/* index.html .
	$(RM) out content/ bin/ templates/ installation.md Makefile README.md
	-git add index.html static
	-git add -u
	-git commit -m 'Automatic build commit on $(DATE).'
	git push
	git checkout ${CURRENT_BRANCH}

clean:
	$(RM) $(OUPUT_DIR)