packages <- c(
  'shiny',
  'bslib',
  'shinyWidgets',
  'shinyjs',
  'fontawesome',
  'plotly',
  # optional: for password hashing/verification in auth helpers
  'sodium'
)

install_if_missing <- function(pkgs){
  to_install <- pkgs[!pkgs %in% installed.packages()[, 'Package']]
  if(length(to_install)){
    install.packages(to_install, repos = 'https://cloud.r-project.org')
  }
}

install_if_missing(packages)

cat('R package installation complete.\n')
