# GetClean_CourseProject
Description of input, script and output

## Input
features.txt file gives the header file for both main data files\
X_test.txt file for main data from test subjects\
X_train.txt file for main data from training subjects\
y_test.txt file gives the different training labels for the test subjects\
y_train.txt file gives the different training labels for the training subjects\
subject_test.txt file gives the subject labels for the test subjects\
subject_train.txt file gives the subject labels for the training subjects\

## Script
run_analysis.R is the script to process the input files\
1. read in libraries\
2. read test & train data\
3. read header for test & train data\
4. set header as column names for test and train data\
5. read & add training and subject labels column\
6. combine train & test dataframes, select columns regarding only the mean() or standard deviation (and additionally, the columns with training labels and subjects) and sort according to subject number\
7. add descriptive column for activity\
8. add more descriptive variable names\
9. make new dataset with averaged data grouped by subject & activity (& training labels for better overview, since it's the same as the activity labels)\
10. generate the final tidy_data.txt file\

## Output
a .txt-file of the tidy_data generated in the run_alaysis.R script\

