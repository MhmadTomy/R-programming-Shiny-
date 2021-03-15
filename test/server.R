#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggplot2)
library(caret)
# Define server logic to read selected file ----
server <- function(input, output,session) {
    
    output$contents <- renderTable({
        req(input$file1)
       
         tryCatch(
            {
                df <- read.csv(input$file1$datapath,
                               header = input$header,
                               sep = input$sep,
                               quote = input$quote)
            },
            error = function(e) {

                stop(safeError(e))
            }
        )
        
        if(input$disp == "head") {
            return(head(df))
        }
        else {
            return(df)
        }
        
    })
    
    ##############################
    output$summ<-renderPrint({
        req(input$file1)

        tryCatch(
            {
                df <- read.csv(input$file1$datapath,
                               header = input$header,
                               sep = input$sep,
                               quote = input$quote)
            },
            error = function(e) {
                # return a safeError if a parsing error occurs
                stop(safeError(e))
            }
        )
        
        summary(df)
    })
    
    ################################
    output$predict<-renderPrint({
        req(input$file1)

        tryCatch(
            {
                df <- read.csv(input$file1$datapath,
                               header = input$header,
                               sep = input$sep,
                               quote = input$quote)
            },
            error = function(e) {
                # return a safeError if a parsing error occurs
                stop(safeError(e))
            }
        )
        
        Predict <- predict(model,newdata = testing )
        values <- confusionMatrix(Predict, testing$hasil )
        values
    })
    
    #########################
    output$scatterplot <- renderPlot({
        output$scatterplot <- renderPlot({
            req(input$file1)
            tryCatch(
                {
                    df <- read.csv(input$file1$datapath,
                                   header = input$header,
                                   sep =  input$sep)
                },
                error = function(e){
                    stop(safeError(e))
                }
            )
            
            tryCatch(
                {
                    plot(df[,input$x], df[,input$y], main= "Scatterplot",
                         xlab= input$x, ylab= input$y, pch = 15)
                    abline(lm(df[,input$y] ~ df[,input$x]), col="red")
                    lines(lowess(df[,input$x],df[,input$y]), col="blue")
                },
                error = function(e){
                    print("")
                }
            )
        })
    
    })   
    
    #########################
    output$barplot1 <- renderPlot({
        req(input$file1)
        tryCatch(
            {
                df <- read.csv(input$file1$datapath,
                               header = input$header,
                               sep =  input$sep)
            },
            error = function(e){
                stop(safeError(e))
            }
        )
        
        tryCatch(
            {
                barplot(df[,input$x], df[,input$y], main= "Barplot",
                     xlab= input$x, ylab= input$y, pch = 15)
                abline(lm(df[,input$y] ~ df[,input$x]), col="red")
                lines(lowess(df[,input$x],df[,input$y]), col="blue")
            },
            error = function(e){
                print("")
            }
        )
    })
    
    #########################
    output$boxplot1 <- renderPlot({
        req(input$file1)
        tryCatch(
            {
                df <- read.csv(input$file1$datapath,
                               header = input$header,
                               sep =  input$sep)
            },
            error = function(e){
                stop(safeError(e))
            }
        )
        
        tryCatch(
            {
                boxplot(df[,input$x], df[,input$y], main= "Boxplot",
                        xlab= input$x, ylab= input$y, pch = 15)
                abline(lm(df[,input$y] ~ df[,input$x]), col="red")
                lines(lowess(df[,input$x],df[,input$y]), col="blue")
            },
            error = function(e){
                print("")
            }
        )
    })
    
}
