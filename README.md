
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

For the most basic chart it is suffice to only provide data and labels.
The resulting chart will add data to the point forecast first and then
you construct the interval around it. The chart will be black and the
infill of the interval will be white. The legend also will be shown.

For the second chart the data for the upper and lower boundary of the
interval are provided and the name of the “main” data set is set to
“book sales”. For both, the first and second chart the axis-limits are
calculated automatically.

The third chart is uses nearly all available options to create a red
point forecast, black borders for the interval and a blue infill. Also
the legend and the tool tips are hidden from the user. The scale of the
y-axis is also set to a specifc range.

``` r
library(ConfidenceIntervals)
library(shiny)
library(bslib)



ui <- bslib::page_fluid(
  titlePanel("Chartjs Widget"),
  mainPanel(
    card(ConfidenceIntervalsOutput("simpleChart")),
    card(ConfidenceIntervalsOutput("basicChart")),
    card(ConfidenceIntervalsOutput("testchart")),
  )
)

server <- function(input, output) {
  
  # This is the simplest way of creating a functioning chart.
  output$simpleChart <- renderConfidenceIntervals({
    ConfidenceIntervals(
                        chart_data = c(10,11,12,13,14,15),
                        labels= c(1,2,3,4,5,6,7,8,9,10))
    
  })
  
  # This is a basic way to create a new chart.
  output$basicChart <- renderConfidenceIntervals({

    ConfidenceIntervals(
                        main_name = "Sales",
                        chart_data = c(10,11,12,13,14,15),
                        top_band = c(15,16,17,18,19,20),
                        bottom_band = c(5,6,7,8,9,10),
                        labels= c(1,2,3,4,5,6,7,8,9,10))
  })
  
  # A more complex custom chart with many options used.
  output$testchart <- renderConfidenceIntervals({
    ConfidenceIntervals(insertion_type = "OnlyIntervals",
                        axis_limits = c(1,9),
                        show_legend= FALSE,
                        show_tooltip = FALSE,
                        background_color = "#0466f9", color_main = "#E11313",
                        chart_data = c(5,3,5,6), top_band= c(6,6,6,6), bottom_band = c(4,4,4,4),
                        labels= c("Eins", "zwei", "drei", "vier", "sechs"))
  })
  
}

# Run the app ----
# shinyApp(ui = ui, server = server)
```

The following block explains the parameters which were used in the above
example.

- insertion_type: Which of the three possible graphs to create.

  - PointForecastFirst: The default option. For each step, first the
    point forecast is made and then the interval is constructed.
  - OnlyIntervals: Only the intervals are created.
  - IntervalFirst: For each step, first the interval is created and then
    the point forecast is made.

- axis_limits: Setting the (min,max) value of the y-axis.

  If no values are provided the min/max value for the y-axis gets
  calculated as such:

  - `axis_max <- max(unlist(top_band)) * 2`
  - `axis_min <- min(unlist(bottom_band)) * 0.5`

- show_legend: Whether the legend is shown or not.

- show_tooltip: Whether the tooltips are shown or not.

- background_color: The infill color of the interval.

  - Defaults to white.

- color_main: Color of the point forecast.

  - Defaults to black.

- chart_data: Data for the point forecast.

- top_band/bottom_band: Data for the upper/lower interval boundaries.

- labels: The labels displayed on the x-axis.
