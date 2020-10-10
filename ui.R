#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

names <- as.list(colnames(KOM_BEF)[c(4:20)])

# Define UI for application that draws a histogram
shinyUI(navbarPage("Sweden Population Data",
                   
                   ##############   Layout(sidebarPanel, mainPanel) !!!!!!!!!!!!!!
                   tabPanel("2003-2019",
                            #tabPanel(h1("Inflation Data 2020-19 (Quarterly)", align = "center")),
                            fluidRow(column(12,
                                            h1("Population for Sweden: Source SCB"),
                                            p("Period 2003:2019")),
                                     hr()
                            ),
                            sidebarPanel(width = 3,
                                         selectInput("period","Choose Year",
                                                     choices = names, selected = "Y_2019"),
                                         selectInput("pal_col", "Colour Scheme",
                                                     choices = c("Purples", "Blues", "YlOrRd", "RdYlBu", "YlGnBu", 
                                                                 "Spectral", "BuPu", "PuBu", "OrRd"), selected = "YlGnBu")),
                            mainPanel(leafletOutput("choro_per", height = 600))#XXXDELXXX,
                            
                   ),#TabPan1
                   
                   
                   tabPanel("Growing or Shrinking",
                            fluidRow(column(12,
                                            h1("Net change in municipality population 2019"),
                                            p("Netto of moving out and moving in")),
                                     hr()
                            ),
                            sidebarPanel(width = 3,
                                         selectInput("tot_chng","Change",
                                                     choices = "Flyttningsnetto"),
                                         selectInput("pal_col_chng", "Colour Scheme",
                                                     choices = c("Purples", "Blues", "YlOrRd", "RdYlBu",
                                                                 "YlGnBu", "Spectral", "BuPu", "PuBu", "OrRd"), selected = "YlOrRd")),


                            mainPanel(leafletOutput("choro_chng", height = 600))
                            
                   )  #Tab Pan2
                   
)    #Title
)    #Nav







# 
# 
# tabPanel("Tab 3"),
# tabPanel("Tab 4")

