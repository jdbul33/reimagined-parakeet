data <- read.csv('C:/Users/jdbul/Documents/GitHub/reimagined-parakeet/sas_ready.csv')

library(dplyr)
library(leaps)
library(GGally)
library(caret)

df <- data %>%
        select(-Ward)


corr_mat <- round(cor(df),2)
ggpairs(df)




null <- lm(TotalHomicides ~ 1, data=df)

full <- lm(TotalHomicides ~ ., data=df)



answer3 <- step(null, scope=list(lower=null, upper=full), direction="forward")
answer2 <- step(full, data=df, direction="backward")
answer <- step(null, scope = list(upper=full), data=df, direction="both")
answer2
answer
answer3
