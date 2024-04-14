#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(dplyr)
library(tm)
library(stringr)

## load training ngrams - adjusted data set
ngrm <- read.csv("ngrm.csv")

## prediction function
predict_list <- function(x, N){
        ## returns the list of N words predicted based on last 2-3 input words
        ## x - input string, N - number of words to return
        
        inp_list <- str_split_1(x, " ") ## split x to vector of words
        n_inp <- length(inp_list)
        if (n_inp < 2){ return("Enter more words, please.")}
        
        words <- if (n_inp == 2){inp_list[1:2]} else {inp_list[(n_inp-2):n_inp]}
        
        list <-c()
        
        if (n_inp > 2){
                temp4 <- ngrm[ngrm$n==4 & ngrm$input == paste(words[1:3],collapse=" "),]
                if (!is.na(temp4[1,2])){ 
                        tl <- temp4[,2]
                        list <- unique(c(list,tl))
                        nl <- length(list)
                        nlm <- min(N, nl)
                        if(nlm==N)return(list[1:N]) 
                }
        }
        temp3 <- ngrm[ngrm$n==3 & ngrm$input == paste(words[2:3],collapse=" "),]
        if (!is.na(temp3[1,2])){
                tl <- temp3[,2]
                list <- unique(c(list,tl))
                nl <- length(list)
                nlm <- min(N, nl)
                if(nlm==N)return(list[1:N])  
        }
        temp2 <- ngrm[ngrm$n==2 & ngrm$input == words[3],]
        if (!is.na(temp2[1,2])){
                tl <- temp2[,2]
                list <- unique(c(list,tl))
                nl <- length(list)
                nlm <- min(N, nl)
                if(nlm==N)return(list[1:N])   
        } 
        temp1 <- ngrm[ngrm$n==1,]
        tl <- temp1[,2]
        list <- unique(c(list,tl))
        nl <- length(list)
        nlm <- min(N, nl)
        return(list[1:N]) 
        
}




# Define server logic required to draw a histogram
function(input, output, session) {
        
        output$value <- renderPrint({ 
                x <- input$text
                y <- stripWhitespace(removeNumbers(removePunctuation(tolower(x), 
                        preserve_intra_word_dashes = TRUE, 
                        preserve_intra_word_contractions = TRUE)))
                y <- str_replace_all(y, "[^[\\da-zA-Z - ' ]]"," ")
                
                trimws(y,which = "both")
                
        })
        
        output$prediction <- renderPrint({
                x <- input$text
                y <- stripWhitespace(removeNumbers(removePunctuation(tolower(x), 
                        preserve_intra_word_dashes = TRUE, 
                        preserve_intra_word_contractions = TRUE)))
                y <- str_replace_all(y, "[^[\\da-zA-Z - ' ]]"," ")
                y <- trimws(y,which = "both")
                predict_list(y, input$num_words)
        })

    
}
