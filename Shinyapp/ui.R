#
# Shiny application that predicts next word based on 2+ input words 
#

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
fluidPage(
        theme=shinytheme('readable'),
        # Application title
        titlePanel("Don't know what to say? We'll help! Enter your words."),

        # Sidebar with a slider input for number of bins
        sidebarLayout(
                sidebarPanel(
                        sliderInput("num_words",
                                    "Number of predicted words",
                                    min = 1,
                                    max = 10,
                                    value = 5),
                        textInput("text", label=h3('Text Input'), 
                                  placeholder='Enter at least two words'),
                        h5('Cleaned text used for prediction'),
                        verbatimTextOutput('value')
                ),
        

                mainPanel(
                        
                        h4('Words proposed'),
                        verbatimTextOutput("prediction")
                ),
        
        ),
        
        fluidRow(h5(column(5, h5('Pavel Zakharov')))        )
)
