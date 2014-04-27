# Getting and Cleaning Data project

This readme gives an overview of the project structure and the scripts.

## Script

### `run_analysis.R`

The script can be used to convert the Samsung dataset into a tiny data set. The script is divided into 4 parts:

* Step 1: Reading all datasources from the raw files and merge them into one dataset.
* Step 2: Extracting only the measurements on the mean and standard deviation for each measurement.
* Step 3: Using descriptive activity names to name the activities in the data set.
* Step 4: Creating a second, independent tidy data set with the average of each variable for each activity and each subject. 

Prerequisites:

* The dataset is already extracted in your working directory.
* The R packages [plyr] and [reshape2] are installed before the script is started. You can get them here:

* http://cran.r-project.org/web/packages/reshape2/index.html and
* http://cran.r-project.org/web/packages/plyr/index.html

## Code book

You can find the codeBook in the file `CodeBook.md` . It describes in detail the variables, datasets and transformations that have been made in every step.