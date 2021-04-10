# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(shiny)

fluidPage(
    titlePanel("World Happiness Reports"),
    tags$h3("DS 3002- Project One"),
    tags$h4("Elit Dogu, ejd5mm 3rd Year UVA"),
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Output: Header + summary of distribution ----
            h4("Summary"),
            verbatimTextOutput("summary"),
            
            # Button
            downloadButton("downloadData", "Download")
        ),
    # Create a new Row in the UI for selectInputs
    # Main panel for displaying outputs ----
    mainPanel(
        
    fluidRow(
        column(4,
               selectInput("year",
                           "Year:",
                           c("All",
                             unique(as.numeric(df$Year))))
        ),
        column(4,
               selectInput("country",
                           "Country:",
                           c("All",
                             unique(as.character(df$Country))))
        ),
        column(4,
               selectInput("continent",
                           "Continent:",
                           c("All",
                             unique(as.character(df$Continent))))
        )
    ),
    # Create a new row for the table.
    DT::dataTableOutput("table"),
    column(12,
           verbatimTextOutput("columns")
    ),
    column(12,
           verbatimTextOutput("rows")
    ),
    column(12,
           verbatimTextOutput("rows2")
    ),
    column(12,
           verbatimTextOutput("data_ex")
    )
    
   )
    )

)
