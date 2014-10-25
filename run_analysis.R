# You should create one R script called run_analysis.R that does the following. 
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.

# plyr is needed to run the script
library(plyr)

# change me if needed - this folder is created when unzipping data source into the repo
dataFolder = "UCI HAR Dataset/"
getFilePath <- function(filepath) {
    paste(dataFolder, filepath, sep="")
}

# 1. Merge training and the test sets
X_train <- read.table(getFilePath("train/X_train.txt"))
X_test <- read.table(getFilePath("test/X_test.txt"))
X <- rbind(X_train, X_test)


Y_train <- read.table(getFilePath("train/y_train.txt"))
Y_test <- read.table(getFilePath("test/y_test.txt"))
Y <- rbind(Y_train, Y_test)

subject_train <- read.table(getFilePath("train/subject_train.txt"))
subject_test <- read.table(getFilePath("test/subject_test.txt"))
subject_data <- rbind(subject_train, subject_test)

# 2. Extract only the measurements on the mean and standard deviation
features <- read.table(getFilePath("features.txt"))
mean_and_std_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, mean_and_std_features]
names(X) <- features[mean_and_std_features, 2]
)
# 3. Descriptive activity names
activities <- read.table(getFilePath("activity_labels.txt"))
Y[, 1] <- activities[Y[, 1], 2]
# correct column name
names(Y) <- "activity"

# 4. Name subject data
names(subject_data) <- "subjectnumber"
# Then: Time to merge everthing together and save into a file: X, Y, subject_data
result <- cbind(subject_data, Y, X)

# 5. Create a 2nd data set
excludedColumns = which(names(result) %in% c("subjectnumber", "activity"))
result <- ddply(result, .(subjectnumber, activity), .fun=function(x){ colMeans(x[,-excludedColumns]) })
write.table(result, "average_data.txt", row.name=FALSE)