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
    # Pie chart : nombre de projet par région
    output$plot1 <- echarts4r::renderEcharts4r({
      dataset %>%
        dplyr::group_by(region) %>% 
        dplyr::summarise(
          projet_total = length(unique(id_projet)),
          `Projet achevé` = sum(etat_du_projet %in% "Achevé"),
          `Projet en exécution` = sum(etat_du_projet %in% "Exécution")
        ) %>% 
        echarts4r::e_charts(region)  %>%  
        echarts4r::e_bar(`Projet achevé`, dodge = "grp") %>%
        echarts4r::e_bar(`Projet en exécution` , dodge = "grp") %>%
        echarts4r::e_labels() %>% 
        echarts4r::e_title("Nombre de projet par région") %>%
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
