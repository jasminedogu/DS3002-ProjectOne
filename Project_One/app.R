if (interactive()) {
    
    library(shiny)
    library(shinyWidgets)
    library(ggplot2)
    library(esquisse)
    
    
    ui <- fluidPage(
        tags$h1("Texas Housing Dataset"),
        tags$h3("DS 3002, Project One"),
        tags$h4("By Jasmine Dogu (ejd5mm)"),
        
        
        radioButtons(
            inputId = "dataset", 
            label = "Data:",
            choices = c(
                "txhousing"
            ),
            inline = TRUE
        ),
        
        fluidRow(
            column(
                width = 3,
                filterDF_UI("filtering")
            ),
            column(
                width = 9,
                progressBar(
                    id = "pbar", value = 100, 
                    total = 100, display_pct = TRUE
                ),
                DT::dataTableOutput(outputId = "table"),
                tags$p("Code Shown Using Package dplyr:"),
                verbatimTextOutput(outputId = "code_dplyr"),
                tags$p("Code as Expression:"),
                verbatimTextOutput(outputId = "code"),
                tags$p("Filtered Data Summary:"),
                verbatimTextOutput(outputId = "res_str"),
                
                
            )
        )
    )
    
    server <- function(input, output, session) {
        
        data <- read.csv(file = '/Users/jasminedogu/Documents/data/DS3002-ProjectOne/Project_One/world-happiness-report.csv')
            
            
         #   reactive({
         #   get(input$dataset)
        #})
    
        res_filter <- callModule(
            module = filterDF, 
            id = "filtering", 
            data_table = data,
            data_name = reactive(input$dataset)
        )
        
        observeEvent(res_filter$data_filtered(), {
            updateProgressBar(
                session = session, id = "pbar", 
                value = nrow(res_filter$data_filtered()), total = nrow(data())
            )
        })
        
        output$table <- DT::renderDT({
            res_filter$data_filtered()
        }, options = list(pageLength = 5))
        
        
        output$code_dplyr <- renderPrint({
            res_filter$code$dplyr
        })
        output$code <- renderPrint({
            res_filter$code$expr
        })
        
        output$res_str <- renderPrint({
            str(res_filter$data_filtered())
        })
        
    }
    
    shinyApp(ui, server)
    
}