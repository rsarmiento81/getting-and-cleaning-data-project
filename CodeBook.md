##This is a codebook to describe the variables, data and transformations used to create the tidy data set from the project files extracted from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###The script file "run_analysis.R" contains the code which completes the following steps as per the assignment
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###The variables in the tidy data set are obtained from the following files
* "Subject" from merged "test/subject_test.txt" and "train/subject_train.txt"
* "Activity" from merged "test/Y_test.txt" and "train/Y_train.txt"
* The rest of the variables in the tidy set are "Features" from "test/X_test.txt" and "train/X_train.txt"

All variables were merged into 1 data set called "alldata"   
*Extracts only the measurements on the mean and standard deviation for each measurement.    
Note: When trying to extract variables from the dataset, an error indicated that 
there were duplicated columns.  In this section, the duplicate columns are removed from the dataset
and then the data is extracted

*Uses descriptive activity names to name the activities in the data set    
The data contained a variable called activities which had a numeric value for each activity  
A merge process was completed to rename the activity numbers to descriptive activity names

*Appropriately labels the data set with descriptive variable names.
Renamed the feature variables with descriptions from features_info.txt
```{r}
names(neatdata)<-gsub("std()", "Standard Deviation", names(neatdata))
names(neatdata)<-gsub("mean()", "Mean", names(neatdata))
names(neatdata)<-gsub("^t", "Time", names(neatdata))
names(neatdata)<-gsub("^f", "Frequency", names(neatdata))
names(neatdata)<-gsub("Acc", "Accelerometer", names(neatdata))
names(neatdata)<-gsub("Gyro", "Gyroscope", names(neatdata))
names(neatdata)<-gsub("Mag", "Magnitude", names(neatdata))
names(neatdata)<-gsub("BodyBody", "Body", names(neatdata))
```
*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```{r}
tidyset <- aggregate(. ~Subject + Activity, neatdata, mean)
tidyset <- tidyset[order(tidyset$Subject, tidyset$Subject),]
```
##Creates the final tidy data set output text
```{r}
write.table(tidyset, file = "tidydata.txt", row.name=FALSE)
```