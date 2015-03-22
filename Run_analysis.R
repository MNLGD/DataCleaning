run_analysis <- function()
{
  library(plyr)
  library(dplyr)
  
  
  testData <- read.table("./UCI HAR Dataset/test/X_Test.txt") 
  testlabel <- read.table("./UCI HAR Dataset/test/y_Test.txt") 
  
  trainData <- read.table("./UCI HAR Dataset/train/X_Train.txt")
  trainlabel <-  read.table("./UCI HAR Dataset/train/y_Train.txt") 
  testSubjectData<- read.table("./UCI HAR Dataset/test/subject_test.txt") 
  trainSubjectData<- read.table("./UCI HAR Dataset/train/subject_train.txt") 
  
  testtrainData <- rbind(trainData, testData)
  testtrainLabel <- rbind(trainlabel, testlabel)
  testtrainSubject <- rbind(trainSubjectData, testSubjectData)
  
  # Read Features
  features <- read.table("./UCI HAR Dataset/features.txt")
  # Read Activities
  activities <-read.table("./UCI HAR Dataset/activity_labels.txt")
  
  
  print(names(features))
  
  # get only feature names like mean or std
  mean_std<- grep("-(mean|std)\\(\\)", features[, 2]) 
  mean_std
  
  #Limit data to std & mean related
  testtrainData <- testtrainData[,mean_std]
  
  #Naming:
  names(testtrainData) <-features[mean_std,2]
  names(testtrainLabel) <-"ACTIVITY"
  names(testtrainSubject) <-"SUBJECT"
  #Map the label columns to the matching activity
  testtrainLabel[,1] <-activities[testtrainLabel[,1],2]
  
  finalDataset <-cbind(testtrainData, testtrainLabel, testtrainSubject)
  # finalDataset
  returned_avgs <- ddply(finalDataset, .(SUBJECT, ACTIVITY), function(x) colMeans(x[, 1:ncol(testtrainData)]))
 #Write out the tidy data
  write.table(returned_avgs, "tidy_data.txt", sep="\t", row.name=FALSE)
}