library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Lab Introduction to Non-parametric Statistical Models"),
  
  hr(),
  
  # Sidebar with a slider input for the number of bins
  fluidRow(
    column(3,
           h3("Mixture of distributions"),
                  
          radioButtons("DisType", h4("Type of Distribution"), 
                  list("Normal" = "norm",
                        "Log-normal" = "lnorm"),
                   selected = "norm"),            
      
          radioButtons("Nmixtures", h4("Number of Mixtures"),
                  list("1" = "M1", 
                    "2" = "M2", "3" = "M3"),
                 selected = "M1"),
                 
          conditionalPanel(
                    condition = "input.Nmixtures == 'M1'",
                    numericInput("Mean1", 
                                 label = h5("Mean component  1"), 
                                 value = 0)),
          conditionalPanel(
                    condition = "input.Nmixtures == 'M2'",
                    numericInput("Mean1", 
                                  label = h5("Mean component 1"), 
                                  value = 0),
                    
                    numericInput("Mean2", 
                                 label = h5("Mean component 2"), 
                                 value = -5)),
          conditionalPanel(
                    condition = "input.Nmixtures == 'M3'",
                    numericInput("Mean1", 
                                  label = h5("Mean component 1"), 
                                  value = 0),
        
                    numericInput("Mean2", 
                                  label = h5("Mean component 2"), 
                                  value = -5),
                    
                    numericInput("Mean3", 
                                  label = h5("Mean component  3"), 
                                  value = 5)),
          sliderInput("n",
                    label = h4("Number of samples"), 
                    min = 10,
                    max = 200,
                    value = 100),
     
          sliderInput("bins",
                    label = h4("Number of histogram's bins"), 
                    min = 1,
                    max = 50,
                    value = 30),
           
          sliderInput("h",
                    label = h4("Bandwidth Kernel estimatior"), 
                    min = 0.1,
                    max = 2,
                    value = 0.5)
    ),
    
    column(8, offset = 1,
           tabsetPanel(
             tabPanel("Histogram", plotOutput("distPlot")), 
             tabPanel("Kernel Estimator", plotOutput("distPlot2"))
           )
    )),
  
  hr(),
  
  fluidRow(
    column(3,
           h2("Kernel Regressor"),
           
           sliderInput("n2",
                       label = h4("Number of samples"), 
                       min = 10,
                       max = 200,
                       value = 100),
           
           sliderInput("h2",
                       label = h4("Bandwidth Kernel estimatior"), 
                       min = 0.1,
                       max = 2,
                       value = 0.5)
    ),
    # Show a plot of the generated distribution
    column(8, offset = 1,
           tabsetPanel(
             tabPanel("Original data", plotOutput("distPlot3")), 
             tabPanel("Kernel Estimator", plotOutput("distPlot4"))
           )
    ) 
  )
))
