

# Global parameters for PDF creation
BUILD_DIR	?=./build
BUILD_TMP	?=$(BUILD_DIR)/tmp

TARGET_NAME		?=$(notdir $(basename $(RECP)))
TARGET_FILE		=$(BUILD_DIR)/$(TARGET_NAME).pdf
TARGET_CV		=$(BUILD_TMP)/$(TARGET_NAME)_CV.pdf
TARGET_LETTER	=$(BUILD_TMP)/$(TARGET_NAME)_letter.pdf

PDFLATEX_ARGS ?= \
		-synctex=1 \
		-file-line-error \
		-interaction=errorstopmode

PDFLATEX_STDIN := \
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

	@echo "Merging letter and CV PDF into one: " $(TARGET_NAME) TODO


$(TARGET_LETTER): check_cli_args $(BUILD_TMP)


$(TARGET_CV): check_cli_args $(BUILD_TMP)

	$(eval jobname :=$(notdir $(basename $(TARGET_CV))))

	# pdflatex parses its input once and is thus not able to create a TOPC
	# index ahead. Therefore we need to execute it twice.
	@echo "\n--- Building TOC index."
	pdflatex \
		-output-directory=$(BUILD_TMP) \
		-jobname=$(jobname) \
		$(PDFLATEX_ARGS) \
		-interaction=batchmode \
		$(PDFLATEX_STDIN) \
		"\\input{$(TEMPLATE_CV)}"

	@echo "\n--- Creating CV PDF."
	pdflatex \
		-output-directory=$(BUILD_TMP) \
		-jobname=$(jobname) \
		$(PDFLATEX_ARGS) \
		$(PDFLATEX_STDIN) \
		"\\input{$(TEMPLATE_CV)}"


.PHONY: check_cli_args
check_cli_args:
	$(call check_env_var,CV)
	$(call check_env_var,RECP)


.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(BUILD_TMP)


$(BUILD_TMP):
	mkdir -p $(BUILD_TMP)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
