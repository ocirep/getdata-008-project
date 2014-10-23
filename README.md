---
title: "getdata-008-project"
output: html_document
---

Coursera Getting and Cleaning Data project

This repository contains the developed script for the Coursera Getting and Cleaning Data project
There are four files in the repository, this 'readme', the script itself 'run_analysis.R', the codebook explaining the meaning of the variables and their changes and processing,'codebook.md' and, finally, the tidy dataset obtained with the script, 'tidy_dataset.txt'
The script 'run_analysis.R' reads the data from two files of the provided dataset, https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip one is from training data and the other from test data.

With the readed datasets, the script follows the provided instructions:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
