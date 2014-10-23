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

## Extract col names to reassign descriptive variable names
col_names<-colnames(selected_data)

## Parse column names to rename columns with descriptive variable names
## Prepare vector for new column names
new_names<-vector(mode='character',length=length(col_names))

## The col names (not assigned 3:68) begin with 'tBody', 'tGravity' and 'fBody'
## Search these expressions and prepare part of the new name
index<-grep('^tBody',col_names)
new_names[index]<-paste('Time_domain.Body',new_names[index],sep='')
index<-grep('^tGravity',col_names)
new_names[index]<-paste('Time_domain.Gravity',new_names[index],sep='')
index<-grep('^fBody',col_names)
new_names[index]<-paste('Frequency_domain.Body',new_names[index],sep='')

## Next we have the correspondences:
## Acc  ->  Linear acceleration
## AccJerk -> Jerk Linear acceleration
## Gyro    -> Angular velocity
## Gyrojerk -> Jerk ancular velocity
## Search for these expressions and continue preparing new names
index<-grep('Acc',col_names)
new_names[index]<-paste(new_names[index],'.Linear_acceleration',sep='')
index<-grep('AccJerk',col_names)
new_names[index]<-paste(new_names[index],'.Jerk_Linear_acceleration',sep='')
index<-grep('Gyro',col_names)
new_names[index]<-paste(new_names[index],'.Angular_velocity',sep='')
index<-grep('GyroJerk',col_names)
new_names[index]<-paste(new_names[index],'.Jerk_Angular_velocity',sep='')

## Next we have XYZ components or the magnitude
## X  ->  X component
## Y  ->  Y component
## Z  ->  Z component
## Mag  ->  Magnitude
index<-grep('X',col_names)
new_names[index]<-paste(new_names[index],'.X_component',sep='')
index<-grep('Y',col_names)
new_names[index]<-paste(new_names[index],'.Y_component',sep='')
index<-grep('Z',col_names)
new_names[index]<-paste(new_names[index],'.Z_component',sep='')
index<-grep('Mag',col_names)
new_names[index]<-paste(new_names[index],'.Magnitude',sep='')

## Finally, we substitute mean and std
## mean  ->  Mean value
## std   ->  Standard deviation
index<-grep('mean',col_names)
new_names[index]<-paste(new_names[index],'.Mean_value',sep='')
index<-grep('std',col_names)
new_names[index]<-paste(new_names[index],'.Standard_deviation',sep='')

## Now the unchanged indexes
new_names[1]<-'Subject'
new_names[2]<-'Activity'
##new_names[69]<-"\"subject\""
##new_names[70]<-"\"activity\""

## Asign the new names to 
colnames(selected_data)<-new_names

## Finally, summarize data calculating mean values by Activity and Subject
summarized_data<-summarise_each(group_by(selected_data,Activity,Subject),funs(mean))

## Write data table to disk
write.table(summarized_data,file='tidy_dataset.txt',row.names=F)
