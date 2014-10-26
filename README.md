Getting and cleaning data - Course Project
========================================================

This is R Markdown document describes how the script *run_analysis.R* works to 
achieve each of the steps required by the course project. Please note that below I only include some of commands but and not all the code. Check the script for further details.

The scripts assumes that you have downloaded and keep locally all the files associated to the dataset required from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Merges the training and the test sets to create one data set.

To merge the test and train datasets, we first  identify which are the right files (using the data *README.txt* file) to then load them into dataframes and use rbind to merge them into a new dataframe.

```{r}
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"")
X_merged <- rbind(X_train,X_test)
```
### Extracts only the measurements on the mean and standard deviation for each measurement.
To extract the meassurements of means and standard deviations, we load the variable names from the file *features.txt* and add them as the column names of our dataframe. After that we use grep command to chose only the variable names that include *mean()* and *std*. There are variable names that include *meanFreq()* but I decided not to include them as I understood them as a different type of measurement. 

```{r}
features <- read.table("UCI HAR Dataset/features.txt", quote="\"")
colnames(X_merged)<- features[,2]
mean_std_cols <- sort(c(grep("std",colnames(X_merged)),
                        grep("mean[\\(\\)]",colnames(X_merged))))
```
Once we have a vector with the right variables we subset ours to only keep those.

```{r}
X_mergedClean <- X_merged [,mean_std_cols]
```

### Uses descriptive activity names to name the activities in the data set
To add the activity, we add the actity data using rbind and cbind like we did in step 1.

```{r}
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"")
y_merged <- rbind(y_train,y_test)
X_mergedClean <- cbind(X_mergedClean,y_merged)
```

Then we load the activity_labels.txt file and merge them with the ids from activity data.

```{r}
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"")
X_mergedClean <- merge(X_mergedClean,activity_labels,by="V1")
```

### Appropriately labels the data set with descriptive variable names. 
To add descriptive variable names we modify the original variable names using gsubs like the ones below.

```{r}
colnames(X_mergedClean)<- gsub ("tBody","time body",colnames(X_mergedClean))
colnames(X_mergedClean)<- gsub ("tGravity","time gravity",colnames(X_mergedClean))
```
### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In a previous step we have added the subject information like we did with the activity.

```{r}
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_merge <- rbind(subject_train,subject_test)
X_mergedClean <- cbind(X_mergedClean,subject_merge)

```
Finally we generate a new tidy dataset *final_data* by aggregating the data by subject and activity and calculating the mean for all variables.


```{r}
final_data <- aggregate(X_mergedClean,
                        list(X_mergedClean$subject,X_mergedClean$activity),
                        FUN=mean,na.rm=TRUE)
write.table(final_data,file="final_data.txt",row.name=FALSE)
```