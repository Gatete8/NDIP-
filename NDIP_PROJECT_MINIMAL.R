## Minimal runnable NDIP app for testing institution redirect
library(shiny)
source('login_module.R')

INSTITUTION_APP_URL <- 'http://127.0.0.1:5446'

ui <- fluidPage(
  titlePanel('NDIP Minimal Test App'),
  p('Click the button to open the login overlay and sign in as an institution.'),
  actionButton('open_login', 'Open Login Overlay'),
  login_ui('standalone'),
  tags$script(HTML("Shiny.addCustomMessageHandler('redirectTo', function(msg){ if(msg && msg.url) window.location.href = msg.url; });"))
)

server <- function(input, output, session){
  observeEvent(input$open_login, { session$sendCustomMessage('setHash', list(hash = '#login')) })

  login <- NULL
  if (exists('login_server', mode = 'function')) login <- get('login_server', mode = 'function')('standalone')

  if (!is.null(login) && is.reactive(login$result)) {
    observeEvent(login$result(), {
      res <- login$result()
      if (is.list(res) && isTRUE(res$success)) {
        role <- tolower(as.character(res$role))
        if (!is.na(role) && role == 'institution') {
          session$sendCustomMessage('redirectTo', list(url = INSTITUTION_APP_URL))
          showNotification('Redirecting to Institution Upload Dashboard...', type = 'message')
        } else {
          showNotification('Login successful (non-institution)', type = 'message')
        }
      } else {
        showNotification('Login failed or cancelled', type = 'error')
      }
    })
  }
}

shinyApp(ui, server)
