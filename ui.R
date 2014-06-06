library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Lab Introduction to Non-parametric Statistical Models"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel( h2("Mixture of distributions"),
                  
      radioButtons("DisType", h3("Type of Distribution"), 
                  list("Normal" = "norm",
                        "Log-normal" = "lnorm"),
                   selected = "norm"),            
      
     radioButtons("Nmixtures", h3("Number of Mixtures"),
                  list("1" = "M1", 
                    "2" = "M2", "3" = "M3"),
                 selected = "M1"),
                 
          conditionalPanel(
                    condition = "input.Nmixtures == 'M1'",
                    numericInput("Mean1", 
                                 label = h4("Mean component  1"), 
                                 value = 0)),
          conditionalPanel(
                    condition = "input.Nmixtures == 'M2'",
                    numericInput("Mean1", 
                                  label = h4("Mean component 1"), 
                                  value = -5),
                    
                    numericInput("Mean2", 
                                 label = h4("Mean component 2"), 
                                 value = 5)),
      
          conditionalPanel(
                    condition = "input.Nmixtures == 'M3'",
                    numericInput("Mean1", 
                     label = h3("Mean component 1"), 
                     value = 1),
        
                    numericInput("Mean2", 
                     label = h3("Mean component 2"), 
                    value = -5),
                    
                    numericInput("Mean3", 
                      label = h3("Mean component  3"), 
                      value = 5)),
     sliderInput("n",
                 label = h3("Number of samples"), 
                 min = 10,
                 max = 200,
                 value = 100),
     
      sliderInput("bins",
                  label = h3("Number of histogram's bins"), 
                  min = 1,
                  max = 50,
                  value = 30),
     sliderInput("h",
                  label = h3("Bandwidth Kernel estimation"), 
                  min = 0.1,
                  max = 2,
                  value = 0.5)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      
      plotOutput("distPlot2"),
      
      plotOutput("distPlot3"),
      
      plotOutput("distPlot4")
      
    )
  )
))
