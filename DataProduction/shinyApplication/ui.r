library(shiny)
shinyUI(
  
  pageWithSidebar(
    headerPanel("Drawing Random Samples"),
    
    # place to put different inputs
    sidebarPanel(
      textInput(inputId="numSamples", label="numSamples", value="100"), 
      textInput(inputId="randomSeed", label="randomSeed", value="333"), 
      textInput(inputId="mean", label="Mean", value="0"),
      textInput(inputId="std", label="Standard Deviation", value="1"),
      
      checkboxGroupInput("pdName", "Choose one of the distributions:",
                         c("Normal"     = "Normal",
                           "Log-normal" = "Lognormal",
                           "Poisson"    = "Poisson"), 
                          selected="Normal"),
      sliderInput('nbin', 'Select the number of bins',value = 10, min = 0, max = 100, step =10),
      
      submitButton('Update') 
    ),
    
    # place to show the codes/figures/results/write-ups etc [connect with server.r]
    # can use whatever input$* or output$* variables
    mainPanel(
      h4('Selected Distribution:'),
      verbatimTextOutput("pdName"),
      plotOutput('newSample')

    )
  )
)
