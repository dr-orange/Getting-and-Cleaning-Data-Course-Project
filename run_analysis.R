## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

rawDataFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
workingDataPath <- "./data"
downloadedZipfilePath <- paste(workingDataPath, "downloaded_dataset.zip", sep = "/")
rawDataPath <- paste(workingDataPath, "UCI HAR Dataset", sep ="/")
if(!file.exists(workingDataPath)) {
        dir.create(workingDataPath)
} else {print("SKIP: create working dir")}
if(!file.exists(downloadedZipfilePath)) {
        download.file(rawDataFileUrl, destfile = downloadedZipfilePath, method = "curl")
} else {print("SKIP: download zip file")}
if(!file.exists(rawDataPath)) {
        unzip(zipfile = downloadedZipfilePath, exdir = workingDataPath)
} else {print("SKIP: extract zip file")}
