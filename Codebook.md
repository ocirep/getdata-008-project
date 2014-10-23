---
title: "Getting and Cleaning Data project Codebook"
output: html_document
---

Data is taken from the Human Activity Recognition Using Smartphones Dataset, Version 1.0
Two datasets with the same variables were available and have been merged together.

Each dataset is distributed into three files that contain the following information:

- Subject
- Activity
- A 561-feature vector with time and frequency domain variables.

The three files are readed from disk and combined into a dataframe. This is performed with both datasets and then, they are merged into a new dataframe, discarding the previous ones.

There are also two more files identifying the activity and features names. 

The activity names are readed and assigned to its column converting the corresponding variable to a factor variable.

The features names are readed and assigned to their corresponding column names.

The features are described in the file 'features_info.txt' and their names in 'features.txt'. Both files were provided with the dataset.

The dataset was then reduced, extracting only the features variables with values of mean and standard deviation of measurements.

In the next step, the column labels were analysed and interpreted in order to change them to more descriptive names with the following equivalences:

* tBody       ->  Time_domain.Body  
* tGravity    ->  Time_domain.Gravity
* fBody       ->  Frequency_domain.Body

* Acc         ->  Linear acceleration
* AccJerk     ->  Jerk Linear acceleration
* Gyro        ->  Angular velocity
* Gyrojerk    ->  Jerk angular velocity

* X           ->  X component
* Y           ->  Y component
* Z           ->  Z component
* Mag         ->  Magnitude

File 'new_col_names.txt' contains the new descriptive column names.

Finally, data are summarised extracting the mean value by activity and subject storing the reulting data frame into a file named 'tidy_dataset.txt'
