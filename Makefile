bookname = visual

all: clean \
	html \
	docs/$(bookname).pdf \
	docs/$(bookname).epub \
	docs/$(bookname).mobi \
	docs/$(bookname).docx

html:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"

docs/$(bookname).pdf:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"

docs/$(bookname).epub:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::epub_book')"

docs/$(bookname).docx:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::word_document2')"

docs/$(bookname).mobi: docs/$(bookname).epub
	kindlegen docs/*epub; \
	[ $$? -eq 0 -o $$? -eq 1 ] || return 1

clean:
	rm -rf docs/
	mkdir docs
	touch docs/.nojekyll
