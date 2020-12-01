#Script to Wrangle the Week 3 Data on Student Alcohol Consumption

#Author: Kalle Kivinen
#Date: 12.11.2020
#Data from https://archive.ics.uci.edu/ml/datasets/Student+Performance

#The formalities
getwd()
setwd("/Users/kallekivinen/Desktop/IODS-project/Data")

library(dplyr)
library(ggplot2)
library(GGally)

# Reading the data into R...
mat <- read.csv("student-mat.csv", header = TRUE, sep = ";")
por <- read.csv("student-por.csv", header = TRUE, sep = ";")

# ... and exploring it.
dim(mat)
str(mat)
dim(por)
str(por)
# The datasets are contain the same 33 variables. The "mat"-set, relating to mathematics students,
# has less answers/values per variable than the "por"-set, which relates to the students of Portuguese. 
# That is 395 answers per variable in the "mat"-set in comparison to 649 answers per variable in the 
# "por"-set.

# Combining the "mat" and "por" datasets into a single set.
# First create a set of variables by which to combine the data:

joining <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# using the inner.join()-function to only retain the students who have provided data on the "joining"-variables

combined <- inner_join(mat, por, by = joining)
dim(combined)
str(combined)
# Interestingly enough, after combining the 395 observations in the "mat"-set 
# to the 649 observatiions in the "por"-set, but specifying 13 variables
# where answers are required, we are left with only 382 observations and
# several dublicate variables.

# Shamelessly copy the solution to the dublicate variables from datacamp, 
# since the instructions allow that.

TheData <- select(combined, one_of(joining))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% joining]

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(combined, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    TheData[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    TheData[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(TheData)

# Combining weekday and weekend alcohol use as an average into a new variable.
TheData <- mutate(TheData, alc_use = (Dalc + Walc) / 2)

# Creating a new variable which divides students into those whose alcohol use
# is higher than two (TRUE) and those whose alcohol use is less (FALSE)
TheData <- mutate(TheData, alcoholics = alc_use > 2)

# Checking that everything functioned.
checking <- ggplot(data = TheData, aes(x = alc_use))
checking + geom_bar()
checkcheck <- ggplot(data = TheData, aes(x = alcoholics))
checkcheck + geom_bar()
glimpse(TheData)
# Everything functions!

# Saving...
write.table(TheData, file = "ThirstyStudents", sep = "\t")
test_week3 <- read.table("ThirstyStudents", header = TRUE, sep = "\t")
glimpse(test_week3)
# Saving complete!



