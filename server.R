#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readxl)
library(sf)
library(leaflet)
library(leaflet.extras)
library(htmltools)
library(tidyverse)
library(RColorBrewer)
# setwd("H:/Finance/R/Project R/Shp file Sweden")
load("SHP_Kommun_Befolk.Rdata")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    
    inf_data <- reactive({
        (input$period)
    })

    chng_data <- reactive({
        (input$tot_chng)
    })
    
    names <- as.list(colnames(KOM_BEF)[c(4:20)])
    
    ####  choro_inf  
    output$choro_per <- renderLeaflet({
        
        #new_labels <- paste0("V_", input$period,)
        #target <- as.name(new_labels)
        
        labels <- sprintf(
            "<strong>%s</strong><br/>Population %g",
            KOM_BEF$Kommun, KOM_BEF[[inf_data()]] ) %>% lapply(htmltools::HTML)
        # # EU_0_NUTS$Country, round(EU_0_NUTS[[inf_data()]],2), input$period) %>% lapply(htmltools::HTML) # remove 3rd display variable
        
        mycolours <- brewer.pal(8, "Blues")
        bins <- c(0,10000,20000,30000,40000, 50000,100000,500000,1000000)
        pal <- colorBin(input$pal_col, domain = KOM_BEF[[inf_data()]], bins = bins)
        
        m <- leaflet(KOM_BEF) %>%
            addTiles() %>%
            setView(lat = 58, lng = 15, zoom = 6) %>%
            addProviderTiles(providers$CartoDB.Positron) %>%
            addPolygons(fillColor =  ~pal(KOM_BEF[[inf_data()]]),                  ##### use colour palette 
                        weight = 1, opacity = 1, 
                        color = "white", dashArray = 3, fillOpacity = 0.7, 
                        highlight = highlightOptions(               ##### Frame in black
                            weight = 2, color = "#666",
                            dashArray = "",
                            fillOpacity = 0.7,
                            bringToFront = TRUE),
                        label = labels,
                        labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto")) %>%
            addLegend(pal = pal, values = ~input$period, opacity = 0.7, title = NULL,
                      position = "bottomright")  
        m
        
    })
    ####---------
    
    
    
    output$choro_chng <- renderLeaflet({

        #new_labels <- paste0("V_", input$period,)
        #target <- as.name(new_labels)

        labels <- sprintf(
            "<strong>%s</strong><br/>Pop. Growth %g ",
            KOM_BEF$Kommun, KOM_BEF[[chng_data()]] ) %>% lapply(htmltools::HTML)
        # EU_0_NUTS$Country, round(EU_0_NUTS[[inf_data()]],2), input$period) %>% lapply(htmltools::HTML) # remove 3rd display variable

        mycolours <- brewer.pal(8, "Blues")
        bins <- c(-400, 0, 500, 1000, 1500, 2000, 3000, 4000,Inf)
        pal <- colorBin(input$pal_col_chng, domain = KOM_BEF[[chng_data()]], bins = bins)

        m <- leaflet(KOM_BEF) %>%
            addTiles() %>%
          setView(lat = 58, lng = 15, zoom = 6) %>%
            addProviderTiles(providers$CartoDB.Positron) %>%
            addPolygons(fillColor =  ~pal(KOM_BEF[[chng_data()]]),                  ##### use colour palette
                        weight = 1, opacity = 1,
                        color = "white", dashArray = 3, fillOpacity = 0.7,
                        highlight = highlightOptions(               ##### Frame in black
                            weight = 2, color = "#666",
                            dashArray = "",
                            fillOpacity = 0.7,
                            bringToFront = TRUE),
                        label = labels,
                        labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto")) %>%
            addLegend(pal = pal, values = ~input$tot_chng, opacity = 0.7, title = NULL,
                      position = "bottomright")
        m

    })
    
   
})
