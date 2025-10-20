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
"/* Professional NDIP Admin Dashboard Styling */
.ndip-header{ 
  background: linear-gradient(135deg, #f1fdf2 0%, #e8f5e8 100%); 
  padding: 16px 24px; 
  display: flex; 
  align-items: center; 
  justify-content: space-between; 
  border-bottom: 1px solid rgba(0,0,0,0.08); 
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}
.ndip-brand{ display: flex; align-items: center; gap: 16px }
.ndip-logo{ 
  width: 52px; 
  height: 52px; 
  background: linear-gradient(135deg, #1f8a2d 0%, #0d5f1a 100%); 
  color: white; 
  display: flex; 
  align-items: center; 
  justify-content: center; 
  font-weight: 700; 
  border-radius: 12px; 
  font-size: 22px;
  box-shadow: 0 4px 12px rgba(31, 138, 45, 0.3);
}
.ndip-title{ line-height: 1.2 }
.ndip-title h1{ margin: 0; color: #1b5e20; font-weight: 700; font-size: 26px; letter-spacing: -0.5px }
.ndip-sub{ margin: 0; color: #6b6b6b; font-size: 13px; font-weight: 500 }
.ndip-user{ display: flex; align-items: center; gap: 16px }
.ndip-user .name{ font-weight: 600; color: #144a2b; font-size: 15px }
.avatar{ 
  width: 40px; 
  height: 40px; 
  background: linear-gradient(135deg, #dfeee2 0%, #c8e6c9 100%); 
  border-radius: 50%; 
  display: flex; 
  align-items: center; 
  justify-content: center; 
  font-weight: 700; 
  color: #0c3e17;
  border: 2px solid rgba(255,255,255,0.8);
}
.admin-badge{ 
  background: linear-gradient(135deg, #ffdde0 0%, #ffcdd2 100%); 
  color: #9d1f2b; 
  padding: 6px 12px; 
  border-radius: 16px; 
  font-size: 12px; 
  font-weight: 600;
  border: 1px solid rgba(157, 31, 43, 0.2);
}

/* Professional Tabs */
.ndip-tabs{ margin: 24px auto 0; display: flex; justify-content: center }
.ndip-tabs .nav{ background: transparent; }
.ndip-tabs .nav .nav-link{ 
  border-radius: 12px; 
  padding: 12px 20px; 
  color: #3b6b52; 
  margin: 0 8px; 
  border: 1px solid transparent; 
  font-weight: 500;
  font-size: 14px;
  transition: all 0.3s ease;
}
.ndip-tabs .nav .nav-link.active{ 
  background: white; 
  border-color: #e6f4ea; 
  box-shadow: 0 4px 12px rgba(0,0,0,0.08); 
  color: #1b5e20;
  font-weight: 600;
}
.ndip-tabs .nav .nav-link:hover{ 
  background: #f6fbf7; 
  transform: translateY(-1px);
}

/* Professional Stat Cards */
.stat-row{ display: flex; gap: 20px; margin-top: 24px }
.stat-card{ 
  background: linear-gradient(135deg, #ffffff 0%, #f8fffe 100%); 
  border-radius: 16px; 
  padding: 24px; 
  flex: 1; 
  box-shadow: 0 6px 20px rgba(17,40,21,0.08); 
  position: relative;
  border: 1px solid rgba(0,0,0,0.05);
  transition: all 0.3s ease;
}
.stat-card:hover{
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(17,40,21,0.12);
}
.stat-card .icon{ 
  position: absolute; 
  right: 20px; 
  top: 20px; 
  color: rgba(0,0,0,0.15); 
  font-size: 20px;
}
.stat-card .big{ 
  font-weight: 800; 
  font-size: 32px; 
  color: #113c19; 
  margin: 8px 0;
  letter-spacing: -1px;
}
.muted{ 
  color: #4f6b54; 
  font-size: 13px; 
  font-weight: 500;
  margin-bottom: 4px;
}

/* Professional Sub-tabs */
.sub-tabs{ margin-top: 20px; display: flex; gap: 16px }
.sub-tabs .pill{ 
  padding: 10px 18px; 
  border-radius: 12px; 
  background: transparent; 
  border: 1px solid transparent; 
  font-weight: 500;
  font-size: 13px;
  transition: all 0.3s ease;
  cursor: pointer;
}
.sub-tabs .pill.active{ 
  background: white; 
  border: 1px solid #e6f4ea; 
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
  color: #1b5e20;
  font-weight: 600;
}
.sub-tabs .pill:hover{
  background: #f6fbf7;
  transform: translateY(-1px);
}

/* Professional Chart Card */
.card{ 
  background: linear-gradient(135deg, #ffffff 0%, #f8fffe 100%); 
  border-radius: 16px; 
  padding: 24px; 
  box-shadow: 0 6px 20px rgba(10,30,10,0.08); 
  border: 1px solid rgba(0,0,0,0.05);
}
.chart-placeholder{ height: 360px }

/* Professional Horizontal Summary Cards */
.summary-cards{ 
  display: flex; 
  gap: 20px; 
  margin-top: 24px;
}
.summary-card{ 
  flex: 1; 
  padding: 24px; 
  border-radius: 16px; 
  background: linear-gradient(135deg, #ffffff 0%, #f8fffe 100%); 
  box-shadow: 0 6px 20px rgba(10,30,10,0.08);
  border: 1px solid rgba(0,0,0,0.05);
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}
.summary-card:hover{
  transform: translateY(-3px);
  box-shadow: 0 10px 30px rgba(10,30,10,0.15);
}
.summary-card::before{
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, var(--card-color) 0%, var(--card-color-light) 100%);
}
.summary-card.approved{
  --card-color: #0b7a24;
  --card-color-light: #4caf50;
}
.summary-card.rejected{
  --card-color: #da3b3b;
  --card-color-light: #f44336;
}
.summary-card.published{
  --card-color: #3b6cff;
  --card-color-light: #2196f3;
}
.summary-card .num{ 
  font-weight: 800; 
  font-size: 36px; 
  margin: 8px 0;
  letter-spacing: -1px;
  line-height: 1;
}
.summary-card .label{ 
  color: #6b6b6b; 
  font-size: 14px; 
  font-weight: 600;
  margin-bottom: 8px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}
.summary-card .percentage{
  font-size: 13px;
  font-weight: 500;
  margin-top: 8px;
}
.summary-card .tag{
  display: inline-block;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-top: 8px;
}

/* Interactive Card Effects */
.summary-card:hover .num{
  transform: scale(1.05);
  transition: transform 0.3s ease;
}
.summary-card:hover .label{
  color: #1b5e20;
  transition: color 0.3s ease;
}

/* Professional Modal Styling */
.modal-content{
  border-radius: 16px;
  border: none;
  box-shadow: 0 20px 60px rgba(0,0,0,0.15);
}
.modal-header{
  background: linear-gradient(135deg, #f1fdf2 0%, #e8f5e8 100%);
  border-bottom: 1px solid rgba(0,0,0,0.1);
  border-radius: 16px 16px 0 0;
}
.modal-title{
  color: #1b5e20;
  font-weight: 700;
  font-size: 18px;
}
.modal-body{
  padding: 24px;
  font-family: 'Inter', sans-serif;
}
.modal-body h4{
  color: #1b5e20;
  font-weight: 600;
  margin-bottom: 12px;
}
.modal-body h5{
  color: #3b6b52;
  font-weight: 600;
  margin-top: 16px;
  margin-bottom: 8px;
}
.modal-body ul{
  margin-bottom: 16px;
}
.modal-body li{
  margin-bottom: 4px;
  color: #4f6b54;
}

/* Professional Sector Statistics Styling */
.sector-stats-container{
  display: flex;
  flex-direction: column;
  gap: 16px;
  padding: 20px 0;
}
.sector-stat-card{
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px 20px;
  background: linear-gradient(135deg, #ffffff 0%, #f8fffe 100%);
  border-radius: 12px;
  border: 1px solid rgba(0,0,0,0.05);
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
  transition: all 0.3s ease;
  cursor: pointer;
}
.sector-stat-card:hover{
  transform: translateX(8px);
  box-shadow: 0 6px 20px rgba(0,0,0,0.1);
  background: linear-gradient(135deg, #f8fffe 0%, #f1fdf2 100%);
}
.sector-dot{
  width: 16px;
  height: 16px;
  border-radius: 50%;
  flex-shrink: 0;
  box-shadow: 0 2px 4px rgba(0,0,0,0.2);
}
.sector-info{
  flex: 1;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.sector-name{
  font-weight: 600;
  color: #1b5e20;
  font-size: 15px;
}
.sector-count{
  font-weight: 700;
  color: #113c19;
  font-size: 18px;
  margin-right: 8px;
}
.sector-percentage{
  font-weight: 500;
  color: #6b6b6b;
  font-size: 13px;
  background: rgba(0,0,0,0.05);
  padding: 4px 8px;
  border-radius: 8px;
}

/* Enhanced Navbar Styling */
.ndip-tabs .nav .nav-link{
  border-radius: 12px;
  padding: 12px 20px;
  color: #3b6b52;
  margin: 0 8px;
  border: 1px solid transparent;
  font-weight: 500;
  font-size: 14px;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}
.ndip-tabs .nav .nav-link::before{
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
  transition: left 0.5s;
}
.ndip-tabs .nav .nav-link:hover::before{
  left: 100%;
}
.ndip-tabs .nav .nav-link.active{
  background: linear-gradient(135deg, #ffffff 0%, #f8fffe 100%);
  border-color: #e6f4ea;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  color: #1b5e20;
  font-weight: 600;
}
.ndip-tabs .nav .nav-link:hover{
  background: #f6fbf7;
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(0,0,0,0.1);
}

.sectors-row{ display: flex; gap: 20px }
.pie-legend{ margin-left: 20px }

/* Responsive Design */
@media (max-width: 1200px){ 
  .stat-row, .summary-cards, .sectors-row{ 
    flex-direction: column; 
    gap: 16px;
  }
  .summary-card .num{
    font-size: 32px;
  }
}
@media (max-width: 768px){
  .ndip-header{
    padding: 12px 16px;
  }
  .ndip-title h1{
    font-size: 22px;
  }
  .stat-card, .summary-card{
    padding: 20px;
  }
  .summary-card .num{
    font-size: 28px;
  }
}
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

      # Professional Main title
      tags$div(style = "padding-top: 24px; padding-bottom: 16px;",
               tags$h2(style = "color: #1b5e20; font-weight: 800; margin-bottom: 8px; font-size: 36px; letter-spacing: -1px; line-height: 1.1;",
                       "Admin Dashboard"),
               tags$p(style = "color: #6b6b6b; font-size: 16px; font-weight: 500; margin: 0;",
                      "Manage data submissions, review uploads, and monitor platform activity.")
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

                 # Professional Submissions Over Time chart
                 div(class = "card", style = "margin-top: 20px;",
                     tags$h4(style = "color: #1b5e20; font-weight: 700; font-size: 20px; margin-bottom: 20px; letter-spacing: -0.3px;", 
                            "Submissions Over Time"),
                     plotlyOutput("line_chart", height = "400px")
                 ),

                 # Professional Interactive Summary Cards
                 div(class = "summary-cards",
                     div(class = "summary-card approved", id = "approved-card", style = "cursor: pointer;",
                         div(class = "label", "Approved"),
                         div(class = "num", style = "color: #0b7a24;", "198"),
                         div(class = "percentage", style = "color: #0b7a24; font-weight: 600;", "80.2%")
                     ),
                     div(class = "summary-card rejected", id = "rejected-card", style = "cursor: pointer;",
                         div(class = "label", "Rejected"),
                         div(class = "num", style = "color: #da3b3b;", "37"),
                         div(class = "percentage", style = "color: #da3b3b; font-weight: 600;", "15.0%")
                     ),
                     div(class = "summary-card published", id = "published-card", style = "cursor: pointer;",
                         div(class = "label", "Published Datasets"),
                         div(class = "num", style = "color: #3b6cff;", "198"),
                         div(class = "tag", style = "background: #e3f2fd; color: #3b6cff;", "Public & Restricted")
                     )
                 )
        ),

        tags$div(class = "tab-pane", id = "submissions",
                 tags$h4("(Submissions tab - content placeholder)")
        ),

        tags$div(class = "tab-pane", id = "sectors",
                 # Professional Sectors Dashboard
                 div(class = "card", style = "margin-top: 20px;",
                     tags$h4(style = "color: #1b5e20; font-weight: 700; font-size: 20px; margin-bottom: 20px; letter-spacing: -0.3px;", 
                            "Submissions by Sector"),
                     
                     # Sectors content with pie chart and statistics
                     fluidRow(
                       column(7,
                         # Interactive Pie Chart
                         plotlyOutput("sectors_pie_chart", height = "400px")
                       ),
                       column(5,
                         # Sector Statistics Cards
                         div(class = "sector-stats-container",
                           div(class = "sector-stat-card", id = "health-sector",
                               div(class = "sector-dot", style = "background: #9c27b0;"),
                               div(class = "sector-info",
                                   div(class = "sector-name", "Health"),
                                   div(class = "sector-count", "89"),
                                   div(class = "sector-percentage", "36.0%")
                               )
                           ),
                           div(class = "sector-stat-card", id = "education-sector",
                               div(class = "sector-dot", style = "background: #2196f3;"),
                               div(class = "sector-info",
                                   div(class = "sector-name", "Education"),
                                   div(class = "sector-count", "67"),
                                   div(class = "sector-percentage", "27.1%")
                               )
                           ),
                           div(class = "sector-stat-card", id = "agriculture-sector",
                               div(class = "sector-dot", style = "background: #ff9800;"),
                               div(class = "sector-info",
                                   div(class = "sector-name", "Agriculture"),
                                   div(class = "sector-count", "45"),
                                   div(class = "sector-percentage", "18.2%")
                               )
                           ),
                           div(class = "sector-stat-card", id = "economy-sector",
                               div(class = "sector-dot", style = "background: #f44336;"),
                               div(class = "sector-info",
                                   div(class = "sector-name", "Economy"),
                                   div(class = "sector-count", "32"),
                                   div(class = "sector-percentage", "13.0%")
                               )
                           ),
                           div(class = "sector-stat-card", id = "infrastructure-sector",
                               div(class = "sector-dot", style = "background: #673ab7;"),
                               div(class = "sector-info",
                                   div(class = "sector-name", "Infrastructure"),
                                   div(class = "sector-count", "14"),
                                   div(class = "sector-percentage", "5.7%")
                               )
                           )
                         )
                       )
                     )
                 )
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
  # Enhanced line chart with professional styling
  output$line_chart <- renderPlotly({
    plot_ly(x = months, y = subs, type = 'scatter', mode = 'lines+markers', 
            line = list(color = '#0b7a24', width = 3), 
            marker = list(color = 'white', size = 8, line = list(color = '#0b7a24', width = 2))) %>%
      layout(
        xaxis = list(
          title = '', 
          tickmode = 'array', 
          tickvals = months,
          gridcolor = 'rgba(0,0,0,0.1)',
          showgrid = TRUE
        ), 
        yaxis = list(
          title = 'Number of Submissions',
          gridcolor = 'rgba(0,0,0,0.1)',
          showgrid = TRUE
        ), 
        plot_bgcolor = 'rgba(0,0,0,0)', 
        paper_bgcolor = 'rgba(0,0,0,0)',
        font = list(family = "Inter, sans-serif", size = 12),
        margin = list(l = 50, r = 50, t = 20, b = 50)
      )
  })
  
  # Sectors pie chart
  output$sectors_pie_chart <- renderPlotly({
    sectors_data <- data.frame(
      sector = c("Health", "Education", "Agriculture", "Economy", "Infrastructure"),
      count = c(89, 67, 45, 32, 14),
      color = c("#9c27b0", "#2196f3", "#ff9800", "#f44336", "#673ab7")
    )
    
    plot_ly(sectors_data, 
            labels = ~paste(sector, count, sep = ": "), 
            values = ~count, 
            type = 'pie',
            marker = list(colors = ~color),
            textinfo = 'label+percent',
            textposition = 'outside',
            hovertemplate = '<b>%{label}</b><br>Count: %{value}<br>Percentage: %{percent}<extra></extra>') %>%
      layout(
        showlegend = FALSE,
        font = list(family = "Inter, sans-serif", size = 12),
        margin = list(l = 20, r = 20, t = 20, b = 20),
        plot_bgcolor = 'rgba(0,0,0,0)',
        paper_bgcolor = 'rgba(0,0,0,0)'
      )
  })
  
  # Interactive card click handlers
  observeEvent(input$approved_card, {
    showModal(modalDialog(
      title = "Approved Submissions Details",
      tags$div(
        tags$h4("Approved Submissions: 198"),
        tags$p("Approval Rate: 80.2%"),
        tags$hr(),
        tags$h5("Recent Approved Submissions:"),
        tags$ul(
          tags$li("Health Indicators Dataset - Ministry of Health"),
          tags$li("Education Statistics - Ministry of Education"),
          tags$li("Agriculture Production Data - Ministry of Agriculture"),
          tags$li("Trade Statistics - Ministry of Trade")
        )
      ),
      easyClose = TRUE,
      size = "m"
    ))
  })
  
  observeEvent(input$rejected_card, {
    showModal(modalDialog(
      title = "Rejected Submissions Details",
      tags$div(
        tags$h4("Rejected Submissions: 37"),
        tags$p("Rejection Rate: 15.0%"),
        tags$hr(),
        tags$h5("Common Rejection Reasons:"),
        tags$ul(
          tags$li("Incomplete data fields"),
          tags$li("Data quality issues"),
          tags$li("Missing metadata"),
          tags$li("Format inconsistencies")
        )
      ),
      easyClose = TRUE,
      size = "m"
    ))
  })
  
  observeEvent(input$published_card, {
    showModal(modalDialog(
      title = "Published Datasets Details",
      tags$div(
        tags$h4("Published Datasets: 198"),
        tags$p("Access Level: Public & Restricted"),
        tags$hr(),
        tags$h5("Dataset Categories:"),
        tags$ul(
          tags$li("Public Datasets: 156"),
          tags$li("Restricted Datasets: 42"),
          tags$li("Most Accessed: Population Statistics"),
          tags$li("Latest Update: Today")
        )
      ),
      easyClose = TRUE,
      size = "m"
    ))
  })
  
  # Interactive sector card click handlers
  observeEvent(input$health_sector, {
    showModal(modalDialog(
      title = "Health Sector Details",
      tags$div(
        tags$h4("Health Sector Submissions: 89"),
        tags$p("Percentage of Total: 36.0%"),
        tags$hr(),
        tags$h5("Recent Health Submissions:"),
        tags$ul(
          tags$li("Health Indicators 2024 - Ministry of Health"),
          tags$li("Hospital Statistics - Rwanda Biomedical Centre"),
          tags$li("Disease Surveillance Data - Rwanda Biomedical Centre"),
          tags$li("Health Facility Data - Ministry of Health")
        ),
        tags$h5("Key Metrics:"),
        tags$ul(
          tags$li("Approval Rate: 85%"),
          tags$li("Average Processing Time: 1.8 days"),
          tags$li("Most Active Institution: Ministry of Health")
        )
      ),
      easyClose = TRUE,
      size = "m"
    ))
  })
  
  observeEvent(input$education_sector, {
    showModal(modalDialog(
      title = "Education Sector Details",
      tags$div(
        tags$h4("Education Sector Submissions: 67"),
        tags$p("Percentage of Total: 27.1%"),
        tags$hr(),
        tags$h5("Recent Education Submissions:"),
        tags$ul(
          tags$li("Student Enrollment Data - Ministry of Education"),
          tags$li("School Performance Metrics - REB"),
          tags$li("Teacher Statistics - Ministry of Education"),
          tags$li("Infrastructure Data - Ministry of Education")
        ),
        tags$h5("Key Metrics:"),
        tags$ul(
          tags$li("Approval Rate: 78%"),
          tags$li("Average Processing Time: 2.1 days"),
          tags$li("Most Active Institution: Ministry of Education")
        )
      ),
      easyClose = TRUE,
      size = "m"
    ))
  })
  
  observeEvent(input$agriculture_sector, {
    showModal(modalDialog(
      title = "Agriculture Sector Details",
      tags$div(
        tags$h4("Agriculture Sector Submissions: 45"),
        tags$p("Percentage of Total: 18.2%"),
        tags$hr(),
        tags$h5("Recent Agriculture Submissions:"),
        tags$ul(
          tags$li("Crop Production Data - Ministry of Agriculture"),
          tags$li("Livestock Statistics - RAB"),
          tags$li("Land Use Data - Ministry of Agriculture"),
          tags$li("Market Prices - MINAGRI")
        ),
        tags$h5("Key Metrics:"),
        tags$ul(
          tags$li("Approval Rate: 82%"),
          tags$li("Average Processing Time: 2.5 days"),
          tags$li("Most Active Institution: Ministry of Agriculture")
        )
      ),
      easyClose = TRUE,
      size = "m"
    ))
  })
  
  observeEvent(input$economy_sector, {
    showModal(modalDialog(
      title = "Economy Sector Details",
      tags$div(
        tags$h4("Economy Sector Submissions: 32"),
        tags$p("Percentage of Total: 13.0%"),
        tags$hr(),
        tags$h5("Recent Economy Submissions:"),
        tags$ul(
          tags$li("GDP Statistics - NISR"),
          tags$li("Trade Data - Ministry of Trade"),
          tags$li("Inflation Rates - BNR"),
          tags$li("Employment Statistics - NISR")
        ),
        tags$h5("Key Metrics:"),
        tags$ul(
          tags$li("Approval Rate: 90%"),
          tags$li("Average Processing Time: 1.5 days"),
          tags$li("Most Active Institution: NISR")
        )
      ),
      easyClose = TRUE,
      size = "m"
    ))
  })
  
  observeEvent(input$infrastructure_sector, {
    showModal(modalDialog(
      title = "Infrastructure Sector Details",
      tags$div(
        tags$h4("Infrastructure Sector Submissions: 14"),
        tags$p("Percentage of Total: 5.7%"),
        tags$hr(),
        tags$h5("Recent Infrastructure Submissions:"),
        tags$ul(
          tags$li("Road Network Data - MININFRA"),
          tags$li("Energy Statistics - REG"),
          tags$li("Water Infrastructure - WASAC"),
          tags$li("ICT Infrastructure - RDB")
        ),
        tags$h5("Key Metrics:"),
        tags$ul(
          tags$li("Approval Rate: 75%"),
          tags$li("Average Processing Time: 3.2 days"),
          tags$li("Most Active Institution: MININFRA")
        )
      ),
      easyClose = TRUE,
      size = "m"
    ))
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
