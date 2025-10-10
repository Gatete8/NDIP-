## NDIP Project — Repaired minimal main app
library(shiny)

# Source the login module
source('login_module.R')

ui <- fluidPage(
  tags$h3('NDIP repaired baseline (login module test)'),
  tags$p('This repaired file is a clean minimal entry that loads the login module.'),
  tags$a(href = '#login', 'Open Login Overlay', class = 'btn btn-primary'),
  login_ui('standalone')
)

server <- function(input, output, session){
  # Safely call module at runtime
  login <- NULL
  if (exists('login_server', mode = 'function')) {
    login <- get('login_server', mode = 'function')('standalone')
  }

  if (!is.null(login) && is.reactive(login$result)) {
    observeEvent(login$result(), {
      if (identical(login$result(), 'ok')) {
        showModal(modalDialog('Demo login successful', easyClose = TRUE))
      }
    })
  }
}

shinyApp(ui, server)
