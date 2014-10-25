# Code Book

## Data source

The data source is: `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`
For further information, please read the `README.txt` file from the data source.

## Variables

All column names are described in README.txt from the data source file, except for the following columns that were added:

* subjectnumber: string that corresponds to the subject of the experiment
* activity: string that represents the activity of the subject while collecting data points

# Output

* average_data.txt: a space-delimited value file that contains tidy data set with the average of each variable for each activity and each subject