# Quick Start Guide

## 🚀 Getting Started in 5 Minutes

### Step 1: Install Packages
```r
source("scripts/setup/install_packages.R")
```

### Step 2: Configure Database
Edit `scripts/db_connection.R` and set your Neon PostgreSQL connection string.

### Step 3: Setup Database
```r
source("scripts/database/setup_database.R")
source("scripts/database/add_sample_data.R")
```

### Step 4: Run App
```r
shiny::runApp("app.R")
```

### Step 5: Login
- **Admin**: `admin@nisr.gov.rw` / `demo123`
- **Institution**: `health@moh.gov.rw` / `demo123`
- **Reviewer**: `reviewer@nisr.gov.rw` / `demo123`

## 📚 Full Documentation
See [README.md](README.md) for complete documentation.
