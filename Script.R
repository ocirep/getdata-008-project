## Required libraries
require('dplyr')
require('plyr')
## Read the train data files
subject <- read.table("../UCI HAR Dataset/train/subject_train.txt", quote="\"")
activity <- read.table("../UCI HAR Dataset/train/y_train.txt", quote="\"")
x_data <- read.table("../UCI HAR Dataset/train/X_train.txt", quote="\"")

## Construct the tbl datframe
train_data<-tbl_df(data.frame(subject,activity,x_data))

## Remove not-needed data to preserve memory
remove('subject')
remove('activity')
remove('x_data')

## Read the test data files
subject <- read.table("../UCI HAR Dataset/test/subject_test.txt", quote="\"")
activity <- read.table("../UCI HAR Dataset/test/y_test.txt", quote="\"")
x_data <- read.table("../UCI HAR Dataset/test/X_test.txt", quote="\"")

## Construct the tbl datframe
test_data<-tbl_df(data.frame(subject,activity,x_data))

## Remove not-needed data to preserve memory
remove('subject')
remove('activity')
remove('x_data')

## Merge test and training data
data<-rbind(test_data,train_data)

## Cleaning up
remove('test_data')
remove('train_data')

## Read features names
features<-read.table("../UCI HAR Dataset/features.txt", quote="\"",stringsAsFactors=F)

## Prepare labels for data frame
data_labels<-c('subject','activity',features[,2])
remove('features')

## Assign labels to data frame
colnames(data)<-data_labels

## Create ordered vector to select columns with 'mean' and 'std' values
## Mantain columns 1 and 2, 'subject' and activity'
select<-c(1,2,sort(c(grep('mean\\(',data_labels),grep('std\\(',data_labels))))
selected_data<-data[,select]

## Remove unused variables
remove('data')
remove('data_labels')
remove('select')

## Read activity labels
activity_labels<-read.table("../UCI HAR Dataset/activity_labels.txt", quote="\"",stringsAsFactors=F)

## Assign activity labels to column 'activity' in dataframe and conversion to factor
selected_data$activity<-factor(selected_data$activity,activity_labels$V1,labels=activity_labels$V2)
## Remove garbage
remove('activity_labels')

## Convert to factor column subject
selected_data$subject<-factor(selected_data$subject)

## Create grouped data table and remove old data
grouped_and_selected_data<-group_by(selected_data,'subject','activity')
remove('selected_data')

## Extract col names to reassign descriptive variable names
col_names<-colnames(grouped_and_selected_data)

## Parse column names to rename columns with descriptive variable names
for (i in 1:length(col_names)){
  if(grep('^t',col_names[i])){
    ## Time domain variable
    if(grep('tBody',col_names[i])){
      ## Body variable
    }
    else{
      ## Gravity variable
    }
  }
  else{
    ## Frequency domain variable
    if(grep('fBody',col_names[i])){
      ## Body variable
    }
    else{
      ## Gravity variable
    }
  }
}
