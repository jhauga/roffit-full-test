#!/bin/bash
# config-variables.sh
# Change the variables, and arrays to meet your test.

# IMPORTANT - in order to use this tool you must agree to "USAGE_AGGREEMENT.md".
#           - Changing the below variable to 1 confirms you acknowledge and agree 
#             and meet criteria(s) specified in "USAGE_AGREEMENT.md".

# Acknowledgment and Agreement to "USAGE_AGREEMENT.md"
# ---------------------------------------------------
#
# Set to 1 to agree; 0 to disagree.
_acknowledgeAndAgreeToUSAGE_AGREEMENT=0

# INSTRUCTIONS:
#  1. Define the new repo name in variable.
#  2. Change the config variables.
#  3. Define options to run with command in array and redirects.
#  4. Declare file extensions for files sourced in conversion in array.
#  5. Change the file extension to target file extension in variable.
#  6. Declare any additional repos to test tool with in array.
#  7. Change the unique repo for focus items of test.
#  8. CHANGE COMMAND SYNTAX VARIABLE _commandSyntax <---IMPORTANT !!!!
#     - If needed edit data-test file.  104 an 107.

# I. DEFINE NEW REPO
# Name of new repository for tests result. CHANGE if needed.
_testResultRepo="repo-name-test" 

# II. CHANGE CONFIG VARIABLES
_COMMAND_TEST="roffit"   # roffit ----- the command/script that will run
_sourceUserName="bagder" # bagder ----- user that the repo was forked from
_pullUserName="pull"     # pull ------- user with fork and making pull request
_repoName="repo-name"    # repo-name -- the repo where command is stored for clone
_useSource=1             # use source - Start off using source user's command

# III. DEFINE OPTIONS USED
# Define options that will be used with command to test builds.
# By default the command will be run with no options.
# Remove "" from array to unset 'run with no option default'.
declare -a _optionsToRun=("" "--bare")

# IV. DECLARE SOURCE FILE EXTENSIONS
# Configuration - file extension to match and move to data folder.
declare -a _fileExtensions=('.1' '.3' '.8' '.1.in')

# V. CHANGE FILE EXTENSION FOR TARGET FILE
_targetFileExtension=".html"

# VI. DECALREE ADDITIONAL REPOS TO TEST TOOL
# Configure user(s) and repositories to clone and build ful test from.
declare -a _fullTestRepos=('nmap' 'nmap' 'libssh2' 'libssh2' 'curl' 'curl')

# VII. CHANGE UNIQUE REPO
# Specify unique user repo to make separate foler.
_unqUser="curl"

# VIII. CHANGE COMMAND SYNTAX
# IMPORTANT - DO NOT CHANGE ELEMENTS - ONLY HOW IT WILL BE CALLED IN COMMAND LINE
#             If needed edit data-test file.  104 an 107.
# Note - keep variables, and note that $opts is for each option in array.
# Note - data/"$_curDir"/"$line" - is the input file
# Note - tests/"$_curData"/"$line"-"$1""$_nameOpt".html - will be output file

_commandSyntax() {
  # IMPORTANT - do not change elements. only how command is called.
  #             If needed edit data-test file.  104 an 107.
  
  _opt="$1" && _inputFile="$2" && _outputFile="$3"
  ./$_COMMAND_TEST "$_opt" < "$_inputFile" > "$_outputFile"
      
  # EXAMPLE:
  # command opts inputfile > output file
  
  # Any additional lines. If needed edit data-test
}

# Exit if _acknowledgeAndAgreeToUSAGE_AGREEMENT is 0
function check_if_user_agreed_exit_if_not() {
  if [ "$_acknowledgeAndAgreeToUSAGE_AGREEMENT" = 0 ]; then
    echo YOU HAVE NOT AGREED TO TERMS OR HAVE NOT CHANGED _acknowledgeAndAgreeToUSAGE_AGREEMENT VARIABLE
	echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
	echo 
    echo Before using you must agree to the usage agreement and change _acknowledgeAndAgreeToUSAGE_AGREEMENT variable.
	echo The _acknowledgeAndAgreeToUSAGE_AGREEMENT variable is on 
	echo \*\* line 13 \*\*
	echo
	echo To do so manually change the variaable "_acknowledgeAndAgreeToUSAGE_AGREEMENT" to 1 on.
	echo \*\* line 13 \*\*
	echo
	echo Or run "./agree" in the terminal. Then rerun make.
	echo
    exit 
  fi
}