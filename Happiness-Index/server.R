#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(googleVis)

# load dataset
happiness.data <- read.csv("./data/report_2018-2019.csv", 
                           col.names = c("rank", "region", "year", "score", "GDP", "social", "life", "choices", "generosity", "corruption"))

# Define server logic required to draw a histogram
function(input, output) {

    output$ranking_map <- renderGvis({
        
        # assign selected year
        map_year <- input$year_select

        # filter data by year
        happiness.year <- happiness.data[happiness.data$year == map_year, ]

        # assign selected category
        cat <- input$category_select
        if (cat == "happiness rank") {
            plot.data <- "rank"
        } else if (cat == "happiness score") {
            plot.data <- "score"
        } else if (cat == "GDP per capita") {
            plot.data <- "GDP"
        } else if (cat == "social support") {
            plot.data <- "social"
        } else if (cat == "healthy life expectancy") {
            plot.data <- "life"
        } else if (cat == "freedom to make life choices") {
            plot.data <- "choices"
        } else if (cat == "generosity") {
            plot.data <- "generosity"
        } else if (cat == "perceptions of corruption") {
            plot.data <- "corruption"
        }

        # create hover text
        happiness.year$hover <- paste0(happiness.year$region)

        # generate map
        gvisGeoChart(data = happiness.year, locationvar = "region", colorvar = plot.data, hovervar = "hover",
                     options = list(width = 800, height = 600))
    })
    
    output$ranked_regions <- renderText({
        
        # assign selected year
        map_year <- input$year_select
        
        # filter data by year
        happiness.year <- happiness.data[happiness.data$year == map_year, ]
        
        # assign selected category
        cat <- input$category_select
        if (cat == "happiness rank") {
            plot.data <- "rank"
        } else if (cat == "happiness score") {
            plot.data <- "score"
        } else if (cat == "GDP per capita") {
            plot.data <- "GDP"
        } else if (cat == "social support") {
            plot.data <- "social"
        } else if (cat == "healthy life expectancy") {
            plot.data <- "life"
        } else if (cat == "freedom to make life choices") {
            plot.data <- "choices"
        } else if (cat == "generosity") {
            plot.data <- "generosity"
        } else if (cat == "perceptions of corruption") {
            plot.data <- "corruption"
        }
        
        # print list of top-ranked regions for selected category
        ranked_regions <- ""
        for (i in 1:input$num_list_countries) {
            if (plot.data == "rank") {
                happiness.sorted <- happiness.year[order(happiness.year[, plot.data]), ]
            } else {
                happiness.sorted <- happiness.year[order(happiness.year[, plot.data], decreasing = TRUE), ]
            }
            ranked_region <- happiness.sorted[i, "region"]
            ranked_regions <- paste(ranked_regions, paste0(i, ". ", ranked_region), sep = '\n')
        }
        ranked_regions
    })

}
