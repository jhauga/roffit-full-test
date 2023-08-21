#!/bin/bash
# make-ready
# Make the config-variable.sh from previously used commands.

# Source from config-prompt.sh
source data/ready/ready-source.sh

# Determine how repo with command is named.
_structureSet="$1"
_partialSet="$2"

# Check if there were errors confirming user and repository
if [ "$_structureSet" != "use" ] && [ "$_structureSet" != "username" ]; then
	echo Files were NOT configured for pre-made "$_readyCommand".
	exit
fi

# Copy ready files to test data folders and reset config-variables.sh
rm data/quick-test/gen/* && rm data/quick-test/unq/*
cp -f data/ready/"$_readyCommand"/data/gen/* data/quick-test/gen/ && cp -f data/ready/"$_readyCommand"/data/unq/* data/quick-test/unq/
cp -f data/ready/"$_readyCommand"/config-variables.sh ./config-variables.sh

# Make config if username and repo matched.
if [ "$_structureSet" = "username" ]; then
	sed -i "s|_pullUserName=\"pull\"|_pullUserName=\"$_confirmUserName\"|" config-variables.sh # change username - matched
	sed -i "s|repo-name|$_readyCommand|g" config-variables.sh # change repo name - matched
	echo Files were FULLY configured for pre-made "$_readyCommand". Please review everything and follow insructions in README.md to run tests.
elif [ "$_partialSet" = "1" ]; then
	sed -i "s|_pullUserName=\"pull\"|_pullUserName=\"$_confirmUserName\"|" config-variables.sh # change username - matched
	echo Files were PARTIALLY configured for pre-made "$_readyCommand". Please review everything and follow insructions in README.md to run tests.
else
	echo Files were MINIMALLY configured for pre-made "$_readyCommand". Please review everything and follow insructions in README.md to run tests.
fi