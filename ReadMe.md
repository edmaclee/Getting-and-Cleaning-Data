# ReadMe:
run_analysis.R file merges the training and test set to create one data set. It does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# The following details how to run the run_analysis.R file:
Require ```reshapre2``` and ```data.table``` librareis.
Load both test and train data
Load the features and activity labels.
Extract the mean and standard deviation column names and data.
Process the data. There are two parts processing test and train data respectively.