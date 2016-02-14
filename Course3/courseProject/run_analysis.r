
# Change this path accordingly based on user's need
setwd('/Users/fengw/study/datasciencecoursera/Course3/courseProject')

# first of all, download zip file and unzip as UCI_HAR_Dataset in the current work directory
# put the current script: run_analysis.r in the same folder as UCI_HAR_Dataset

# set work directory to where the code is located
wrkpth <- getwd()

# step 1: read data and combine/merge
print("step1: Reading and merging the training and the test sets...")
measurement.train <- read.table(paste(wrkpth, "/UCI_HAR_Dataset/train/X_train.txt", sep="")) 
measurement.test <- read.table(paste(wrkpth, "/UCI_HAR_Dataset/test/X_test.txt", sep=""))
measurement.alldata <- rbind(measurement.train, measurement.test)

activity.train <-read.table(paste(wrkpth, "/UCI_HAR_Dataset/train/y_train.txt", sep=""))
activity.test <- read.table(paste(wrkpth, "/UCI_HAR_Dataset/test/y_test.txt", sep=""))
activity.ids <- rbind(activity.train, activity.test)
names(activity.ids) <- 'activityid'

subjectid.train <- read.table(paste(wrkpth, "/UCI_HAR_Dataset/train/subject_train.txt", sep=""))
subjectid.test <- read.table(paste(wrkpth, "/UCI_HAR_Dataset/test/subject_test.txt", sep=""))
subject.ids <- rbind(subjectid.train, subjectid.test)
names(subject.ids) <- 'subjectid'

# step 2: extract mean and std of each measurement in the dataset 
print("step2: Extracting only the measurements on the mean and standard deviation for each measurement...")
indices.subset <- grep("-mean\\(\\)|-std\\(\\)", measurement.names)
measurement.data <- measurement.alldata[,indices.subset]

# step 3-4: use descriptive names for measurements and activities
print("step 3 and 4: Use descriptive activity names and label data properly...")
measurement.names <- read.table(paste(wrkpth, "/UCI_HAR_Dataset/features.txt", sep=""))
measurement.names <- measurement.names[,2]  # only use the charactor names 
names(measurement.data) <- measurement.names[indices.subset]
names(measurement.data) <- gsub("\\(|\\)", "", names(measurement.data))
names(measurement.data) <- tolower(names(measurement.data))

activity.labels <- read.table(paste(wrkpth, "/UCI_HAR_Dataset/activity_labels.txt", sep="")); 
activity.labels[, 2] <- gsub("_", "", tolower(as.character(activity.labels[, 2])))
activity.names <- data.frame(activityname=activity.labels[activity.ids[,],2])

# Combining all the data frames into one single data frame and then write into file 
clean.data <- cbind(subject.ids, activity.names, measurement.data)
first.datafile = "cleandata_ExtractedMeanStdMeasurements.csv"
print(paste("****Writing the cleaned data into csv file: ",first.datafile,sep=""))
write.csv(clean.data,first.datafile,row.names=FALSE)

# step 5: generate tidy data (average of each variable for each activity, each subject)
print("step 5: Using dataframe melt and dcast to get the average measurement for each activity and subject")
if (!is.element("reshape2", installed.packages()[,1])){
  install.packages("reshape2")
} else{
  library(reshape2)
}

id.variables <- c("subjectid","activityname")
measurement.variables <- names(measurement.data)
melted.data <- melt(clean.data, id=id.variables, measure.vars=measurement.variables)

# Decasting the melt data frame based on required criteria (average for each activity and subject id)
tidy.data <- dcast(melted.data, subjectid+activityname ~ variable, mean)
 
# Writing our final tidy dataset into files
second.datafile = "tidydata_ActivitySubjectAveragedMeasurements.csv"
print(paste("****Writing the cleaned data into csv file: ",second.datafile,sep=""))
write.csv(tidy.data,second.datafile,row.names=FALSE)

print("Finished!")




