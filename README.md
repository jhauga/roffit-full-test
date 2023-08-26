# Roffit Full Test - Selective Repos Test Result

Ctrl + click [test results](https://jhauga.github.io/htmlpreview.github.com/?https://github.com/jhauga/roffit-full-test/blob/main/index.html).

The repos used for the test were selected as they had several dozen (*hundred*) files that could be converted to html with roffit.
Expand below to show test repos and what file extensions were used: 
<details>
 <summary>Show File Extensions and Repos Tested</summary>
  
  ### File Extensions:
   - .1
   - .3
   - .8
   - .1.in
   
  ### GitHub Repositories Tested:
   - nmap/nmap.git
   - libssh2/libssh2.git
   - curl/curl.git
   
</details>

I included comments in extract-full-data.sh (*extract test files from repos*) and data-test (*file to build test*) where each of the below steps occur. They should be hard to miss.

## Extract Data Procedure - Condensed:
1. Set configuration and ready data to be extracted.
2. Determine, then clone repositories from configuration.
3. Extract files matching configured extensions in ` config-variables.sh ` to data/full-test directory.
4. Prompt to confirm then run function to extract data.

## Test Procedure - Condensed:
1. Set configuration and ready test elements.
2. Clone source (*bagder*) and pull (*jhauga*) roffit repo.
3. Start test function configurring function for source or pull.
4. Set a start and end time for each build with roffit, pushing start and end to two separate arrays.
5. In ` run_command() ` sub-function call roffit first utilizing prior configurations to build using source or pull roffit and calculate build time(s).
   - Additional marker here cause this is where roffit is called and timed.
7. Determnin difference after all files built second in `runc_command() sub-function.
8. Call ` run_command() ` sub-function.
9. Determine if there is a difference, checking empty files and count number of differences.
10. Call ` run_test() ` function with source or pull, reconfigure and call ` run_test() ` again.
11. Make support html elements for difference output and dropdown menus.
12. Compare total fies built to files with differences, outputting results to supporting text file.
13. Calculate stats for build times, outputting results to supporting text file.
14. Make remaining support html elements and clean files and directories.
