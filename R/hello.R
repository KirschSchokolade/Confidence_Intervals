library(shiny)
#library(ConfidenceIntervals)
library(bslib)

ui <- page_fluid(
  titlePanel("Chartjs Widget"),
  mainPanel(
    card(ConfidenceIntervalsOutput("HILF_MIR")),
    card(ConfidenceIntervalsOutput("basicChart")),

    card(
      card_header(
        "This is the most basic chart one can create"
      ),
      ConfidenceIntervalsOutput("simpleChart")
      )

  )
)

# Define server logic ----
server <- function(input, output) {

  # This is the simplest way of creating a functioning chart.
  output$simpleChart <- renderConfidenceIntervals({
    ConfidenceIntervals(
      element_name = "simpleChart",
      chart_data = c(10,11,12,13,14,15),
      labels= c(1,2,3,4,5,6,7,8,9,10))

  })

  output$HILF_MIR <- renderConfidenceIntervals({
    # The widget
    ConfidenceIntervals(insertion_type = "OnlyIntervals",
                        axis_limits = c(1,9),show_legend= FALSE, show_tooltip = FALSE, background_color = "#0466f9",element_name = "HilfMir",
                        color_main = "#E11313", chart_data = c(5,3,5,6), top_band= c(6,6,6,6), bottom_band = c(4,4,4,4), labels= c("Eins", "zwei", "drei", "vier", "sechs", "siebn"),
                        enable_zoom = FALSE)
  })




  # This is the most basic way to create a new chart.
  output$basicChart <- renderConfidenceIntervals({

    ConfidenceIntervals(
                        element_name = "basic_Chart",
                        main_name = "Book Sales",
                        chart_data = c(10,11,12,13,14,15),
                        top_band = c(15,16,17,18,19,20),
                        bottom_band = c(5,6,7,8,9,10),
                        labels= c(1,2,3,4,5,6,7,8,9,10))
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)
