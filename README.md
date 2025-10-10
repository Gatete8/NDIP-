# NDIP CODES

Welcome to the NDIP CODES repository — a compact R/Shiny project containing analysis, visualizations, and a deployable dashboard showcasing Rwanda's socio-economic datasets. This README gives you everything needed to run the project locally, understand the files, and view a short demo video.

## Demo Video

Watch a short demo of the app and walkthrough here:

https://drive.google.com/file/d/1tH7F9P8uTxNmiKT98l2ohs68ycPPkgzz/view?usp=sharing

## Project summary

This project collects a set of national indicators for Rwanda (agriculture, education, health, GDP, population, trade, labour, inflation, and more) and provides an interactive Shiny dashboard for exploring trends and relationships across time and sectors. The app includes authentication modules, helper scripts for importing datasets, and deployment helpers for shinyapps.io.

Key goals:
- Clean, documented R code for reproducible analysis
- Interactive visualizations using Shiny
- Simple dataset import and transformation utilities
- A small, self-contained deployment pipeline for shinyapps.io

## Files and folders

- `admin_dashboard_app.R` — Main Shiny application that includes admin features.
- `standalone_login_app.R` — Small app demonstrating the login module.
- `login_module.R` — Reusable login/authentication module for Shiny.
- `NDIP CODES.Rproj` — RStudio project file.
- `import_datasets.R` — Scripts to load, clean, and standardize CSV datasets.
- `db.R`, `db_test.R`, `disconnect_db.R` — Database connection helpers (if using an external DB).
- `deploy_shinyapps.R` — Helper for deploying to shinyapps.io (uses `rsconnect`).
- `install_packages.R` — Utility to install required R packages.
- `Dockerfile` — Dockerfile for containerizing the Shiny app (optional).
- `www/` — Static assets for the Shiny app.
- `NDIP DATASETS- economic schema/` — CSV datasets used by the app (agriculture, GDP, education, population, health, etc.).

If you open the `rsconnect/documents/NDIP PROJECT 1.R/shinyapps.io/gatete-jimmy/NDIP-CODES.dcf` file you will find metadata for the shinyapps.io deployment used previously.

## Quick start (local)

Prerequisites

- R (>= 4.0) and RStudio (recommended)
- Optional: Docker (for containerized run)

1. Install required packages (run in R or RStudio):

	source('install_packages.R')

2. Import and prepare datasets:

	source('import_datasets.R')

3. Launch the app (choose one):

	- For admin dashboard: `runApp('admin_dashboard_app.R')` or open in RStudio and click "Run App"
	- For standalone login demo: `runApp('standalone_login_app.R')`

4. If you use a database, update `db.R` with credentials, then run `db_test.R` to confirm connectivity.

## Deploying to shinyapps.io

1. Install and configure `rsconnect` (see `deploy_shinyapps.R`).
2. Update `deploy_shinyapps.R` with your account info and app name.
3. Run `deploy_shinyapps.R` to publish.

## Docker (optional)

Build and run the container (from repository root):

	docker build -t ndip-codes .
	docker run -p 3838:3838 ndip-codes

Then visit `http://localhost:3838` to view the app.

## Datasets overview

Datasets are stored in `NDIP DATASETS- economic schema/`. They include (sample):

- `Rwanda_GDP_Yearly_2010_2025.csv` — Annual GDP figures and growth
- `Rwanda_Education_Indicators_2014_2025.csv` — Education metrics by year
- `rwanda_population.csv` — Population totals and demographic breakdowns
- `rwanda_health_indicators.csv` — Health metrics (mortality, vital stats)
- `Rwanda_Trade.csv` — Trade balance, imports/exports

Each CSV contains header rows; `import_datasets.R` demonstrates how they are read and cleaned.

## Troubleshooting

- If the app fails to start, run `install_packages.R` to ensure all packages are installed.
- If datasets fail to load, confirm the CSV files are present in `NDIP DATASETS- economic schema/` and that file paths in `import_datasets.R` match.
- For deployment issues on shinyapps.io, check the account configuration in `deploy_shinyapps.R` and the `rsconnect` documentation.

## Contributing

If you'd like to contribute improvements, please open an issue or submit a pull request. Suggested improvements:
- Add unit tests for data import functions
- Centralize configuration values into a single `config.R`
- Add more descriptive documentation for each Shiny module

## License

This repository does not contain a license file. If you want to open-source this project, add an appropriate `LICENSE` file (e.g., MIT, GPL).

## Contact

For questions about this project reach out to the repository owner or the contributor listed in the `rsconnect` metadata.

---

Enjoy exploring Rwanda's datasets! If you want a guided walkthrough, watch the demo linked above.
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
