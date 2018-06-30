# Human Activity Recognition Using Smartphones Data Set 

## Abstract:

A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

## Download Data Set:

https://github.com/dr-orange/Getting-and-Cleaning-Data-Course-Project/blob/master/tidy_data.csv

## Source:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Data Set Information:

These signals were used to estimate variables of the feature vector for each pattern:  

1. Time or Frequency  
    `Time` domain signals were captured at a constant rate of 50 Hz.  
    `Frequency` domain signals were appied a Fast Fourier Transform (FFT).
2. Body or Gravity  
    The acceleration signal was then separated into `body` and `gravity` acceleration signals.
3. Acceleration or Gyroscope  
    Signals from the `accelerometer` and `gyroscope`. 
4. Jerk  
    The body linear acceleration and angular velocity were derived in time to obtain `Jerk` signals.
5. Magnitude  
    The `magnitude` of these three-dimensional signals were calculated using the Euclidean norm.
6. Mean or StandardDeviation  
    `Mean` value, `Standard deviation`.
7. X, Y or Z  
    3-axial signals in the `X`, `Y` and `Z` directions.

## Variables

The complete list of variables of each feature vector:

|Column #|Variable Name|
|-|:--------|
|[1]|SubjectId|
|[2]|Activity|
|[3]|TimeBodyAccelerationMeanX|
|[4]|TimeBodyAccelerationMeanY|
|[5]|TimeBodyAccelerationMeanZ|
|[6]|TimeBodyAccelerationStandardDeviationX|
|[7]|TimeBodyAccelerationStandardDeviationY|
|[8]|TimeBodyAccelerationStandardDeviationZ|
|[9]|TimeGravityAccelerationMeanX|
|[10]|TimeGravityAccelerationMeanY|
|[11]|TimeGravityAccelerationMeanZ|
|[12]|TimeGravityAccelerationStandardDeviationX|
|[13]|TimeGravityAccelerationStandardDeviationY|
|[14]|TimeGravityAccelerationStandardDeviationZ|
|[15]|TimeBodyAccelerationJerkMeanX|
|[16]|TimeBodyAccelerationJerkMeanY|
|[17]|TimeBodyAccelerationJerkMeanZ|
|[18]|TimeBodyAccelerationJerkStandardDeviationX|
|[19]|TimeBodyAccelerationJerkStandardDeviationY|
|[20]|TimeBodyAccelerationJerkStandardDeviationZ|
|[21]|TimeBodyGyroscopeMeanX|
|[22]|TimeBodyGyroscopeMeanY|
|[23]|TimeBodyGyroscopeMeanZ|
|[24]|TimeBodyGyroscopeStandardDeviationX|
|[25]|TimeBodyGyroscopeStandardDeviationY|
|[26]|TimeBodyGyroscopeStandardDeviationZ|
|[27]|TimeBodyGyroscopeJerkMeanX|
|[28]|TimeBodyGyroscopeJerkMeanY|
|[29]|TimeBodyGyroscopeJerkMeanZ|
|[30]|TimeBodyGyroscopeJerkStandardDeviationX|
|[31]|TimeBodyGyroscopeJerkStandardDeviationY|
|[32]|TimeBodyGyroscopeJerkStandardDeviationZ|
|[33]|TimeBodyAccelerationMagnitudeMean|
|[34]|TimeBodyAccelerationMagnitudeStandardDeviation|
|[35]|TimeGravityAccelerationMagnitudeMean|
|[36]|TimeGravityAccelerationMagnitudeStandardDeviation|
|[37]|TimeBodyAccelerationJerkMagnitudeMean|
|[38]|TimeBodyAccelerationJerkMagnitudeStandardDeviation|
|[39]|TimeBodyGyroscopeMagnitudeMean|
|[40]|TimeBodyGyroscopeMagnitudeStandardDeviation|
|[41]|TimeBodyGyroscopeJerkMagnitudeMean|
|[42]|TimeBodyGyroscopeJerkMagnitudeStandardDeviation|
|[43]|FrequencyBodyAccelerationMeanX|
|[44]|FrequencyBodyAccelerationMeanY|
|[45]|FrequencyBodyAccelerationMeanZ|
|[46]|FrequencyBodyAccelerationStandardDeviationX|
|[47]|FrequencyBodyAccelerationStandardDeviationY|
|[48]|FrequencyBodyAccelerationStandardDeviationZ|
|[49]|FrequencyBodyAccelerationJerkMeanX|
|[50]|FrequencyBodyAccelerationJerkMeanY|
|[51]|FrequencyBodyAccelerationJerkMeanZ|
|[52]|FrequencyBodyAccelerationJerkStandardDeviationX|
|[53]|FrequencyBodyAccelerationJerkStandardDeviationY|
|[54]|FrequencyBodyAccelerationJerkStandardDeviationZ|
|[55]|FrequencyBodyGyroscopeMeanX|
|[56]|FrequencyBodyGyroscopeMeanY|
|[57]|FrequencyBodyGyroscopeMeanZ|
|[58]|FrequencyBodyGyroscopeStandardDeviationX|
|[59]|FrequencyBodyGyroscopeStandardDeviationY|
|[60]|FrequencyBodyGyroscopeStandardDeviationZ|
|[61]|FrequencyBodyAccelerationMagnitudeMean|
|[62]|FrequencyBodyAccelerationMagnitudeStandardDeviation|
|[63]|FrequencyBodyBodyAccelerationJerkMagnitudeMean|
|[64]|FrequencyBodyBodyAccelerationJerkMagnitudeStandardDeviation|
|[65]|FrequencyBodyBodyGyroscopeMagnitudeMean|
|[66]|FrequencyBodyBodyGyroscopeMagnitudeStandardDeviation|
|[67]|FrequencyBodyBodyGyroscopeJerkMagnitudeMean|
|[68]|FrequencyBodyBodyGyroscopeJerkMagnitudeStandardDeviation|