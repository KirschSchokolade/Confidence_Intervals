library(ConfidenceIntervals)
library(shiny)
library(bslib)


data <- AirPassengers




ui <- bslib::page_fluid(
  titlePanel("Chartjs Widget"),
  mainPanel(
    card(ConfidenceIntervalsOutput("simpleChart")),
    card(verbatimTextOutput("bla")),
  )
)
server <- function(input, output) {

  observeEvent(input$submit, {
    showModal(modalDialog(
      title = "Congrats, you completed your first shinysurvey!",
      "You can customize what actions happen when a user finishes a survey using input$submit."
    ))
  })

  # This is the simplest way of creating a functioning chart.
  output$simpleChart <- renderConfidenceIntervals({
    ConfidenceIntervals(
      insertion_type = "OnlyIntervals",
      element_name = "simpleChart",
      chart_data = data,
      labels= c(1: (length(data) + 10) ),
      enable_zoom = TRUE)

  })



  output$bla <- renderText({
    x <-  input$simpleChart

  })



}

# Run the app ----
shinyApp(ui = ui, server = server)
