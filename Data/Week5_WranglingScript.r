# Week 5 Data Wrangling - "Human"-dataset
# Author: Kalle Kivinen
# Date: 24.11.2020

# Source of the Original Data: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

# Libraries
library(dplyr)

# Step 0: Load the Data into R and describe it
getwd()
setwd("/Users/kallekivinen/Desktop/IODS-project/Data")
Human <- read.table("Human", header = TRUE, sep = "\t",stringsAsFactors=FALSE)
dim(Human)
str(Human)
summary(Human)
# The set contains observations on 19 variables collected from 195 countries.
# The variables measure development and gender equality in these countries.
# HDI.Rank refers to the relative ranking of a country compared to the other 194 countries in terms of human development
# HDI is the score (ranging from 0 to 1) on which the above ranking is based
# Life.Expectancy refers to a citizens average life expectancy at birth
# Education.Years is the amount of years a citizen is planned to spend in education
# Mean.Education.Length is the average of the actual amount of years spent in education
# GNI.Per.Capita is the Gross National INcome adjusted for population
# GNI.Rank.HDI.Rank is the result of deducting the HDI-rank from the GNI-rank
# GII.Rank refers to the relative ranking of a country compared to the other 194 countries in terms of gender equality
# Gender.Inequality is the score acting as the basis of the above measure, where 0 denotes equality and 1 inequality
# Maternal.Mortality is a ratio of deaths per 100,000 births
# Teen.Birth is the number of births per 1,000 women ages 15 to 19.
# Parliamentary.Participation is the ratio of women to men in parliament
# Female.Secondary.Education is the percentage of females that attend secondary education
# Male.Secondary.Education is the percentage of males that attend secondary education
# Female.Work is the percentage of females that participate in the labour force
# Male.Work is the percentage of males that participate in the labour force
# Fem_Male.EducationRatio is the ratio of women to men that have completed secondary education
# Fem_Male.WorkRatio is the ratio of women to men that participate in the labour force.

# Step 1. Transform GNI into a numeric variable
Human$GNI.per.Capita
Human$GNI.per.Capita<-as.numeric(gsub(",","",Human$GNI.per.Capita))
Human$GNI.per.Capita
summary(Human)
Human$GNI.per.Capita

# Step 2. Exclude Unneeded Variables
retain <- c("Country", "Female.Secondary.Education", "Female.Work", "Life.Expectancy", "Education.Years", "GNI.per.Capita", "Maternal.Mortality", "Teen.Birth", "Parliamentary.Participation")
Human <- select(Human, one_of(retain))

# Step 3. Remove Rows With Missing Variables
data.frame(Human[-1], Complete = complete.cases(Human))
Human_Complete <- filter(Human, complete.cases(Human) == TRUE)
data.frame(Human_Complete[-1], Complete = complete.cases(Human_Complete))

# Step 4. Remove the observations which relate to regions instead of countries
tail(Human_Complete, 10)
Regions <- nrow(Human_Complete) - 7
Human_Complete <- Human_Complete[1:Regions, ]

# Step 5. Name Rows After Countries, Remove Country-Row
rownames(Human_Complete) <- Human_Complete$Country
Human_Complete <- select(Human_Complete, -Country)
Human_Complete
str(Human_Complete)

# SAVE - Created a new file
setwd("/Users/kallekivinen/Desktop/IODS-project/Data")
write.table(Human_Complete, file = "Human_Complete", sep = "\t", row.names = TRUE)
Human2.0 <- read.table("Human_Complete", header = TRUE, sep = "\t")
str(Human2.0)


