### Getting and Cleaning Data Course Project

This repository contains four files:

*run_analysis.R* - R script that downloads UCI HAR data, cleans and processes it, and writes out a tidy data set.

*tidy.data.txt* - This is the output of run_analysis.R, it is a tidy data set with default " " space separator.

*README.md* - This file, which outlines the processes and transforms of the run_analysis.R script.

*CodeBook.md* - a descriptive codebook that outlines the data and the variables and transformations from the run_analysis.R script.

**Please see *CodeBook.md* for additional details on data and variables.**

## *run_analysis.R* performs the following steps to get and clean data:

1. Gets the working directory, then downloads and unzips the "UCI HAR Dataset".

2. Reads in the "test" data.  From the UCI HAR Dataset, the test data is loaded and stored in data frames that share the literal name of the text file loaded (without the extension).  For this reason these particular variable names deliberately choose to use the underscore character ("_") in the variable name. 

3. Reads in the "train" data.  From the UCI HAR Dataset, the train data is loaded and stored in data frames that share the literal name of the text file loaded (without the extension).  For this reason these particular variable names deliberately choose to use the underscore character ("_") in the variable name.

4. Merge the data (Requirements **Step #1**).  This occurs in three steps.  First, the label data (y_) is combined as the first column to the X_ data set for both the train and test data using cbind, and then the subject data is prepended to that.  Then, the train and test data sets are combined with rbind to create a single data set, called combined.data.

5. Read the feature labels and descriptive activity labels.

6. Uses grep to identify relevant columns to extract from the data to meet requirement Step #2, use only the measurements of mean and standard deviation 

7.  We also want to keep the two newly-added columns (subject and activity label) that we created with the combined data steps, so we create extract.vector, which includes those two columns, then we add the relevant columns selected above and use the extract.vector to pull the relevant data subset out of the combined.data

8. Requirement **Step #3**, use descriptive activity names.  Converts numeric activity labels from y_ data to descriptive names using activity_labels as a lookup table.

9. Requirement **Step #4**, appropriately labels data set with descriptive variable names.  Uses the descriptive names from the relevant columns extraction (relevant.cols) to label the observation columns, with the following adjustments: a) eliminates dashes from names, b) enhances readability of mean and std by relacing with "Mean" and "StdDev", c) expands t or f in variable name to "time" and "freq"

10. Creates a vector with the new descriptions that includes the two prepended columns for subject id and activity label, then applys the new descriptive labels to the extracted.data data set.

11.  Requirements **Step #5** - create second independent tidy data set with the average of each variable for each activity and each subject.  Uses aggregate command to apply the mean function by aggregate of activity and subject.  This data is then stored in the variable tidy.data after dropping two redundant columns created by the aggregate operation.

12. Write aggregated tidy data out to file (tidy.data.txt)





