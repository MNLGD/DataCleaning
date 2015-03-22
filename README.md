# DataCleaning
Project for Coursera course

Run_analysis progresses as follows:

* data is read into fields : testdata, testlable, traindata, trainlabel, testsubjectdata, trainsubjectdata
* testtraindata, testtrainlabel, testtrainSubject  hold the merged data sets<
* features  lists the applicable names for testtraindata; and is applied to column names that match "mean" & "std" fileds required.
* activities hold activity names.
* finaldataset holds the bound columns of  the merged datasets.
* returned averages  contains the relevant averages which is written to tidy_data.txt  
*  ddply()  from the plyr package is used to apply  colMeans() 
