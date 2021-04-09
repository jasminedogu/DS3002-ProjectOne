#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("World Happiness Report Data"),
    tags$h3("DS 3002, Project One"),
    tags$h4("By Jasmine Dogu (ejd5mm)"),
    
   selectInput('year',"Choose a Year",
               choices = data$year)
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    data <- read.csv("world-happiness-report.csv")
    

}

# Run the application 
shinyApp(ui = ui, server = server)
