# NDIP Shiny App - Deployment

This repository contains a single-file Shiny app: `NDIP PROJECT 1.R` and static assets under `www/`.

Two deployment options are provided:

1) Run in Docker (recommended for reproducible deployments)

- Build the image locally (requires Docker installed):

```powershell
docker build -t ndip-shiny-app .
```

- Run a container exposing port 3838:

```powershell
docker run --rm -p 3838:3838 ndip-shiny-app
```

Then open http://localhost:3838/ndip-app in your browser.

2) Deploy to shinyapps.io

- Install the `rsconnect` R package and follow the instructions at https://docs.rstudio.com/shinyapps.io/.
- From R, you can deploy with:

```r
library(rsconnect)
rsconnect::deployApp('c:/Users/USER/Desktop/NDIP CODES')
```

Notes:
- The Dockerfile uses `rocker/shiny:4.3.2` as base. Adjust R version if necessary.
- The app currently uses demo authentication (hard-coded credentials). Do not deploy to production without replacing with a secure auth system.
