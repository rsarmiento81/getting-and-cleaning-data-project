## In this script, I am going to merge the test and training sets
## x_test.txt and x_train.txt
## Next it is going to extract the measurements for mean and stdev on each measurement
## It will then label the activities to something descriptive
## Last it will create an independent tidy data set with the average for each variable for each 
## activity and each subject and then create a codebook

##install dplyr package
install.packages("dplyr")
##run dplyr library
library(dplyr)

##read files included with data set
actlabels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
names(actlabels) <- c("V1","Activity")

##1. Merges the training and the test sets to create one data set.

##read subject data
subjecttest <- read.table("test/subject_test.txt")
subjecttrain <- read.table("train/subject_train.txt")
##merge "subject" data into 1 table and name the variable
subjectdata <- rbind(subjecttest,subjecttrain)
names(subjectdata) <- c("Subject")

##read activity data
ytest <- read.table("test/Y_test.txt")
ytrain <- read.table("train/Y_train.txt")
##merge "activity" data into 1 table and name the variable
activitydata <- rbind(ytest, ytrain)
names(activitydata) <- c("Activity")


##read feature data from test and train data sets
xtest <- read.table("test/X_test.txt")
xtrain <- read.table("train/X_train.txt")
#merge "feature" data into 1 table and name the variables
featuredata <- rbind(xtest, xtrain)
names(featuredata) <- features$V2

##merge subject, activity and features data to 1 table
mergesubact <- cbind(subjectdata,activitydata)
alldata <- cbind(mergesubact,featuredata)

##2. Extracts only the measurements on the mean and standard deviation for each measurement.
##Note: When trying to extract variables from the dataset, an error indicated that 
##there were duplicated columns.  In this section, the duplicate columns are removed from the dataset
##and then the data is extracted

## removes duplicate feature names
filtered <- alldata[,!duplicated(features$V2)]

## extract measurements for mean and stdev on each measurement
extractedmeasures <- select(filtered, 1, 2, contains("mean()"), contains("std()"))

##3. Uses descriptive activity names to name the activities in the data set
describeact <- merge(actlabels, extractedmeasures, by.x ="V1", by.y = "Activity", sort = TRUE)
## Remove non-descriptive activity variable and order variables
neatdata <- arrange(select(describeact,-V1), Subject)

##4.Appropriately labels the data set with descriptive variable names.
##Rename the feature variables with descriptions from features_info.txt
names(neatdata)<-gsub("std()", "Standard Deviation", names(neatdata))
names(neatdata)<-gsub("mean()", "Mean", names(neatdata))
names(neatdata)<-gsub("^t", "Time", names(neatdata))
names(neatdata)<-gsub("^f", "Frequency", names(neatdata))
names(neatdata)<-gsub("Acc", "Accelerometer", names(neatdata))
names(neatdata)<-gsub("Gyro", "Gyroscope", names(neatdata))
names(neatdata)<-gsub("Mag", "Magnitude", names(neatdata))
names(neatdata)<-gsub("BodyBody", "Body", names(neatdata))

##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyset <- aggregate(. ~Subject + Activity, neatdata, mean)
tidyset <- tidyset[order(tidyset$Subject, tidyset$Subject),]


write.table(tidyset, file = "tidydata.txt", row.name=FALSE)
