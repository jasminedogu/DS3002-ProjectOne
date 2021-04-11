# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(shiny)
library(shinyWidgets)

fluidPage(
    #text with project name and my information
    titlePanel("World Happiness Report"),
    tags$h3("DS 3002- Project One"),
    tags$h4("Elit Dogu, ejd5mm 3rd Year UVA"),
    # use a gradient in background, setting background color to blue
    setBackgroundColor(  
        #https://rdrr.io/cran/shinyWidgets/man/setBackgroundColor.html used this website for help on background color
        color = c("#F7FBFF", "#2171B5"),
        gradient = "radial",
        direction = c("top", "left")
    ),
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Output: Header + summary of distribution ----
            h4("Summary"),
            verbatimTextOutput("summary"),
            
            # Download button
            downloadButton("downloadData", "Download")
        ),
    # Create a new Row in the UI for selectInputs
    # Main panel for displaying outputs ----
    mainPanel(

    fluidRow(  #manipulates the original dataframe given user selection
        column(4,
               selectInput("year",  #selection for the year variable
                           "Year:",
                           c("All",
                             unique(as.numeric(df$Year))))
        ),
        column(4,
               selectInput("country",  #selection for the country variable
                           "Country:",
                           c("All",
                             unique(as.character(df$Country))))
        ),
        column(4,
               selectInput("continent",  #selection for the continent variable
                           "Continent:",
                           c("All",
                             unique(as.character(df$Continent))))
        )
    ),
    # Create a new row for the table
    DT::dataTableOutput("table"),
    
    # Create a new column for the text to be displayed
    column(12,
           verbatimTextOutput("columns") #column to display col count
    ),
    column(12,
           verbatimTextOutput("rows") #column to display row count
    ),

    column(12,
           verbatimTextOutput("data_ex") #column to display more information text
            )
        )
    )
)
