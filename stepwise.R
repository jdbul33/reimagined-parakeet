data <- read.csv('C:/Users/jdbul/Documents/GitHub/reimagined-parakeet/sas_ready.csv')

library(dplyr)
library(leaps)

df <- data %>%
        select(-TotalHomicides, -Ward)


null <- lm(TotalCrime ~ 1, data=df)

full <- lm(TotalCrime ~ ., data=df)

step(null, scope=list(lower=null, upper=full), direction="forward")
step(full, data=df, direction="backward")
step(null, scope = list(upper=full), data=df, direction="both")
