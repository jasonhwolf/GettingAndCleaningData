# ==============================================
#
# This R script cleans up the data obtained here:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# Here are the data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
#
# Here is the process the script follows
# ======================================

# 1) Merges the training and the test sets to create one data set.

    # First download the file and extract it. if it already exists, skip. Delete the temp.zip file when done.
    # Read the feature names into a table, only the feature names
    # Read the training data and assign column names. cBind with subjectID
    # Cleanup variables using rm()
    
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 

    #Need to grab the column names that contain the words "mean" or "std dev", then extract those column names

# 3) Uses descriptive activity names to name the activities in the data set

    # Read the row numes 
    # The row names are all found using "merge" rather than SQL: 
    #       merge(combinedSetY, activities, by.x = "V1", by.y = "V1")$V2
    # Then a new column (column 1) is appended to the dataset:
    # Cleanup variables using rm()
    
# 4) Appropriately labels the data set with descriptive variable names. 

    # (This was done in step 1)


# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each 
#       variable for each activity and each subject.
   
    # change the second column to a factor
    # Create the summary set
    # cleanup dataset names
    # Reset the wd
    # write the output file
    # Output the tidy dataset
