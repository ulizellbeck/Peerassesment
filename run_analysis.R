## Setting Working directory

##setwd("/media/tko/44C0B556C0B54F44/data_scientist/coursera/courses//03_GettingData//assignment")

## Install packages (if neccessary)

## install.packages("plyr")
## install.packages("reshape2")

library(plyr)
library(reshape2)

# Merges the training and the test sets to create one data set.

# Step 1: Read all datasources from files 

# Step 1.1: Read all test files
testDataset_X <- read.table("data/UCI HAR Dataset/test/X_test.txt")
testDataset_Y <- read.table("data/UCI HAR Dataset/test/y_test.txt")
testDataset_Subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")

# Step 1.2: Read all training files
trainDataset_X <- read.table("data/UCI HAR Dataset/train/X_train.txt")
trainDataset_Y <- read.table("data/UCI HAR Dataset/train/y_train.txt")
trainDataset_Subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")

# Step 1.3: Read all describing variables
columnames_X <- read.table("data/UCI HAR Dataset/features.txt")
activity_Names <- read.table("data/UCI HAR Dataset/activity_labels.txt")

# Step 1.4: Transform activity Names into characters
activity_Names$V1 <- as.factor(activity_Names$V1)
activity_Names$V2 <- as.character(activity_Names$V2)

# Step 1.5: Use meaningful column headers
names(testDataset_X) <- columnames_X$V2
names(testDataset_Y) <- "Activity_Code"
names(testDataset_Subject) <- "Subject"

names(trainDataset_X) <- columnames_X$V2
names(trainDataset_Y) <- "Activity_Code"
names(trainDataset_Subject) <- "Subject"

# Step 1.6: Create a testDataset with the subject, activity and the variables
testDataset <- cbind(testDataset_Subject,testDataset_Y,testDataset_X)

# Step 1.7: Create a trainingDataset with the subject, activity and the variables
trainDataset <- cbind(trainDataset_Subject,trainDataset_Y,trainDataset_X)

# Step 1.8: Merge both datasets
Dataset <- rbind(testDataset,trainDataset)
  
# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

# Step 2.1: Setting a regular expression to extract the right column names. 
# \\ is used as escape parameter
ptn <- "mean\\(\\)|std\\(\\)|Subject|Activity_Code"

# Step 2.2: Create a new dataset "Dataset_Extracted" with only the measurements that
# have the column names like "mean()", "std()", "Subject" and "Activity_Code"

Dataset_Extracted <- Dataset[grepl(ptn,names(Dataset_Sample))]

# Step 3: Uses descriptive activity names to name the activities in the data set

# Step 3.1: Create a new dataset "Dataset_Activity_Names" as a copy from the last one.
Dataset_Activity_Names <- Dataset_Extracted

# Step 3.2: Using the command "mapvalues" the numbers in the column Activity_Code can be
# decoded.
Dataset_Activity_Names$Activity_Code <- mapvalues(Dataset_Activity_Names$Activity_Code, from = activity_Names$V1, to = activity_Names$V2)

# Step 3.3: Change Column name to "Activity_Name"
colnames(Dataset_Activity_Names)[2] <- "Activity_Name"

# Step 4: Creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject. 

# Step 4.1: The Dataset is being melted. The ids are "Subject" and "Activity_Name"
Dataset_Melt <- melt(Dataset_Activity_Names,id=c("Subject","Activity_Name"))

# Step 4.2: Bring the dataset into a readable format
Tidy_Dataset <- dcast(Dataset_Melt,Subject + Activity_Name ~ variable,mean)

# Step 4.3: Write the dataset into the file "tidy_dataset.txt"
write.table(Tidy_Dataset, "tidy_dataset.txt", row.names = FALSE)
