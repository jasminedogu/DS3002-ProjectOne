# Elit Jasmine Dogu, ejd5mm
# Project One DS 3002

#libraries
library(dplyr)
library(countrycode)
library(shiny)
df <- read.csv("./world-happiness-report-cleaned.csv") #reading in the data (cleaned)

server <- function(input, output) {
    # Filter data based on user selections
    output$table <- DT::renderDataTable(DT::datatable({
        data <- df %>%
            filter(
                if(input$year != "All") {
                    Year ==input$year
                } else {TRUE}
            ) %>%
            filter(
                if(input$country != "All") {
                    Country ==input$country
                } else {TRUE}
            ) %>%
            filter(
                if(input$continent != "All") {
                    Continent ==input$continent
                } else {TRUE}
            )
        
        return(data)
        
    }))
        # Generate a summary of the dataset (on the left panel)
        output$summary <- renderPrint({
            data <- df %>%
                filter(
                    if(input$year != "All") {
                        Year ==input$year
                    } else {TRUE}
                ) %>%
                filter(
                    if(input$country != "All") {
                        Country ==input$country
                    } else {TRUE}
                ) %>%
                filter(
                    if(input$continent != "All") {
                        Continent ==input$continent
                    } else {TRUE}
                )
            
            return(summary(data))
            
        })
    
       #Generate a function to show the number of rows w/ any given dataframe selection/restriction
    rows = function() {
        data <- df %>%
            filter(
                if(input$year != "All") {
                    Year ==input$year
                } else {TRUE}
            ) %>%
            filter(
                if(input$country != "All") {
                    Country ==input$country
                } else {TRUE}
            ) %>%
            filter(
                if(input$continent != "All") {
                    Continent ==input$continent
                } else {TRUE}
            )
        
        return(nrow(data)) #returns number of rows of the data
    }
    
    #Generate a function to show the number of columns w/ any given dataframe selection/restriction
    cols = function() {
        data <- df %>%
            filter(
                if(input$year != "All") {
                    Year ==input$year
                } else {TRUE}
            ) %>%
            filter(
                if(input$country != "All") {
                    Country ==input$country
                } else {TRUE}
            ) %>%
            filter(
                if(input$continent != "All") {
                    Continent ==input$continent
                } else {TRUE}
            )
        
        return(ncol(data)) #returns the number of columns of the data
    }

    #Using the functions created above
        output$columns  <- renderText({
            paste("Number of Columns:" , cols() ) #text to display the number of columns
        })
        output$rows  <- renderText({
            paste("Number of Rows (Records):" , rows() ) #text to display the number of rows 
        })

        output$data_ex  <- renderText({
            paste("Please see GitHub Repo for information regarding the dataset.") #text to display where to find more information
        })
 

        # Downloadable csv of selected dataset 
        output$downloadData <- downloadHandler(
            filename = function() {
                selected <-c() #this assists with the name of the file
                if (input$year != "All") { 
                    selected <-c(selected, input$year)
                }
                if (input$country != "All") {
                    selected <-c(selected, input$country)
                }
                if (input$continent != "All") {
                    selected <-c(selected, input$continent)
                }
                if (length(selected) == 0) {
                    selected <- c("AllData")
                }
                
                paste0(paste(selected, collapse="-"), ".csv")
            },
            content = function(con) { #creates content of the csv file
                data <- df %>%
                    filter(
                        if(input$year != "All") {
                            Year ==input$year
                        } else {TRUE}
                    ) %>%
                    filter(
                        if(input$country != "All") {
                            Country ==input$country
                        } else {TRUE}
                    ) %>%
                    filter(
                        if(input$continent != "All") {
                            Continent ==input$continent
                        } else {TRUE}
                    )
                write.csv(data, con, row.names = TRUE) #saves the filtered data
            }
        )
}
