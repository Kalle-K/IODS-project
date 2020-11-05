# This is the week 1 data wrangling file
# Author: Kalle Kivinen
# Date: 5.11.2020

install.packages("dbplyr")
library(dplyr)

# Reading the data into R (1 point)
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header = TRUE, sep="\t")
str(learning2014) # While this is an extensive list of the varibales with certain indicative observations included, it tells me little without a key to interpret the variable names.
dim(learning2014) # This tells me that there are 183 observations per 60 variables, or in other words, 183 people have answered a survey of 60 questions.

# Creating an analysis dataset (1 point)
# Starting by creating the mean columns of attitude, deep, stra, and surf questions. 
# According to the reference dataset, questions measuring attitude are Da, Db, Dc, Dd, De, Df, Dg, Dh, Di, Dj.
# Consequently,
attitude_questions <- c("Da", "Db", "Dc", "Dd", "De", "Df", "Dg", "Dh", "Di", "Dj")
attitude_columns <- select(learning2014, one_of(attitude_questions))
learning2014$attit <- rowMeans(attitude_columns)

# The process is similar for the remainder of columns.
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$strat <- rowMeans(strategic_columns)

# Creating a new dataset by only retaining the above, new meamn columns together with "gender," "Age," and "Points." 
retain_data <- c("Age", "gender", "attit", "deep", "surf", "strat", "Points")
Learn2014 <- select(learning2014, one_of(retain_data))

# Removing values below "0" and exploring the final dataset
Learn2014 <- filter(Learn2014, Points > 0)
Learn2014
str(Learn2014)
dim(Learn2014)

# Creating a .txt file from the newly created "Learn2014"-dataframe. (3 points)
getwd()
setwd("/Users/kallekivinen/Desktop/IODS-project/Data")
?write.table
write.table(Learn2014, file = "Learn2014", sep = "\t")
test_week2 <- read.table("Learn2014", header = TRUE, sep = "\t")
dim(test_week2)
str(test_week2)
# Everything works!