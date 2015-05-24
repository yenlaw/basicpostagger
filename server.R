
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

# Define dependencies.
library(shiny)

library(dplyr)
library(BH)

# Omly include basic NLP libraries - as this version will be gitHub public.
library(NLP)
library(openNLP)

shinyServer(function(input, output) {
  
  # Define POS Tagging function.
  tagPOS <-  function(x, ...) {
    s <- as.String(x)
    word_token_annotator <- Maxent_Word_Token_Annotator()
    a2 <- Annotation(1L, "sentence", 1L, nchar(s))
    a2 <- annotate(s, word_token_annotator, a2)
    a3 <- annotate(s, Maxent_POS_Tag_Annotator(), a2)
    a3w <- a3[a3$type == "word"]
    POStags <- unlist(lapply(a3w$features, `[[`, "POS"))
    POStagged <- paste(sprintf("%s/%s", s[a3w], POStags), collapse = " ")
    list(POStagged = POStagged, POStags = POStags)
  }
  
  # Plot POS Results - limit analysis to 1000 characters on shinyapp.io.
  output$distPlot <- renderPlot({    
    
    if(nchar(input$plaintext) < 1001){
    
      tagged_table <- table(tagPOS(input$plaintext)[[2]])

      plot(tagged_table, main = "Grammatical Summary", xlab = "Grammatical Tag", ylab = "Frequency", col="blue") 
  }
    
  })
  
  # Show Word - POS relationship - limit analysis to 1000 characters on shinyapp.io.
  output$text <- renderText({
    if(nchar(input$plaintext) < 1001){
      paste(tagPOS(input$plaintext)[[1]]);
    }else{
      paste("Please limit the source text to 1000 characters.")
    }
    
  })

})
