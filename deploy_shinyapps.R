# Small helper to deploy this app to shinyapps.io using environment vars
# Set these environment variables in your shell before running this script:
# RSCONNECT_NAME  (your shinyapps.io account name)
# RSCONNECT_TOKEN (token from shinyapps.io)
# RSCONNECT_SECRET (secret from shinyapps.io)

required_vars <- c('RSCONNECT_NAME', 'RSCONNECT_TOKEN', 'RSCONNECT_SECRET')
missing <- required_vars[!nzchar(Sys.getenv(required_vars))]
if(length(missing)){
  stop('Missing environment vars: ', paste(missing, collapse = ', '), '\nPlease set them and retry.')
}

name <- Sys.getenv('RSCONNECT_NAME')
token <- Sys.getenv('RSCONNECT_TOKEN')
secret <- Sys.getenv('RSCONNECT_SECRET')

if(!requireNamespace('rsconnect', quietly = TRUE)){
  install.packages('rsconnect', repos = 'https://cloud.r-project.org')
}
library(rsconnect)

message('Registering account info...')
rsconnect::setAccountInfo(name = name, token = token, secret = secret)

app_dir <- normalizePath('.', winslash = '/')
message('Deploying app from: ', app_dir)

# deployApp will use the account set above. You can pass appName to name the app explicitly.
rsconnect::deployApp(appDir = app_dir, appName = 'ndip-shiny-app', launch.browser = FALSE)

message('Deployment request submitted. Check https://www.shinyapps.io/ for status and logs.')
