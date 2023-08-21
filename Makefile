##########################################################
###################### MAKE TEST #########################
### All files in this repositroy are public domain cc0 ###
### Any files created by the test are subject to the   ###
### license specified in that reposityor.              ###
##########################################################

all:
	@./extract-full-data.sh
	@./data-test 1

quick:
	@./data-test
	
# Ready made test. See "Ready Made Tests" in README.md
roffit:
	@if [ ! -d "reset" ]; then \
		mkdir reset; \
		cp -f config-variables.sh reset/config-variables.sh; \
	fi
	@./data/ready/config-prompt.sh "roffit"
	

clean:
	@rm -rf diff/* support/* tests/* data/full-test/*
	@rm -rf diff commands support tests
	@sed -i "s|https://github.com/.*/.*/blob/main/index.html|https://github.com/CHANGE_USER/CHANGE_REPO/blob/main/index.html|" README.md
	@sed -i "s|var cur_test_results = \"https://github.com/.*/.*/blob/main/\";|var cur_test_results = \"https://github.com/CHANGE_USER/CHANGE_REPO/blob/main/\";|" index.html
	@if [ -d "reset" ]; then \
		echo Resetting to initial config.; \
		mv reset/config-variables.sh ./config-variables.sh; \
		rm -rf reset data/quick-test/gen/* data/quick-test/unq/*; \
		echo General files. > data/quick-test/gen/General.txt && echo Unique files. > data/quick-test/unq/Unique.txt; \
		sed -i "s|_readyCommand=.*|_readyCommand=CHANGE_READY_COMMAND|" data/ready/ready-source.sh; \
		sed -i "s|_confirmUserName=.*|_confirmUserName=CHANGE_USER_NAME|" data/ready/ready-source.sh; \
	fi
	