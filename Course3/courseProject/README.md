#Getting and Cleaning Data Course Project

##Project Introduction
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data are collected from the accelerometers from the Samsung Galaxy S smartphone, and can be download from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), and a full description is available at the site where the data was obtained from [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

##Project Tasks
The task of the project is to create tidy data based on the original data, which can be used later for other analysis. Create a R script to perform the following steps in order to deliever the tidy data which meets the requirement. 

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


## Script Related
### Execution/Setup
+ Pull the repo from github and put the *run_analysis.r* in your local path where you want to put the original data and outcome tidy data, and set the work directory as it.

+ In R stuido, source("run_analysis.r") 

### Functions/Details
First of all, the script first download the original data set (zip file) and *unzip* it if the data is not in the local path. The work directory is set as "*/Users/fengw/study/datasciencecoursera/Course3/courseProject*" for my case, users can change this based on their needs.

Step 1: According to the original data structure (indicated in *CodeBook.md*), the measurements, activity IDs, subject IDs for both train and test are read in and combined with "rbind" function. 

Step 2: Extract measurements with "-mean()" or "-std()" with help of measurement name (read from feature.txt). Note that "(" is indicated by "\\(", as well as ")" by "\\)" for special charactors in grep function.

Step 3 and 4: Assign descriptive names and labels for measurement and activity, where activity labels are in activity.txt file. All labels/names are converted to lower case. A clean data frame (*clean.data*) is then written into a file: 
"cleandata_ExtractedMeanStdMeasurements.csv" in the work directory. The description of the clean data can be found in *CodeBook.md*.

Step 5: Based on the clean data set generated from step 1-4, and create a data set that shows the average of each activity and subject with help of melt and dcast in library "reshape2" (the program takes care the case where you don't have the package). A tidy data frame (*tidy.data*) is written into a file: "tidydata_ActivitySubjectAveragedMeasurements.txt" in the work directory. The description of the tidy data can be found in *CodeBook.md*.
