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
          projet_acheve = sum(etat_du_projet %in% "Achev\u00e9"),
          engagement_brut = sum(engagements_bruts_euro, na.rm = TRUE),
          versement = sum(versements_euro, na.rm = TRUE)
        ) %>% 
        reactable::reactable(
          defaultColDef = reactable::colDef(
            align = "center",
            minWidth = 70,
            headerStyle = list(background = "#f7f7f8")
          ),
          defaultSorted = "region",
          columns = list(
            region = reactable::colDef(name = "Region"),
            pays_distinct = reactable::colDef(name = "Nombre de pays"),
            projet_total = reactable::colDef(name = "Nombre projet total"),
            projet_acheve = reactable::colDef(name  = "Nombre de projet achev\u00e9"),
            engagement_brut = reactable::colDef(
              name  = "Engagement brut",
              format = reactable::colFormat(currency = "EUR")
            ),
            versement = reactable::colDef(
              name  = "Versement",
              format = reactable::colFormat(currency = "EUR")
            )
          )
        )
    })
  })
}

## To be copied in the UI
# mod_figure_ui("figure_ui_1")

## To be copied in the server
# mod_figure_server("figure_ui_1")
