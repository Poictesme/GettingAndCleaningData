# CODEBOOK
## This CodeBook is for the Coursera Getting and Cleaning Data Course Project

This codebook describes the variables, data and transformations performed by the script *run_analysis.R*

## Data 
This data is derived from the "Human Activity Regcognition Using Smartphones Data Set"" from the UCI Machine Learning Repository: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The actual data is taken from the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The structure of the data set is described on the UCI site, and in the README.txt and features_information.txt files included with that data.  

### Summary of Data from UCI web page
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

### Brief summary of data files from README.txt:
The dataset includes the following files:

'README.txt'

'features_info.txt': Shows information about the variables used on the feature vector.

'features.txt': List of all features.

'activity_labels.txt': Links the class labels with their activity name.

'train/X_train.txt': Training set.

'train/y_train.txt': Training labels.

'test/X_test.txt': Test set.

'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


## *run_analysis.R* performs the following steps to get and clean data:


### 1.  Gets the working directory, then downloads and unzips the "UCI HAR Dataset".

VARIABLES: 

*workingDir* - stores initial working directory

*zippedData* - contains a temporary file name used to store the downloaded data before it is unzipped.

### 2. Reads in the "test" data.  From the UCI HAR Dataset, the test data is loaded and stored in data frames that share the literal name of the text file loaded (without the extension).  For this reason these particular variable names deliberately choose to use the underscore character ("_") in the variable name.  

VARIABLES:

*subject_test* - contents of the "subject_test.txt" test data file.    From README.txt: "Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

*X_test* - contents of the "X_test.txt" test data file.  This is the test data set. 

*y_test* - contents of the "y_test.txt" test data file.  These are the labels for the test data set.

The Inertial Signals are not required as they will be stripped out anyway under step 2. For additional discussion see https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
This document is a recommended reference by mentor Phillipe Alcouffe as given in the pinned tip for the week 4 discussion entitled "[tip] The infamous and so useful post from David Hood for the final assignment .. and quizzes"


### 3. Reads in the "train" data.  From the UCI HAR Dataset, the train data is loaded and stored in data frames that share the literal name of the text file loaded (without the extension).  For this reason these particular variable names deliberately choose to use the underscore character ("_") in the variable name.  

VARIABLES:

*subject_train* - contents of the "subject_train.txt" test data file.  From README.txt: "Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. "

*X_train* - contents of the "X_train.txt" train data file.  This is the training data set.  

*y_train* - contents of the "y_train.txt" train data file.  These are the labels for the training data set.

### 4. Merge the data (Requirements **Step #1**).  This occurs in three steps.  First, the label data (y_) is combined as the first column to the X_ data set for both the train and test data using cbind, and then the subject data is prepended to that.  Then, the train and test data sets are combined with rbind to create a single data set, called combined.data.

VARIABLES:

*combined.train* - Interim processing variable that contains the X train data with the numeric activity labels from the Y train data prepended as the first column.

*combined.test* - Interim processing variable that contains the X test data with the numeric activity labels from the Y test data prepended as the first column.

*combined.data* - This is both the train and test data sets, with prepended the column of numeric activity labels, combined into a single unified data set.

### 5. Read the feature labels and descriptive activity labels.

VARIABLES:

*features* - Contents of the "features.txt" data file. This data contains the column labels of the different observations in the data set.  
*activity_labels* - Contents of the "activity_labels.txt" data file. This data links numeric activity labels with descriptive activity names.

### 6. Identifies relevant columns to extract from the data to meet requirement **Step #2**, use only the measurements of mean and standard deviation 

VARIABLES:

*relevant.cols* - interim data frame that includes column number and observation name of mean and standard deviation observations.

### 7.  We also want to keep the two newly-added columns (subject and activity label) that we created with the combined data steps, so we create extract.vector, which includes those two columns, then we add the relevant columns selected above and use the extract.vector to pull the relevant data subset out of the combined.data

*extract.vector* - interim variable that contains relevant columns to extract from combined data, includes relevant.cols and additional subject and activity label columns.
*extracted.data* - interim data frame that contains only the data from the relevant (extracted) columns of the original combined data.

### 8. Requirement **Step #3**, use descriptive activity names.  Converts numeric activity labels from y_ data to descriptive names using activity_labels as a lookup table.

### 9. Requirements **Step #4**, appropriately labels with data set with descriptive variable names.  Uses the descriptive names from the relevant columns extraction (relevant.cols) to label the observation columns, with the following adjustments: a) eliminates dashes from names, b) enhances readability of mean and std by relacing with "Mean" and "StdDev", c) expands t or f in variable name to "time" and "freq"

VARIABLES:

*mycols* - temporary variable used in processing the renaming of descriptive variable names.

### 10. Creates a vector with the new descriptions that includes the two prepended columns for subject id and activity label, then applys the new descriptive labels to the extracted.data data set.

VARIABLES:
*newcolnames* - temporary variable used in processing the renaming of descriptive variable names, with the subject and activity column names included (prepended)

### 11.  Requirements **Step #5** - create second independent tidy data set with the average of each variable for each activity and each subject.  Uses aggregate command to apply the mean function by aggregate of activity and subject.  This data is then stored in the variable tidy.data after dropping two redundant columns created by the aggregate operation.

VARIABLES:

*aggdata* - temporary variable used in the processing the aggregate command, contains the mean function applied on data aggregated by activity and subject.
*tidy.data* - the final data product of tidy data

### 12. Write aggregated tidy data out to file

###OUTPUT:

*tidy.data.txt* - this output file contains the final data product tidy.data with an arbitrary .txt extension.  Chose to write out with default separator.








