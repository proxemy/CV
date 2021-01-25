

# Parameters for PDF creation
# To pass your customized values, eg. use 'make DOC_FONT_SIZE=14 ...'
BUILD_DIR	?=./build
BUILD_TMP	?=$(BUILD_DIR)/tmp
TARGET_NAME	?=$(notdir $(basename $(RECP)))

TEMPLATE_LETTER	?=src/template_letter.tex
TEMPLATE_CV		?=src/template_cv.tex


define check_env_var
$(if $(value $(1)),,$(error "'$(1)' not passed. Use 'make $(1)=file.tex'."))
$(if $(wildcard ./$(value $(1))),,$(error "'$(1)'-file '$(value $(1))' not found."))
endef


all: cover_letter appendix
	#TODO: merge the two PDFs


cover_letter: init_build
#TODO see below
	$(call check_env_var,CV)
	$(call check_env_var,RECP)


appendix: init_build appendix_toc
# this is temporary. TODO the two build target generate indiv. PDFs and merge them
	pdflatex \
		-output-directory $(BUILD_TMP) \
		-jobname=$(TARGET_NAME)_appendix \
		-synctex=1 \
		-file-line-error \
		-halt-on-error \
		-interaction=nonstopmode \
		"\\def\\CVFile{$(CV)} \
		\\def\\CVDataPath{$(dir $(CV))} \
		\\def\\RecpFile{$(RECP)} \
		\\input{$(TEMPLATE_CV)}"


appendix_toc:
	#TODO: build the TOC intermediate file before building the actual appendix


.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(BUILD_TMP)


.PHONY: init_build
init_build:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BUILD_TMP)
