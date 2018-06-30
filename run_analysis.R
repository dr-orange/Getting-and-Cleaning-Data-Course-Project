## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for 
##    each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##    average of each variable for each activity and each subject.

library(dplyr)
library(tidyr)
library(Hmisc) # capitalize()

# Download Data
rawDataFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
workingDataPath <- file.path(".", "data")
downloadedZipfilePath <- file.path(workingDataPath, "downloaded_dataset.zip")
rawDataPath <- file.path(workingDataPath, "UCI HAR Dataset")
# Create working directory
if(!file.exists(workingDataPath)) {
        dir.create(workingDataPath)
} else {
        # Already exists
        message("SKIP: create working dir")
}
# Download ziped file
if(!file.exists(downloadedZipfilePath)) {
        download.file(rawDataFileUrl, destfile = downloadedZipfilePath, method = "curl")
} else {
        # Already exists
        message("SKIP: download zip file")
}
# Unzip
if(!file.exists(rawDataPath)) {
        unzip(zipfile = downloadedZipfilePath, exdir = workingDataPath)
} else {
        # Already exists
        message("SKIP: extract zip file")
}

# Read Data
trainDataPath <- file.path(rawDataPath, "train")
testDataPath <- file.path(rawDataPath, "test")

subjectTrain <- tbl_df(read.table(file.path(trainDataPath, "subject_train.txt")))
xTrain <- tbl_df(read.table(file.path(trainDataPath, "X_train.txt")))
yTrain <- tbl_df(read.table(file.path(trainDataPath, "y_train.txt")))

subjectTest <- tbl_df(read.table(file.path(testDataPath, "subject_test.txt")))
xTest <- tbl_df(read.table(file.path(testDataPath, "X_test.txt")))
yTest <- tbl_df(read.table(file.path(testDataPath, "y_test.txt")))

featureNames <- read.table(file.path(rawDataPath, "features.txt"))
activityNames <- read.table(file.path(rawDataPath, "activity_labels.txt"))

# Readable Name
names(subjectTrain) <- "SubjectId"
names(subjectTest) <- "SubjectId"
names(xTrain) <- featureNames$V2
names(yTrain) <- "Activity"
names(xTest) <- featureNames$V2
names(yTest) <- "Activity"

## 1. Merges the training and the test sets to create one data set.
subjectData <- rbind(subjectTrain, subjectTest)
xData <- rbind(xTrain, xTest)
yData <- rbind(yTrain, yTest)

data <- cbind(subjectData, yData, xData)

# Free templary used objects
rm(featureNames, subjectTrain, subjectTest, xTrain, xTest, yTrain, yTest, subjectData, xData, yData)

## 2. Extracts only the measurements on the mean and standard deviation for 
##    each measurement.
data <- data[, grepl("SubjectId|Activity|mean\\(\\)|std\\(\\)", names(data))]

## 3. Uses descriptive activity names to name the activities in the data set
# Capitalize each words
activityNames$V2 <- sapply(activityNames$V2, function(x) {
        paste(sapply(strsplit(tolower(x), "_"), capitalize), collapse=" ")
})
# Uses descriptive activity names
data$Activity <- factor(data$Activity, labels = activityNames$V2)

## 4. Appropriately labels the data set with descriptive variable names.
names(data) <- sapply(names(data), function(x){
        x <- gsub("-([XYZ])$", "\\1", x);
        x <- gsub("^t", "Time", x);
        x <- gsub("^f", "Frequency", x);
        x <- gsub("Acc", "Acceleration", x);
        x <- gsub("Gyro", "Gyroscope", x);
        x <- gsub("Mag", "Magnitude", x);
        x <- gsub("-mean\\(\\)", "Mean", x);
        x <- gsub("-std\\(\\)", "StandardDeviation", x)
})

## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##    average of each variable for each activity and each subject.
meltedData <- melt(data, id = c("SubjectId", "Activity"))
# Average of each variable
tidyData <- dcast(meltedData, SubjectId + Activity ~ variable, mean)

write.table(tidyData, "tidy_data.csv", sep = ",")
