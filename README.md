
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
#> 
#> Attaching package: 'bslib'
#> The following object is masked from 'package:utils':
#> 
#>     page



ui <- page_fluid(
  titlePanel("Chartjs Widget"),
  mainPanel(
    card(ConfidenceIntervalsOutput("testchart")),
  )
)

server <- function(input, output) {
  output$testchart <- renderConfidenceIntervals({

    # The  widget
    ConfidenceIntervals(insertion_type = "OnlyIntervals", chart_data = c(5,5,5,5), 
             top_band= c(6,6,6,6), bottom_band = c(4,4,4,4), 
                labels= c("Eins", "zwei", "drei", "vier", "sechs"))
  })
}

# Run the app ----
# shinyApp(ui = ui, server = server)
```
