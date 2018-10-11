# Resume Generator
> Forked & Inspired by from [epsalt's resume builder](https://github.com/epsalt/resume-builder)

* Resume, cover letter, and reference list, and GitHub Page builder.
* Available on both Windows cmd and MacOS terminal.
* Converts from `markdown` content files to `html` and `pdf` using Pandoc and PhantomJS.

## How to use (for beginners)
- [Korean](installation_ko.md)

## Examples
- Website: [gh-pages][resume-gh-pages]
- Resume: [html][resume-html], [pdf][resume-pdf]
- Cover letter: [html][letter-html], [pdf][letter-pdf]
- References: [html][references-html], [pdf][references-pdf]

## Requirements
- `Pandoc`
- `PhantomJS`

## Usage
- Edit the markdown files in the `content` directory with your own
  information
- Replace `sig.png` with a copy of your signature (or comment that
  line out of `letter.md` if you do not want to include a signature
  image at the bottom of your cover letter)
- Run `make all` to build the `html` and `pdf` output documents to
  the `out` directory
- Run `make build` to build just the `html` documents
- Run `make gh-pages` to create gh-pages in local and remote branches
- Run `make deploy` to deploy `index.html(resume.html)` to gh-pages


## License
[GNU General Public License v3.0](LICENSE.md) 

[resume-gh-pages]: https://sujinleeme.github.io/resume-maker/
[resume-html]: https://s3-us-west-2.amazonaws.com/epsalt-resume-builder/resume.html
[resume-pdf]: https://s3-us-west-2.amazonaws.com/epsalt-resume-builder/resume.pdf
[letter-html]: https://s3-us-west-2.amazonaws.com/epsalt-resume-builder/letter.html
[letter-pdf]: https://s3-us-west-2.amazonaws.com/epsalt-resume-builder/letter.pdf
[references-html]: https://s3-us-west-2.amazonaws.com/epsalt-resume-builder/references.html
[references-pdf]: https://s3-us-west-2.amazonaws.com/epsalt-resume-builder/references.pdf
