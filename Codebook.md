---
title: "Codebook for Getting and Cleaning Data Project"
author: "Shanghui Li"
date: "April 6, 2017"
output: md_document
---

# Codebook

This codebook describes the variables, the data, and any transformations or work performed to clean up the data from the UCI HAR Dataset.

## The Data

Link to data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description of data from source:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## The Experiment

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

## Description of data

'activity_labels.txt': contains the six activity labels 

'features.txt': list of the measured features 

'subject_train.txt' and 'subject_test.txt': identify the train/test subject that performed the activity, ranges from 1-30. 

'y_train.txt' and 'y_test.txt': identify the train/test activity for the observed data 

'X_train.txt' and 'X_test.txt': observed train/test data

## Transformations

1. Merge the training and test sets to create one data set.  
Bind the training and test data frames by row, then bind the observations, activity labels and subject labels by column to create one data frame. Add names to columns of data frame.

2. Extract only the measurements on the mean and standard deviation for each measurement.  
Use *grep* command to extract variables that contain 'mean()' and 'std()' while retaining subject and activity variables.

3. Use descriptive activity names to name the activities in the data set.  
Replace activity numbers with descriptive activity names by employing the *cut* command to transform the numbers into factors and renaming the factors.

4. Label the data set with descriptive variable names.  
Using the *gsub* command:  
Replace 't' with 'time'  
Replace 'f' with 'frequency'  
Replace 'Acc' with 'Accelerometer'  
Replace 'Gyro' with 'Gyroscope  
Replace 'Mag' with 'Magnitude'  
Replace 'BodyBody' with 'Body'  
Replace 'mean()' with 'MEAN'  
Replace 'std()' with 'STDEV'

5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.  
First, melt the data frame such that each row contains only one observation, with the feature type stated in a column called 'variable'.  
Next, use the command *dcast* to obtain the average of each variable for every subject and activity.  
Finally, write the data frame to a file named 'tidy.csv'.
