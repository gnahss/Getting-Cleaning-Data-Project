# Getting and Cleaning Data Project

library(reshape2)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile="data.zip",method="curl")
unzip("data.zip",exdir=".")

activities <- read.table("UCI HAR Dataset/activity_labels.txt") [,2]
features <- read.table("UCI HAR Dataset/features.txt") [,2]

# read subject labels
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt")
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt")

# read activity labels
trainAct <- read.table("UCI HAR Dataset/train/y_train.txt")
testAct <- read.table("UCI HAR Dataset/test/y_test.txt")

# read data
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
testData <- read.table("UCI HAR Dataset/test/X_test.txt")

# 1. Merge data
allSub <- rbind(trainSub, testSub)
names(allSub) <- "subject"
allAct <- rbind(trainAct, testAct)
names(allAct) <- "activity"
allData <- rbind(trainData, testData)
names(allData) <- features
m <- cbind(allSub, allAct, allData)

# 2. Extract mean and st_dev
m <- m[,grep("^subject|^activity|mean\\(\\)|std\\(\\)",names(m))]

# 3. Use descriptive activity names
m$activity <- cut(m$activity, breaks=0:6, labels=activities) # replace activity numbers with names

# 4. Use descriptive variable names
names(m) <- gsub("^t", "time", names(m))
names(m) <- gsub("^f", "frequency", names(m))
names(m) <- gsub("Acc", "Accelerometer", names(m))
names(m) <- gsub("Gyro", "Gyroscope", names(m))
names(m) <- gsub("Mag", "Magnitude", names(m))
names(m) <- gsub("BodyBody", "Body", names(m))
names(m) <- gsub("mean\\(\\)", "MEAN", names(m))
names(m) <- gsub("std\\(\\)", "STDEV", names(m))

# 5. Create a second tidy data set with the average of each variable for each activity and subject
dataMelt <- melt(m, id=c('subject','activity')) # melt data so each row is one observation
average <- dcast(dataMelt, subject+activity ~ variable, mean) # recast data to get mean of each variable
write.csv(average, 'tidy.csv', row.names=FALSE)
