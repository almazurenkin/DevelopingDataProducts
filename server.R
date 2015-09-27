library(shiny)
library(markdown)
library(ISLR)
library(ggplot2)
library(RcppEigen)
library(caret)
       
# Below code build pregiction model using Generalized Boosted Regression Models
# algorythm based on Wage data from ISLR R package.
# Note that Shiny run this code once when application starts.

data(Wage)
Wage <- Wage[ , names(Wage) != "logwage" & names(Wage) != "region" & names(Wage) != "year" & names(Wage) != "sex"]
age.range <- seq(min(Wage$age), max(Wage$age), 1)        

index.training <- createDataPartition(y = Wage$wage, p = 0.75, list = F)
        
wage.training <- Wage[index.training, ]  # training subset
wage.validation <- Wage[-index.training, ]  # validation subset
        
# model1 <- train(wage ~ ., method = "gbm", data = wage.training)
# saveRDS(model1, "model.rds")  # Performance improvememnt mewasure: we once built a model and serialized it into "model.rds" file
model1 <- readRDS("model.rds")  # Now instead of building a model each time, we just read it from "model.rds"

# model2 <- train(wage ~ ., method = "glm", data = wage.training, verbose = F)
# model3 <- train(wage ~ ., method = "lm", data = wage.training)

shinyServer(        
        function(input, output) {
                
                # This reactive function is building prediction based on selected
                # input parameters and is used to render output for multiple controls.
                processor <- reactive({

                        buffer <- data.frame()
                        for (i in age.range) {
                                row <- data.frame( 
                                        'age' = i,
                                        #'sex' = as.factor(input$sex),
                                        'maritl' = as.factor(input$maritl),
                                        'race' = as.factor(input$race),
                                        'education'  = as.factor(input$education),
                                        'jobclass' = as.factor(input$jobclass),
                                        'health' = as.factor(input$health),
                                        'health_ins' = as.factor(input$health_ins))
                                
                                buffer <- rbind(buffer, row)
                        }
                        
                        predict(model1, newdata = buffer)      
                })        
                
                
                output$age <- renderText({input$age})
                
                output$img <- renderPlot({
                        
                        wage.prediction <- processor()
                         
                        img <- qplot(age.range, wage.prediction, geom = 'smooth', method = "loess", span = 0.33, xlab = "Age", ylab = "Wage")
                        img + geom_vline(xintercept = input$age)       
                                                
                })
                
                output$salary <- renderText({
                        wage.prediction <- processor()
                        wage.prediction[input$age-min(Wage$age)+1]
                })
                
                output$data = renderDataTable({
                        Wage
                })
                
        }
)