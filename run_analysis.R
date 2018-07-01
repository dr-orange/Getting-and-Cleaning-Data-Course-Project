## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for 
##    each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##    average of each variable for each activity and each subject.

library(dplyr)
library(Hmisc) # capitalize()

# Download Data
rawDataFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
workingDataPath <- file.path(".", "data")
downloadedZipfilePath <- file.path(workingDataPath, "downloaded_dataset.zip")
rawDataPath <- file.path(workingDataPath, "UCI HAR Dataset")
# Create working directory
if(!file.exists(workingDataPath)) {
        dir.create(workingDataPath)
}
# Download ziped file
if(!file.exists(downloadedZipfilePath)) {
        download.file(rawDataFileUrl, destfile = downloadedZipfilePath, method = "curl")
}
# Unzip
if(!file.exists(rawDataPath)) {
        unzip(zipfile = downloadedZipfilePath, exdir = workingDataPath)
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

# Readable names
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
# Capitalize each words
descriptiveActivityNames <- sapply(activityNames$V2, function(x) {
        paste(sapply(strsplit(tolower(x), "_"), capitalize), collapse = " ")
})

## 1. Merges the training and the test sets to create one data set.
subjectData <- rbind(subjectTrain, subjectTest)
activityData <- rbind(yTrain, yTest)
signalData <- rbind(xTrain, xTest)

## 4. Appropriately labels the data set with descriptive variable names.
names(subjectData) <- "SubjectId"
names(activityData) <- "Activity"
names(signalData) <- descriptiveFeatureNames

tidyData <- data.frame(subjectData, activityData, signalData, check.names = FALSE) %>%
        ## 2. Extracts only the measurements on the mean and standard deviation for 
        ##    each measurement.
        select(matches("SubjectId|Activity|Mean|StandardDeviation", ignore.case = FALSE),
               -matches("^angle", ignore.case = FALSE)) %>%
        ## 3. Uses descriptive activity names to name the activities in the data set
        mutate(Activity = factor(data$Activity, labels = descriptiveActivityNames)) %>%
        ## 5. From the data set in step 4, creates a second, independent tidy data set with the 
        ##    average of each variable for each activity and each subject.
        group_by(SubjectId, Activity) %>%
        summarise_all(mean)

# write file
write.table(tidyData, "tidy_data.csv", sep = ",", row.name = FALSE)
