library(shiny)
library(ISLR); data(Wage)

shinyUI(pageWithSidebar(
        headerPanel("Wage Calculator"),
      
        sidebarPanel(
                h3('Choose Parameters:'),
        
                sliderInput("age", 
                            "Age (18-80)", 
                            min = 18,
                            max = 80, 
                            value = 33),
                
                #radioButtons("sex", "Sex:", as.list(levels(Wage$sex))),
                selectInput("maritl", "Marital Status:", choices = levels(Wage$maritl)),
                selectInput("race", "Race:", choices = levels(Wage$race)),
                selectInput("education", "Education:", choices = levels(Wage$education)),
                selectInput("jobclass", "Job Class:", choices = levels(Wage$jobclass)),
                selectInput("health", "Health State:", choices = levels(Wage$health)),
                radioButtons("health_ins", "Health Insurance:", as.list(levels(Wage$health_ins)))
        ),
        
        mainPanel(
                  tabsetPanel(
                        tabPanel("Wage Prediction", 
                                h3("Selected Age:"),
                                verbatimTextOutput("age"),
                                h3("Recommended Salary:"),
                                verbatimTextOutput("salary"),
                                h3("Wage per Age for Selected Parameters:"),
                                plotOutput("img")

                        ), 
                        
                        tabPanel("Data", dataTableOutput('data')),
                        tabPanel("Documentation", includeMarkdown("documentation.md"))
                        
                )
                
        )
))