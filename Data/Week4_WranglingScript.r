# Title: Week 4 Data Wrangling
# Author: Kalle Kivinen
# Date: 20.11.2020


# 2. Read in the data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# 3. Dimensions, Structures, and Summaries 
# The hd-dataset contains 195 observations in eight variables, which map national data related to human development.
# The gii-dataset contains 195 observations in 10 variables, which map national gender-equality related data.
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

# 4. Renaming
# hd
colnames(hd)[1] <- "HDI.Rank" # Remains the same, since already short
colnames(hd)[2] <- "Country" #Remains the same, since already short
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "Life.Expectancy"
colnames(hd)[5] <- "Education.Years"
colnames(hd)[6] <- "Mean.Educaction.Length"
colnames(hd)[7] <- "GNI.per.Capita"
colnames(hd)[8] <- "GNI.Rank-HDI.Rank"

#gii
colnames(gii)[1] <- "GII.Rank" # Remains the same, since already short
colnames(gii)[2] <- "Country" #Remains the same, since already short
colnames(gii)[3] <- "Gender.Inequality"
colnames(gii)[4] <- "Maternal.Mortality"
colnames(gii)[5] <- "Teen.Birth"
colnames(gii)[6] <- "Parliamentary.Participation"
colnames(gii)[7] <- "Female.Secondary.Education"
colnames(gii)[8] <- "Male.Secondary.Education"
colnames(gii)[9] <- "Female.Work"
colnames(gii)[10] <- "Male.Work"

# Mutate the Data
library(dplyr)
library(ggplot2)

gii <- mutate(gii, Fem_Male.EducationRatio = (Female.Secondary.Education/Male.Secondary.Education))
gii <- mutate(gii, Fem_Male.WorkRatio = (Female.Work/Male.Work))
summary(gii)

# Join together
human <- inner_join(hd, gii, by = "Country")
str(human)
setwd("/Users/kallekivinen/Desktop/IODS-project/Data")
write.table(human, file = "Human", sep = "\t")
test_week4 <- read.table("Human", header = TRUE, sep = "\t")
dim(test_week4)
str(test_week4)
summary(test_week4)

# Everything works!

