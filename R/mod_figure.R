#' figure UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_figure_ui <- function(id){
  ns <- NS(id)
  tagList(
 h2("L'AFD en quelques chiffres"),
 reactable::reactableOutput(ns("table"))
  )
}
    
#' figure Server Functions
#'
#' @noRd 
mod_figure_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$table <- reactable::renderReactable({
      dataset %>%
        dplyr::group_by(region) %>%
        dplyr::summarise(
          pays_distinct = length(unique(pays_de_realisation)),
          projet_total = length(unique(id_projet)),
          projet_achevé = sum(etat_du_projet %in% "Achevé"),
          engagement_brut = sum(engagements_bruts_euro, na.rm = TRUE),
          versement = sum(versements_euro, na.rm = TRUE),
          cofinancier = sum(cofinanciers_o_n %in% "Oui")
          ) %>% 
      reactable::reactable()
    })
  })
}
    
## To be copied in the UI
# mod_figure_ui("figure_ui_1")
    
## To be copied in the server
# mod_figure_server("figure_ui_1")
