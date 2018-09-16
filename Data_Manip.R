
setwd("C://Users/jdbul/Documents/Github/reimagined-parakeet")
school_profile <- read.csv("Chicago_Public_Schools_-_School_Profile_Information_SY1617.csv")
progress_report <- read.csv("Chicago_Public_Schools_-_School_Progress_Reports_SY1617.csv")
locations <- read.csv("CPS_School_Locations_1617.csv")
crime_16 <- read.csv("Crimes_-_2016.csv")
crime_17 <- read.csv("Crimes_-_2017.csv")
library(plyr)
library(dplyr)


school_data <- locations %>%
                 join(school_profile, type="inner", by="School_ID") %>%
                   join(progress_report, type="inner", by="School_ID")

school_data <- school_data[order(school_data$WARD_15),]

write.csv(school_data, file="total_school_data.csv")
