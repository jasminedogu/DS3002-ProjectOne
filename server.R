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
        if (input$year != "All") {
            data <- df[df$Year == input$year,]
        }
        if (input$country != "All") {
            data <- df[df$Country == input$country,]
        }
        if (input$continent != "All") {
            data <- df[df$Continent == input$continent,]
        }
        
        return(data)

    }))
        # Generate a summary of the dataset ----
        output$summary <- renderPrint({
            if (input$year != "All") {
                data <- df[df$Year == input$year,]
                summary(data)
            }  
            if (input$country != "All") {
                data <- df[df$Country == input$country,]
                summary(data)
            }
            if (input$continent != "All") {
                data <- df[df$Continent == input$continent,]
                summary(data)
            }
            return(summary(data))
            
        })
        output$columns  <- renderText({
            paste("Number of Columns:" , ncol(data) )
        })
        output$rows  <- renderText({
            paste("Number of Rows in Original Dataframe:" , nrow(data) )
        })
        output$rows2  <- renderText({
            paste("See Directly Under the Dataframe for the Updated Number of Rows")
        })
        output$data_ex  <- renderText({
            paste("Please see README.md file for information regarding the dataset.")
        })
        
        # Downloadable csv of selected dataset ----
        output$downloadData <- downloadHandler(
            filename = function() {
                paste(input$data, ".csv", sep = "")
            },
            content = function(file) {
                write.csv(datasetInput(), file, row.names = TRUE)
            }
        )
        
   
    
}
