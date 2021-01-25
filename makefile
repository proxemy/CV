

# Parameters for PDF creation
# To pass your customized values, eg. use 'make DOC_FONT_SIZE=14 ...'
BUILD_DIR	?=./build
BUILD_TMP	?=$(BUILD_DIR)/tmp

TARGET_NAME		?=$(notdir $(basename $(RECP)))
TARGET_FILE		=$(BUILD_DIR)/$(TARGET_NAME).pdf
TARGET_CV		=$(BUILD_TMP)/$(TARGET_NAME)_CV.pdf
TARGET_LETTER	=$(BUILD_TMP)/$(TARGET_NAME)_appendix.pdf

PDFLATEX_ARGS ?= \
		-synctex=1 \
		-file-line-error \
		-halt-on-error \
		-interaction=nonstopmode

PDFLATEX_STDIN ?= \
		"\\def\\CVFile{$(CV)} \
		\\def\\CVDataPath{$(dir $(CV))} \
		\\def\\RecpFile{$(RECP)}"

TEMPLATE_LETTER	?=src/template_letter.tex
TEMPLATE_CV		?=src/template_cv.tex


define check_env_var
$(if $(value $(1)),,$(error "'$(1)' not passed. Use 'make $(1)=file.tex'."))
$(if $(wildcard ./$(value $(1))),,$(error "'$(1)'-file '$(value $(1))' not found."))
endef


$(TARGET_FILE): $(BUILD_DIR) $(TARGET_LETTER) $(TARGET_CV)
	#TODO: merge the two PDFs


$(TARGET_LETTER): $(BUILD_TMP)
#TODO see below
	$(call check_env_var,CV)
	$(call check_env_var,RECP)


$(TARGET_CV): $(BUILD_TMP)

	pdflatex \
		-output-directory=$(BUILD_TMP) \
		-jobname=$(notdir $(basename $(TARGET_CV))) \
		$(PDFLATEX_ARGS) \
		$(PDFLATEX_STDIN) \
		"\\input{$(TEMPLATE_CV)}"


.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(BUILD_TMP)


$(BUILD_TMP):
	mkdir -p $(BUILD_TMP)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
