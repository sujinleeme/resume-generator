#!make
CURRENT_BRANCH = $(shell git name-rev --name-only HEAD)
OUPUT_DIR = out
BUILD_DIR = public
ifndef CURRENT_BRANCH
CURRENT_BRANCH = $(error Could not get current branch.)
endif

DATE=$(shell date +%F)

ifeq ($(shell echo "check_quotes"),"check_quotes")
   WINDOWS := yes
else
   WINDOWS := no
endif

ifeq ($(WINDOWS),yes)
   mkdir = mkdir $(subst /,\,$(1)) > nul 2>&1 || (exit 0)
   cp = cp $(subst /,\,$(1)) > nul 2>&1 || (exit 0)
   rm = $(wordlist 2,65535,$(foreach FILE,$(subst /,\,$(1)),& del $(FILE) > nul 2>&1)) || (exit 0)
   rmdir = rmdir $(subst /,\,$(1)) > nul 2>&1 || (exit 0)
   echo = echo $(1)
else
   mkdir = mkdir -p $(1)
   cp = cp -r $(1)
   rm = rm $(1) > /dev/null 2>&1 || true
   rmdir = rmdir $(1) > /dev/null 2>&1 || true
   echo = echo "$(1)"
endif

all: build pdf

build:
	$(mkdir, $(OUPUT_DIR))
	$(cp, $(static/ out/static/))

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
	pandoc --section-divs -s ./content/resume.md -H ./templates/header.html -c static/resume.css -o index.html
	git checkout gh-pages
	-rsync -a --delete --exclude=.* --exclude=.git --exclude=static/* index.html .
	$(rm, $(out content/ bin/ templates/ installation.md Makefile README.md))
	-git add index.html static
	-git add -u
	-git commit -m 'Automatic build commit on $(DATE).'
	git push
	git checkout ${CURRENT_BRANCH}

clean:
	$(RM) $(OUPUT_DIR)