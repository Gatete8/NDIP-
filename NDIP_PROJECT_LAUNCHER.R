## NDIP PROJECT 1 - Minimal Launcher (safe copy)
## Purpose: small, parseable entrypoint that points to standalone apps.

library(shiny)
library(bslib)
library(shinyjs)

app_theme <- bs_theme(version = 5, bootswatch = "flatly")

ui <- fluidPage(
  useShinyjs(),
  theme = app_theme,
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  div(class = "container", style = "max-width:900px; margin:28px auto; padding:18px;",
      h1("NDIP - Launcher"),
      p("This file is a minimal launcher. Run the full dashboards as standalone apps in separate R sessions."),
      tags$ul(
        tags$li("admin_dashboard_app.R  (recommended port: 5445)"),
        tags$li("standalone_login_app.R (recommended port: 5432)"),
        tags$li("institution_upload_app.R (recommended port: 5446)")
      ),
      br(),
      fluidRow(
        column(6, actionButton('info_admin', 'How to run Admin App')),
        column(6, actionButton('info_institution', 'How to run Institution App'))
      ),
      br(),
      tags$pre("# Example commands (run in separate R sessions):\n# shiny::runApp('admin_dashboard_app.R', port=5445, launch.browser=TRUE)\n# shiny::runApp('standalone_login_app.R', port=5432, launch.browser=TRUE)\n# shiny::runApp('institution_upload_app.R', port=5446, launch.browser=TRUE)")
  )
)

server <- function(input, output, session){
  observeEvent(input$info_admin, {
    showNotification("Open a new R session and run: shiny::runApp('admin_dashboard_app.R', port=5445, launch.browser=TRUE)", type = 'message', duration = 6)
  })
  observeEvent(input$info_institution, {
    showNotification("Open a new R session and run: shiny::runApp('institution_upload_app.R', port=5446, launch.browser=TRUE)", type = 'message', duration = 6)
  })
}

shinyApp(ui, server)
