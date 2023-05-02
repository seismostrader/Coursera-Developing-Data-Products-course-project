#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Global Happiness Index Ranking"),

    # Sidebar with all included widgets
    sidebarLayout(
        sidebarPanel(
            p(
                "This is a simple app that allows the user to display a map of global happiness index rankings for the years 2018 and 2019. 
                The user can choose to display the overall ranking, or the scores of the components used to calculate the 
                overall happiness index of each region. Furthermore, the user can specify the number of top-ranked regions 
                that are listed for a given year and score category.",
                align = "center"
            ),
            # add dropdown box to select happiness ranking score
            selectInput("category_select", "Choose a score to display",
                        choices = list(
                            "happiness rank",
                            "happiness score", 
                            "GDP per capita",
                            "social support",
                            "healthy life expectancy",
                            "freedom to make life choices",
                            "generosity",
                            "perceptions of corruption"
                        )),
            
            # add radio buttons to select the year from which scores will be displayed
            radioButtons("year_select", "Choose a year to display",
                         choices = list(
                             "2018" = 2018,
                             "2019" = 2019
                         )),
            
            # add numeric input to select number of rankings to be listed
            numericInput("num_list_countries", "Select how many rankings to list",
                         value = 5, min = 1, max = 20, step = 1),
            
            # List top-ranked regions according to selected category and year
            h3("Top-Ranked Regions:"),
            verbatimTextOutput("ranked_regions")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            htmlOutput("ranking_map")
        )
    )
)
