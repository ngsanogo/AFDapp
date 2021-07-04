#' chart UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_chart_ui <- function(id){
  ns <- NS(id)
  tagList(
    h2("L'AFD en graphiques"),
    echarts4r::echarts4rOutput(ns("plot1")),
    highcharter::highchartOutput(ns("plot2"))
  )
}

#' chart Server Functions
#'
#' @noRd 
mod_chart_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    # Pie chart : nombre de projet par r\u00e9gion
    output$plot1 <- echarts4r::renderEcharts4r({
      dataset %>%
        dplyr::group_by(region) %>% 
        dplyr::summarise(
          projet_total = length(unique(id_projet)),
          projet_acheve = sum(etat_du_projet %in% "Achev\u00e9"),
          projet_execution = sum(etat_du_projet %in% "Ex\u00e9cution")
        ) %>% 
        echarts4r::e_charts(region)  %>%  
        echarts4r::e_bar(projet_acheve, dodge = "grp", name = "Projet achev\u00e9") %>%
        echarts4r::e_bar(projet_execution , dodge = "grp", name = "Projet ex\u00e9cution") %>%
        echarts4r::e_labels() %>% 
        echarts4r::e_title("Nombre de projet par r\u00e9gion") %>%
        echarts4r::e_legend()
    })
    output$plot2 <- highcharter::renderHighchart({
      dataset %>%
        dplyr::group_by(region) %>% 
        dplyr::summarise(
          n_pays = length(unique(pays_de_realisation))
        ) %>% 
        highcharter::hchart("treemap",
                            highcharter::hcaes(x = region, value = n_pays),
                            color = "#66ffcc") %>%
        highcharter::hc_title(
          text = "Nombre de pays par region"
        ) 
    })
  })
}

## To be copied in the UI
# mod_chart_ui("chart_ui_1")

## To be copied in the server
# mod_chart_server("chart_ui_1")
