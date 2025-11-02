# NDIP — National Data Intelligence Platform (Rwanda)

Live demo: https://gatete-jimmy.shinyapps.io/NDIP-CODES/

Overview
--------

NDIP (National Data Intelligence Platform) is an interactive Shiny-based platform that brings together official Rwandan statistics and institution-submitted datasets into a single, real-time analytics environment. The platform is designed to support fast, evidence-based decision-making by government agencies, institutions and analysts.

What the platform aims at
-------------------------

- Real-time national insights: provide up-to-date visualisations and indicators across key development sectors (Economy, Health, Education, Agriculture, Demographics, Tourism, Governance). Dashboards surface trends, KPIs and alerts so policymakers and analysts can spot changes quickly.
- Data upload & review portal: enable institutions to securely upload datasets (CSV/Excel/JSON). Each upload runs lightweight validation and metadata checks, and then flows into a review queue for admin/reviewer approval before being included in production analytics.
- Fast analytics pipeline: ingested and approved data are integrated into interactive charts and summary KPIs. Analysts can filter by time, region and category to generate near-real-time reports for operational decisions.
- Decision support: the platform includes pre-built views (national overview, sector dashboards, and predictive widgets) and exportable data slices so decision-makers can act on validated insights.
- Governance & traceability: every uploaded dataset is tracked (uploader, timestamp, version), reviewers can leave notes, and approvals/rejections are recorded to maintain data provenance and trust.

Realtime insights (examples)
---------------------------

- Population trends and projections (yearly updates, regional breakdowns)
- GDP growth and sector contributions (quarterly updates, interactive drill-downs)
- Health system indicators (facility coverage, vital stats, disease surveillance summaries)
- Education enrollment and school-type percentages (time-series and cohort comparisons)
- Inflation and production output indicators with alerting for significant changes

Data upload & review portal (workflow)
-------------------------------------

1. Institution uploads dataset via the portal (CSV/Excel/JSON). The upload form collects metadata (title, description, category, contact email).
2. Automated checks run: file format, required columns presence, simple range/consistency checks and basic schema validation.
3. If checks pass, the submission enters the review queue. If checks fail, the uploader receives immediate feedback to correct issues.
4. Reviewer/Admin inspects the submission, requests changes or approves. Review notes and actions are recorded.
5. Approved datasets are published into the analytics pipeline and become available in dashboards and exports; rejected datasets remain in the uploader's drafts.

How this helps decision-making
-----------------------------

- Faster cycles: institutions can provide updated data as soon as it’s available, reducing lag between collection and policy action.
- Trusted inputs: validation and reviewer workflows improve data quality and build confidence among decision-makers.
- Actionable views: curated dashboards and alerts focus attention on metrics that matter for budgeting, interventions and monitoring.

What you’ll find in this repository
-----------------------------------

- `NDIP PROJECT 1.R` — The main Shiny app (UI + server, dashboards, upload and review flows).
- `admin_dashboard_app.R` — Admin-focused dashboard and review tools.
- `standalone_login_app.R`, `institution_upload_app.R` — Smaller helpers for authentication and uploads.
- `install_packages.R` — Installs required R packages used by the apps.
- `NDIP DATASETS- economic schema/` — Example source CSVs used by the app.
- `www/` — Static assets (CSS, images, footer markup).

Dependencies & running locally
------------------------------
See `install_packages.R` for core R package installation. To run locally inside R/RStudio:

```r
source('install_packages.R')
runApp('NDIP PROJECT 1.R')
```

Security & notes
----------------

- Authentication in the codebase contains demo credentials: replace with a secure system before production rollout.
- The upload pipeline performs basic validation — consider adding schema-driven validation and automated unit tests for ingestion logic.
- For production use, plan for proper logging, backups, and role-based access control.

Contributing & contact
-----------------------

Open issues or pull requests for enhancements. For help with deployment, integration or refactoring into modular Shiny components, contact the repository owner.

License
-------

Add a LICENSE file to declare the project license.
