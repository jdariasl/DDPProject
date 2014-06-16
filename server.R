library(shiny)
#library(shinyRGL) I was trying to do something in 3D
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. 
  
  data <- reactive({  set.seed(10)
    dist <- switch(input$DisType,
                   norm = rnorm,
                   lnorm = rlnorm,
                   rnorm)
    # The number of points is split equally into the number of components in the mixture
    samples <- switch(input$Nmixtures,
              M1 = {dist(input$n,input$Mean1)},
              M2 = {N <- ceiling(input$n/2)
                   c(dist(N,input$Mean1),dist(N,input$Mean2))},
              M3 = {N <- ceiling(input$n/3)
                    tem <- c(dist(N,input$Mean1),dist(N,input$Mean2))
                    c(tem,dist(N,input$Mean3))})
    return(samples)
  })
  
  # Kernel density estimation
  data2 <-reactive({
    datos <- data()
    tem <- seq(min(datos) - 1,max(datos) + 1,length=input$n)
    y <- matrix(0,1,input$n)
    for (i in 1:length(tem)) {
      tem2 <- 0
      for (j in 1:length(datos)) {
        tem2 <- tem2 + exp(-0.5*(tem[i]-datos[j])^2/(input$h^2))
      }
      y[i] <- tem2
    }
    tem3 <- cbind(tem,t(y)) 
    return(tem3)
  })
    
  output$distPlot <- renderPlot({
    #x    <- faithful[, 2]  # Old Faithful Geyser data
    bins <- seq(min(data()) - 1, max(data()) + 1, length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(data(), breaks = bins, col = 'skyblue', border = 'white')
   
   })
  
  output$distPlot2 <- renderPlot({
    datos <- data2()
    plot(datos[,1],datos[,2], type = "l", main = "Kernel Density Estimation")
    
  })
  
  # Generation of the "real" data for the regression exercise
  data3 <- reactive({
        tem <- seq(-4,4,length=2*input$n2)
        datos <- 2*sin(2*pi*tem)*exp(-tem/5) + 0.5*rnorm(input$n2)
        tem3 <- cbind(tem,datos)
        return(tem3)
        })
  
  
  
  output$distPlot3 <- renderPlot({
    tem <- data3()
    plot(tem[,1],tem[,2], type = "p", main = "Original Data")
  })
  
  # Nadaraya-Watson estimator 
  output$distPlot4 <- renderPlot({
    tem <- data3()
    tem2 <- seq(-4,4,length=input$n2)
    y <- matrix(0,1,input$n2)
    for (i in 1:length(tem2)) {
      num <- 0
      den <- 0
      for (j in 1:length(tem[,1])) {
        num <- num + exp(-0.5*(tem2[i]-tem[j,1])^2/(input$h2^2))*tem[j,2]
        den <- den + exp(-0.5*(tem2[i]-tem[j,1])^2/(input$h2^2))
      }
      y[i] <- num/den
    }
    plot(tem2,y, type = "l", main = "Nadaraya-Watson Estimator")
  })
  
  
})
