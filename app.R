
library(shiny)

# Define UI for application that plots net worth over time given a budget
ui <- fluidPage(
    titlePanel("Budget"),
    sidebarLayout(
        sidebarPanel(
        dateInput(inputId = "startdate", 
                      label = "Start date", 
                      value = Sys.Date(), 
                      format = "yyyy-mm-dd"),
        dateInput(inputId = "enddate", 
                      label = "End date", 
                      value = Sys.Date() + 730, 
                      format = "yyyy-mm-dd"),
        numericInput(inputId = "initial",
                         label = "Initial amount",
                         value = 10000),
        numericInput(inputId = "paycheck",
                        label = "Paycheck",
                        value = 0),
        dateInput(inputId = "paydate", 
                      label = "Payday", 
                      value = NULL, 
                      format = "yyyy-mm-dd"),
        textInput(inputId = "payrecur",
                      label = "Recurring",
                      value = "monthly"),   
        textOutput("text1"),
        sliderInput(inputId = "rent",
                    label = "Rent",
                    min = 0,
                    max = 5000,
                    value = 1200),
        dateInput(inputId = "rentdate", 
                  label = "Rent due date", 
                  value = NULL, 
                  format = "yyyy-mm-dd"),
        textInput(inputId = "rentrecur",
                  label = "Recurring",
                  value = "monthly"),
        sliderInput(inputId = "pet",
                    label = "Pet Care",
                    min = 0,
                    max = 100,
                    value = 75),
        dateInput(inputId = "petdate", 
                  label = "Pet care liability", 
                  value = NULL, 
                  format = "yyyy-mm-dd"),
        textInput(inputId = "petrecur",
                  label = "Recurring",
                  value = "monthly"),
        sliderInput(inputId = "groceries",
                    label = "Groceries",
                    min = 0,
                    max = 300,
                    value = 100),
        dateInput(inputId = "grocdate", 
                  label = "Grocery day", 
                  value = NULL, 
                  format = "yyyy-mm-dd"),
        textInput(inputId = "grocrecur",
                  label = "Recurring",
                  value = "monthly"),
        sliderInput(inputId = "dine",
                    label = "Dining + Drinks/Going Out",
                    min = 0,
                    max = 200,
                    value = 75),
        dateInput(inputId = "dinedate", 
                  label = "Dining payment cycle", 
                  value = NULL, 
                  format = "yyyy-mm-dd"),
        textInput(inputId = "dinerecur",
                  label = "Recurring",
                  value = "monthly"),
        sliderInput(inputId = "transpo",
                    label = "Transportation",
                    min = 0,
                    max = 150,
                    value = 30),
        dateInput(inputId = "transdate", 
                  label = "Transportation payment cycle", 
                  value = NULL, 
                  format = "yyyy-mm-dd"),
        textInput(inputId = "transrecur",
                  label = "Recurring",
                  value = "monthly"),
        sliderInput(inputId = "misc",
                    label = "Miscellaneous",
                    min = 0,
                    max = 200,
                    value = 50),
        dateInput(inputId = "miscdate", 
                  label = "Misc. payments cycle", 
                  value = NULL, 
                  format = "yyyy-mm-dd"),
        textInput(inputId = "miscrecur",
                  label = "Recurring",
                  value = "monthly")
    ),
        mainPanel(
            plotOutput("plot")
        )
    )
)

# Define server logic required to plot budget
server <- function(input, output) {
library(budgetr)
    output$plot <- renderPlot({
       plot(create_budget(create_schedule(create_item(name = "Paycheck", amount = input$paycheck, day = input$paydate, recurring = input$payrecur),
                                          create_item(name = "Rent", amount = -(input$rent), day = input$rentdate, recurring = input$rentrecur), 
                                            create_item(name = "Pet Care", amount = -(input$pet), day = input$petdate, recurring = input$petrecur), 
                                            create_item(name = "Groceries", amount = -(input$groceries), day = input$grocdate, recurring = input$grocrecur),
                                            create_item(name = "Dining", amount = -(input$dine), day = input$dinedate, recurring = input$dinerecur), 
                                            create_item(name = "Transportation", amount = -(input$transpo), day = input$transdate, recurring = input$transrecur), 
                                            create_item(name = "Miscellaneous", amount = -(input$misc), day = input$miscdate, recurring = input$miscrecur)),
                            start = input$startdate,
                            end = input$enddate,
                            initial = input$initial))
    })
    output$text1 <- renderText({
        "'Recurring' options include 'daily', 'weekly', 'monthly', 'yearly', or 
        'X days', 'X weeks', 'X months', 'X years'"
    })
  
}

# Run the application 
shinyApp(ui = ui, server = server)



