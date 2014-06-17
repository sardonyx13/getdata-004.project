
library('plyr')

ExtractFeatures <- function(root.dir) {
  # Returns features(columns) which are only the measurements on the mean 
  # and standard deviation for each measurement.
  # The function returns features corresponging to tBodyAcc, tGravityAcc 
  # and tBodyGyro. Other features (Jerk, Magnitude or f) are derived(calculated)
  # from tBodyAcc, tGravityAcc and tBodyGyro and don't present a raw data.
  # For instance: 'fBodyAcc-meanFreq()-X' is ignored because fBodyAcc derived
  # from tBodyAcc by FFT.
  #
  # Args:
  #   root.dir: a path to directory that contains source files of database(unzipped 
  #             file from:
  #             https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
  #             A default path is "./UCI HAR Dataset".
  #
  # Returns:
  #   The data.frame with final data. The data frame has columns:
  #     - Number (is a number)
  #     - Description (is a string)
  #
  #   'Description' is a string corresponding to patterns:
  #     - tBodyAcc.mean.XYZ
  #     - tBodyAcc.std.XYZ
  #     - tGravityAcc.mean.XYZ
  #     - tGravityAcc.std.XYZ
  #     - tBodyGyro.mean.XYZ
  #     - tBodyGyro.std.XYZ  
  # 
  # Note: The function does make a special error handling, so if the input directory
  # doesn't exist or doesn't contain required files in required format then no special
  # messages will be provided. Just errors which produced by read.table.
  
  # counstuct a name of file with feature's labels(root.dir/features.txt)
  file.name <- paste(root.dir, "/features.txt", sep = "")
  
  # read a map "Number" => "Description"
  features <- read.table(file.name, col.names = c("Number", "Description"), 
                         stringsAsFactors = FALSE)
  
  # get features which correspond to patterns: 'tBodyAcc-', 'tGravityAcc-'
  # and 'tBodyGyro-'.
  features <- subset(features, grepl("^tBodyAcc\\-|^tGravityAcc\\-|^tBodyGyro\\-",
                     Description))
  
  # get variables which estimated by mean() and std() functions
  features <- subset(features, grepl("mean\\(\\)|std\\(\\)" , Description))
  
  # convert descriptions to format that can be easily used in data.frame column names
  #
  # replace '+' and '-' by '.'
  features$Description <- gsub("[+-]", ".", features$Description)
  
  # remove '(', ')', '[' and ']' at all
  features$Description <- gsub("\\(|\\)|\\[|\\]", "", features$Description)
  features
}

ExtractActivitiesLabels <- function(root.dir) {
  # Read activity labels from "UCI HAR Dataset".
  #
  # Args:
  #   root.dir: a path to directory that contains source files of database(unzipped 
  #             file from:
  #             https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
  #             A default path is "./UCI HAR Dataset".
  #
  # Returns:
  #   The data.frame with columns:
  #     - Activity (is a number)
  #     - Label (is a string)
  #   and columns with names from 'features'(features$Description)
  # 
  # Note: The function does make a special error handling, so if the input directory
  # doesn't exist or doesn't contain required files in required format then no special
  # messages will be provided. Just errors which produced by read.table.
  
  # counstuct a name of file with activitiy's labels(root.dir/activity_labels.txt)
  file.name <- paste(root.dir, "/activity_labels.txt", sep = "")
  
  # read and return a map "Activity" => "Label"
  read.table(file.name, col.names = c("Activity", "Label"), 
             stringsAsFactors = FALSE)  
}

ReadDataByType <- function(root.dir, type, features, activities.labels) {
  # Read measurments corresponding to a specified dataset (test or training)
  #
  # Args:
  #   root.dir: a path to directory that contains source files of database(unzipped 
  #             file from:
  #             https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
  #             A default path is "./UCI HAR Dataset".
  #   type:     a 'test' or 'train' string which identifies a type of dataset that 
  #             should be read
  #   features: a map of 'Number' => 'Description' where 'Number' is a column 
  #             number which should be read from database and 'Description' is 
  #             a name that should be assigned to column in a resulting data frame
  #   activities.labels: a map 'Activity' => 'Label' where 'Activity' is 
  #             an activity id and 'Label' is corresponding acrivity's name. 
  #             'Label' will be used in a resulting data frame instead of 'Activity'.
  #
  # Returns:
  #   The data.frame with final data. The data frame has columns:
  #     - Subject (is a number)
  #     - Activity (is a string)
  #   and columns with names from 'features'(features$Description)
  # 
  # Note: The function does make a special error handling, so if the input directory
  # doesn't exist or doesn't contain required files in required format then no special
  # messages will be provided. Just errors which produced by read.table.
  
  # counstuct a name of file with subject's ids.
  # example: 
  #   - root.dir/subject_test.txt
  #   - root.dir/subject_train.txt
  file.name <- paste(root.dir, "/", type, "/subject_", type, ".txt",sep = "")
  
  subjects <- read.table(file.name, header = FALSE, col.names = c("Subject"))
  
  # counstuct a name of file with activity's ids.
  # example: 
  #   - root.dir/y_test.txt
  #   - root.dir/y_train.txt
  file.name <- paste(root.dir, "/", type, "/y_", type, ".txt",sep = "")

  activities <- read.table(file.name, col.names = c("Activity"))
  
  # convert activity's ids to their labels
	activities <- sapply(activities, function(a) activities.labels$Label[a])

  # counstuct a name of file with measurments.
  # example: 
  #   - root.dir/X_test.txt
  #   - root.dir/X_train.txt
  file.name <- paste(root.dir, "/", type, "/X_", type, ".txt",sep = "")
  
  # read measurments
  data <- read.table(file.name, header = FALSE)
  
  # select required columns only
  data <- data[, features$Number]
  
	colnames(data) <- features$Description

  # combine and return data.frame
	cbind(subjects, activities, data)
}

RunAnalysis <- function(root.dir = "UCI HAR Dataset") {
  # Calculates a tidy data set with the average of each variable for each activity 
  # and each subject from 'Human Activity Recognition database'
  # The data set description can be found here:
  #   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  #
  # Args:
  #   root.dir: a path to directory that contains source files of database(unzipped file from:
  #             https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
  #             A default path is "./UCI HAR Dataset".
  #
  # Returns:
  #   The data.frame with final data. The data frame has columns:
  #     - Subject (is a number)
  #     - Activity (is a string)
  #   and columns with names corresponding to patterns
  #     - tBodyAcc.mean.XYZ
  #     - tBodyAcc.std.XYZ
  #     - tGravityAcc.mean.XYZ
  #     - tGravityAcc.std.XYZ
  #     - tBodyGyro.mean.XYZ
  #     - tBodyGyro.std.XYZ
  # 
  # Note: The function does make a special error handling, so if the input directory
  # doesn't exist or doesn't contain required files in required format then no special
  # messages will be provided. Just errors which produced by read.table.

  # get features which need to be processed
  features <- ExtractFeatures(root.dir)
  
  # get a map of activity's ids to activity's labels
  activities.labels <- ExtractActivitiesLabels(root.dir)
  
  # read and combine 'test' and 'train' measurments
  data <-
    rbind(ReadDataByType(root.dir, "test", features, activities.labels), 
          ReadDataByType(root.dir, "train", features, activities.labels))
  
  # combine all measurments by 'Subject' and 'Activity'. And calulate the average
  # of each feature for each 'Subject' and 'Activity'.
	ddply(data, .(Subject, Activity), numcolwise(mean))
}
