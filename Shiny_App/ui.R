#Loading Libraries
library(shiny)
library(devtools)
library(plotly)
library(stringr)
library(dplyr)
library(shiny)
library(markdown)
library(leaflet)
library (RColorBrewer)
library(shinythemes)

# Scripts
source("scripts/discharge_breakdown.r")

# Datasets 
overview.discharges <- read.csv("Data/overall_drg_discharges.csv", stringsAsFactors = F)
overview.discharges <- overview.discharges %>% arrange(drg)

ui <- navbarPage (theme = shinytheme("cerulean"),
                  fluid = T,
                  title = "DRG Explorer",
                  
                  #######################################################
                  # Get a cost breakdown for any DRG
                  # Bar Chart
                  #tabPanel(title ="Cost Breakdown"),
                  
                  #######################################################
                  # Get a breakdown for number of discharges per year
                  # Bar Chart
                  tabPanel(title ="Discharge Breakdown",
                           h1("Get the Discharge Breakdown for Any DRG", style = "text-align: center;padding: 20px;"), hr(),
                           
                           # Create a sidebar with widgets that will modify the map
                           sidebarLayout(
                             sidebarPanel(helpText("Select a DRG for which you want a breakdown"),
                                          hr(),
                                          # Select input for the DRGs
                                          selectInput("select.drg.discharge.brk",
                                                      "Select DRG",
                                                      overview.discharges$drg,
                                                      selected = "001 - HEART TRANSPLANT OR IMPLANT OF HEART ASSIST SYSTEM W MCC")),
                             
                             # Main Panel to Display Bar Chart
                             mainPanel(p("Discharge Statistics for the DRG Selected"),
                                       br(),
                                       helpText ("Scroll Down to See Data Table Results"),
                                       hr(),
                                       plotlyOutput('discharge.breakdown.bar'),
                                       dataTableOutput('data.table.discharge.breakdown')
                                       ),
                                        
                           )
                           ), 
                  

                  #######################################################
                  # Get a breakdown of National Statistics 
                  # Chloropleth Map
                  tabPanel(title = "National Statistics",
                           h1("National Statistics", style = "text-align: center;padding: 20px;"), hr(),
                           
                           # Sidebar with a slider input for number of bins 
                           sidebarLayout(
                             sidebarPanel(
                               radioButtons("map",
                                            h3("Select Statistic"),
                                            choices = list("Average Covered Charges" = 1, 
                                                           "Total Discharges" = 2), 
                                            selected = 1
                               )
                             ),
                             # Show a plot of the generated distribution
                             mainPanel(
                               plotlyOutput("plot")
                             )
                           ))
                  
                  # Find a Nearby Provider
                  #tabPanel(title = "Find Provider"), 
                  

                  )