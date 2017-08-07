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


### VARIABLES: 

*workingDir* - stores initial working directory

*zippedData* - contains a temporary file name used to store the downloaded data before it is unzipped.

*subject_test* - contents of the "subject_test.txt" test data file.    From README.txt: "Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

*X_test* - contents of the "X_test.txt" test data file.  This is the test data set. 

*y_test* - contents of the "y_test.txt" test data file.  These are the labels for the test data set.

The Inertial Signals are not required as they will be stripped out anyway under step 2. For additional discussion see https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
This document is a recommended reference by mentor Phillipe Alcouffe as given in the pinned tip for the week 4 discussion entitled "[tip] The infamous and so useful post from David Hood for the final assignment .. and quizzes"

*subject_train* - contents of the "subject_train.txt" test data file.  From README.txt: "Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. "

*X_train* - contents of the "X_train.txt" train data file.  This is the training data set.  

*y_train* - contents of the "y_train.txt" train data file.  These are the labels for the training data set.

*combined.train* - Interim processing variable that contains the X train data with the numeric activity labels from the Y train data prepended as the second column and the subject id prepended as the first column.

*combined.test* - Interim processing variable that contains the X test data with the numeric activity labels from the Y test data prepended as as the second column and the subject id prepended as the first column.

*combined.data* - This is both the train and test data sets, with prepended columns of subject id and numeric activity labels, combined into a single unified data set.

*features* - Contents of the "features.txt" data file. This data contains the column labels of the different observations in the data set.  

*activity_labels* - Contents of the "activity_labels.txt" data file. This data links numeric activity labels with descriptive activity names.

*relevant.cols* - interim data frame that includes column number and observation name of mean and standard deviation observations.

*extract.vector* - interim variable that contains relevant columns to extract from combined data, includes relevant.cols and additional subject and activity label columns.

*extracted.data* - interim data frame that contains only the data from the relevant (extracted) columns of the original combined data.

*mycols* - temporary variable used in processing the renaming of descriptive variable names.

*newcolnames* - temporary variable used in processing the renaming of descriptive variable names, with the subject and activity column names included (prepended)

*aggdata* - temporary variable used in the processing the aggregate command, contains the mean function applied on data aggregated by activity and subject.

*tidy.data* - the final data product of tidy data

### OUTPUT:

*tidy.data.txt* - this output file contains the final data product tidy.data with an arbitrary .txt extension.  Chose to write out with default separator.








