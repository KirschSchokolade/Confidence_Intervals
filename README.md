
<!-- README.md is generated from README.Rmd. Please edit that file -->

# myCharts

<!-- badges: start -->
<!-- badges: end -->

The goal of this project is to enable researchers, in the field of
judgmental forecasting, to include graphs containing confidence
intervals into their shiny apps.

## Installation

You can install the development version of this project from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("KirschSchokolade/Confidence_Intervals")
```

``` r
# install.packages("pak")
pak::pak("KirschSchokolade/Confidence_Intervals")
```

## Example

This is a basic example which shows you how to add a chartjs chart to
your shiny app:

``` r
library(ConfidenceIntervals)
library(shiny)
library(bslib)



ui <- bslib::page_fluid(
  titlePanel("Chartjs Widget"),
  mainPanel(
    card(ConfidenceIntervalsOutput("testchart")),
    card(ConfidenceIntervalsOutput("simpleChart"))
  )
)

server <- function(input, output) {
  output$testchart <- renderConfidenceIntervals({

    # The  widget
    ConfidenceIntervals(insertion_type = "OnlyIntervals",
                        axis_limits = c(1,9),show_legend= FALSE, show_tooltip = FALSE, background_color = "#0466f9",
                        color_main = "#E11313", chart_data = c(5,3,5,6), top_band= c(6,6,6,6), bottom_band = c(4,4,4,4), labels= c("Eins", "zwei", "drei", "vier", "sechs"))
  })
  
# This is the most basic way to create a new chart.
  output$simpleChart <- renderConfidenceIntervals({

    ConfidenceIntervals(
                        chart_data = c(10,11,12,13,14,15),
                        top_band = c(15,16,17,18,19,20),
                        bottom_band = c(5,6,7,8,9,10),
                        labels= c(1,2,3,4,5,6,7,8,9,10))
  })
}

# Run the app ----
# shinyApp(ui = ui, server = server)
```

The following block explains the parameters which were used in the above
example.

- insertion_type: Which of the three possible graphs to create.
- axis_limits: Setting the (min,max) value of the y-axis.
- show_legend: Whether the legend is shown or not.
- show_tooltip: Whether the tooltips are shown or not.
- background_color: The infill color of the interval.
- color_main: Color of the point forecast.
- chart_data: Data for the point forecast.
- top_band/bottom_band: Data for the upper/lower interval boundaries.
- labels: The labels displayed on the x-axis.
