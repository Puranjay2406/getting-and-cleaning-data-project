################################ download file and unzip it####################

library(dplyr) 
if(!file.exists("./data")){dir.create("./data");dir.create("./data/unzipdt")}
dturl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dturl,"./data/wearabledt.zip",mode="wb")
unzip(zipfile = "./data/wearabledt.zip",exdir = "./data/unzipdt")

############################## Load necessary data ########################################
activitylabels <- read.table("./data/unzipdt/UCI HAR Dataset/activity_labels.txt",
                             colClasses = c("numeric","character"))

measures <- read.table("./data/unzipdt/UCI HAR Dataset/features.txt",
                       colClasses = c("numeric","character"))

selectedmeasures <- grep(".*mean.*|.*std.*", measures[,2])

measuresnames <- {measuresnames <- measures[selectedmeasures,2];
                  measuresnames <-  gsub('-mean', 'Mean', measuresnames);
                  measuresnames <- gsub('-std', 'Std', measuresnames)
                  measuresnames <- gsub('[-()]', '',measuresnames) 
                  measuresnames <- gsub("BodyBody", "Body",measuresnames)
                  measuresnames <- tolower(measuresnames)
                          }
####### Extracts only the measurements on the mean and standard deviation for each measurement########

traindt <- read.table("./data/unzipdt/UCI HAR Dataset/train/X_train.txt")[selectedmeasures]
trainactivs <- read.table("./data/unzipdt/UCI HAR Dataset/train/Y_train.txt")
trainsubjects <- read.table("./data/unzipdt/UCI HAR Dataset/train/subject_train.txt")
testdt <- read.table("./data/unzipdt/UCI HAR Dataset/test/X_test.txt")[selectedmeasures]
testactivs <- read.table("./data/unzipdt/UCI HAR Dataset/test/Y_test.txt")
testsubjects <- read.table("./data/unzipdt/UCI HAR Dataset/test/subject_test.txt")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~merge datasets~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~# 

traindt <- cbind(trainsubjects, trainactivs, traindt) 
testdt <- cbind(testsubjects, testactivs, testdt)
finaldata <- rbind(traindt, testdt)
colnames(finaldata) <- c("subject", "activity", measuresnames)

#### independent tidy data set with the average of each variable for each activity and each subject####

indepdata <- finaldata %>% group_by(activity,subject)%>%summarize_all(mean);{indepdata$activity <- factor(indepdata$activity,labels = activitylabels$V2)}
                        

