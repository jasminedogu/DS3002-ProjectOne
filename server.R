# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(ggplot2)
library(dplyr)
library(countrycode)
library(shiny)



function(input, output) {
    #reading in the data and basic data cleaning 
    df <- read.csv("world-happiness-report.csv")
    df <- df %>%  #changing column names 
        rename(
            Year = year,
            Ladder = Life.Ladder, 
            GDP = Log.GDP.per.capita, 
            Social = Social.support, 
            Life_Expectancy = Healthy.life.expectancy.at.birth,
            Freedom = Freedom.to.make.life.choices,
            Corruption = Perceptions.of.corruption,
            Positive_Affect = Positive.affect,
            Negative_Affect = Negative.affect
        )
    
    df<- df %>%
        mutate(Continent = countrycode(Country, 'country.name', 'continent')) %>%   
        group_by(Continent)
    
    df <- na.omit(df) 
    #View(df)
    data<- df
    
    # Filter data based on selections
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
        # Generate a summary of the dataset ----
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
        
        return(nrow(data))
    }
    
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
        
        return(ncol(data))
    }
    
        output$columns  <- renderText({
            paste("Number of Columns:" , cols() )
        })
        output$rows  <- renderText({
            paste("Number of Rows:" , rows() )
        })

        output$data_ex  <- renderText({
            paste("Please see README.md file for information regarding the dataset.")
        })
 
        # Downloadable csv of selected dataset ----
        
        
        
        output$downloadData <- downloadHandler(
            filename = function() {
                selected <-c()
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
            content = function(con) {
                if (input$year != "All") {
                    data <- df[df$Year == input$year,]
                }
                if (input$country != "All") {
                    data <- df[df$Country == input$country,]
                }
                if (input$continent != "All") {
                    data <- df[df$Continent == input$continent,]
                }
                write.csv(data, con, row.names = TRUE)
            }
        )
        
   
    
}
