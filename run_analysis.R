#load respective package libraries
library(dplyr)
library(data.table)
library(stringr)

#download the data
if(!file.exists("./info")){dir.create("./info")}
data.url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(data.url,destfile="./info/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./info/Dataset.zip",exdir="./info")

#read activity data
activity.data <- read.table("./info/UCI HAR Dataset/activity_labels.txt")

#read features
feature.txt <- read.table("./info/UCI HAR Dataset/features.txt")
#feature.info <- read.table("./info/UCI HAR Dataset/features_info.txt")

#read test data 
x.test <- read.table("./info/UCI HAR Dataset/test/X_test.txt")
y.test <- read.table("./info/UCI HAR Dataset/test/y_test.txt")
subject.test <- read.table("./info/UCI HAR Dataset/test/subject_test.txt")

#read train data
x.train <- read.table("./info/UCI HAR Dataset/train/X_train.txt")
y.train <- read.table("./info/UCI HAR Dataset/train/y_train.txt")
subject.train <- read.table("./info/UCI HAR Dataset/train/subject_train.txt")

#assign column names
colnames(x.train) <- feature.txt$V2
colnames(y.train) <-"activityId"
colnames(subject.train) <- "subjectId"

colnames(x.test) <- feature.txt$V2
colnames(y.test) <-"activityId"
colnames(subject.test) <- "subjectId"

colnames(activity.data) <- c("activityId" ,"activity.Type")


#merge test dataset
merge.test <- cbind(x.test,y.test,subject.test)
merge.train <- cbind(x.train,y.train,subject.train)
merge.all.data <- rbind(merge.test,merge.train)

#Extracts only the measurements on the mean and standard deviation for each measurement
colNames <- colnames(merge.all.data)
mean.std.val <- (grepl("activityId" , colNames)|grepl("subjectId" , colNames) | grepl("mean.." , colNames) |grepl("std.." , colNames))

data.set.mean.std <- merge.all.data[ , mean.std.val == TRUE]

#Uses descriptive activity names to name the activities in the data set

activity.name.set <- merge(data.set.mean.std, activity.data,by='activityId',all.x=TRUE)

#Creating a second, independent tidy data set 
second.tidy <- aggregate(. ~subjectId + activityId, activity.name.set, mean)
sec.tidy.set <- second.tidy[order(second.tidy$subjectId, second.tidy$activityId),]

write.table(sec.tidy.set, "Tidy.dataset.txt", row.name=FALSE)
solution <- read.table("Tidy.dataset.txt")

View(solution)


