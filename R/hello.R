library(shiny)
library(ConfidenceIntervals)
library(bslib)

ui <- page_fluid(
  titlePanel("Chartjs Widget"),
  mainPanel(
    card(ConfidenceIntervalsOutput("HILF_MIR")),
    card(ConfidenceIntervalsOutput("testing")),
    card(ConfidenceIntervalsOutput("blabla")),

  )
)

# Define server logic ----
server <- function(input, output) {
  output$HILF_MIR <- renderConfidenceIntervals({

    # The widget
    ConfidenceIntervals(insertion_type = "OnlyIntervals", chart_data = c(5,5,5,5), top_band= c(6,6,6,6), bottom_band = c(4,4,4,4), labels= c("Eins", "zwei", "drei", "vier", "sechs"))
  })

  output$testing <- renderConfidenceIntervals({

    # The widget
    ConfidenceIntervals(insertion_type = "PointForecastFirst", chart_data = c(5,5,5,5), top_band= c(6,6,6,6), bottom_band = c(4,4,4,4), labels= c("Eins", "zwei", "drei", "vier", "sechs"))
  })

  output$blabla <- renderConfidenceIntervals({

    # The widget
    ConfidenceIntervals(insertion_type = "IntervalFirst", chart_data = c(5,5,5,5), top_band= c(6,6,6,6), bottom_band = c(4,4,4,4), labels= c("Eins", "zwei", "drei", "vier", "sechs"))
  })

}

# Run the app ----
shinyApp(ui = ui, server = server)
