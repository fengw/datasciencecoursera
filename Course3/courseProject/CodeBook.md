# Getting & Cleaning Data Course Project

## Original Data 

### Human Activity Recognition Using Smartphones Dataset, Version 1.0
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws, www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

#### For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

#### The dataset includes the following files:
- 'README.txt' *Original data codebook*

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all feature names. (*total 561 rows*)

- 'activity_labels.txt': Links the class labels with their activity name. (*total 10299 rows*, and unique activity is 6 types same as the data description)

- 'train/X_train.txt': Training set of measurement/record/feature. (*dim: 7352,561*)

- 'train/y_train.txt': Training labels of activity. (*total 7352 rows*)

- 'test/X_test.txt': Test set of measurement/record/feature. (*dim: 2947,561*)

- 'test/y_test.txt': Test labels of activity. (*total 2947 rows*)

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

### Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

### License:
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

## Dataset processing

First of all, the script first download the original data set (zip file) and *unzip* it if the data is not in the local path. The work directory is set as "*/Users/fengw/study/datasciencecoursera/Course3/courseProject*" for my case, users can change this based on their needs.

Step 1: According to the original data structure (indicated in *CodeBook.md*), the measurements, activity IDs, subject IDs for both train and test are read in and combined with "rbind" function.
 + *measurement.train, measurement.test, and measurement.alldata* are for measurements
 + *activity.train, activity.test, and activity.ids* are for activity types
 + *subject.train. subject.test, and subject.ids* are for subject identifier

Step 2: Extract measurements with "-mean()" or "-std()" with help of measurement name (read from feature.txt). Note that "(" is indicated by "\\(", as well as ")" by "\\)" for special charactors in grep function.
  + *meansurement.names* include all measurement names in the dataset.
  + *indices.subset* indicates the column index where the measurement is either mean or std. 
  
Step 3 and 4: Assign descriptive names and labels for measurement and activity, where activity labels are in activity.txt file. All labels/names are converted to lower case. A clean data frame (*clean.data*) is then written into a file: 
"cleandata_ExtractedMeanStdMeasurements.csv" in the work directory. 
 + *meansurement.names and measurement.data* are the extracted measurement names and subset from *measurement.alldata*. 
 + *activity.names* are names for *acvitity.ids* loaded in step1, include: *"walking, walking_upstairs, walking_downstairs, sitting, standing, laying"* 
 + *clean.data* is a data frame include *subject.ids*, *activity.names*, and *measurement.data* 
 
Step 5: Based on the clean data set generated from step 1-4, and create a data set that shows the average of each activity and subject with help of melt and dcast in library "reshape2" (the program takes care the case where you don't have the package). A tidy data frame (*tidy.data*) is written into a file: "tidydata_ActivitySubjectAveragedMeasurements.txt" in the work directory. 

## Clean Data 
Datafile: "*cleandata_ExtractedMeanStdMeasurements.csv*"
The data set created from *run_analysis.r*, which includes the mean and std measurement extracted from orignal data set for each acivity and subject. It has dimension (*10299,68*) dimension which incidates that it's the subset of the original dataset (*10299,561*). The first column is **subjectid** indicating the subject ID (range from 1 to 30), second column name is **activityname** indicating the acrtivity types (*"walking, walking_upstairs, walking_downstairs, sitting, standing, laying"*), and other columns are extracted measurement names that have "-mean" or "-std" as required.

## Tidy Data 
Datafile: "*tidydata_ActivitySubjectAveragedMeasurements.txt*"
The data set created from *run_analysis.r*, which includes the average measurement for each subject and activity across all measurements available for the subject and activity.
It has dimension(*180,68*) which is consistent with total number of subjects (30) times activity (6). The first column is **subjectid** (range from 1 to 30), second column name is **activityname** (*"walking, walking_upstairs, walking_downstairs, sitting, standing, laying"*), and other columns are the same measurement names as in clean data.  
