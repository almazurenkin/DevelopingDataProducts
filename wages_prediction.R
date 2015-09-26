library(ISLR); data(Wage)
library(ggplot2)
library(caret)

#Wage <- Wage[ , names(Wage) != "logwage" & names(Wage) != "region"]
Wage <<- Wage[ , names(Wage) != "logwage" & names(Wage) != "region" & names(Wage) != "year"]

index.training <- createDataPartition(y = Wage$wage, p = 0.75, list = F)

wage.training <- Wage[index.training, ]  # training subset
wage.validation <- Wage[-index.training, ]  # validation subset

model1 <- train(wage ~ ., method = "gbm", data = wage.training, verbose = F)
model2 <- train(wage ~ ., method = "glm", data = wage.training)
model3 <- train(wage ~ ., method = "lm", data = wage.training)

pr1 <- predict(model1, newdata = wage.validation)
pr2 <- predict(model2, newdata = wage.validation)
pr3 <- predict(model3, newdata = wage.validation)

qplot(pr1, pr2, colour = wage, data = wage.validation)
qplot(wage.validation$wage, pr3, colour = wage, data = wage.validation)

sqrt(sum((pr1 - wage.validation$wage)^2))/length(pr1)
sqrt(sum((pr2 - wage.validation$wage)^2))/length(pr1)
sqrt(sum((pr3 - wage.validation$wage)^2))/length(pr1)

age <- 18:80
buffer <- data.frame()
for (i in age) {
        row <- data.frame(##'year' = 2007, 
                        'age' = i,
                        'sex' = as.factor('1. Male'),
                        'maritl' = as.factor('2. Married'),
                        'race' = as.factor('1. White'),
                        'education'  = as.factor('1. < HS Grad'), # 1. < HS Grad /' 5. Advanced Degree
                        'jobclass' = as.factor('2. Information'),
                        'health' = as.factor('2. >=Very Good'),
                        'health_ins' = as.factor('1. Yes'))
        
        buffer <- rbind(buffer, row)
}

wage.prediction <- predict(model1, newdata = buffer)

img <- qplot(age, wage.prediction, geom = 'smooth', method = "loess", span = 0.33, xlab = "Age", ylab = "Wage")
img + geom_vline(xintercept = 33)