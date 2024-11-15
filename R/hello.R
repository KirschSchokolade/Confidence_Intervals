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
    ConfidenceIntervals(insertion_type = "OnlyIntervals", show_legend= FALSE, show_tooltip = FALSE,
                        color_main = "#E11313", chart_data = c(5,3,5,6), top_band= c(6,6,6,6), bottom_band = c(4,4,4,4), labels= c("Eins", "zwei", "drei", "vier", "sechs"))
  })


}

# Run the app ----
shinyApp(ui = ui, server = server)
