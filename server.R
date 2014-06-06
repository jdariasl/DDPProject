library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  data <- reactive({  set.seed(10)
    dist <- switch(input$DisType,
                   norm = rnorm,
                   lnorm = rlnorm,
                   gamma = rgamma,
                   rnorm)
    
    samples <- switch(input$Nmixtures,
              M1 = {dist(input$n,input$Mean1)},
              M2 = {N <- ceiling(input$n/2)
                   c(dist(N,input$Mean1),dist(N,input$Mean2))},
              M3 = {N <- ceiling(input$n/3)
                    tem <- c(dist(N,input$Mean1),dist(N,input$Mean2))
                    c(tem,dist(N,input$Mean3))})
    return(samples)
  })
  
  
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
    hist(data(), breaks = bins, col = 'darkgray', border = 'white')
   
   })
  
  output$distPlot2 <- renderPlot({
    datos <- data2()
    plot(datos[,1],datos[,2], type = "l", main = "Kernel Density Estimation")
    
  })
  
  output$distPlot3 <- renderWebGL({
    tem <- seq(-10,10,length=input$n)
    z <- matrix(0,length(tem),length(tem))
    for (i in 1:length(tem)) {
      for (j in 1:length(tem)) {
        z[i,j] <- 3*sin(2*pi*tem[i] + tem[j]) - 2*tem[j]^2 + tem[i]*tem[j]
      }
    }
   rgl.surface(tem,tem,z)
  })
  
})
