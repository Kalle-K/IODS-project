

library(dplyr)
library(tidyr)

# 1. Read the data into R and Examine it:
BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep=" ", header = TRUE, stringsAsFactors = TRUE)
RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep="\t", header = TRUE, stringsAsFactors = TRUE)

str(BPRS) # Observations spanning from week 0 to week 8, and covering 40 subjects divided into two groups.
summary(BPRS)
BPRS$subject
str(RATS) # Observations spanning eleven days, spanning 16 subjects in three groups. 
summary(RATS)
RATS$ID

# 2. Converting Categorical Variables Into Factors.
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# 3. Converting Datasets to Long Form and Adding the Week and TIme Variables.
BP_Long <- gather(BPRS, key = weeks, value = bprs, -treatment, -subject)
RAT_Long <- gather(RATS, key = WD, value = Weight, -ID, -Group)

BP_Long <-  mutate(BP_Long, week = as.integer(substr(weeks, 5, 5)))
RAT_Long <- mutate(RAT_Long, Time = as.integer(substr(WD, 3, 4))) 

# 4. Taking a SERIOUS Look at the Data
str(BP_Long) 
summary(BP_Long)
head(BP_Long)

str(RAT_Long) 
summary(RAT_Long)
head(RAT_Long)

  # The difference between long and wide form data is clear: 
  # Whereas with the wide form data each subject is treated as having 
  # various measures (Scores/weights) in different variables (weeks),
  # with the long form data, each subject-at-specific-time only has one
  # time specific measurement of score or weight. As each subject must be 
  # included in the data as many times as there are time-periods when 
  # measurements were taken, it consequently means that the dataset gets
  # quite literally "longer." Accordingly, in the long-form data we have
  # time-specific subject-measurement pairings, whereas with the wide-form 
  # data, subjects take a variety of measurements represented by the 
  # time-specifying variables.



# 5. Saving...
getwd()
setwd("/Users/kallekivinen/Desktop/IODS-project/Data")
write.csv(BPRS, file = "BPRS")
write.csv(RATS, file = "RATS")
write.csv(BP_Long, file = "BP_Long")
write.csv(RAT_Long, file = "RAT_Long")


