run_analysis<-function(){
library(dplyr)
library(data.table)

###########################################
### first step:                         ###
### Load the two tables into the memory ###
###########################################

X_test <- fread("./test/X_test.txt")
X_train <- fread("./train/X_train.txt")

###########################################
### Second step:                        ###
### Merge the two tables into One 'X'   ###
###########################################

X<-rbind(X_test,X_train)

###########################################
### During the import:                  ###
### was load as the first column,       ###
### an inesisten column of NA           ###
### I take away this column             ###
###########################################

X<-select(X,-V1)

############################################
### Import the file feature              ###
### Which contains all the variable names### 
### into the the feature dataset.        ###
############################################


feature<-read.table("./features.txt")

############################################
### Associate each variable namae        ###
### to the relate column of the dataset  ###
### By associating eaxch columns name to ###
### the relate  feature                  ###
############################################

setnames(X,names(X),as.character(feature[,2]))

############################################
### I extract all the variables with the ### 
## mean and I save them into the dataset ###
### X_Means                              ###
############################################

X_Means<-select(X,contains("Mean()"))

############################################
### I extract all the variables with the ### 
## mean and I save them into the dataset ###
### X_Means                              ###
############################################

X_sdt<-select(X,contains("std()"))

############################################
### Merge the two set of variables into  ###
### one data set X                       ### 
############################################

X<-cbind(X_Means,X_sdt)

############################################
### The X data Frame is again our        ###
### working data set                     ###
### one data set X                       ### 
############################################


############################################
### create the Activity class vector     ###
############################################

############################################
### Read the train and test              ###
### Activity class vector                ###
############################################

Test_Activity <- fread("./test/y_test.txt")
Train_Activity<- fread("./train/y_train.txt")

############################################
### Merge the train and test             ###
### Activity class vector into           ###
### the vector Activity                  ###
############################################

Activity<-rbind(Test_Activity,Train_Activity)

############################################
### Read the file activity_labels.txt'   ###
### which Links the class labels with    ###
### their activity name.                 ###
############################################

Label_Activity<-fread("./activity_labels.txt")

############################################
### Associate the class labels (int)     ###
### with their activity name             ###
### (character/label).                   ###
############################################

Activity<-full_join(Activity,Label_Activity, by = "V1")

############################################
### remove from the data farme the int   ###
### class labels (int)                   ###
### as only activity name labels         ###
### are needed                           ###
############################################

Activity<-select(Activity,-V1)

############################################
### Give a proper name to the            ###
### column\ variable                     ###
############################################

names(Activity)<-"Activity_Label"

############################################
### Merge the activity vector to the     ###
###  data set X                       ### 
############################################

X<-cbind(Activity,X)

############################################
### The data set X is the requested      ###
### dataframe                            ###
### The variable are alraedy             ###
###  self explanatory as done before     ###
############################################

View(X)

############################################
###  Create the data-set requeste        ###
### on the point 5                       ###
############################################


############################################
###  Read teh subject file "subject_test"###
### from the test and train folders      ###
############################################

Test_subject <- fread("./test/subject_test.txt")
Train_subjecy<- fread("./train/subject_train.txt")
     
############################################
### Merge the train and test             ###
### subject into                         ###
### the vector Subject                   ###
############################################

Subject<-rbind(Test_subject,Train_subjecy)

############################################
### Give a proper name to the            ###
### column\ variable                     ###
############################################

setnames(Subject,names(Subject),"Subject")

############################################
### Merge the Subject vector with the    ###
###  data set X and save into Y          ### 
############################################

Y<-cbind(Subject,X)

############################################
### Group by subject and activity label  ###
### compute the averagwe for each column ### 
############################################


Final <-Y %>% group_by(Subject,Activity_Label) %>% summarise_each(funs(mean))
View(Final)

############################################
### Write the new data set               ###
### for the evaluation                   ### 
############################################

write.table(Final,"./finale.txt",row.name=FALSE)
}
