#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(ggplot2)
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("Data for Final"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("Draft Year",
                       "Draft Year:",
                       c("All",
                         sort(unique(as.integer(NBA$'Draft Year')))))
    ),
    column(4,
           selectInput("Pick",
                       "Pick:",
                       c("All",
                         sort(unique(as.integer(NBA$Pick)))))
    ),
    
    column(4,
           selectInput("Team",
                       "Team:",
                       c("All",
                         unique(as.character(NBA$Team))))
    )
  ),
  # Create a new row for the table.
  DT::dataTableOutput("table"),
  
  column(8,plotOutput('x2', height = 500)),
  column(8,plotOutput('x3', height = 500)),
  column(8,plotOutput('x4', height = 500))
  
))
