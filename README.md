# Getting and cleaning data
Assignment= week 4 project
This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1)Download the dataset if it does not already exist in the working directory and then unzips the zipped datafile.
2)Loads both the training and test datasets, extracting only the measurements on the mean and standard deviation for each value
3)Loads the activity data and feature information
4)Loads the activity and subject data for each dataset, and merges the respective columns with the dataset
5)Merges all the datasets in one
6)Sets descriptive activity names to name the activities in the data set
7)Creates a tidy dataset that consists of the average value of each variable for each subject and activity pair.
The output is shown in the file Tidy.set.txt.
