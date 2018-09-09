# Getting and cleaning data project

## The R script, run_analysis.R, cleans the dataset than summarises it on 7 steps as follows :

- Step1:downloads the dataset and unzip it in a defined directory 
- step2:loads the activity labels and the features files 
- step3:selects the names of only needed measurements on the mean and standard deviation from features file 
- step4:change the names of the selected variables to be more readable and corrects typos
- step5:loads the datasets of train and test which have only the selected variables
- step6:merges the datasets and modifies the columns names
- step7:summarises the tidy dataset using dplyr to get the average of each variable for each activity and each subject
