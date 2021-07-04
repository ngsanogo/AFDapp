#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  
  # shinymanger
  res_auth <- shinymanager::secure_server(
    check_credentials = shinymanager::check_credentials(credentials)
  )
  # Your application server logic 
  mod_figure_server("figure_ui_1")
  mod_chart_server("chart_ui_1")
  mod_map_server("map_ui_1")
}
