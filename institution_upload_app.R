## Minimal standalone Institution Upload App for NDIP
# Purpose: target for standalone_login_app.R INSTITUTION_APP_URL during demo

library(shiny)
library(bslib)

ui <- fluidPage(
  theme = bs_theme(version = 4),
  tags$head(tags$style(HTML(".center{display:flex;align-items:center;justify-content:center;height:100vh;flex-direction:column;} .card{padding:24px;border-radius:12px;box-shadow:0 8px 30px rgba(0,0,0,0.06);}"))),
  div(class='center',
      div(class='card',
          tags$h2('Institution Upload Dashboard'),
          tags$p('This is a minimal placeholder for the institution upload app.'),
          tags$p('Demo login: health@moh.gov.rw / demo123'),
          actionButton('dummy', 'Open Upload Center')
      )
  )
)

server <- function(input, output, session){
  observeEvent(input$dummy, {
    showModal(modalDialog(title = 'Upload', 'Upload center placeholder', easyClose = TRUE))
  })
}

shinyApp(ui, server)
