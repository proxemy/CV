#!/usr/bin/env sh


error() {
	echo "$@" >&2;
	exit 1;
}

if [ $# -ne 2 ]; then
	error "Usage: ./compile_cv.sh [data folder path] [recipient tex file]"
fi

if [ ! -f "${1}" ]; then
	error "Can't find data path: ${1}"
fi

if [ ! -f "${2}" ]; then
	error "Can't find recipient data tex file: ${2}"
fi

pdf_file_name=$(basename ${2})
CV_data_path=$(dirname ${1})

latex_code="\\def\\CVFile{${1}} \\def\\CVDataPath{${CV_data_path}} \\def\\RecpFile{${2}} \\input{CV_template.tex}"

mkdir -p build

pdflatex -output-directory "build" -jobname=${pdf_file_name%.*}  -synctex=1 -halt-on-error -interaction=nonstopmode $latex_code

