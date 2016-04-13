
library(shiny)
library(ggplot2)

shinyServer(
  
  function(input, output) {
    
    output$pdName <- renderPrint({input$pdName})
    
    output$newSample <- renderPlot( { 
      mu <- as.numeric(input$mean)
      std <- as.numeric(input$std)
      randomSeed <- as.numeric(input$randomeSeed)
      set.seed(input$randomSeed)
      numSample <- as.numeric(input$numSamples)
      nbin <- input$nbin 
      
      #sample
      if (input$pdName == 'Normal') 
        {
        rd <- rnorm(numSample, mean=mu, sd=std)
        px <- dnorm(rd,mu,std)
      } 
      if (input$pdName == 'Lognormal') 
      {
        rd <- rlnorm(numSample, meanlog=mu, sdlog=std)
        px <- dlnorm(rd,mu,std)
      } 
      if (input$pdName == 'Poisson') 
      {
        rd <- rpois(numSample, mu)
        px <- dpois(rd,mu)
      } 
      
      dataFrame <- data.frame(Sample=rd,y=px)
      mainTitle <- paste(input$pdName, ", mu = ", mu, " std = ", std, " numSamples = ", numSample)
      g <- ggplot(dataFrame, aes(Sample)) +
        geom_histogram(aes(y = ..density..),
                       binwidth=(max(rd)-min(rd))/nbin,
                       colour='black',fill='blue') +
        geom_line(aes(x=Sample,y=y), color='red',size=1.5)
      print(g)
    })
  }
  
  
)

