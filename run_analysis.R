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

featureNames <- read.table(file.path(rawDataPath, "features.txt"), stringsAsFactors = TRUE)
activityNames <- read.table(file.path(rawDataPath, "activity_labels.txt"))

hackCounter <- 0
descriptiveFeatureNames <- sapply(featureNames$V2, function(x){
        hackCounter <<- hackCounter + 1
        x <- gsub("-([XYZ])$", "\\1", x)
        x <- gsub("^t", "Time", x)
        x <- gsub("^f", "Frequency", x)
        x <- gsub("Acc", "Acceleration", x)
        x <- gsub("Gyro", "Gyroscope", x)
        x <- gsub("Mag", "Magnitude", x)
        x <- gsub("-mean\\(\\)", "Mean", x)
        x <- gsub("-std\\(\\)", "StandardDeviation", x)
        # add a counter value to be unique name
        x <- gsub("(-bandsEnergy\\(\\))", paste("\\1", hackCounter, sep = ""), x)
})

## 1. Merges the training and the test sets to create one data set.
subjectData <- rbind(subjectTrain, subjectTest)
signalData <- rbind(xTrain, xTest)
activityData <- rbind(yTrain, yTest)

## 4. Appropriately labels the data set with descriptive variable names.
names(subjectData) <- "SubjectId"
names(activityData) <- "Activity"
names(signalData) <- descriptiveFeatureNames

data <- data.frame(subjectData, activityData, signalData, check.names = FALSE)

# Free tempolary used large objects
rm(subjectTrain, subjectTest, xTrain, xTest, yTrain, yTest, subjectData, signalData, activityData)


# Capitalize each words
descriptiveActivityNames <- sapply(activityNames$V2, function(x) {
        paste(sapply(strsplit(tolower(x), "_"), capitalize), collapse = " ")
})

## 2. Extracts only the measurements on the mean and standard deviation for 
##    each measurement.
extractName <- grep("SubjectId|Activity|Mean|StandardDeviation", names(data), value = TRUE)
removeName <- grep("^angle", extractName, value = TRUE)
data <- data %>%
        select(extractName, -removeName)

## 3. Uses descriptive activity names to name the activities in the data set
# Uses descriptive activity names
data <- data %>%
        mutate(Activity = factor(data$Activity, labels = descriptiveActivityNames))

## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##    average of each variable for each activity and each subject.
tidyData <- data %>%
        group_by(SubjectId, Activity) %>%
        summarise_all(mean)

# write file
write.table(tidyData, "tidy_data.csv", sep = ",", row.name = FALSE)
