# Resume Generator

Resume, cover letter, and reference list builder. Converts from
`markdown` content files to `html` and `pdf` using Pandoc and
PhantomJS.

All names, characters, and incidents portrayed in this repo are
fictitious. No identification with actual persons (living or
deceased), places, buildings, and products is intended or should be
inferred. No person or entity associated with this repo received
payment or anything of value, or entered into any agreement, in
connection with the depiction of tobacco products.

## Examples

- Resume: [html][resume-html], [pdf][resume-pdf]
- Cover letter: [html][letter-html], [pdf][letter-pdf]
- References: [html][references-html], [pdf][references-pdf]

## Requirements

- `Pandoc`
- `PhantomJS` (optional: for `pdf` generation)

## Usage

- Edit the markdown files in the `content` directory with your own
  information
- Replace `sig.png` with a copy of your signature (or comment that
  line out of `letter.md` if you do not want to include a signature
  image at the bottom of your cover letter)
- Run `make all` to build the `html` and `pdf` output documents to
  the `out` directory
- Run `make build` to build just the `html` documents

[resume-html]: https://s3-us-west-2.amazonaws.com/epsalt-resume-builder/resume.html
[resume-pdf]: https://s3-us-west-2.amazonaws.com/epsalt-resume-builder/resume.pdf
[letter-html]: https://s3-us-west-2.amazonaws.com/epsalt-resume-builder/letter.html
[letter-pdf]: https://s3-us-west-2.amazonaws.com/epsalt-resume-builder/letter.pdf
[references-html]: https://s3-us-west-2.amazonaws.com/epsalt-resume-builder/references.html
[references-pdf]: https://s3-us-west-2.amazonaws.com/epsalt-resume-builder/references.pdf
