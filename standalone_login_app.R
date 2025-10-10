## Standalone Login App for NDIP
# Uses: shiny, shinyjs, reactiveValues
# Behavior: If credentials match admin@nisr.gov.rw / demo123, redirect browser to the standalone admin app URL.

library(shiny)
library(shinyjs)

### CONFIG: Set the admin app URL you will run separately
# By default we assume you'll run admin_dashboard_app.R on port 5445 locally.
ADMIN_APP_URL <- 'http://127.0.0.1:5445'

ui <- fluidPage(
  useShinyjs(),
  tags$head(tags$style(HTML(".login-box{ max-width:420px; margin:60px auto; padding:24px; border-radius:12px; background:#f4fbf6; box-shadow:0 6px 24px rgba(10,30,10,0.04);} .error{ color:#b00020; font-weight:700; }"))),
  div(class = 'login-box',
      tags$h3('NDIP - Admin Login'),
      tags$p('Enter admin credentials to continue.'),
      textInput('email', 'Email', value = ''),
      passwordInput('password', 'Password', value = ''),
    actionButton('login', 'Login', class = 'btn btn-success'),
    # server-rendered login error text (safer than direct DOM manipulation)
    tags$div(class = 'error', textOutput('login_error')),
      tags$hr(),
      tags$p(tags$strong('Demo account:'), 'admin@nisr.gov.rw / demo123')
  )
)

server <- function(input, output, session){
  # reactiveValues to hold authentication state
  state <- reactiveValues(authenticated = FALSE, user = NULL)

  # Stored credentials (no DB) - production systems should not store plain passwords
  credentials <- list(email = 'admin@nisr.gov.rw', password = 'demo123')

  # ---- 1. User clicks the login button ----
  observeEvent(input$login, {
    req(input$email, input$password)
    email <- tolower(trimws(input$email))
    pwd <- input$password

    # ---- 2. Validate credentials ----
    if(identical(email, credentials$email) && identical(pwd, credentials$password)){
      # Successful authentication
      state$authenticated <- TRUE
      state$user <- list(email = email, role = 'Admin')

      # ---- 3. Redirect to standalone admin app ----
      # We use shinyjs::runjs() to change the browser location to the admin app URL.
      # This assumes you run the admin app separately (e.g. runApp('admin_dashboard_app.R', port=5445)).
      # clear any previous error and navigate
      output$login_error <- renderText({ '' })
      runjs(sprintf("window.location.href = '%s';", ADMIN_APP_URL))

    } else {
      # Authentication failed -> show inline error on the same login page (rendered by Shiny)
      output$login_error <- renderText({ 'Invalid credentials.' })
    }
  })

  # Allow pressing Enter while focused in the password input to trigger login (improves UX)
  # add a small JS handler that clicks the login button when Enter is pressed in the password field
  observe({
    runjs("(function(){var pw = document.getElementById('password'); if(!pw) return; pw.addEventListener('keypress', function(e){ if(e.key==='Enter'){ var btn = document.getElementById('login'); if(btn) btn.click(); } }); })();")
  })
}

shinyApp(ui, server)

## How to use:
# 1. Open one terminal and run the admin app (edit port if you change it):
#    R -e "shiny::runApp('C:/Users/USER/Desktop/NDIP CODES/admin_dashboard_app.R', port=5445, launch.browser=TRUE)"
# 2. In another terminal, run this login app (choose a different port):
#    R -e "shiny::runApp('C:/Users/USER/Desktop/NDIP CODES/standalone_login_app.R', port=5432, launch.browser=TRUE)"
# 3. Visit the login app (e.g., http://127.0.0.1:5432), sign in using admin@nisr.gov.rw / demo123.
#    On success, the browser will navigate to the admin app URL (http://127.0.0.1:5445).
