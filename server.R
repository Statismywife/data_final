#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(ggplot2)
library(shiny)
library(readxl)
library(DT)
library(tidyverse)

NBA <- read_xlsx("NBA Drafts.xlsx")
Win <- NBA[,c('Pick', "Win SharesS/48")]
Year <- NBA[,c('Pick', 'Yrs')]
VOR <- NBA[,c('Pick','Value Over Replacement')]

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$table <- DT::renderDataTable(DT::datatable({
    data <- NBA
    if (input$'Draft Year' != "All") {
      data <- data[data$'Draft Year' == input$'Draft Year',]
    }
    if (input$Pick != "All") {
      data <- data[data$Pick == input$Pick,]
    }
    if (input$Team != "All") {
      data <- data[data$Team == input$Team,]
    }
    data
  },options = 
    list(
         language = list(
           zeroRecords = "No records to display - custom text")              
    )
  
  ))
  
  output$x2 = renderPlot({
    s = input$table_rows_selected
    par(mar = c(4, 4, 1, .1))
    plot(Win)
    if (length(s)) points(Win[s, , drop = FALSE], pch = 19, cex = 2,col="red")
  })
  
  output$x3 = renderPlot({
    s = input$table_rows_selected
    par(mar = c(4, 4, 1, .1))
    plot(Year)
    if (length(s)) points(Year[s, , drop = FALSE], pch = 19, cex = 2,col="blue")
  })
  
  output$x4 = renderPlot({
    s = input$table_rows_selected
    par(mar = c(4, 4, 1, .1))
    plot(VOR)
    if (length(s)) points(VOR[s, , drop = FALSE], pch = 19, cex = 2,col="green")
  })
})
