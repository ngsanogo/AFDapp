#' map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_map_ui <- function(id){
  ns <- NS(id)
  tagList(
    h2("Projets en cours d'ex\u00e9cution depuis 2018"),
    leaflet::leafletOutput(ns("map"))
  )
}
    
#' map Server Functions
#'
#' @noRd 
mod_map_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$map <- leaflet::renderLeaflet({
      dataset %>%
        dplyr::distinct(id_projet, .keep_all = TRUE) %>% 
        dplyr::mutate(
          content = paste(
            sep = "<br/>",
            paste0("<b style='color:Tomato;'>Id projet : </b>", id_projet),
            paste0("<b style='color:Tomato;'>Nom du projet : </b>", nom_du_projet_pour_les_instances),
            paste0("<b style='color:Tomato;'>Date 1er versement : </b>", format(date_de_1er_versement_projet, "%d/%m/%Y"))
          ),
          year = as.numeric(substr(date_d_octroi, 1, 4))
        ) %>%
        dplyr::filter(
          etat_du_projet %in% "Ex\u00e9cution" &
                 year %in% 2018
          ) %>% 
        leaflet::leaflet() %>% 
        leaflet::addTiles() %>%  # Add default OpenStreetMap map tiles
        leaflet::addMarkers(
          lng = ~longitude,
          lat = ~latitude,
          popup = ~content,
          clusterOptions = leaflet::markerClusterOptions()
        )
    })
  })
}
    
## To be copied in the UI
# mod_map_ui("map_ui_1")
    
## To be copied in the server
# mod_map_server("map_ui_1")
