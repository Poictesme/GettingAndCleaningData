#1.  Gets the working directory, then downloads and unzips the "UCI HAR Dataset".
workingDir<-getwd()
dataURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zippedData<-"UCI_HAR_data.zip"
download.file(dataURL,zippedData) #download to current working directory
unzip(zippedData)

#2. Reads in the "test" data.  From the UCI HAR Dataset, the test data is loaded and stored in data frames that share the literal name of the text file loaded (without the extension).  For this reason these particular variable names deliberately choose to use the underscore character ("_") in the variable name.  
#The Inertial Signals are not required as they will be stripped out anyway under step 2.
setwd(paste0(workingDir,"/UCI HAR Dataset/test"))
subject_test<-read.table("subject_test.txt") #Identifies subject (1:30)
X_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt") 

#3. Reads in the "train" data.  From the UCI HAR Dataset, the train data is loaded and stored in data frames that share the literal name of the text file loaded (without the extension).  For this reason these particular variable names deliberately choose to use the underscore character ("_") in the variable name.  
setwd(paste0(workingDir,"/UCI HAR Dataset/train"))
subject_train<-read.table("subject_train.txt") #Identifies subject (1:30)
X_train<-read.table("X_train.txt") #Training set
y_train<-read.table("y_train.txt") #Training labels

#4. Merge the data (Requirement Step #1).  This occurs in three steps.  First, the label data (y_*) is combined as the first column to the X_* data set for both the train and test data using cbind, and then the subject data is prepended to that.  Then, the train and test data sets are combined with rbind to create a single data set, called combined.data.
combined.train<-cbind(y_train,X_train)
combined.train<-cbind(subject_train,combined.train)
combined.test<-cbind(y_test,X_test)
combined.test<-cbind(subject_test,combined.test)
combined.data<-rbind(combined.train,combined.test)

#5. Read the feature labels and descriptive activity labels.
setwd(paste0(workingDir,"/UCI HAR Dataset"))
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")

#6. Identifies relevant columns to extract (using grep) from the data to meet requirement Step #2, use only the measurements of mean and standard deviation 
relevant.cols<-subset(features,grepl("mean[[:punct:]]|std",features$V2)) #remove meanFreq (mean followed by punctuation character)

#7.  We also want to keep the two newly-added columns (subject and activity label) that we created with the combined data steps, so we create extract.vector, which includes those two columns, then we add the relevant columns selected above and use the extract.vector to pull the relevant data subset out of the combined.data
extract.vector<-c(1,2) # want to include my two new columns in the extraction
extract.vector<-append(extract.vector,relevant.cols$V1+2,after=3) #relevant.cols$V1+2 #this will increase the column number from features.txt by two
extracted.data<-combined.data[,extract.vector]

#8. Requirement Step #3, use descriptive activity names.  Converts numeric activity labels from y_* data to descriptive names using activity_labels as a lookup table.
extracted.data$V1.1<-activity_labels[extracted.data$V1.1,2]

#9. Requirements Step #4, appropriately labels with data set with descriptive variable names.  Uses the descriptive names from the relevant columns extraction (relevant.cols) to label the observation columns, with the following adjustments: a) eliminates dashes from names, b) enhances readability of mean and std by relacing with "Mean" and "StdDev", c) expands t or f in variable name to "time" and "freq"
mycols<-relevant.cols
mycols$V2<-gsub("-std\\(\\)-*","StdDev",mycols$V2)
mycols$V2<-gsub("-mean\\(\\)-*","Mean",mycols$V2) #-* to remove dash after parens IF it is present, while preserving other text (i.e. X,etc.) and still capturing if paren is end of string
#Convert t to time and f to frequency, WHEN they are the first character only
mycols$V2<-gsub("^t","time",mycols$V2)
mycols$V2<-gsub("^f","freq",mycols$V2)

#10. Creates a vector with the new descriptions that includes the two prepended columns for subject id and activity label, then applys the new descriptive labels to the extracted.data data set.
newcolnames<-c("SubjectId","Activity")
newcolnames<-append(newcolnames,mycols$V2)
colnames(extracted.data)<-newcolnames

#11.  Requirements Step #5 - create second independent tidy data set with the average of each variable for each activity and each subject.  Uses aggregate command to apply the mean function by aggregate of activity and subject.  This data is then stored in the variable tidy.data after dropping two redundant columns created by the aggregate operation.
aggdata<-aggregate(extracted.data, by=list(Subject=extracted.data$SubjectId,Activity=extracted.data$Activity),FUN="mean")
tidy.data<-subset(aggdata,select=-(3:4)) # drops columns 3 and 4, redundant after aggregate

#12. Write aggregated tidy data out to file in the original working directory.
setwd(workingDir)
write.table(tidy.data,"tidy.data.txt")

