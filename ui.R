library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Introduction to Non-parametric Statistical Models"),
  
  hr(),
  
  
  fluidRow(
    column(3,
           h3("Mixture of distributions"),
           # RadioButton to select the type of distribution in the pdf exercise
           radioButtons("DisType", h4("Type of Distribution"),
                        list("Normal" = "norm",
                             "Log-normal" = "lnorm"),
                        selected = "norm"),
           
           radioButtons("Nmixtures", h4("Number of Mixtures"),
                        list("1" = "M1",
                             "2" = "M2", "3" = "M3"),
                        selected = "M1"),
           # Aditional panels depending on the number of mixture components
           conditionalPanel(
             condition = "input.Nmixtures == 'M1'",
             numericInput("Mean1",
                          label = h5("Mean component 1"),
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
                          label = h5("Mean component 3"),
                          value = 5)),
           # Sidebar with a slider input for the number of samples
           sliderInput("n",
                       label = h4("Number of samples"),
                       min = 10,
                       max = 200,
                       value = 100),
           # Sidebar with a slider input for the number of bins
           sliderInput("bins",
                       label = h4("Number of histogram's bins"),
                       min = 1,
                       max = 50,
                       value = 30),
           # Sidebar with a slider input for the bandwidth
           sliderInput("h",
                       label = h4("Bandwidth Kernel estimatior"),
                       min = 0.1,
                       max = 2,
                       value = 0.5)
    ),
    # Show plots in different tabs of the histogram and the kernel density function
    column(8, offset = 1,
           tabsetPanel(
             tabPanel("Histogram", plotOutput("distPlot")),
             tabPanel("Kernel Estimator", plotOutput("distPlot2")),
             tabPanel("Help", "Assignment Developing Data Products Coursera's course.

This project implements a basic nonparametric estimation of a probability density function (pdf) and a regression function using the well-known Nadaraya-Watson estimator. Both, pdf and regressor, were implemented using a kernel density estimator using a RBF kernel whose bandwidth can be adjusted using a slide bar. In order to evaluate the effect of the bandwidth, the pdf estimation can be compared with a histogram and the regression function can be contrasted with the real data.

The data used for the pdf estimation is randomly sampled from a mixture of two possible distributions. A mixture could have one, two or three components and their means are adjustable.

The data used for the regression function is extracted from a sinusoid function times a negative exponential plus random noise. ")
           )
    )),
  
  hr(),
  
  fluidRow(
    column(3,
           h2("Kernel Regressor"),
           # Sidebar with a slider input for the number of samples in the regression exercise
           sliderInput("n2",
                       label = h4("Number of samples"),
                       min = 10,
                       max = 200,
                       value = 100),
           # Sidebar with a slider input for the bandwith in the regression excercise
           sliderInput("h2",
                       label = h4("Bandwidth Kernel estimatior"),
                       min = 0.1,
                       max = 2,
                       value = 0.5)
    ),
    # Show plots in different tabs of the original data and the output of the Nadaraya-Watson regressor
    column(8, offset = 1,
           tabsetPanel(
             tabPanel("Original data", plotOutput("distPlot3")),
             tabPanel("Kernel Estimator", plotOutput("distPlot4")),
             tabPanel("Help", "Assignment Developing Data Products Coursera's course.

This project implements a basic nonparametric estimation of a probability density function (pdf) and a regression function using the well-known Nadaraya-Watson estimator. Both, pdf and regressor, were implemented using a kernel density estimator using a RBF kernel whose bandwidth can be adjusted using a slide bar. In order to evaluate the effect of the bandwidth, the pdf estimation can be compared with a histogram and the regression function can be contrasted with the real data.

The data used for the pdf estimation is randomly sampled from a mixture of two possible distributions. A mixture could have one, two or three components and their means are adjustable.

The data used for the regression function is extracted from a sinusoid function times a negative exponential plus random noise. ")
           )
    )
  )
))
