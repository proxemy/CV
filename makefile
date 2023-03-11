

# Global parameters for PDF creation
BUILD_DIR	?=./build

TARGET_NAME		?=$(notdir $(basename $(RECP)))
TARGET_FILE		=$(BUILD_DIR)/$(TARGET_NAME).pdf
TARGET_LETTER	=$(BUILD_DIR)/$(TARGET_NAME)_letter.pdf

PDFLATEX_ARGS ?= \
		-synctex=1 \
		-file-line-error \
		-interaction=errorstopmode

TEMPLATE_LETTER	?=src/template_letter.tex
TEMPLATE_CV		?=src/template_cv.tex
TEMPLATE_CORE	?=src/template_core.tex

PDFLATEX_TEX_ARGS := \
		"\\input{$(CV)} \
		\\input{$(RECP)} \
		\\input{$(TEMPLATE_CORE)} \
		\\def\\CVDataPath{$(dir $(CV))}"

# helper function to check existence of env vars
define check_env_var
$(if $(value $(1)),,$(error "'$(1)' not passed. Use 'make $(1)=file.tex'."))
$(if $(wildcard ./$(value $(1))),,$(error "'$(1)'-file '$(value $(1))' not found."))
endef


$(TARGET_FILE): check_env_args $(BUILD_DIR) $(TARGET_LETTER)
	$(eval jobname :=$(notdir $(basename $(TARGET_FILE))))

	# pdflatex parses its input once and is thus not able to create a TOC
	# index ahead. Therefore we need to execute it twice to create a complete
	# TOC file for the the second run.
	@echo -e "\n\n--- Building TOC index. ---\n\n"
	pdflatex \
		-output-directory=$(BUILD_DIR) \
		-jobname=$(jobname) \
		$(PDFLATEX_ARGS) \
		$(PDFLATEX_TEX_ARGS) \
		"\\def\\InputLetter{$(TARGET_LETTER)} \
		\\input{$(TEMPLATE_CV)}"

	@echo -e "\n\n--- Creating CV PDF. ---\n\n"
	pdflatex \
		-output-directory=$(BUILD_DIR) \
		-jobname=$(jobname) \
		$(PDFLATEX_ARGS) \
		$(PDFLATEX_TEX_ARGS) \
		"\\def\\InputLetter{$(TARGET_LETTER)} \
		\\input{$(TEMPLATE_CV)}"


$(TARGET_LETTER): check_env_args $(BUILD_TMP)
	@echo -e "\n\n--- Creating letter PDF. ---\n\n"
	pdflatex \
		-output-directory=$(BUILD_DIR) \
		-jobname=$(notdir $(basename $(TARGET_LETTER))) \
		$(PDFLATEX_ARGS) \
		$(PDFLATEX_TEX_ARGS) \
		"\\input{$(TEMPLATE_LETTER)}"


.PHONY: check_env_args
check_env_args:
	$(call check_env_var,CV)
	$(call check_env_var,RECP)


.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)


$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
