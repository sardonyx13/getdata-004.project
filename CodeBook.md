Intro
=====================

A **getdata-004.project** produces a dataset based on **Human Activity Recognition Using Smartphones Data Set** (HAR dataset). For more information see [link]( http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The resulting data contains a tidy data set with the average of the selected mesurments for each activity and each subject. 

Dataset description
=====================

- Subject

    The volunteer id. It's a number from [1..30].

- Activity

    One of six activities is performed by each person:
      - WALKING
      - WALKING_UPSTAIRS
      - WALKING_DOWNSTAIRS
      - SITTING
      - STANDING
      - LAYING 

- tBodyAcc.mean.X
 
    The average value of all 'tBodyAcc-mean()-X' from HAR dataset for corresponding Subject:Activity pair

- tBodyAcc.mean.Y 
  
    The average value of all 'tBodyAcc-mean()-Y' from HAR dataset for corresponding Subject:Activity pair

- tBodyAcc.mean.Z 
 
    The average value of all 'tBodyAcc-mean()-Z' from HAR dataset for corresponding Subject:Activity pair

- tBodyAcc.std.X 
 
    The average value of all 'tBodyAcc-std()-X' from HAR dataset for corresponding Subject:Activity pair

- tBodyAcc.std.Y 
 
    The average value of all 'tBodyAcc-std()-Y' from HAR dataset for corresponding Subject:Activity pair

- tBodyAcc.std.Z 
 
    The average value of all 'tBodyAcc-std()-Z' from HAR dataset for corresponding Subject:Activity pair

- tGravityAcc.mean.X 
 
    The average value of all 'tGravityAcc-mean()-X' from HAR dataset for corresponding Subject:Activity pair

- tGravityAcc.mean.Y 
 
    The average value of all 'tGravityAcc-mean()-Y' from HAR dataset for corresponding Subject:Activity pair

- tGravityAcc.mean.Z 
 
    The average value of all 'tGravityAcc-mean()-Z' from HAR dataset for corresponding Subject:Activity pair

- tGravityAcc.std.X 
 
    The average value of all 'tGravityAcc-std()-X' from HAR dataset for corresponding Subject:Activity pair

- tGravityAcc.std.Y 
 
    The average value of all 'tGravityAcc-std()-Y' from HAR dataset for corresponding Subject:Activity pair

- tGravityAcc.std.Z 
 
    The average value of all 'tGravityAcc-std()-Z' from HAR dataset for corresponding Subject:Activity pair

- tBodyGyro.mean.X 
 
    The average value of all 'tBodyGyro-mean()-X' from HAR dataset for corresponding Subject:Activity pair

- tBodyGyro.mean.Y 
 
    The average value of all 'tBodyGyro-mean()-Y' from HAR dataset for corresponding Subject:Activity pair

- tBodyGyro.mean.Z 
 
    The average value of all 'tBodyGyro-mean()-Z' from HAR dataset for corresponding Subject:Activity pair

- tBodyGyro.std.X 
 
    The average value of all 'tBodyGyro-std()-X' from HAR dataset for corresponding Subject:Activity pair

- tBodyGyro.std.Y 
 
    The average value of all 'tBodyGyro-std()-Y' from HAR dataset for corresponding Subject:Activity pair

- tBodyGyro.std.Z
 
    The average value of all 'tBodyGyro-std()-Z' from HAR dataset for corresponding Subject:Activity pair

Notes
=====================
We process varibles from HAR dataset which based on real measurments(std and mean functions calculated on raw data). Variables with prefixies:
- tBodyAcc-
- tGravityAcc- 
- tBodyGyro- 

Other variables (xxxJerk-, xxxMag- or fXXX) are derived(calculated) from corresponding tBodyAcc-, tGravityAcc- and tBodyGyro- and don't present a raw data. For instance: 'fBodyAcc-meanFreq()-X' is ignored because fBodyAcc derived from tBodyAcc by FFT.

Data Transformation Steps
-------------------------
The following steps done for gettint resulting dataset from HAR dataset:
1.  dataset from 'test/X_test.txt' combined with 'test/Y_test.txt' and 'test/subject_test.txt'
   
        So now we have one dataset with relations person => activity => measurement

2.  select variables which will be processed then 

3.  dataset from 'train/X_test.txt' combined with 'train/Y_test.txt' and 'tran/subject_test.txt'
   
        So now we have one dataset with relations person => activity => measurement

4.  select variables which will be processed then 
5.  combine both datasets
6.  calculate average for each numerical variable grouped by Subject, Activity
