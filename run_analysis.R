# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 

# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

setwd("~/1.Documents/Library/OCD-Data Science/Formacion/datasciencecoursera/3. Cleaning data/course project/")
# 1. We merge the training and test datasets
# - 'train/X_train.txt': Training set.
# - 'test/X_test.txt': Test set.
# - 'test/y_test.txt': Test labels.
# - 'train/y_train.txt': Training labels.

X_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"")
X_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"")
X_merged <- rbind(X_train,X_test)
rm(X_train)
rm(X_test)

# 2. Extract only the mean and stdv 
# - 'features.txt': List of all features.
# we first add the variable names 
features <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"")
colnames(X_merged)<- features[,2]
rm(features)
# mean(): Mean value
# and then extract the mean and stdv
# std(): Standard deviation
mean_std_cols <- sort(c(grep("std",colnames(X_merged)),grep("mean[\\(\\)]",colnames(X_merged))))
X_mergedClean <- X_merged [,mean_std_cols]
colnames(X_mergedClean)
rm(X_merged)
rm(mean_std_cols)

# we add the subject
subject_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", quote="\"")
subject_test <- read.table("~getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_merge <- rbind(subject_train,subject_test)
X_mergedClean <- cbind(X_mergedClean,subject_merge)
rm(subject_merge)
rm(subject_test)
rm(subject_train)
colnames(X_mergedClean)[67]<-"subject"

# 3. we add the activity
# 1 WALKING; 2 WALKING_UPSTAIRS; 3 WALKING_DOWNSTAIRS;4 SITTING;5 STANDING;6 LAYING
# - 'train/y_train.txt': Training labels.
# - 'test/y_test.txt': Test labels.
y_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\"")
y_test <- read.table("~getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\"")
y_merged <- rbind(y_train,y_test)

X_mergedClean <- cbind(X_mergedClean,y_merged)
rm(y_merged)
rm(y_test)
rm(y_train)

# reading the activity labels and merging with the X_mergedClean
activity_labels <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", quote="\"")
X_mergedClean <- merge(X_mergedClean,activity_labels,by="V1")
colnames(X_mergedClean)[69]<-"activity"
colnames(X_mergedClean)[1]<-"activityID"

# 4. Add descriptive variable names
colnames(X_mergedClean)<- gsub ("tBody","time body",colnames(X_mergedClean))
colnames(X_mergedClean)<- gsub ("tGravity","time gravity",colnames(X_mergedClean))
colnames(X_mergedClean)<- gsub ("fBody","frequency domain signal body",colnames(X_mergedClean))
colnames(X_mergedClean)<- gsub ("Acc"," accelerometer ",colnames(X_mergedClean))
colnames(X_mergedClean)<- gsub ("Gyro"," gyroscope ",colnames(X_mergedClean))
colnames(X_mergedClean)<- gsub ("Jerk"," jerk signal ",colnames(X_mergedClean))
colnames(X_mergedClean)<- gsub ("Mag"," magnitude ",colnames(X_mergedClean))
colnames(X_mergedClean)<- gsub ("mean\\(\\)","  Mean value ",colnames(X_mergedClean))
colnames(X_mergedClean)<- gsub ("std\\(\\)","  Standard deviation value ",colnames(X_mergedClean))
colnames(X_mergedClean)<- gsub ("Body","",colnames(X_mergedClean))


# 5. create final dataset with means of subjects
# average of each variable for each activity and each subject.
final_data <- aggregate(X_mergedClean,
                        list(X_mergedClean$subject,X_mergedClean$activity),
                        FUN=mean,na.rm=TRUE)

colnames(final_data)[1]<-"subject"
colnames(final_data)[2]<-"activity"
final_data <- final_data [,1:69]
colnames(final_data) <- gsub ("time","average time",colnames(final_data))
colnames(final_data) <- gsub ("frequency","average frequency",colnames(final_data))
write.table(final_data,file="final_data.txt",row.name=FALSE)