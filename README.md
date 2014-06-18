Description
==================

A **getdata-004.project** calculates a tidy data set that contains the average of each variable for each activity and each subject from 'Human Activity Recognition database'. The input data set can be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and description can be found [here]( http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

This tool has been developed in the scope of Coursera ["Getting and Cleaning Data"](https://class.coursera.org/getdata-004) course project.

Content
==================
*run_analysis.R* - is R script that contains functions' definition intended to produce a tidy dataset from HAR dataset. For more information about resulting dataset see CodeBook.md

How To Use
==================

At first, the HAR dataset should be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzipped somewhere (as result you get 'UCI HAR Dataset' folder that contains HAR dataset files).

Next, load the *run_analysis.R* script into R console and call *RunAnalysis* function. The function requires a path to HAR dataset. By default it takes data from './UCI HAR Dataset'. As result *RunAnalysis* returns data.frame(see description in CodeBook.md) that can be used for further analysis.

Note
-------------------
The function does make a special error handling, so if the input directory doesn't exist or doesn't contain required files in required format then no special messages will be provided. Just errors which produced by read.table.
