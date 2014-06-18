Description
==================
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


How To Use
==================
