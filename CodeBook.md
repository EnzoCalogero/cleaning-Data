# Codebook for the Clean data Corsera project 

The script run_analysis() in the file Run_analysis.R, first load the two R libraries:
dplyr and data.table.
The first is use to manipulate the data set
(reduce aggregate the number of variables/columns, group and summarise), 
while the second library is used mainly for the function fread() which allow to load
big file into data set in a short time.

## Input 
The script read the two files "./test/X_test.txt" and ./train/X_train.txt"
(note: before the importing it is needed to transform the double space into a single space 
https://class.coursera.org/getdata-012/forum/thread?thread_id=136)

## Variables selection 
The two dataset are merged into a new one called "X"

To give a name to each column it is loaded the file "./features.txt"
and once loaded the features are associated to the data set X.

Using the function select() are extracted from the Data Set X all the variable with the mean
and then all the variables with the STD and merged together in a new data set called X. 
 
##Adding the Activity Variable to the data set X.
The two files that logs the activities are read and load as data sets "./test/y_test.txt" and "./train/y_train.txt".
They are transformed from the int value into self-explaining labels.
Finally  they are merged into a new data set called "Activity" and then merged into the X data set.

##Adding the subjects Variable to the data set X.
The two files that logs the subjects, are read and load as data set "./test/subject_test.txt" and "./train/subject_train.txt".

They are merged into a new data set called "subject" and then merged back into a new data set called again X.

## Final Summary 
The data set X is summarised by grouping by the activity and subject and for each variable thE relate average is calculated and saved in the data set called "finale" and saved in the file "./finale.txt" 

## Variables selected 
For the following variables are selected the mean and the sdt. 
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag
