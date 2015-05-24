
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

  shinyUI(pageWithSidebar(  
    headerPanel("Part of Speech Tagger"),
    sidebarPanel(
      p("Enter Text"),
      tags$textarea(id="plaintext", rows=18, style="width:100%;", "The quick brown fox ..."),
      submitButton("Perform Tagging")
    ),
    
    mainPanel(    
      plotOutput("distPlot"),
      p("Tagged Text"),
      verbatimTextOutput("text")
    )
  ))