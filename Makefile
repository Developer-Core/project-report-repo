.PHONY: all pdf readme clean

DEFAULTS     := config/build.yaml
OUTPUT       := build/project-report.pdf
README       := README.md
FRONT_HTML   := build/front-matter.html

# Front-matter files — pre-rendered to HTML, passed as include-before-body
FRONT_FILES  := report/front-matter/00-title-page.md \
                report/front-matter/01-version-history.md \
                report/front-matter/02-collaboration-insights.md \
								report/front-matter/03-toc.md

# Chapter files — from build.yaml input-files (source of truth for PDF body)
BODY_FILES   := $(shell grep -E '^\s+- report/' $(DEFAULTS) | sed 's/^[[:space:]]*- //')

# All MD files — used for README and dependency tracking
MD_FILES     := $(FRONT_FILES) $(BODY_FILES)
SOURCES      := $(MD_FILES) $(DEFAULTS) css/report.css

all: pdf readme

pdf: $(OUTPUT)

$(FRONT_HTML): $(FRONT_FILES)
	@mkdir -p build
	@pandoc $(FRONT_FILES) --from markdown --to html --file-scope > $(FRONT_HTML)

$(OUTPUT): $(SOURCES) $(FRONT_HTML)
	@pandoc --defaults=$(DEFAULTS) --include-before-body=$(FRONT_HTML)

readme: $(README)

$(README): $(MD_FILES)
	@cat $(MD_FILES) | sed 's/ *{[^}]*}//g' | sed '/<div class="page-break"><\/div>/d' | sed 's|src="assets/|src="report/assets/|g' | sed 's|src="annexes/|src="report/annexes/|g' > $(README)

clean:
	@rm -rf build/
