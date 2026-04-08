.PHONY: all pdf clean

DEFAULTS := config/build.yaml
OUTPUT   := build/project-report.pdf
# SOURCES is only for rebuild dependency tracking.
# The actual Pandoc input list and ordering are defined in $(DEFAULTS).
SOURCES  := config/metadata.yaml $(shell find report -name "*.md") $(DEFAULTS)

all: $(OUTPUT)
pdf: $(OUTPUT)

$(OUTPUT): $(SOURCES)
	@mkdir -p build
	@pandoc --defaults=$(DEFAULTS)

clean:
	@rm -rf build/
