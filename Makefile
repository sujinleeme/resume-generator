#!make
CURRENT_BRANCH = $(shell git name-rev --name-only HEAD)
IN_DIR = content
OUT_DIR = out
STATIC_DIRS = static/ out/html/static/
BUILD_CSS = static/resume.css dist/style.css
HTML_DIR = $(OUT_DIR)/html
PDF_DIR = $(OUT_DIR)/pdf
DOCX_DIR = $(OUT_DIR)/docx
DEPLOY_BRANCH = gh-pages
DEPLOY_DELETE_DIRS = out content bin templates
DEPLOY_DELETE_FILES = Makefile README.md LICENSE.md installation_ko.md

ifndef CURRENT_BRANCH
	CURRENT_BRANCH = $(error Could not get current branch.)
endif

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
	DATE = $(shell date /t)
else
	mkdir = mkdir -p $(1)
	cp = cp -r $(1)
	rm = rm -rf $(1) > /dev/null 2>&1 || true
	rmdir = rm -rf $(1) > /dev/null 2>&1 || true
	echo = echo "$(1)"
	DATE = $(shell date +%FT)
endif

all: html pdf docx

html:
	$(call mkdir, $(OUT_DIR))
	$(call mkdir, $(HTML_DIR))
	$(call cp, $(STATIC_DIRS))
	pandoc --section-divs -s ./content/resume.md -H ./templates/header.html -c static/resume.css -o ./${HTML_DIR}/resume.html
	pandoc --section-divs -s ./content/letter.md -H ./templates/header.html -c static/letter.css -o ./${HTML_DIR}/letter.html
	pandoc --section-divs -s ./content/references.md -H ./templates/header.html -c static/references.css -o ./${HTML_DIR}/references.html

docx:
	$(call mkdir, $(DOCX_DIR))
	pandoc --standalone ./content/resume.md --output ./${DOCX_DIR}/resume.docx
	pandoc --standalone ./content/letter.md --output ./${DOCX_DIR}/letter.docx
	pandoc --standalone ./content/references.md --output ./${DOCX_DIR}/references.docx

pdf: html
	$(call mkdir, $(PDF_DIR))
	phantomjs bin/rasterize.js ${HTML_DIR}/resume.html ${PDF_DIR}/resume.pdf 0.7
	phantomjs bin/rasterize.js ${HTML_DIR}/letter.html ${PDF_DIR}/letter.pdf 0.7
	phantomjs bin/rasterize.js ${HTML_DIR}/references.html ${PDF_DIR}/references.pdf 0.7

gh-pages:
	git checkout -b ${DEPLOY_BRANCH}
	git push --set-upstream origin ${DEPLOY_BRANCH}
	$(call rmdir, $(DEPLOY_DELETE_DIRS))		
	$(call rm, $(DEPLOY_DELETE_FILES))
	git add .
	-git commit -m "Create gh-pages branch"
	git push
	git checkout ${CURRENT_BRANCH}

del-gh-pages:
	git push --delete origin ${DEPLOY_BRANCH}
	git branch -D ${DEPLOY_BRANCH}

build : dist/index.html
	$(call cp, $(BUILD_CSS))
	pandoc --section-divs -s ./content/resume.md -H ./templates/header.html -c style.css -o dist/index.html

deploy: build
	git add dist
	-git commit -m "Automatic build commit on ${DATE}"
	git checkout gh-pages
	git checkout ${CURRENT_BRANCH} -- dist
	git mv -f dist/* ./
	$(call rm, dist)
	$(call rm, static)
	git add .
	-git commit -m "Automatic build commit on ${DATE}"
	git push origin gh-pages
	git checkout ${CURRENT_BRANCH}

commit: build
	git checkout ${CURRENT_BRANCH}
	git add .
	-git commit -m 'Automatic commit on ${DATE}.'
	git push

clean:
	rm -rf dist/*

.PHONY: build clean