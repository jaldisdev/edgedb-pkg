#!/usr/bin/env bash
# This script is needed for macOS support.

if [[ $BASH_VERSION =~ ^[34] ]]; then
    echo "Install a newer Bash version with 'brew install bash'"
    exit 1
fi

if which xcode-select >/dev/null; then
	# macOS
	FIND="$(which gfind)"
	if [[ ! -e $FIND ]]; then
		echo "Install gnu-find with 'brew install findutils'"
		exit 1
	fi
else
    FIND="$(which find)"
fi

$FIND . -maxdepth 1 -mindepth 1 -type d -printf '%P\n'
