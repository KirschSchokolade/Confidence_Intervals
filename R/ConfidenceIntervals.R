#' Creates a new html widget which wraps a chartjs chart instance.
#'
#'
#'
#' @param insertion_type How the confidence intervals are constructed
#' @param chart_data The data for the point forecast
#' @param top_band The data for the upper bound
#' @param bottom_band The data for the lower bound
#' @param labels the labels for the data. Displayed on the x-axis.
#' @param width width of the widget
#' @param height heigth of the widget
#' @param elementId The html id of the chart.
#'
#' @import htmlwidgets
#'
#' @export
ConfidenceIntervals <- function(insertion_type = "PointForecastFirst", chart_data, top_band, bottom_band,labels, width = NULL, height = NULL, elementId = NULL) {
  if (is.null(top_band))
  {
    top_band <- chart_data
  }

  if (is.null(bottom_band))
  {
    bottom_band <- chart_data
  }

  # forward options using x
  x = list(
    insertion_type = insertion_type,
  chart_data = chart_data,
  top_band = top_band,
  bottom_band = bottom_band,
  labels = labels
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'ConfidenceIntervals',
    x,
    width = width,
    height = height,
    package = 'ConfidenceIntervals',
    elementId = elementId
  )
}

widget_html.ConfidenceIntervals <- function(id, style, class, ...){
  htmltools::tags$canvas(id = id,
                      class = class,
                      style = style,
  )
}

#' Shiny bindings for ConfidenceIntervals
#'
#' Output and render functions for using ConfidenceIntervals within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a ConfidenceIntervals
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name ConfidenceIntervals-shiny
#'
#' @export
ConfidenceIntervalsOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'ConfidenceIntervals', width, height, package = 'ConfidenceIntervals')
}

#' @rdname ConfidenceIntervals-shiny
#' @export
renderConfidenceIntervals <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, ConfidenceIntervalsOutput, env, quoted = TRUE)
}
