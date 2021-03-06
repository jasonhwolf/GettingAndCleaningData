# Full description of data:
#       http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# Here are the data for the project: 
#       https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# 1) Merges the training and the test sets to create one data set.

    require(plyr)
    
    setwd("C:/Users/jwolf/Documents/workingDirectory")

    # First download the file and extract it. if it already exists, skip. Delete the temp.zip file when done.
    if(!file.exists("UCI HAR Dataset")) {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "temp.zip")
        unzip("temp.zip")
        unlink("temp.zip")
    }

    setwd("UCI HAR Dataset")

    # Read the feature names into a table, only the feature names
    features <- read.table("features.txt", colClasses = c("NULL", NA), strip.white = TRUE, stringsAsFactors = FALSE)
    
    # Read the training data and assign column names. cBind with subjectID
    testSet <- cbind(read.table("test/subject_test.txt", col.names = "SubjectID")
                     ,read.table("test/X_test.txt", col.names = features[,1]))
    trainingSet <- cbind(read.table("train/subject_train.txt", col.names = "SubjectID")
                         ,read.table("train/X_train.txt", col.names = features[,1]))
    combinedSet <- rbind(testSet,trainingSet)
    
    # Cleanup
    rm(trainingSet,testSet,features)
    
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 

    #Need to grab the column names that contain the words "mean" or "std dev", then extract those column names
    combinedSet <- cbind(
            combinedSet$SubjectID
            , combinedSet[ ,grepl("mean",names(combinedSet))]
            , combinedSet[ ,grepl("std",names(combinedSet))]
        )

# 3) Uses descriptive activity names to name the activities in the data set

    # Read the row numes 
    activities <- read.table("activity_labels.txt", strip.white = TRUE, stringsAsFactors = FALSE)
    testSet <- read.table("test/y_test.txt")
    trainingSet <- read.table("train/y_train.txt")
    combinedSetY <- rbind(testSet,trainingSet)
    
    # The row names are all found using "merge" rather than SQL: 
    #       merge(combinedSetY, activities, by.x = "V1", by.y = "V1")$V2
    # Then a new column (column 1) is appended to the dataset:
    combinedSet <-  as.data.frame(
        append(
            combinedSet
            , list(activityName = merge(combinedSetY, activities, by.x = "V1", by.y = "V1")$V2)
            , after = 0)
        )
    names(combinedSet)[2] <- "subjectID"
    
    # Cleanup
    rm(trainingSet,testSet,activities,combinedSetY)
    

# 4) Appropriately labels the data set with descriptive variable names. 

    # This was done in step 1


# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each 
#       variable for each activity and each subject.
   
    # change the second column to a factor
    combinedSet$subjectID  <- as.factor(combinedSet$subjectID)
    
    # Create the summary set
    summarySet <- aggregate(combinedSet[,3:81], list(combinedSet$activityName,combinedSet$subjectID), mean)
    
    #cleanup dataset names
    names(summarySet)[1:2] <- c("activity","subjectID")
    
    # Reset the wd
    setwd("..")
    
    # write the output file
    write.table(summarySet, file = "summarySet.txt")
    
    # Output the tidy dataset
    summarySet
    
