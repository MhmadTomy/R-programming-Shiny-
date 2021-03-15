#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(markdown)
library(shinythemes)

ui <- fluidPage(theme = shinytheme("superhero"),
                navbarPage("Naive Bayes Classifier",
                           tabPanel("Main Menu",
                                    sidebarLayout(
                                        sidebarPanel(
                                            # Input: Select a file ----
                                            fileInput("file1", "Choose CSV File",
                                                      multiple = FALSE,
                                                      accept = c("text/csv",
                                                                 "text/comma-separated-values,text/plain",
                                                                 ".csv")),
                                            
                                            # Horizontal line ----
                                            tags$hr(),
                                            
                                            # Input: Checkbox if file has header ----
                                            checkboxInput("header", "Header", TRUE),
                                            
                                            # Input: Select separator ----
                                            radioButtons("sep", "Separator",
                                                         choices = c(Comma = ",",
                                                                     Semicolon = ";",
                                                                     Tab = "\t"),
                                                         selected = ","),
                                            
                                            # Input: Select quotes ----
                                            radioButtons("quote", "Quote",
                                                         choices = c(None = "",
                                                                     "Double Quote" = '"',
                                                                     "Single Quote" = "'"),
                                                         selected = '"'),
                                            
                                            # Horizontal line ----
                                            tags$hr(),
                                            
                                            # Input: Select number of rows to display ----
                                            radioButtons("disp", "Display",
                                                         choices = c(Head = "head",
                                                                     All = "all"),
                                                         selected = "head")
                                        ),
                                        mainPanel(
                                            tableOutput("contents")
                                        )
                                    )
                           ),
                           tabPanel("Summary",
                                    verbatimTextOutput("summ")
                           ),
                           tabPanel("Predict",
                                    verbatimTextOutput("predict")
                           ),
                           tabPanel("Grafik",
                                    sidebarLayout(
                                        sidebarPanel(
                                            selectInput("x", "Masukkan Variabel Independen", c("Total_session",
                                                                                               "Total_upload",
                                                                                               "Total_download")),
                                            selectInput("y", "Masukkan Variabel Dependen", c("hasil"))
                                        ),
                                        
                                        mainPanel(
                                            tabsetPanel(type = "tabs",
                                                        tabPanel("Scatterplot", plotOutput("scatterplot")),
                                                        
                                                        tabPanel("Barplot", plotOutput("barplot1")),
                                                        
                                                        
                                                        tabPanel("Boxplot", plotOutput("boxplot1"))
                                                        
                                                        
                                                        
                                            )
                                        )
                                    )
                           )
                )
)

