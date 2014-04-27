# Code Book

## Input

Human Activity Recognition Using Smartphones

([zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip),
[info](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones))

The dataset contains information about an experiment with a group of 30 persons where "Each person 
performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist".

The original dataset has 10299 instances with 561 attributes and is divided into 2 groups: 

* training data with 70% of subjects
* test data which has 30% of subjects.  

Each data set is divided in 3 files. 

* X_(train/test).txt includes all observations. It has 561 columns which are separated by whitespace.
* y_(train/test).txt includes the decoded six activites. It has 1 column.
* subject_(train/test).txt includes each person. There is only 1 column.

There are two files describing the attributes (features.txt) and the activity names (activity_labels.txt)

## Output

The tidy dataset contains 180 observations (30 subjects * 6 activities) and has 68 variables:

 * Subject identifies the person by id.
 * Activity_Name: identifies the activity that is performed.
 * 66 variables identifying the mean of the measured variables.

## Transformation

Each step of transformation can be seen as it is stored in a new variable.

Step 1.1 & 1.2: The original datasets are loaded into the variables:

* testDataset_X
* testDataset_Y
* testDataset_Subject
* trainDataset_X
* trainDataset_Y
* trainDataset_Subject

Step 1.3: The describing activity names and subjects are loaded into the variables:

* columnames_X
* activity_Names

Step 1.4: The variable "activity_Names" has 2 columns which match the id of an activity to the 
activity name. Because the function that matches ids to the activity names in the dataset needs 
it in a certain format the id (activity_Names$V1) is transformed into factor and the names
(activity_Names$V2) is transformed into character.

Step 1.5: The column Names of the datsets are named meaningful. For the X-datasets the variable
"columnnames_X" is used.

Step 1.6 & 1.7: The X,Y and Subject variables for the test - and training dataset are merged together and stored into the variables "testDataset" and "trainDataset".

Step 1.8: Both datasets are merged into one dataset "Dataset"

Step 2.2: Only the necessary columns are extracted and stored into the dataset "Dataset_Extracted". Therefore a regular expression is used which identifies the column names like "mean()", "std()", "Subject" and 
"Activity_Code".

Step 3.2: The function "mapvalue" is used to decode the activity codes (Dataset_Extracted$Activity_Code) 
into proper activity names and the dataset is stored as "Dataset_Activity_Names". In the next step the
column name is changed to Activity_Name.

Step 4.1: The dataset is "melted" and stored into the variavle "Dataset_Melt". The dataset has now
4 columns, where two columns are for the two ids "subject" and "Activity_Name". One column has each of the 66 variable types and there is a column for the values of those variables.

Step 4.2: The molten dataset is then transformed into the final format of the tidy dataset and stored into the 
variable "Tidy_Dataset".