#!/bin/bash
# extract-full-data.sh
# Clone repositories specified in "_fullTestRepos" by username and repositroy
# to the full-test directory to test a data-conversion-tool pull request.


## 1 START*********************************************************************************
## 1 - Set configuration and ready data to be extracted.
## 1		
#####################################################################################################

source config-variables.sh
check_if_user_agreed_exit_if_not # check if agreed to terms, exit if not

# Make temp extract location.
mkdir -p data/extract data/full-test

# Directory where repos will be cloned, extracted, then deleted.
_startingDir="data/extract" # clone and extract here

#####################################################################################################
#####################################################################################################
## 1		
## 1 - Set configuration and ready data to be extracted.
## 1 END*********************************************************************************


# Function to process directories recursively
process_directory() {

## 2 START*********************************************************************************
## 2 - Determine, then clone repositories from configuration.
## 2		
#####################################################################################################

	# clone to data/extract
    dir="$1"
	# username where repo is hosted
	_curUser="$2"
	# if functio  not recursing
	if [ "$_curUser" != "0" ]; then
		# repo name to clone
		_curRepo="$3"
		# check if user is set for outputting to unq folder
		if [ "$_curUser" == "$_unqUser" ]; then
			_outPutDir="data/full-test/unq"
		else
			_outPutDir="data/full-test/gen"
		fi
		# make directory to extract to
		mkdir -p $_outPutDir
		# clone to data/extract where it will be deleted after funciton run
		git clone https://github.com/$_curUser/$_curRepo.git data/extract/$_curRepo
	fi

#####################################################################################################
#####################################################################################################	
## 2			
## 2 - Determine, then clone repositories from configuration.
## 2 END*********************************************************************************
	
	
## 3 START*********************************************************************************
## 3 - Extract files matching configured extensions in ` config-variables.sh ` to data/full-test directory.
## 3		
#####################################################################################################
	
	# loop and extract files matching extension or recurse
    for entry in "$dir"/*; do
		# current iteration is a file
        if [ -f "$entry" ]; then
			# loop extensions and check if file matches it
            for ext in "${_fileExtensions[@]}"; do
				# if a match move to data/full-test/[gen | unq]
                if [[ "$entry" == *"$ext" ]]; then
                    cp "$entry" "$_outPutDir" # copy
                    echo "Copied: $entry"     # stdout copied
                    break                     # end ext. loop
                fi
            done
        elif [ -d "$entry" ]; then # recurse
            process_directory "$entry" "0" "0"
        fi
    done

#####################################################################################################
#####################################################################################################
## 3		
## 3 - Extract files matching configured extensions in ` config-variables.sh ` to data/full-test directory.
## 3 END*********************************************************************************

	
}

## 4 START*********************************************************************************
## 4 - Prompt to confirm then run function to extract data.
## 4		
#####################################################################################################

# Alert on long script runtime.
echo Script has begun recursing. 
echo \#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#  && echo 
echo This may take a while. Est. time - 10 minutes.
echo Continue [Y/n]: && echo 
# User response to confirm or not functionrun.
read -r _response

# Start processing from the starting directory if responded yes[Y]
if [ "$_response" == "Y" ]; then
	index=0
	
	# loop through user/repo array respectively passing 
	# user and repo as arguments, incrementing by 2
	while (( index < ${#_fullTestRepos[@]} - 1 )); do
		_user=${_fullTestRepos[index]}     # even index
		_repo=${_fullTestRepos[index + 1]} # odd index
		# run recursing function and then delete cloned directory
		process_directory "$_startingDir" "$_user" "$_repo" && 	rm -rf "data/extract/$_repo"
		# increment index by 2
		index=$((index + 2))
	done
else
	# if user response is "n"
	echo Script did not run. Batch will now clean and exit.
fi

# Clean after extraction
rm -rf data/extract

#####################################################################################################
#####################################################################################################
## 4		
## 4 - Prompt to confirm then run function to extract data.
## 4 END*********************************************************************************
