# Login module for standalone login overlay
# load shiny once
library(shiny)

# UI: login overlay (root id 'standalone-upload' kept so existing hash routing still works)
login_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$style(HTML("/* Minimal CSS for the standalone login overlay */
      html, body { margin:0; padding:0; height:100%; }
      #standalone-upload { position:fixed; inset:0; z-index:2200; background: url('/pic.login.2.jpg') center/cover no-repeat; }
      #standalone-upload::before { content:''; position:absolute; inset:0; background: linear-gradient(rgba(0,0,0,0.28), rgba(0,0,0,0.28)); }
      #standalone-upload .standalone-main { position:relative; display:flex; justify-content:center; align-items:center; height:100vh; padding:0; box-sizing:border-box; }
      #standalone-upload .login-card { width:350px; max-width:92%; padding:40px; background: rgba(0,0,0,0.45); box-shadow:0 12px 30px rgba(0,0,0,0.45); border-radius:12px; color:#fff; }
      #standalone-upload .login-title { font-weight:700; font-size:22px; margin:0 0 12px 0; }
      @media (max-width:420px) { #standalone-upload .login-card { width:92%; padding:20px; } }
    ")),

    div(id = 'standalone-upload', style = 'display:none; position:fixed; inset:0; z-index:2200; overflow:auto; padding:0;',
        div(class = 'standalone-main',
            div(class = 'login-card',
                tags$h3('LOGIN', class = 'login-title'),
                div(class='card-header-welcome', tags$div(class='typewriter', id='login-typewriter', 'Welcome to the National Data Intelligence Platform')),
                div(style='margin-top:12px;',
                    tags$label('Email', `for` = ns('ndip_email')), 
                    textInput(ns('ndip_email'), NULL, placeholder = 'your.email@gov.rw', width = '100%'),
                    tags$label('Password', `for` = ns('ndip_password')),
                    passwordInput(ns('ndip_password'), NULL, placeholder = 'Enter your password', width = '100%'),
                    actionButton(ns('ndip_signin'), 'Sign In', class = 'btn btn-primary', style='background:#0B7A10; color:#fff; margin-top:10px; width:100%;')
                ),
                div(style='margin-top:14px; font-size:13px; color:rgba(255,255,255,0.85);',
                    tags$div(HTML('<strong>Demo Accounts:</strong>')),
                    tags$div(HTML('<strong>Admin:</strong> admin@nisr.gov.rw')),
                    tags$div(HTML('<strong>Institution:</strong> health@moh.gov.rw')),
                    tags$div(HTML('<strong>Reviewer:</strong> reviewer@nisr.gov.rw')),
                    tags$div(HTML('<strong>Password:</strong> demo123'))
                )
            )
        )
    ),

    # JS: open/close overlay on hash '#login' and expose custom message handler
  tags$script(HTML("(function(){ function toggleUpload(){ var el=document.getElementById('standalone-upload'); if(location.hash==='#login'){ if(el) el.style.display='block'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} } else { if(el) el.style.display='none'; try{ document.querySelector('body').style.overflow='auto'; }catch(e){} } } window.addEventListener('hashchange', toggleUpload); setTimeout(toggleUpload,30); if(window.Shiny && Shiny.addCustomMessageHandler){ Shiny.addCustomMessageHandler('setHash', function(message){ try{ if(message && message.hash!==undefined) location.hash = message.hash; }catch(e){} });
  // handle goAdmin message from server: navigate to admin dashboard hash
  Shiny.addCustomMessageHandler('goAdmin', function(message){ try{ if(message && message.role){ /* choose hash or route as needed */ location.hash = '#admin-dashboard'; } }catch(e){} });
  // handle openAdmin - directly show the admin overlay (avoids hash race)
  Shiny.addCustomMessageHandler('openAdmin', function(message){ try{ var el = document.getElementById('standalone-admin'); if(el){ el.style.display='block'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} } }catch(e){} });
  } })();")),

    # Typewriter for the small header
    tags$script(HTML("(function(){ function typeWrite(el, text, speed){ if(!el) return; el.textContent=''; var i=0; function step(){ if(i<=text.length){ el.textContent = text.substring(0,i); i++; setTimeout(step, speed); } } step(); } function run(){ var el = document.getElementById('login-typewriter'); if(!el) return; typeWrite(el, 'the modern digitization transformation.', 40); } function watch(){ if(location.hash==='#login') run(); } window.addEventListener('hashchange', watch); setTimeout(watch,40); })();"))
  )
}

# Server: simple module that returns reactive 'result' (list with success/message)
login_server <- function(id, authenticate_fn = NULL){
  moduleServer(id, function(input, output, session){
    auth_result <- reactiveVal(NULL)

    observeEvent(input$ndip_signin, {
      email <- input$ndip_email
      pwd <- input$ndip_password
      if(!is.null(authenticate_fn) && is.function(authenticate_fn)){
        res <- tryCatch(authenticate_fn(email, pwd), error = function(e) list(success=FALSE, message=as.character(e)))
        auth_result(res)
      } else {
        if(isTruthy(email) && isTruthy(pwd)) auth_result(list(success=TRUE, message='demo'))
        else auth_result(list(success=FALSE, message='Please enter email and password'))
      }
    })

    # return reactive value and namespace function
    list(result = auth_result, ns = session$ns)
  })
}

## Database-backed authentication removed in this project snapshot.
## If you need DB authentication later, implement `authenticate_db(email, password)`
## to query your user store and verify the password using `sodium::password_verify()`.
authenticate_db <- function(email, password){
  list(success = FALSE, message = 'Database authentication not enabled in this copy of the project')
}
