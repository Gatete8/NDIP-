## Admin Dashboard Shiny App (standalone)
## Shows a polished admin UI only when logged in as admin@nisr.gov.rw / demo123

library(shiny)
library(shinyjs)
library(bslib)
library(plotly)
library(DT)

## Sample data matching the reference screenshots
months <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep")
subs <- c(15, 20, 24, 32, 28, 35, 46, 38, 12)

sectors <- data.frame(
  sector = c("Health","Education","Agriculture","Economy","Infrastructure"),
  count = c(89,67,45,32,14)
)

ui_login <- function(namespace = ""){
  ns <- function(id) paste0(namespace, id)
  fluidPage(
    theme = bs_theme(version = 4, base_font = font_google("Inter")),
    tags$head(
      tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"),
      tags$style(HTML(
"/* Basic layout and color tokens */
.ndip-header{ background:#f1fdf2; padding:12px 20px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid rgba(0,0,0,0.04); }
.ndip-brand{ display:flex; align-items:center; gap:12px }
.ndip-logo{ width:48px; height:48px; background:#1f8a2d; color:white; display:flex; align-items:center; justify-content:center; font-weight:700; border-radius:8px; font-size:20px }
.ndip-title{ line-height:1 }
.ndip-title h1{ margin:0; color:#1b5e20; font-weight:700; font-size:22px }
.ndip-sub{ margin:0; color:#6b6b6b; font-size:12px }
.ndip-user{ display:flex; align-items:center; gap:12px }
.ndip-user .name{ font-weight:600; color:#144a2b }
.avatar{ width:36px; height:36px; background:#dfeee2; border-radius:50%; display:flex; align-items:center; justify-content:center; font-weight:700; color:#0c3e17 }
.admin-badge{ background:#ffdde0; color:#9d1f2b; padding:4px 8px; border-radius:12px; font-size:11px; }

/* Tabs */
.ndip-tabs{ margin:18px auto 0; display:flex; justify-content:center }
.ndip-tabs .nav{ background:transparent; }
.ndip-tabs .nav .nav-link{ border-radius:999px; padding:10px 18px; color:#3b6b52; margin:0 6px; border:1px solid transparent }
.ndip-tabs .nav .nav-link.active{ background:white; border-color:#e6f4ea; box-shadow:0 1px 0 rgba(0,0,0,0.02); }
.ndip-tabs .nav .nav-link:hover{ background:#f6fbf7 }

.stat-row{ display:flex; gap:18px; margin-top:18px }
.stat-card{ background:#eef9ef; border-radius:12px; padding:18px; flex:1; box-shadow:0 4px 10px rgba(17,40,21,0.04); position:relative }
.stat-card .icon{ position:absolute; right:14px; top:12px; color:rgba(0,0,0,0.15); font-size:18px }
.stat-card .big{ font-weight:800; font-size:28px; color:#113c19 }
.muted{ color:#4f6b54; font-size:12px }

.sub-tabs{ margin-top:16px; display:flex; gap:12px }
.sub-tabs .pill{ padding:8px 14px; border-radius:999px; background:transparent; border:1px solid transparent }
.sub-tabs .pill.active{ background:white; border:1px solid #e6f4ea }

.card{ background:#f4fbf6; border-radius:12px; padding:18px; box-shadow:0 3px 8px rgba(10,30,10,0.03); }
.chart-placeholder{ height:320px }

.summary-cards{ display:flex; gap:12px; margin-top:18px }
.summary-card{ flex:1; padding:16px; border-radius:12px; background:#f7fdf8; box-shadow:0 2px 6px rgba(10,30,10,0.02) }
.summary-card .num{ font-weight:800; font-size:24px }
.summary-card .label{ color:#6b6b6b; font-size:12px }

.sectors-row{ display:flex; gap:18px }
.pie-legend{ margin-left:18px }

@media (max-width:900px){ .stat-row, .summary-cards, .sectors-row{ flex-direction:column } }
"))
    ),

    # Header
    div(class = "ndip-header",
        div(class = "ndip-brand",
            div(class = "ndip-logo", "N"),
            div(class = "ndip-title",
                tags$h1("NDIP"),
                tags$p(class = "ndip-sub","National Data Intelligence Platform")
            )
        ),
        div(class = "ndip-user",
            div(class = "name", "NISR Administrator"),
            div(class = "avatar","NA"),
            div(class = "admin-badge","Admin")
        )
    ),

    # Main login card
    fluidRow(column(4, offset = 4,
      div(style = "margin-top:30px;",
          div(class = "card",
              tags$h3("Admin login"),
              tags$p("Enter admin credentials to access the admin dashboard."),
              textInput(ns("email"), "Email", value = ""),
              passwordInput(ns("password"), "Password"),
              actionButton(ns("login"), "Login", class = "btn btn-success"),
              tags$div(style = "margin-top:8px; color:#6b6b6b;", "Tip: admin@nisr.gov.rw / demo123"),
              tags$div(style = "margin-top:8px; color:#b00020; font-weight:600;", textOutput(ns("login_error")))
          )
      )
    ))
  )
}

ui_dashboard <- function(){
  fluidPage(
    useShinyjs(),
    theme = bs_theme(version = 4, base_font = font_google("Inter")),
    tags$head(tags$style(HTML("
  # JS: if URL hash requests a specific page, activate the corresponding tab (e.g. #page=demographics)
  tags$head(tags$script(HTML("(function(){ var h = window.location.hash || ''; if(h.indexOf('#page=demographics')===0){ setTimeout(function(){ var a = document.querySelector('a[href=\"#demographics\"]'); if(a){ a.click(); } }, 250); } })();"))),
      body{ background:#ffffff }
      .container-main{ padding:20px 28px }
    "))),
  div(class = "ndip-header",
    div(class = "ndip-brand",
      div(class = "ndip-logo", "N"),
      div(class = "ndip-title",
        tags$h1("NDIP"),
        tags$p(class = "ndip-sub","National Data Intelligence Platform")
      )
    ),
    div(class = "ndip-user",
      div(class = "name", "NISR Administrator"),
      div(class = "avatar","NA"),
      div(class = "admin-badge","Admin"),
      actionButton('logout_btn', 'Logout', class = 'btn btn-outline-secondary', style = 'margin-left:12px;')
    )
  ),

    div(class = "container-main",

      # Main title
      tags$div(style = "padding-top:20px; padding-bottom:10px;",
               tags$h2(style = "color:#124b20; font-weight:800; margin-bottom:6px; font-size:32px;","Admin Dashboard"),
               tags$p("Manage data submissions, review uploads, and monitor platform activity.")
      ),

      # Tabs
      div(class = "ndip-tabs",
          tags$ul(class = "nav nav-pills",
              tags$li(class = "nav-item", tags$a(class = "nav-link active", `data-toggle` = "tab", href = "#overview", tags$i(class = "fa fa-chart-line"), " Overview")),
              tags$li(class = "nav-item", tags$a(class = "nav-link", `data-toggle` = "tab", href = "#submissions", tags$i(class = "fa fa-database"), " Submissions")),
              tags$li(class = "nav-item", tags$a(class = "nav-link", `data-toggle` = "tab", href = "#institutions", tags$i(class = "fa fa-building"), " Institutions")),
              tags$li(class = "nav-item", tags$a(class = "nav-link", `data-toggle` = "tab", href = "#settings", tags$i(class = "fa fa-gear"), " Settings"))
        ,
        tags$li(class = "nav-item", tags$a(class = "nav-link", `data-toggle` = "tab", href = "#demographics", tags$i(class = "fa fa-seedling"), " Demographics & Agriculture"))
          )
      ),

      # Content area
      tags$div(class = "tab-content", style = "margin-top:16px;",
        tags$div(class = "tab-pane active", id = "overview",
                 # Stat cards
                 div(class = "stat-row",
                     div(class = "stat-card",
                         tags$i(class = "fa fa-upload icon"),
                         tags$p("Total Submissions", class = "muted"),
                         tags$div(class = "big", "247"),
                         tags$p(class = "muted", tags$small("+12% from last month"))
                     ),
                     div(class = "stat-card",
                         tags$i(class = "fa fa-clock icon"),
                         tags$p("Pending Review", class = "muted"),
                         tags$div(class = "big", style = "color:#d2691e;","12"),
                         tags$p(class = "muted", tags$small("Avg. processing: 2.3 days"))
                     ),
                     div(class = "stat-card",
                         tags$i(class = "fa fa-check icon"),
                         tags$p("Approval Rate", class = "muted"),
                         tags$div(class = "big", style = "color:#0b7a24;","80.2%"),
                         tags$div(style = "height:8px; background:#dff3df; border-radius:999px; margin-top:8px; overflow:hidden;", div(style = "width:80%; height:100%; background:#0b7a24;"))
                     ),
                     div(class = "stat-card",
                         tags$i(class = "fa fa-users icon"),
                         tags$p("Active Institutions", class = "muted"),
                         tags$div(class = "big","12/15"),
                         tags$div(style = "height:8px; background:#dff3df; border-radius:999px; margin-top:8px; overflow:hidden;", div(style = "width:80%; height:100%; background:#0b7a24;"))
                     )
                 ),

                 # Sub-tabs under stats
                 div(class = "sub-tabs",
                     tags$button(class = "pill active", "Submissions"),
                     tags$button(class = "pill", "Sectors"),
                     tags$button(class = "pill", "Institutions")
                 ),

                 # Submissions Over Time chart
                 div(class = "card", style = "margin-top:12px;",
                     tags$h4("Submissions Over Time"),
                     plotlyOutput("line_chart", height = "360px")
                 ),

                 # Summary below
                 div(class = "summary-cards",
                     div(class = "summary-card", style = "border-left:6px solid #0b7a24;",
                         div(class = "num", "198"),
                         div(class = "label", "Approved"),
                         div(style = "margin-top:8px; color:#6b6b6b; font-size:12px;","80.2%")
                     ),
                     div(class = "summary-card", style = "border-left:6px solid #da3b3b;",
                         div(class = "num", style = "color:#da3b3b;","37"),
                         div(class = "label", "Rejected"),
                         div(style = "margin-top:8px; color:#6b6b6b; font-size:12px;","15.0%")
                     ),
                     div(class = "summary-card", style = "border-left:6px solid #3b6cff;",
                         div(class = "num", style = "color:#3b6cff;","198"),
                         div(class = "label", "Published Datasets"),
                         div(style = "margin-top:8px; color:#6b6b6b; font-size:12px;","Public & Restricted")
                     )
                 )
        ),

        tags$div(class = "tab-pane", id = "submissions",
                 tags$h4("(Submissions tab - content placeholder)")
        ),

        tags$div(class = "tab-pane", id = "institutions",
                 tags$h4("(Institutions tab - content placeholder)")
        ),

        tags$div(class = "tab-pane", id = "settings",
                 tags$h4("(Settings tab - content placeholder)")
        )
          ,
          tags$div(class = "tab-pane", id = "demographics",
                   div(class = "card",
                       tags$h3("Demographics & Agriculture Dashboard"),
                       tags$p("Overview and visualizations for population, vital statistics, labour force, agriculture and land use."),
                       # Sidebar-like navigation inside this tab
                       fluidRow(
                         column(3,
                                wellPanel(
                                  tags$h5("Navigate"),
                                  navlistPanel(id = "demo_subtab", widths = c(12,0),
                                               tabPanel("Overview", value = "overview_demo"),
                                               tabPanel("Population", value = "population"),
                                               tabPanel("Vital statistics", value = "vital_stats"),
                                               tabPanel("Labor force", value = "labor_force"),
                                               tabPanel("Agriculture", value = "agriculture"),
                                               tabPanel("Land use", value = "land_use"),
                                               tabPanel("Predictive analysis", value = "predictive")
                                  )
                                )
                         ),
                         column(9,
                                uiOutput("demographics_body")
                         )
                       )
                   )
          )
      )
    )
  )
}


server_logic <- function(input, output, session, logged_in){
  output$line_chart <- renderPlotly({
    plot_ly(x = months, y = subs, type = 'scatter', mode = 'lines+markers', line = list(color = '#16a34a'), marker = list(color = 'white', line = list(color = '#16a34a', width = 2))) %>%
      layout(xaxis = list(title = '', tickmode = 'array', tickvals = months), yaxis = list(title = ''), plot_bgcolor = '#f4fbf6', paper_bgcolor = '#f4fbf6')
  })
}

# ------------------- Demographics & Agriculture server bits -------------------
observeEvent(TRUE, {
  # This block will be invoked when the UI is active; we attach outputs safely.
}, once = TRUE)

demographics_server <- function(input, output, session){
  # Data paths (relative to app root)
  data_dir <- file.path(getwd(), 'NDIP DATASETS- economic schema')

  # Helper to safely read CSVs (some files have different naming cases)
  safe_read <- function(name_patterns){
    files <- list.files(data_dir, pattern = paste(name_patterns, collapse = "|"), ignore.case = TRUE, full.names = TRUE)
    if(length(files) == 0) return(NULL)
    read.csv(files[1], stringsAsFactors = FALSE)
  }

  population <- reactive({ safe_read(c('rwanda_population')) })
  vital <- reactive({ safe_read(c('rwanda_vital_stats','rwanda_vital')) })
  labour <- reactive({ safe_read(c('Rwanda_Labour_Force','labour')) })
  agriculture <- reactive({ safe_read(c('rwanda_agriculture','rwanda_agriculture yields','rwanda_agriculture_%')) })
  landuse <- reactive({ safe_read(c('rwanda_land_use','rwanda_land_use_data')) })

  # Render the right-hand content based on selected subtab
  output$demographics_body <- renderUI({
    sel <- input$demo_subtab
    if(is.null(sel)) sel <- 'overview_demo'

    switch(sel,
           'overview_demo' = tagList(
             fluidRow(
               column(6, div(class = 'card', style = 'padding:12px;',
                             tags$h5('Population (latest)'), plotlyOutput('pop_line', height = '300px'))),
               column(6, div(class = 'card', style = 'padding:12px;',
                             tags$h5('Vital statistics (latest)'), plotlyOutput('vital_bar', height = '300px')))
             ),
             fluidRow(
               column(6, div(class = 'card', style = 'padding:12px;',
                             tags$h5('Labor force'), plotlyOutput('labour_plot', height = '300px'))),
               column(6, div(class = 'card', style = 'padding:12px;',
                             tags$h5('Agriculture - key metric'), plotlyOutput('agri_plot', height = '300px')))
             )
           ),
           'population' = tagList(
             tags$h4('Population dataset preview'),
             DT::dataTableOutput('pop_table'),
             plotlyOutput('pop_line', height = '420px')
           ),
           'vital_stats' = tagList(
             tags$h4('Vital statistics dataset preview'),
             DT::dataTableOutput('vital_table'),
             plotlyOutput('vital_bar', height = '420px')
           ),
           'labor_force' = tagList(
             DT::dataTableOutput('labour_table'),
             plotlyOutput('labour_plot', height = '420px')
           ),
           'agriculture' = tagList(
             DT::dataTableOutput('agri_table'),
             plotlyOutput('agri_plot', height = '420px')
           ),
           'land_use' = tagList(
             DT::dataTableOutput('landuse_table'),
             plotlyOutput('landuse_plot', height = '420px')
           ),
           'predictive' = tagList(
             tags$h4('Predictive analysis (simple linear forecast)'),
             tags$p('Select a dataset and variable for quick forecasting.'),
             selectInput('pred_dataset', 'Dataset', choices = c('Population' = 'population', 'Agriculture' = 'agriculture')),
             uiOutput('pred_var_ui'),
             actionButton('run_pred', 'Run forecast', class = 'btn btn-primary'),
             plotlyOutput('pred_plot')
           )
    )
  })

  # Table outputs
  output$pop_table <- DT::renderDataTable({ population() })
  output$vital_table <- DT::renderDataTable({ vital() })
  output$labour_table <- DT::renderDataTable({ labour() })
  output$agri_table <- DT::renderDataTable({ agriculture() })
  output$landuse_table <- DT::renderDataTable({ landuse() })

  # Basic plots (guard for NULLs)
  output$pop_line <- renderPlotly({
    df <- population()
    if(is.null(df)) return(NULL)
    # try to find a year and population columns
    possible_years <- grep('year|date', tolower(names(df)), value = TRUE)
    possible_pop <- grep('pop|population', tolower(names(df)), value = TRUE)
    if(length(possible_years)==0 || length(possible_pop)==0) return(NULL)
    xcol <- possible_years[1]
    ycol <- possible_pop[1]
    p <- plot_ly(x = df[[xcol]], y = df[[ycol]], type = 'scatter', mode = 'lines+markers') %>%
      layout(xaxis = list(title = xcol), yaxis = list(title = ycol), plot_bgcolor = '#f4fbf6', paper_bgcolor = '#f4fbf6')
    p
  })

  output$vital_bar <- renderPlotly({
    df <- vital()
    if(is.null(df)) return(NULL)
    # pick first two numeric columns
    nums <- names(df)[sapply(df, is.numeric)]
    if(length(nums) < 1) return(NULL)
    xcol <- names(df)[1]
    ycol <- nums[1]
    plot_ly(x = df[[xcol]], y = df[[ycol]], type = 'bar') %>% layout(xaxis = list(title = xcol), yaxis = list(title = ycol))
  })

  output$labour_plot <- renderPlotly({
    df <- labour()
    if(is.null(df)) return(NULL)
    nums <- names(df)[sapply(df, is.numeric)]
    if(length(nums) < 1) return(NULL)
    xcol <- names(df)[1]
    ycol <- nums[1]
    plot_ly(x = df[[xcol]], y = df[[ycol]], type = 'scatter', mode = 'lines+markers') %>% layout(xaxis = list(title = xcol), yaxis = list(title = ycol))
  })

  output$agri_plot <- renderPlotly({
    df <- agriculture()
    if(is.null(df)) return(NULL)
    nums <- names(df)[sapply(df, is.numeric)]
    if(length(nums) < 1) return(NULL)
    xcol <- names(df)[1]
    ycol <- nums[1]
    plot_ly(x = df[[xcol]], y = df[[ycol]], type = 'bar') %>% layout(xaxis = list(title = xcol), yaxis = list(title = ycol))
  })

  output$landuse_plot <- renderPlotly({
    df <- landuse()
    if(is.null(df)) return(NULL)
    nums <- names(df)[sapply(df, is.numeric)]
    if(length(nums) < 1) return(NULL)
    xcol <- names(df)[1]
    ycol <- nums[1]
    plot_ly(x = df[[xcol]], y = df[[ycol]], type = 'bar') %>% layout(xaxis = list(title = xcol), yaxis = list(title = ycol))
  })

  # Predictive UI and logic (very simple linear model on a selected numeric column against year/index)
  output$pred_var_ui <- renderUI({
    ds <- input$pred_dataset
    df <- switch(ds, population = population(), agriculture = agriculture(), NULL)
    if(is.null(df)) return(tags$em('No data available'))
    nums <- names(df)[sapply(df, is.numeric)]
    selectInput('pred_var', 'Variable', choices = nums)
  })

  observeEvent(input$run_pred, {
    df <- switch(input$pred_dataset, population = population(), agriculture = agriculture(), NULL)
    req(df, input$pred_var)
    yname <- input$pred_var
    # create an index as predictor if no year
    if(any(grepl('year|date', tolower(names(df))))){
      xname <- names(df)[grepl('year|date', tolower(names(df)))][1]
      x <- as.numeric(df[[xname]])
    } else {
      x <- seq_len(nrow(df))
    }
    y <- as.numeric(df[[yname]])
    # fit lm and predict next 5
    model <- lm(y ~ x)
    newx <- data.frame(x = max(x, na.rm = TRUE) + seq(1,5))
    preds <- predict(model, newdata = newx, interval = 'prediction')
    pred_df <- data.frame(x = c(x, newx$x), y = c(y, rep(NA, nrow(newx))), pred = c(rep(NA, length(y)), preds[,1]), lwr = c(rep(NA, length(y)), preds[,2]), upr = c(rep(NA, length(y)), preds[,3]))
    output$pred_plot <- renderPlotly({
      plot_ly(pred_df, x = ~x) %>%
        add_lines(y = ~pred, name = 'Forecast') %>%
        add_ribbons(ymin = ~lwr, ymax = ~upr, name = '95% PI', opacity = 0.2) %>%
        add_markers(data = data.frame(x = x, y = y), x = ~x, y = ~y, name = 'Observed')
    })
  })
}

# App: handles login and shows dashboard only for admin
app <- shinyApp(
  ui = uiOutput("app_ui"),
  server = function(input, output, session){
    credentials <- list(email = "admin@nisr.gov.rw", password = "demo123")
    user <- reactiveVal(NULL)

    # Render either login or dashboard UI
    output$app_ui <- renderUI({
      if(!is.null(user()) && identical(user(), credentials$email)){
        ui_dashboard()
      } else {
        ui_login()
      }
    })

    # inline login error state (avoid modals/notifications)
    login_error <- reactiveVal(NULL)
    output$login_error <- renderText({
      login_error()
    })

    # Wire login button: on success immediately switch UI to dashboard (no notification)
    observeEvent(input$login, {
      login_error(NULL)
      email <- input$email
      pwd <- input$password
      if(!is.null(email) && !is.null(pwd) && email == credentials$email && pwd == credentials$password){
        # immediate transition to dashboard
        user(credentials$email)
      } else {
        # show inline error under the login form
        login_error("Invalid credentials. Please check your email and password.")
      }
    })

    # After UI switches to dashboard, initialize dashboard server bits
    observe({
      if(!is.null(user()) && user() == credentials$email){
        # Need to call a module-like server to attach outputs
        server_logic(input, output, session, user)
        # Initialize Demographics & Agriculture server logic
        tryCatch({ demographics_server(input, output, session) }, error = function(e){ message('Demographics server init error: ', e$message) })
      }
    })

    # ---- Logout handling ----
    # When the admin clicks logout, redirect the browser back to the login app.
    # We use shinyjs::runjs() for a client-side navigation; this assumes the login app
    # is hosted at LOGIN_APP_URL (run standalone_login_app.R on that port).
    LOGIN_APP_URL <- 'http://127.0.0.1:5432'
    observeEvent(input$logout_btn, {
      # Reset any local authenticated state (if stored) and navigate back to login app
      user(NULL)
      runjs(sprintf("window.location.href = '%s';", LOGIN_APP_URL))
    })
  }
)

# If running interactively, launch app
if(interactive()){
  runApp(app)
}

# Export for usage by runApp('admin_dashboard_app.R')
app
