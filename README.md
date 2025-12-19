# NDIP - National Data Intelligence Platform

[![R](https://img.shields.io/badge/R-4.0+-blue.svg)](https://www.r-project.org/)
[![Shiny](https://img.shields.io/badge/Shiny-1.7+-green.svg)](https://shiny.rstudio.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Neon-orange.svg)](https://neon.tech/)
[![Live App](https://img.shields.io/badge/Live%20App-Available-brightgreen.svg)](https://gatete-jimmy.shinyapps.io/NDIP-CODES/)

## 🌐 Live Application

**👉 [Access the Live Application](https://gatete-jimmy.shinyapps.io/NDIP-CODES/)**

A comprehensive data management and visualization platform for Rwanda's National Data Intelligence Platform, featuring automated workflow from data submission to publication.

## 🎯 Features

- **🔐 Multi-Role Authentication**: Admin, Institution, and Reviewer roles with secure session management
- **📤 Data Submission Workflow**: Institutions upload datasets with sector classification
- **✅ Review & Approval System**: Reviewers evaluate and approve/reject submissions
- **📊 Live Dashboard Publishing**: Admins publish approved datasets to live dashboards
- **🔔 Real-time Notifications**: Automated notifications at each workflow stage
- **📈 Interactive Visualizations**: echarts4r and Plotly charts for data exploration
- **🤖 Machine Learning Models**: Random Forest and Prophet models for predictive analytics
- **⚡ Optimized Performance**: Fast loading with caching and lazy loading strategies
- **🔍 Audit Trail**: Complete logging of all system actions

## 🏗️ Architecture

```
┌─────────────┐
│  Institution│  Uploads Data
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Reviewer   │  Reviews & Approves
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   Admin     │  Publishes to Live Dashboard
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ Live Data   │  Available in Sector Dashboards
└─────────────┘
```

## 📁 Project Structure

```
NDIP.CODES.111.gatete/
├── app.R                          # Main Shiny application
├── check_database_status.R        # Database verification utility
├── README.md                      # This file
│
├── modules/                       # Shiny modules
│   ├── login_module.R            # Authentication system
│   ├── admin_dashboard.R         # Admin dashboard (publish/pull-back)
│   ├── institution_dashboard.R   # Institution upload center
│   ├── reviewer_dashboard.R      # Reviewer approval system
│   ├── economic_dashboard_module.R
│   ├── health_education_dashboard_module.R
│   ├── demographics_agriculture_dashboard_module.R
│   ├── session_manager.R        # Session management
│   └── global.R                  # Shared utilities
│
├── scripts/                       # Backend scripts
│   ├── db_connection.R           # Database connection manager
│   ├── notifications.R           # Notification system
│   ├── audit_log.R               # Audit logging
│   ├── automation_workflow.R     # Workflow automation
│   ├── publish_data.R            # Data publishing functions
│   │
│   ├── database/                 # Database setup
│   │   ├── 01_create_schemas_and_tables.sql
│   │   ├── 02_add_sample_data.sql
│   │   ├── 03_create_admin_dashboard_tables.sql
│   │   ├── 04_create_reviewer_dashboard_tables.sql
│   │   ├── 05_add_reviewer_sample_data.sql
│   │   ├── 06_create_trade_table.sql
│   │   ├── 07_create_ndip_schema.sql
│   │   ├── 08_create_live_data_table.sql
│   │   ├── 09_update_submissions_schema.sql
│   │   └── setup_*.R             # Setup scripts
│   │
│   ├── deployment/                # Deployment configuration
│   │   ├── deploy_shinyapps.R
│   │   └── Dockerfile
│   │
│   └── setup/
│       └── install_packages.R
│
├── data/
│   ├── datasets/                  # Sample datasets
│   └── uploads/                   # User uploads (gitignored)
│
└── www/                           # Static assets
    ├── custom.css
    └── *.jpg                      # Images
```

## 🚀 Quick Start

### 🌐 Try the Live Application

**👉 [Access the Live Application](https://gatete-jimmy.shinyapps.io/NDIP-CODES/)**

The application is deployed and ready to use. You can explore all features including:
- Interactive sector dashboards (Economic, Demographics & Agriculture, Health & Education)
- Machine learning predictive models
- Data submission and review workflows
- Real-time visualizations

### Prerequisites (For Local Development)

- R (>= 4.0.0)
- RStudio (recommended)
- Neon PostgreSQL database account

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd NDIP.CODES.111.gatete
   ```

2. **Install R packages**
   ```r
   source("scripts/setup/install_packages.R")
   ```

3. **Configure database connection**
   
   Edit `scripts/db_connection.R` and set your Neon PostgreSQL connection string:
   ```r
   NEON_CONNECTION_STRING <- "postgresql://user:password@host/database?sslmode=require"
   ```

4. **Setup database schema**
   ```r
   # Run database setup scripts in order
   source("scripts/database/setup_database.R")
   source("scripts/database/add_sample_data.R")
   
   # Verify setup
   source("check_database_status.R")
   ```

5. **Run the application**
   ```r
   shiny::runApp("app.R")
   ```

## 👤 Demo Accounts

| Role | Email | Password | Access |
|------|-------|----------|--------|
| **Admin** | `admin@nisr.gov.rw` | `demo123` | Full access, publish datasets |
| **Institution** | `health@moh.gov.rw` | `demo123` | Upload datasets, track status |
| **Reviewer** | `reviewer@nisr.gov.rw` | `demo123` | Review & approve submissions |

## 🔄 Workflow

1. **Institution Uploads Data**
   - Institution logs in and uploads CSV/Excel file
   - Selects sector (Economic, Health/Education, Demographics/Agriculture)
   - Adds description and submits
   - Status: `submitted`

2. **Reviewer Reviews**
   - Reviewer receives notification
   - Reviews submission in dashboard
   - Approves or rejects with comments
   - Status: `approved` or `rejected`

3. **Admin Publishes**
   - Admin receives notification for approved datasets
   - Reviews and publishes to live dashboard
   - Data becomes available in sector-specific dashboards
   - Status: `published`

4. **Live Dashboard**
   - Published data appears in sector dashboards
   - Interactive visualizations and charts
   - Real-time data updates

## 🗄️ Database Schema

### Key Tables

- `auth.users` - User accounts and authentication
- `uploads.data_submissions` - Dataset submission metadata
- `review.review_actions` - Review decisions and comments
- `ndip.notifications` - System notifications
- `ndip.audit_logs` - Audit trail
- `ndip.live_data` - Published datasets (JSONB format)

### Status Values

- `submitted` - Initial state after upload
- `under_review` - Reviewer is reviewing
- `approved` - Reviewer approved, awaiting admin
- `rejected` - Reviewer rejected
- `published` - Published to live dashboards
- `pulled_back` - Removed from live dashboards

## 🛠️ Technology Stack

- **Frontend**: Shiny, HTML5, CSS3, JavaScript
- **Backend**: R (Shiny Server)
- **Database**: Neon PostgreSQL
- **Visualization**: echarts4r, Plotly, DT (DataTables)
- **Machine Learning**: Random Forest, Prophet
- **Deployment**: [ShinyApps.io](https://gatete-jimmy.shinyapps.io/NDIP-CODES/) / Docker

## 📦 Key R Packages

```r
shiny          # Web framework
DT             # Interactive tables
echarts4r      # Interactive charts (primary)
plotly         # Interactive charts
DBI            # Database interface
RPostgres      # PostgreSQL connector
dplyr          # Data manipulation
readxl         # Excel file reading
jsonlite       # JSON handling
randomForest   # ML models
prophet        # Time series forecasting
```

## 🔧 Configuration

### Environment Variables

Create a `.Renviron` file (not tracked in git):

```r
NEON_CONNECTION_STRING=postgresql://user:pass@host/db?sslmode=require
```

### Database Setup

Run SQL scripts in order:
1. `01_create_schemas_and_tables.sql`
2. `02_add_sample_data.sql`
3. `03_create_admin_dashboard_tables.sql`
4. `04_create_reviewer_dashboard_tables.sql`
5. `07_create_ndip_schema.sql`
6. `08_create_live_data_table.sql`
7. `09_update_submissions_schema.sql`

## 🚢 Deployment

### Live Application

**👉 [Access the Live Application](https://gatete-jimmy.shinyapps.io/NDIP-CODES/)**

The application is currently deployed on ShinyApps.io and is accessible at the link above.

### Deploy to ShinyApps.io

```r
source("scripts/deployment/deploy_shinyapps.R")
```

### Docker

```bash
docker build -t ndip-dashboard -f scripts/deployment/Dockerfile .
docker run -p 3838:3838 ndip-dashboard
```

## 🐛 Troubleshooting

### Database Connection Issues
```r
source("check_database_status.R")
```

### Performance Issues
- Check database connection pooling
- Verify indexes are created
- Review reactive polling intervals

### Login Not Working
- Clear browser cache
- Verify database users exist
- Check connection string

## 📝 Development

### Adding New Features

1. Create module in `modules/`
2. Source in `app.R`
3. Add UI and server functions
4. Test locally
5. Update documentation

### Code Style

- Use meaningful variable names
- Add comments for complex logic
- Follow Shiny best practices
- Optimize database queries

## 📄 License

© 2025 National Institute of Statistics Rwanda (NISR)

## 👥 Contributors

- **Project Lead**: NISR Data Team
- **Developer**: gatete-jimmy

## 📞 Support

For questions or issues:
- Email: admin@nisr.gov.rw
- Create an issue in the repository

---

**Version**: 1.0.0  
**Last Updated**: January 2025  
**Live Application**: [https://gatete-jimmy.shinyapps.io/NDIP-CODES/](https://gatete-jimmy.shinyapps.io/NDIP-CODES/)
