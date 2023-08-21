#!/bin/bash
# config-prompt
# Prompt for username and ask to use default ready.

# Source pre-made config for roffit.
source data/ready/"$_readyCommand"/config-variables.sh

# Get the ready command to use.
_readyCommand="$1"
sed -i "s|_readyCommand=CHANGE_READY_COMMAND|_readyCommand=\"$_readyCommand\"|" data/ready/ready-source.sh

# Prompt for user name
echo IMPORTANT - this assumes that your username holds the repo $_readyCommand or repo is same name that $_readyCommand was pulled from, and has the $_COMMAND_TEST in the default branch.
echo -
echo If above is TRUE:
echo                 - What is your Github user name \(ensure it is entered correctly\)\?
echo -
echo If above is FALSE:
echo                  - Input \[n\] or \[e\] to \[E\]xit and keep default \"config-Variables.sh\"
echo                  - Input \[use\] to \[USE\] $_readyCommand \"config-Variables.sh\", applying remaing configurations manually
echo
read _confirmUserName

# Check user and repo exists.
_checkInputError=$(curl -s -o /dev/null -w "%{http_code}" https://api.github.com/repos/"$_confirmUserName"/"$_readyCommand")

# Check user and repo and run conditions accordingly.
if [ "$_confirmUserName" = "n" ] || [ "$_confirmUserName" = "e" ] || [ "$_confirmUserName" = "E" ] || [ "$_confirmUserName" = "" ]; then
	echo No changes to config or test files. Re-run to use pre-made configurations. && echo 
	exit
elif [ "$_confirmUserName" = "use" ] || [ "$_confirmUserName" = "USE" ]; then
	./data/ready/make-ready.sh "use"
else		
	if [ "$_checkInputError" = "200" ]; then
		sed -i "s|_confirmUserName=CHANGE_USER_NAME|_confirmUserName=\"$_confirmUserName\"|" data/ready/ready-source.sh
		./data/ready/make-ready.sh "username"
	else
		echo Something went wrong with confirming repository. Is username below correct\? \[Y\\n\]
		echo && echo "$_confirmUserName" && echo 
		read _reConfirm		
		if [ "$_reConfirm" = "Y" ] || [ "$_reConfirm" = "y" ]; then
			_checkInputError=$(curl -s -o /dev/null -w "%{http_code}" https://api.github.com/users/"$_confirmUserName")
			if [ "$_checkInputError" = "200" ]; then
				echo Something went wrong. Check the repo name and make sure it matches the name of repo it was forked from.
				echo Input \[use\] to continue minimal configuration for "$_readyCommand" test. Press enter to exit with no changes.
				read _reconfirmReconfirm
				if [ "$_reconfirmReconfirm" = "use" ]; then
					sed -i "s|_confirmUserName=CHANGE_USER_NAME|_confirmUserName=\"$_confirmUserName\"|" data/ready/ready-source.sh
				fi
				echo && echo Not all pre-config varaibales have been changed. Please change these manually in "config-variables.sh".
				./data/ready/make-ready.sh "use" "1"
			else
				echo Something wnet wrong. There doesn\'t seem to be a user with that name on GitHub.
				echo Check that you are entering the correct username and repository name, and then re-run the command.
				exit
			fi
		else
			echo Check that you are entering the correct username and repository name, and then re-run the command.
			echo You can also configure \"config-variables.sh\" manually and upload test files to \""data/quick-test/[ gen | unq ]"\" manually.
			exit
		fi
	fi
fi	
