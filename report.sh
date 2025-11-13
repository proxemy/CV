#!/usr/bin/env bash

set -euo pipefail

RECP=${RECP:-$RECP_ENV_VAR_NOT_SET}
TEX_FILES=($(find "$RECP" -iname '*.tex'))
SEP=";"


process_file()
{
	echo \
		$(get_date "$1")$SEP\
		$(get_recipient "$1")$SEP\
		$(get_reference "$1")$SEP
}

get_recipient()
{
	grep -oP "(?<=RecpCompany\{)[^}]*" "$1"
}

get_reference()
{
	grep -oP "(?<=RecpJobRef\{)[^}]*" "$1"
}

get_date()
{
	grep -oP "\d{4}\D\d{2}\D\d{2}" "$1"
}


for tex_file in ${TEX_FILES[@]}; do
	process_file "$tex_file"
done
