library(shiny)
# library(myCharts)
library(bslib)

ui <- page_fluid(
  titlePanel("Chartjs Widget"),
  mainPanel(
    card(MyChartsOutput("HILF_MIR")),
    card(MyChartsOutput("testing")),
    card(MyChartsOutput("blabla")),

  )
)

# Define server logic ----
server <- function(input, output) {
  output$HILF_MIR <- renderMyCharts({

    # The MyCharts widget
    MyCharts(insertion_type = "OnlyIntervals", chart_data = c(5,5,5,5), top_band= c(6,6,6,6), bottom_band = c(4,4,4,4), labels= c("Eins", "zwei", "drei", "vier", "sechs"))
  })

  output$testing <- renderMyCharts({

    # The MyCharts widget
    MyCharts(insertion_type = "PointForecastFirst", chart_data = c(5,5,5,5), top_band= c(6,6,6,6), bottom_band = c(4,4,4,4), labels= c("Eins", "zwei", "drei", "vier", "sechs"))
  })

  output$blabla <- renderMyCharts({

    # The MyCharts widget
    MyCharts(insertion_type = "IntervalFirst", chart_data = c(5,5,5,5), top_band= c(6,6,6,6), bottom_band = c(4,4,4,4), labels= c("Eins", "zwei", "drei", "vier", "sechs"))
  })

}

# Run the app ----
shinyApp(ui = ui, server = server)
