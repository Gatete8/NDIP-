# import_datasets.R
# Import CSV, Excel, RDS, and RData files from a source directory and save as .rds files
# Usage:
#   Rscript import_datasets.R [source_dir] [output_dir]
# Defaults: source_dir = 'data_raw' (relative), output_dir = 'data'

args <- commandArgs(trailingOnly = TRUE)
src_dir <- if(length(args) >= 1) args[[1]] else 'data_raw'
out_dir <- if(length(args) >= 2) args[[2]] else 'data'

cat(sprintf('Source dir: %s\nOutput dir: %s\n', src_dir, out_dir))

if(!dir.exists(src_dir)){
  stop(sprintf("Source directory '%s' not found. Create it or pass a different path as the first argument.", src_dir))
}
if(!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)

files <- list.files(src_dir, pattern = "\\.(csv|txt|xlsx|xls|rds|rda|RData)$", full.names = TRUE, ignore.case = TRUE)
if(length(files) == 0){
  cat('No supported data files found in source directory.\n')
  quit(status = 0)
}

# helpers
safe_name <- function(x){
  nm <- tools::file_path_sans_ext(basename(x))
  nm <- gsub('[^A-Za-z0-9_\-]', '_', nm)
  nm
}

for(f in files){
  ext <- tolower(tools::file_ext(f))
  base <- safe_name(f)
  cat(sprintf('\nProcessing: %s (.%s)\n', basename(f), ext))
  tryCatch({
    if(ext %in% c('csv','txt')){
      if(requireNamespace('data.table', quietly = TRUE)){
        dt <- data.table::fread(f)
        saveRDS(dt, file = file.path(out_dir, paste0(base, '.rds')))
        cat(sprintf('Saved %s rows x %s cols to %s\n', nrow(dt), ncol(dt), file.path(out_dir, paste0(base, '.rds'))))
      } else {
        df <- utils::read.csv(f, stringsAsFactors = FALSE)
        saveRDS(df, file = file.path(out_dir, paste0(base, '.rds')))
        cat(sprintf('Saved %s rows x %s cols to %s (used read.csv)\n', nrow(df), ncol(df), file.path(out_dir, paste0(base, '.rds'))))
      }
    } else if(ext %in% c('xlsx','xls')){
      if(!requireNamespace('readxl', quietly = TRUE)) stop('Package "readxl" required to read Excel files. Install with install.packages("readxl")')
      sheets <- readxl::excel_sheets(f)
      if(length(sheets) == 1){
        df <- readxl::read_excel(f)
        saveRDS(df, file = file.path(out_dir, paste0(base, '.rds')))
        cat(sprintf('Saved Excel sheet "%s" (%s rows) to %s\n', sheets[1], ifelse(is.data.frame(df), nrow(df), 'NA'), file.path(out_dir, paste0(base, '.rds'))))
      } else {
        for(sh in sheets){
          df <- readxl::read_excel(f, sheet = sh)
          outname <- file.path(out_dir, paste0(base, '_', gsub('[^A-Za-z0-9]', '_', sh), '.rds'))
          saveRDS(df, file = outname)
          cat(sprintf('Saved Excel sheet "%s" to %s\n', sh, outname))
        }
      }
    } else if(ext == 'rds'){
      obj <- readRDS(f)
      saveRDS(obj, file = file.path(out_dir, paste0(base, '.rds')))
      cat(sprintf('Copied RDS to %s\n', file.path(out_dir, paste0(base, '.rds'))))
    } else if(ext %in% c('rda','RData')){
      # load may create multiple objects - save each as separate rds
      env <- new.env()
      load(f, envir = env)
      objs <- ls(envir = env)
      if(length(objs) == 0){
        cat('No objects found in .rda file.\n')
      } else {
        for(objn in objs){
          obj <- get(objn, envir = env)
          outname <- file.path(out_dir, paste0(base, '__', objn, '.rds'))
          saveRDS(obj, file = outname)
          cat(sprintf('Saved object "%s" to %s\n', objn, outname))
        }
      }
    } else {
      cat(sprintf('Skipping unsupported extension: %s\n', ext))
    }
  }, error = function(e){
    cat(sprintf('Error processing %s: %s\n', f, conditionMessage(e)))
  })
}

cat('\nImport complete. Look in the "', normalizePath(out_dir), '" directory for .rds files.\n', sep='')
