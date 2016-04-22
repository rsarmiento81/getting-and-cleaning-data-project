# getting-and-cleaning-data-project
This repo contains the run_analysis.R script, CodeBook.md and README.md for the Getting and Cleaning Data project

run_analysis.R is an R script which merges the required data from the zipped file located here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and performs a series of transformations to make the data more readable.

For the script to work, the run_analysis.R file should be stored in a folder with the data extracted from the zip file
When working with this data, I extracted the zip file to a folder called UCI HAR Dataset and ran run_analysis.R from the root of this
directory.
The script will read selected files from the test and train subdirectories

The codebook file "CodeBook.md" in this repo contains information about the variables of the tidy data set and transformations used to obtain the final tidy data set

