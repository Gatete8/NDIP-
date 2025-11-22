# ============================================================================
# Check Database Status - Quick Verification
# ============================================================================
# Purpose: Check if database is already set up before adding sample data
# ============================================================================

cat("\n")
cat("=" , rep("=", 70), "\n", sep="")
cat("  Checking NDIP Database Status\n")
cat("=" , rep("=", 70), "\n\n")

# Ensure we're in the right directory (project root)
cat(sprintf("📁 Current working directory: %s\n\n", getwd()))

cat("📡 Loading database connection module...\n")

# If scripts/db_connection.R is not found, suggest correct setwd to user
if (!file.exists("scripts/db_connection.R")) {
  stop(paste0(
    "❌ Cannot find scripts/db_connection.R\n",
    "   Current directory: ", getwd(), "\n\n",
    "👉 Please run this first in R:\n",
    "   setwd(\"C:/Users/USER/Desktop/NDIP.CODES.111.gatete\")\n"
  ))
}

source("scripts/db_connection.R")

# Test connection
cat("🔌 Testing connection...\n")
if (!test_neon_connection()) {
  stop("❌ Database connection failed!")
}
cat("✅ Connected to Neon database\n\n")

# Check schemas
cat("1️⃣ Checking schemas...\n")
schemas <- check_schemas()
cat(sprintf("   Found %d schemas:\n", nrow(schemas)))
for (i in seq_len(nrow(schemas))) {
  cat(sprintf("   • %s\n", schemas$schema_name[i]))
}

required_schemas <- c("auth", "uploads", "review")
has_all_schemas <- all(required_schemas %in% schemas$schema_name)

if (has_all_schemas) {
  cat("   ✅ All required schemas exist\n\n")
} else {
  missing <- setdiff(required_schemas, schemas$schema_name)
  cat(sprintf("   ❌ Missing schemas: %s\n\n", paste(missing, collapse=", ")))
}

# Check tables
cat("2️⃣ Checking tables...\n")
tables <- check_tables()
cat(sprintf("   Found %d tables:\n", nrow(tables)))
for (i in seq_len(nrow(tables))) {
  cat(sprintf("   • %s.%s\n", tables$table_schema[i], tables$table_name[i]))
}

required_tables <- c("auth.users", "uploads.data_submissions", "review.review_actions")
existing_tables <- paste(tables$table_schema, tables$table_name, sep=".")
has_all_tables <- all(required_tables %in% existing_tables)

if (has_all_tables) {
  cat("   ✅ All required tables exist\n\n")
} else {
  missing <- setdiff(required_tables, existing_tables)
  cat(sprintf("   ❌ Missing tables: %s\n\n", paste(missing, collapse=", ")))
}

# Check users
cat("3️⃣ Checking demo users...\n")
users <- check_users()
if (!is.null(users) && nrow(users) > 0) {
  cat(sprintf("   Found %d users:\n", nrow(users)))
  for (i in seq_len(nrow(users))) {
    cat(sprintf("   • %s (%s)\n", users$email[i], users$role[i]))
  }
  cat("   ✅ Demo users exist\n\n")
} else {
  cat("   ❌ No users found\n\n")
}

# Check if sample data already exists
cat("4️⃣ Checking for existing data...\n")
conn <- get_neon_connection()

# Check submissions
submission_count <- dbGetQuery(conn, "SELECT COUNT(*) as count FROM uploads.data_submissions")$count
submission_count <- as.numeric(submission_count)
cat(sprintf("   • Submissions: %.0f\n", submission_count))

# Check reviews
review_count <- dbGetQuery(conn, "SELECT COUNT(*) as count FROM review.review_actions")$count
review_count <- as.numeric(review_count)
cat(sprintf("   • Review actions: %.0f\n", review_count))

if (submission_count > 0) {
  cat("\n   📊 Existing submissions:\n")
  existing_data <- dbGetQuery(conn, "
    SELECT dataset_name, status, submitted_at 
    FROM uploads.data_submissions 
    ORDER BY submitted_at DESC 
    LIMIT 5
  ")
  print(existing_data)
}

dbDisconnect(conn)

# Summary and recommendation
cat("\n")
cat("=" , rep("=", 70), "\n", sep="")
cat("  SUMMARY\n")
cat("=" , rep("=", 70), "\n\n")

if (has_all_schemas && has_all_tables && nrow(users) >= 3) {
  cat("✅ Database is FULLY SET UP!\n\n")
  
  if (submission_count == 0) {
    cat("📊 Status: No sample data found\n\n")
    cat("🎯 RECOMMENDATION:\n")
    cat("   You can safely run Step 2 to add sample data:\n")
    cat("   > source('scripts/database/add_sample_data.R')\n\n")
  } else {
    cat(sprintf("📊 Status: %.0f submissions already exist\n\n", submission_count))
    cat("🎯 RECOMMENDATION:\n")
    if (submission_count < 5) {
      cat("   You have some data, but adding more sample data is safe:\n")
      cat("   > source('scripts/database/add_sample_data.R')\n\n")
    } else {
      cat("   You already have data! No need to add sample data.\n")
      cat("   Your admin dashboard should show real data now.\n\n")
    }
  }
  
  cat("✅ Ready to use admin dashboard!\n")
  cat("   Login: admin@nisr.gov.rw / demo123\n\n")
  
} else {
  cat("❌ Database is NOT fully set up\n\n")
  cat("🎯 RECOMMENDATION:\n")
  cat("   Run Step 1 first to create schemas and tables:\n")
  cat("   > source('scripts/database/setup_database.R')\n\n")
}

cat("=" , rep("=", 70), "\n\n")


