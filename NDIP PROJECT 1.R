

library(shiny)
library(bslib)
library(shinyWidgets)
library(shinyjs)
library(fontawesome)
library(plotly)
library(DT)
library(readr)
library(readxl)
library(dplyr)



# Load datasets with error handling
tryCatch({
  Rwanda_agriculture <- read.csv("NDIP DATASETS- economic schema/rwanda_agriculture yields crops_ to GDP.csv")
  Rwanda_agri_gdp <- read.csv("NDIP DATASETS- economic schema/rwanda_agriculture_% to GDP data.csv")
  Rwanda_education <- read.csv("NDIP DATASETS- economic schema/Rwanda_Education_Indicators_2014_2025.csv")
  Rwanda_GDP <- read.csv("NDIP DATASETS- economic schema/Rwanda_GDP_Yearly_2010_2025.csv")
  Rwanda_health <- read.csv("NDIP DATASETS- economic schema/rwanda_health_indicators.csv")
  Rwanda_inflation <- read.csv("NDIP DATASETS- economic schema/Rwanda_Inflation.csv")
  Rwanda_labor_force <- read.csv("NDIP DATASETS- economic schema/Rwanda_Labour_Force.csv")
  Rwanda_land_use <- read.csv("NDIP DATASETS- economic schema/rwanda_land_use_data.csv")
  Rwanda_population <- read.csv("NDIP DATASETS- economic schema/rwanda_population.csv")
  Rwanda_production_output <- read.csv("NDIP DATASETS- economic schema/Rwanda_Production_Output.csv")
  Rwanda_schools <- read.csv("NDIP DATASETS- economic schema/rwanda_school_type_percentages_2010_2025.csv")
  Rwanda_trade <- read.csv("NDIP DATASETS- economic schema/Rwanda_Trade.csv")
  Rwanda_vital_statistics <- read.csv("NDIP DATASETS- economic schema/rwanda_vital_stats.csv")
  message("All datasets loaded successfully!")
}, error = function(e) {
  message("Error loading datasets: ", e$message)
  message("Please ensure all CSV files are in the 'NDIP DATASETS- economic schema' folder")
})




# Define a simple Bootstrap theme used by the UI. The original code referenced `app_theme`
# but it wasn't defined which caused the runtime error. This provides a minimal theme.
app_theme <- bs_theme(
  version = 5,
  base_font = font_google("Inter"),
  bg = "#ffffff",
  fg = "#0D1B2A",
  primary = "#0B78A0",
  secondary = "#157A4A"
)

custom_css <- "/* Professional NDIP Styling - Solid Colors, No Gradients */
* {
  box-sizing: border-box;
}

html, body { 
  scroll-behavior: smooth; 
  height: 100%;
  margin: 0;
  padding: 0;
  overflow-x: hidden; /* Prevent horizontal scrolling */
}

body { 
  background: #ffffff; 
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif; 
  color: #1a1a1a; 
  line-height: 1.6;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  width: 100%;
  max-width: 100vw;
}

/* Professional Navbar - Clean and Modern */
.topnav { 
  display: flex; 
  align-items: center; 
  justify-content: center; 
  position: fixed; 
  top: 20px; 
  left: 50%; 
  transform: translateX(-50%); 
  z-index: 1000; 
  width: calc(100% - 40px); 
  max-width: 1200px; 
  padding: 12px 24px; 
  background: #ffffff; 
  border-radius: 16px; 
  box-shadow: 0 4px 20px rgba(0,0,0,0.08); 
  border: 1px solid #e5e7eb;
}

.brand { 
  font-weight: 700; 
  color: #1f2937; 
  font-size: 18px; 
  margin-right: 32px; 
}

.topnav-inner { 
  display: flex; 
  align-items: center; 
  width: 100%; 
  justify-content: space-between;
}

.navlinks { 
  display: flex; 
  gap: 32px; 
  margin: 0;
}

.navlinks a { 
  color: #374151; 
  text-decoration: none; 
  font-weight: 500; 
  font-size: 15px; 
  padding: 8px 16px; 
  border-radius: 8px; 
  transition: all 0.2s ease;
}

.navlinks a:hover { 
  background: #f3f4f6; 
  color: #1f2937; 
}

.nav-cta .cta-btn { 
  background: #2563eb; 
  color: #ffffff; 
  padding: 10px 20px; 
  border-radius: 8px; 
  font-weight: 600; 
  text-decoration: none; 
  transition: background 0.2s ease;
}

.nav-cta .cta-btn:hover { 
  background: #1d4ed8; 
}

/* Responsive Navbar */
@media (max-width: 768px) { 
  .topnav { 
    width: calc(100% - 20px); 
    padding: 10px 16px; 
  } 
  .navlinks { 
    gap: 16px; 
  } 
  .navlinks a {
    font-size: 14px;
    padding: 6px 12px;
  }
  .nav-cta { 
    display: none; 
  } 
}

/* Professional Hero Section */
.section { 
  padding: 80px 20px 40px;
  max-width: 1200px;
  margin: 0 auto;
  width: 100%;
}

.hero {
  display: flex;
  gap: 60px;
  align-items: center;
  padding: 40px 0;
  max-width: 1200px;
  margin: 0 auto;
  width: 100%;
}

.hero-left { 
  flex: 1; 
  max-width: 600px;
}

.hero-left .badge { 
  display: inline-block; 
  background: #eff6ff; 
  color: #2563eb; 
  padding: 6px 12px; 
  border-radius: 20px; 
  font-weight: 600; 
  font-size: 14px; 
  margin-bottom: 16px; 
}

.hero-left .hero-title { 
  font-size: 48px; 
  font-weight: 800; 
  color: #111827; 
  margin: 0 0 16px 0; 
  line-height: 1.1;
}

.hero-left .hero-sub { 
  font-size: 20px; 
  color: #6b7280; 
  margin-bottom: 32px; 
  line-height: 1.5;
}

.hero-left .hero-ctas { 
  display: flex; 
  gap: 16px; 
  margin-bottom: 40px; 
}

.hero-left .btn-primary { 
  background: #2563eb; 
  color: #ffffff; 
  padding: 14px 28px; 
  border-radius: 8px; 
  font-weight: 600; 
  text-decoration: none; 
  transition: background 0.2s ease;
  border: none; 
  cursor: pointer; 
}

.hero-left .btn-primary:hover { 
  background: #1d4ed8; 
}

.hero-left .btn-outline { 
  background: transparent; 
  border: 2px solid #d1d5db; 
  color: #374151; 
  padding: 12px 26px; 
  border-radius: 8px; 
  text-decoration: none; 
  font-weight: 600; 
  transition: all 0.2s ease;
}

.hero-left .btn-outline:hover { 
  background: #f9fafb; 
  border-color: #9ca3af;
}

/* Professional Image Carousel */
.hero-right { 
  flex: 0 0 500px;
  max-width: 500px;
  width: 100%;
}

.carousel-container { 
  position: relative;
  width: 100%; 
  height: 400px; 
  overflow: hidden; 
  border-radius: 16px; 
  box-shadow: 0 20px 40px rgba(0,0,0,0.1);
}

.carousel-track { 
  display: flex; 
  width: 500%; 
  height: 100%; 
  animation: slide 15s infinite; 
}

.carousel-slide { 
  width: 20%; 
  height: 100%; 
}

.carousel-slide img { 
  width: 100%;
  height: 100%; 
  object-fit: cover;
}

.carousel-dots { 
  position: absolute; 
  bottom: 20px; 
  left: 50%; 
  transform: translateX(-50%); 
  display: flex; 
  gap: 8px; 
}

.dot { 
  width: 10px; 
  height: 10px; 
  border-radius: 50%; 
  background: rgba(255,255,255,0.5); 
  cursor: pointer; 
  transition: background 0.3s; 
}

.dot.active { 
  background: #ffffff; 
}

@keyframes slide { 
  0%, 20% { transform: translateX(0%); }
  25%, 45% { transform: translateX(-20%); }
  50%, 70% { transform: translateX(-40%); }
  75%, 95% { transform: translateX(-60%); }
  100% { transform: translateX(-80%); }
}

/* Responsive Design */
@media (max-width: 1024px) {
  .hero {
    gap: 40px;
    padding: 30px 0;
  }
  .hero-right {
    flex: 0 0 400px;
    max-width: 400px;
  }
  .carousel-container {
    height: 300px;
  }
}

@media (max-width: 768px) {
  .hero {
    flex-direction: column;
    gap: 40px;
    text-align: center;
  }
  .hero-right {
    flex: 1;
    max-width: 100%;
  }
  .carousel-container {
    height: 250px;
  }
  .hero-left .hero-title {
    font-size: 36px;
  }
  .hero-left .hero-sub {
    font-size: 18px;
  }
  .hero-left .hero-ctas {
    justify-content: center;
    flex-wrap: wrap;
  }
}

@media (max-width: 480px) {
  .section {
    padding: 60px 16px 30px;
  }
  .hero-left .hero-title {
    font-size: 28px;
  }
  .hero-left .hero-sub {
    font-size: 16px;
  }
  .hero-left .btn-primary,
  .hero-left .btn-outline {
    padding: 12px 20px;
    font-size: 14px;
  }
  .carousel-container {
    height: 200px;
  }
}

/* Professional Stats Cards */
.home-stats { 
  display: flex; 
  gap: 24px; 
  justify-content: center; 
  margin: 60px 0; 
  flex-wrap: wrap;
}

.stat-card { 
  flex: 1; 
  min-width: 280px; 
  max-width: 320px; 
  background: #ffffff; 
  border-radius: 16px; 
  padding: 32px 24px; 
  box-shadow: 0 4px 20px rgba(0,0,0,0.06); 
  border: 1px solid #f3f4f6;
  display: flex; 
  gap: 20px; 
  align-items: center; 
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.stat-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 30px rgba(0,0,0,0.1);
}

.stat-card .stat-icon { 
  width: 64px; 
  height: 64px; 
  border-radius: 16px; 
  background: #eff6ff; 
  display: flex; 
  align-items: center; 
  justify-content: center; 
  color: #2563eb; 
  font-size: 24px; 
  flex-shrink: 0;
}

.stat-card .num { 
  font-size: 32px; 
  font-weight: 800; 
  color: #1f2937; 
  line-height: 1; 
  margin-bottom: 4px;
}

.stat-card .num .suffix { 
  font-size: 18px; 
  margin-left: 4px; 
  color: #6b7280; 
}

.stat-card .label { 
  font-size: 16px; 
  font-weight: 600; 
  color: #374151; 
  margin-bottom: 4px;
}

.stat-card .small { 
  font-size: 14px; 
  color: #9ca3af; 
}

/* Stats Cards Responsive */
@media (max-width: 768px) {
  .home-stats { 
    flex-direction: column; 
    align-items: center; 
    gap: 16px; 
    margin: 40px 0;
  }
  
  .stat-card { 
    width: 100%; 
    max-width: 400px; 
    min-width: auto;
  }
}

/* Small visual enhancements used by the creative count-up script */
.stat-card.counting { transform: translateY(-6px) scale(1.01); box-shadow: 0 22px 60px rgba(11,120,160,0.12); }
.stat-card .suffix { transition: opacity 420ms ease 300ms; opacity: 1; }
.stat-card .suffix.hidden { opacity: 0; }
@keyframes pop-in { 0% { transform: scale(.92); opacity: 0.0 } 60% { transform: scale(1.06); opacity: 1 } 100% { transform: scale(1); opacity: 1 } }
.num.pop { animation: pop-in 720ms cubic-bezier(.2,.9,.2,1); }

/* Features row */
features { 
  display: grid; 
  grid-template-columns: repeat(4, 1fr); 
  gap: 18px; 
  margin-top: 36px; 
}
.feature-card { 
  background: #fff; 
  border-radius: 12px; 
  padding: 18px; 
  box-shadow: 0 8px 24px rgba(15,15,15,0.03); 
  border: 1px solid rgba(11,120,160,0.06); 
}
.feature-card h4 { 
  margin: 6px 0 0; 
  color: #111; 
}
.feature-card p { 
  color: #555; 
  font-size: 14px; 
}

/* Sections */
.section-alt { 
  background: #fbfbfd; 
  min-height: 1400px; /* Increased height for overview section */
  padding-bottom: 120px; /* Add more space at the bottom */
}
.section h2 { 
  color: #0D1B2A; 
  font-weight: 800; 
  margin-bottom: 18px; 
}

/* Footer */
.footer { 
  padding: 28px; 
  background: #f5f8fa; 
  text-align: center; 
  color: black; 
  margin-top: 30px; 
  max-width: calc(100% - 120px); /* limit width and keep small side gutters */
  margin-left: auto; margin-right: auto; /* center the footer */
  border-radius: 10px; /* subtle rounding when not full-bleed */
}

/* Floating chat widget - Menya */
.menya-btn { position: fixed; right: 28px; bottom: 28px; width:64px; height:64px; border-radius:20px; background: linear-gradient(90deg,#3b82f6,#0ea5e9); color:#fff; display:flex; align-items:center; justify-content:center; font-weight:800; box-shadow: 0 18px 40px rgba(14,165,233,0.18); cursor:pointer; z-index:1400; }
.menya-btn .label { position:absolute; right:78px; bottom:18px; background:#0ea5e9; color:#fff; padding:8px 12px; border-radius:12px; font-weight:700; box-shadow:0 8px 18px rgba(14,165,233,0.12); }
.menya-modal { position: fixed; right: 28px; bottom: 110px; width: 360px; max-width: calc(100% - 48px); background: #fff; border-radius:12px; box-shadow: 0 30px 80px rgba(6,22,34,0.28); z-index:1500; overflow:hidden; display:none; flex-direction:column; }
.menya-modal .header { background: linear-gradient(90deg,#60a5fa,#3b82f6); color:#fff; padding:12px 14px; display:flex; align-items:center; justify-content:space-between; }
.menya-modal .messages { padding:12px; max-height:320px; overflow:auto; background:#fbfdff; }
.menya-modal .input-row { display:flex; gap:8px; padding:10px; border-top:1px solid #eef6ff; }
.menya-modal .input-row input { flex:1; padding:10px 12px; border-radius:8px; border:1px solid #e6f2ff; }
.menya-modal .input-row button { background:#0b78a0; color:#fff; border:none; padding:10px 12px; border-radius:8px; cursor:pointer; }


/* Animations */
.fade-in-up { 
  opacity: 0; 
  transform: translateY(18px); 
  transition: all 700ms cubic-bezier(.2,.9,.2,1); 
  will-change: opacity, transform;
}
.fade-in-up.in-view { 
  opacity: 1; 
  transform: translateY(0); 
}
.text-highlight { 
  color: var(--accent);
  /* optional extra emphasis */
  text-decoration: none;
}

/* Creative Typewriter Effect */
@keyframes creative-typewriter { from { width: 0; } to { width: 100%; } }
@keyframes creative-caret { 0%, 100% { border-color: transparent; } 50% { border-color: var(--accent-yellow); } }
.creative-typewriter { 
  display: inline-block; 
  overflow: hidden; 
  border-right: 3px solid var(--accent-yellow); 
  white-space: nowrap; 
  width: 0; 
  color: var(--accent); 
  font-weight: 500; 
  font-size: 15px; /* Smaller font size */
  letter-spacing: 0.2px; /* Tighter spacing */
  margin-bottom: 4px; /* Less space below */
  animation: creative-typewriter 3.8s steps(32, end) 0.5s 1 normal both, creative-caret 0.8s step-end infinite; 
  background: linear-gradient(90deg, var(--accent-yellow) 10%, var(--accent) 90%); 
  -webkit-background-clip: text; 
  -webkit-text-fill-color: transparent; 
}

/* Responsive */
@media (max-width: 900px) { 
  .hero { flex-direction: column-reverse; padding: 40px 20px; } 
  .hero-right { width: 100%; flex: 0 0 auto; } 
  .features { grid-template-columns: repeat(2, 1fr); } 
}
@media (max-width: 600px) { 
  .topnav { padding: 12px 16px; } 
  .section { padding-top: 120px; } 
  .features { grid-template-columns: 1fr; } 
}

/* Sector Performance Cards */
.sector-section { margin-left: -200px; padding: 22px 28px; }
.sector-title { color: #0B78A0; font-weight:800; margin-bottom:18px; text-align:left; }
.sector-row { display:flex; gap:24px; align-items:stretch; margin-bottom:22px; }
.sector-card { background: var(--network-gray); border-radius:14px; padding:28px; box-shadow: 0 16px 40px rgba(0,0,0,0.25); border:1px solid rgba(0,0,0,0.35); flex:1; min-width:480px; position:relative; transition: transform 220ms ease, box-shadow 220ms ease; cursor: pointer; min-height:220px; color: #fff; }
.sector-card:hover { transform: translateY(-8px); box-shadow: 0 18px 40px rgba(11,120,160,0.12); }
.ector-card .left-icon { width:48px; height:48px; border-radius:12px; display:flex; align-items:center; justify-content:center; background:var(--network-gray-2); color:#fff; font-size:18px; margin-right:14px; }

/* Fix accidental typo-free duplicate selector corrected below */
 .sector-card .left-icon { width:48px; height:48px; border-radius:12px; display:flex; align-items:center; justify-content:center; background:var(--network-gray-2); color:var(--accent); font-size:18px; margin-right:14px; }
 /* Alternate sector card icon colors: odd = blue, even = green */
 .sector-row .sector-card:nth-child(odd) .left-icon,
 .sector-row .sector-card:nth-child(odd) .left-icon i { color: var(--accent); }
 .sector-row .sector-card:nth-child(even) .left-icon,
 .sector-row .sector-card:nth-child(even) .left-icon i { color: var(--accent-2); }

/* Alternate icon colors specifically for overview cardboxes: odd = blue, even = green */
#overview .animated-infobox:nth-child(odd) .infobox-icon,
#overview .animated-infobox:nth-of-type(odd) .infobox-icon,
#overview .animated-infobox:nth-child(odd) .infobox-icon i,
#overview .animated-infobox:nth-of-type(odd) .infobox-icon i { color: var(--accent); }

#overview .animated-infobox:nth-child(even) .infobox-icon,
#overview .animated-infobox:nth-of-type(even) .infobox-icon,
#overview .animated-infobox:nth-child(even) .infobox-icon i,
#overview .animated-infobox:nth-of-type(even) .infobox-icon i { color: var(--accent-2); }
.sector-card .card-head { display:flex; align-items:center; gap:12px; }
.sector-card h4 { margin:0; font-size:20px; color:#0D1B2A; }
.sector-badge { background:#00a6c4; color:#fff; padding:6px 10px; border-radius:14px; font-size:12px; font-weight:700; margin-left:8px; }
.sector-change { position:absolute; right:18px; top:18px; color:#157A4A; font-weight:700; }
.perf-line { margin-top:12px; display:flex; align-items:center; gap:12px; }
.perf-line .score { font-weight:700; color:#0D1B2A; }
.perf-bar { background:#e6eef0; height:10px; border-radius:10px; overflow:hidden; flex:1; }
.perf-bar .fill { height:100%; background: linear-gradient(90deg,#0B78A0,#157A4A); border-radius:10px; width:0%; }
.sector-desc { margin-top:12px; color:#4a5b64; font-size:14px; }

/* Infobox icon and size tweaks */
.infobox-icon { width:56px; height:56px; border-radius:10px; display:flex; align-items:center; justify-content:center; background:var(--network-gray-2); color:#fff; font-size:22px; flex:0 0 56px; }

/* Make overview/interactive boxes and feature cards darker and consistent */
.animated-infobox, .interactive-box, .feature-card { background: var(--network-gray) !important; color: #fff; border: 1px solid rgba(0,0,0,0.22) !important; }
.animated-infobox * , .interactive-box * , .feature-card * { color: inherit; }
.animated-infobox { transition: transform 180ms ease, box-shadow 180ms ease; }
.animated-infobox:hover { transform: translateY(-6px); box-shadow: 0 12px 30px rgba(11,120,160,0.08); }

/* Sector header & subtitle */
.sector-subtitle { color:#556; font-size:15px; margin-top:6px; margin-bottom:18px; }
.high-perf-header { display:flex; align-items:center; gap:12px; margin-bottom:12px; }
.high-perf-header i { color: var(--accent); font-size:20px; }
.sector-badge { background:#00a6c4; color:#fff; padding:6px 12px; border-radius:18px; font-size:12px; font-weight:700; margin-left:8px; }
.sector-change { color:#16a34a; font-weight:800; display:flex; align-items:center; gap:6px; }
.sector-card.fade-in-up { opacity: 0; transform: translateY(18px); }
.sector-card.fade-in-up.in-view { opacity:1; transform: translateY(0); transition: all 560ms cubic-bezier(.2,.9,.2,1); }

/* Space title and badge vertically, and push the performance line down */
.sector-card .card-head { align-items:flex-start; }
.sector-card .card-head h4 { margin:0; font-size:20px; line-height:1.2; }
.sector-card .card-head h4 .sector-badge { display:block; margin-top:8px; margin-left:0; }
.sector-card .card-head .left-icon { margin-top:4px; }
.sector-card .perf-line { margin-top:20px; }

/* Developing header between rows */
  .developing-header { display:flex; align-items:center; gap:10px; margin:22px 0 8px; }
.developing-header i { color: var(--accent); background:#e6f7ff; padding:8px; border-radius:8px; font-size:16px; }
.developing-header h4 { margin:0; font-size:18px; color:#0B78A0; font-weight:800; }

/* Predictive analysis cards */
.predict-section { margin-left: -200px; padding: 22px 28px; }
.predict-title { color: #0B78A0; font-weight:800; margin-bottom:12px; text-align:left; }
.predict-title { margin-top:0; }
.predict-row { display:flex; gap:24px; align-items:stretch; margin-bottom:22px; }
.predict-card { background: var(--network-gray); border-radius:14px; padding:22px; box-shadow: 0 14px 36px rgba(0,0,0,0.06); border:1px solid rgba(0,0,0,0.06); flex:1; min-width:420px; position:relative; transition: transform 220ms ease, box-shadow 220ms ease; cursor: pointer; min-height:260px; color: #0D1B2A; }
.predict-card:hover { transform: translateY(-8px); box-shadow: 0 20px 44px rgba(11,120,160,0.12); }
.predict-header { display:flex; align-items:center; gap:12px; justify-content:space-between; }
.predict-header .left-icon { width:44px; height:44px; border-radius:10px; display:flex; align-items:center; justify-content:center; background:var(--network-gray-2); color:var(--accent); font-size:18px; margin-right:12px; }
.predict-year { color:#445; font-weight:700; font-size:14px; }
.predict-confidence { margin-top:8px; font-size:13px; color:#556; }
.predict-body { display:flex; gap:18px; margin-top:14px; align-items:flex-start; }
.predict-body .current, .predict-body .predicted { flex:1; }
.predict-body .current .val, .predict-body .predicted .val { font-size:22px; font-weight:800; color:var(--accent); }
.predict-growth { margin-top:12px; font-weight:800; display:flex; align-items:center; gap:8px; }
.predict-growth.up { color: #157A4A; }
.predict-growth.down { color: #d9534f; }
.predict-desc { margin-top:10px; color:#556; font-size:13px; }
.predict-bar { height:10px; background:#e9eef0; border-radius:12px; overflow:hidden; margin-top:10px; }
.predict-bar .predict-fill { height:100%; width:0%; background: linear-gradient(90deg,#0B78A0,#157A4A); transition: width 900ms cubic-bezier(.2,.9,.2,1); }

/* Sector Dashboards (cards grid matching provided image) */
.sector-dashboards { margin-left: -200px; padding: 12px 28px 28px 28px; }
.sd-header { display:flex; flex-direction:column; gap:6px; margin-bottom:18px; }
.sd-title { font-size:34px; font-weight:900; text-align:left; color:#0D1B2A; margin:0 0 6px 0; }
.sd-sub { text-align:center; color:#556; margin:0 auto 18px; max-width:880px; }
/* New grid layout for sector cards to ensure consistent ordering and spacing */
.sd-grid { display:grid; grid-template-columns: repeat(3, minmax(340px, 1fr)); gap:32px; align-items:stretch; }
.sd-row { display:flex; gap:24px; flex-wrap:wrap; align-items:stretch; justify-content:space-between; }
.sd-card { background: #e6f7ee; /* light green card body */ border-radius:14px; padding:30px; box-shadow: 0 16px 54px rgba(0,0,0,0.08); border:1px solid rgba(0,0,0,0.06); flex: none; width:100%; min-height:420px; position:relative; transition: transform 220ms ease, box-shadow 220ms ease; cursor:pointer; color:#0D1B2A; }
.sd-card:hover { transform: translateY(-8px); box-shadow: 0 22px 56px rgba(11,120,160,0.10); }
.sd-top { display:flex; align-items:center; gap:12px; }
.sd-top .left-icon { width:48px; height:48px; border-radius:10px; display:flex; align-items:center; justify-content:center; background:var(--network-gray-2); color:var(--accent); font-size:20px; }
.sd-title-inline { font-size:20px; font-weight:800; }
.sd-desc { color:#556; font-size:13px; margin-top:8px; }
.sd-kpi { margin-top:18px; background:#d6f0d9; /* pale green for KPI strip */ border-radius:12px; padding:20px; display:flex; align-items:center; justify-content:space-between; }
.sd-kpi .kpi-label { color:#556; font-size:14px; }
.sd-kpi .kpi-val { font-size:34px; font-weight:900; color:var(--accent); }
.sd-footer { margin-top:16px; }
.sd-button { display:inline-block; background:#0B78A0; color:#fff; padding:12px 18px; border-radius:8px; text-decoration:none; font-weight:700; }


@media (max-width: 1100px) {
  .sector-section { margin-left: -40px; padding: 12px; }
  .sector-row { flex-direction: column; }
}

.footer {
  /* Updated gradient palette (top -> bottom):
    #FFFFFF, #EAF6FF, #C1E5FF, #9CD5FF, #6AB0E3 */
  background: linear-gradient(180deg, #FFFFFF 0%, #EAF6FF 25%, #C1E5FF 50%, #9CD5FF 75%, #6AB0E3 100%);
  color: #0D1B2A;
  padding: 36px 48px;
  box-sizing: border-box;
  border-top: 1px solid rgba(255,255,255,0.06); /* subtle lighter divider */
  max-width: 1200px; /* constrain width to avoid full-bleed */
  margin: 30px auto 0; /* center horizontally */
  border-radius: 12px;
}
.footer h4 { font-size: 18px; font-weight: 800; margin: 0 0 12px 0; color: #0D1B2A; }
.footer p, .footer li, .footer a { font-size: 15px; color: #556; text-decoration: none; }
.footer .left-logo { width:48px; height:48px; border-radius:10px; display:flex; align-items:center; justify-content:center; font-weight:800; font-size:16px; color:#fff; background:#0B78A0; }
.footer .left-desc { max-width:520px; color:#445; font-size:15px; }
.footer .col { min-width:160px; }
.footer .footer-bottom { margin-top:18px; padding-top:16px; border-top:1px solid rgba(13,27,42,0.04); text-align:center; color:#556; font-weight:600; font-size:14px; }

@media (max-width:900px) {
  .footer { padding: 24px 20px; }
  .footer h4 { font-size:16px; }
  .footer p, .footer li, .footer a { font-size:14px; }
  .footer .left-desc { max-width:360px; }
}

/* Standalone Economic Dashboard Sidebar (steelblue + pill hover effect) */
.standalone-sidebar { position:fixed; left:0; top:0; bottom:0; width:300px; background:#4682B4; padding:28px 18px; color:#fff; box-shadow: 0 30px 60px rgba(3,105,161,0.08); display:flex; flex-direction:column; gap:18px; align-items:flex-start; border-top-right-radius:12px; border-bottom-right-radius:12px; overflow:visible; z-index:2100; }
.standalone-sidebar .brand { font-weight:900; font-size:20px; color:#fff; margin-bottom:8px; }
.side-nav ul { list-style:none; padding:0; margin:12px 0 0 0; width:100%; display:flex; flex-direction:column; gap:12px; }
.side-link { position:relative; display:flex; align-items:center; gap:12px; padding:12px 14px; color:#fff; text-decoration:none; border-radius:999px; font-weight:800; font-size:18px; z-index:2; transition: color .24s ease; overflow:visible; }
.side-link .side-icon { width:26px; text-align:center; font-size:18px; color:inherit; z-index:3; }
.side-link .side-text { display:inline-block; white-space:nowrap; z-index:3; }
.side-link .side-pill { position:absolute; left:8px; top:50%; transform:translateY(-50%); width:0; height: calc(100% + 12px); background:#ffffff; border-radius:28px; transition: width .36s cubic-bezier(.2,.9,.2,1); box-shadow: 0 12px 30px rgba(2,6,23,0.08); z-index:1; }
.side-link:hover .side-pill, .side-link.active .side-pill { width:290px; }
.side-link:hover { color:#2a5d73; }
.side-link:focus { outline:none; }
.standalone-main { margin-left:300px !important; transition: margin-left .28s ease; }
@media(max-width:900px) {
  .standalone-sidebar { width:84px; padding:18px 12px; align-items:center; }
  .standalone-sidebar .brand { font-size:16px; }
  .side-link { justify-content:center; padding:12px; font-size:16px; }
  .side-link .side-text { display:none; }
  .standalone-main { margin-left:84px !important; }
  .side-link .side-pill { display:none; }
}
"

ui <- fluidPage(
  useShinyjs(),
  theme = app_theme,
  tags$head(
    # Viewport meta tag for proper mobile responsiveness
    tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0"),
    tags$style(HTML(custom_css)),
    # Font Awesome CDN for icons (solid)
    tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"),
    # Inter font for professional typography
    tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"),
    # Ensure the top-level Shiny container is a column flex so footer can be pushed to bottom
    tags$style(HTML('.container-fluid{display:flex; flex-direction:column; min-height:100vh; padding:0;}.container-fluid > .row{flex:1 0 auto;}')),
    tags$script(HTML(
      "document.addEventListener('DOMContentLoaded', function() {
         // Smooth scrolling for anchor links
         try {
           const links = document.querySelectorAll('.topnav .navlinks a');
           if (links && links.length) {
             links.forEach(function(a){
               a.addEventListener('click', function(e){
                 e.preventDefault();
                 const id = this.getAttribute('href');
                 if (!id) return;
                 const el = document.querySelector(id);
                 if (el) {
                   el.scrollIntoView({behavior:'smooth', block:'start'});
                 }
               });
             });
           }
         } catch (err) {
           console.warn('Anchor smooth scroll setup failed', err);
         }

         // IntersectionObserver to add 'in-view' class for animations
         try {
           var observerSupported = ('IntersectionObserver' in window);
           if (observerSupported) {
             const obs = new IntersectionObserver(function(entries){
               entries.forEach(function(en){
                 if (en.isIntersecting) {
                   en.target.classList.add('in-view');
                   // Optional: unobserve after it becomes visible
                   obs.unobserve(en.target);
                 }
               });
             }, { threshold: 0.12 });

             const fadeEls = document.querySelectorAll('.fade-in-up');
             if (fadeEls && fadeEls.length) {
               fadeEls.forEach(function(el){ obs.observe(el); });
             }

             // Also observe the sector-section to animate perf bars with stagger
             const sector = document.querySelector('.sector-section');
             if (sector) {
               const secObs = new IntersectionObserver(function(entries){
                 entries.forEach(function(en){
                   if (en.isIntersecting) {
                     // Animate fills with a stagger based on index
                     const fills = Array.from(sector.querySelectorAll('.perf-bar .fill'));
                     fills.forEach(function(f, i){
                       const target = f.getAttribute('data-fill') || f.style.width || '80%';
                       setTimeout(function(){ f.style.transition = 'width 900ms cubic-bezier(.2,.9,.2,1)'; f.style.width = target; }, 120 * (i+1));
                     });
                     secObs.unobserve(sector);
                   }
                 });
               }, { threshold: 0.16 });
               secObs.observe(sector);
             }

           } else {
             // If not supported, just reveal everything
             document.querySelectorAll('.fade-in-up').forEach(function(el){ el.classList.add('in-view'); });
             document.querySelectorAll('.perf-bar .fill').forEach(function(f){
               const target = f.getAttribute('data-fill') || '80%'; f.style.width = target;
             });
           }
         } catch (err) {
           console.warn('Observer setup failed', err);
         }

         // Creative typewriter effect for h1
         var h1 = document.getElementById('typewriter-h1');
         if (h1) {
           h1.style.width = '0';
           setTimeout(function() {
             h1.style.transition = 'none';
             h1.style.width = h1.scrollWidth + 'px';
           }, 3200);
         }
         // Typewriter for GDP and Literacy boxes
         function typeWriterBox(id, text, speed) {
           var el = document.getElementById(id);
           if (!el) return;
           el.innerHTML = '';
           let i = 0;
           function type() {
             if (i < text.length) {
               el.innerHTML += text.charAt(i);
               i++;
               setTimeout(type, speed);
             }
           }
           type();
         }
         setTimeout(function(){
           try {
             typeWriterBox('gdp-typewriter', document.getElementById('gdp-typewriter').getAttribute('data-text'), 22);
             typeWriterBox('literacy-typewriter', document.getElementById('literacy-typewriter').getAttribute('data-text'), 22);
           } catch(e) { /* ignore if not present */ }
         }, 800);

         // Make sector cards clickable and send an input to Shiny for modal details
         try {
           document.querySelectorAll('.sector-card').forEach(function(card){
             card.addEventListener('click', function(){
               var title = card.querySelector('h4').innerText || 'Sector';
               if (window.Shiny && Shiny.setInputValue) {
                 Shiny.setInputValue('sector_card_click', title + '|' + Math.random());
               }
             });
           });
         } catch(e) { /* ignore */ }

         // Predictive cards: animate fills when in view and wire clicks to Shiny
         try {
           var predictSection = document.querySelector('.predict-section');
           if (predictSection && 'IntersectionObserver' in window) {
             var predObs = new IntersectionObserver(function(entries){
               entries.forEach(function(en){
                 if (en.isIntersecting) {
                   var fills = Array.from(predictSection.querySelectorAll('.predict-fill'));
                   fills.forEach(function(f, i){
                     var target = f.getAttribute('data-fill') || '60%';
                     setTimeout(function(){ f.style.width = target; }, 120 * (i+1));
                   });
                   predObs.unobserve(predictSection);
                 }
               });
             }, { threshold: 0.12 });
             predObs.observe(predictSection);
           } else if (predictSection) {
             predictSection.querySelectorAll('.predict-fill').forEach(function(f){ f.style.width = f.getAttribute('data-fill') || '60%'; });
           }

           document.querySelectorAll('.predict-card').forEach(function(card){
             card.addEventListener('click', function(){
               var id = card.getAttribute('data-id') || card.querySelector('strong').innerText || 'predict';
               if (window.Shiny && Shiny.setInputValue) {
                 Shiny.setInputValue('predict_card_click', id + '|' + Math.random());
               }
             });
           });
         } catch(e) { /* ignore */ }

      });"
    )),
  tags$script(HTML("(function(){
    // Creative immediate-on-load count-up for the Home stat cards
    function animateCount(el,target,decimals){
      var start=0; var startTime=null; var duration=1200;
      function step(ts){
        if(!startTime) startTime = ts;
        var progress = Math.min((ts - startTime)/duration, 1);
        var value = start + (target - start) * progress;
        if(decimals && decimals>0){ el.textContent = Number(value).toFixed(decimals); } else { el.textContent = Math.floor(value).toLocaleString(); }
        if(progress < 1) requestAnimationFrame(step);
      }
      requestAnimationFrame(step);
    }
    function playCreativeCounts(){
      try{
        var counts = Array.from(document.querySelectorAll('.home-stats .count'));
        if(!counts.length) return;
        // hide suffixes initially
        document.querySelectorAll('.home-stats .suffix').forEach(function(s){ s.classList.add('hidden'); });
        counts.forEach(function(c, i){
          var target = parseFloat(c.getAttribute('data-target')||0);
          var decimals = parseInt(c.getAttribute('data-decimals')||0,10) || 0;
          var delay = i * 420;
          setTimeout(function(){
            var card = c.closest('.stat-card'); if(card) card.classList.add('counting');
            animateCount(c, target, decimals);
            setTimeout(function(){
              var suf = c.parentElement.querySelector('.suffix'); if(suf) suf.classList.remove('hidden');
              if(card) setTimeout(function(){ card.classList.remove('counting'); }, 700);
            }, 1280);
          }, delay);
        });
      }catch(e){ console.warn('creative counts failed', e); }
    }
    if(document.readyState === 'loading'){ document.addEventListener('DOMContentLoaded', playCreativeCounts); } else { playCreativeCounts(); }
  })();")),
  # ...removed dynamic footer show/hide script to make footer a normal page element...
  ),

  # CSS tweaks to ensure standalone login has no scrollbars and is centered
  tags$style(HTML("/* Global reset for the overlay page */
    html, body { margin:0; padding:0; height:100%; }
    /* Full-screen background image with overlay */
    #standalone-upload { 
      position:fixed; 
      inset:0; 
      z-index:2200; 
      background: #f8fafc;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    #standalone-upload::before { 
      content:''; 
      position:absolute; 
      inset:0; 
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      opacity: 0.1;
    }

    /* Centering container */
    #standalone-upload .standalone-main { position:relative; display:flex; justify-content:center; align-items:center; height:100vh; padding:0; box-sizing:border-box; }

    /* Login row used to center the card */
    #standalone-upload .login-row { position:relative; display:flex; align-items:center; justify-content:center; width:100%; z-index:2400; }

    /* Card styling to match provided design */
    #standalone-upload .login-card {
      width: 400px;
      max-width: 95%;
      padding: 48px;
      background: #ffffff;
      box-shadow: 0 20px 60px rgba(0,0,0,0.15);
      border-radius: 20px;
      border: 1px solid #e5e7eb;
      box-sizing: border-box;
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
      color: #1f2937;
      display: block;
    }

  /* Professional Title */
  #standalone-upload .login-card .login-title { 
    font-weight:700; 
    font-size:28px; 
    color:#111827; 
    margin:0 0 8px 0; 
    font-family: 'Inter', sans-serif;
    text-align: center;
  }

    /* Inputs inside card */
    #standalone-upload .login-card input[type='text'],
    #standalone-upload .login-card input[type='password'],
    #standalone-upload .login-card .form-control {
      width: 100%;
      margin-bottom: 24px;
      padding: 12px 16px;
      border-radius: 8px;
      border: 2px solid #e5e7eb;
      background: #ffffff;
      color: #1f2937;
      font-size: 16px;
      transition: border-color 0.2s ease;
      box-sizing: border-box;
    }
    
    #standalone-upload .login-card input[type='text']:focus,
    #standalone-upload .login-card input[type='password']:focus,
    #standalone-upload .login-card .form-control:focus {
      outline: none;
      border-color: #2563eb;
      box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    /* Professional Sign in button */
    #standalone-upload .login-card .btn-primary { 
      width: 100%; 
      padding: 14px; 
      border-radius: 8px; 
      font-weight: 600; 
      font-size: 16px;
      background: #2563eb;
      color: #ffffff;
      border: none;
      cursor: pointer;
      transition: background 0.2s ease;
      margin-top: 8px;
      pointer-events: auto;
      z-index: 10;
      position: relative;
    }
    
    #standalone-upload .login-card .btn-primary:hover {
      background: #1d4ed8;
    }
    

    /* Center helper for input groups */
    #standalone-upload .login-card .form-group { display:flex; flex-direction:column; }

    /* Professional Demo Accounts Section */
    #standalone-upload .login-card .meta { 
      text-align: center; 
      margin-top: 24px; 
      padding: 20px;
      background: #f9fafb;
      border-radius: 12px;
      border: 1px solid #e5e7eb;
      color: #6b7280;
      font-size: 14px;
    }
    
    #standalone-upload .login-card .meta strong {
      color: #374151;
    }

    /* Responsive Login Design */
    @media (max-width: 480px) {
      #standalone-upload .login-card { 
        width: 95%; 
        padding: 32px 24px; 
      }
      #standalone-upload .login-card .login-title { 
        font-size: 24px; 
      }
      #standalone-upload .standalone-main {
        padding: 16px;
      }
    }
  ")),

  # Data Upload Portal (shown when clicking Login)
  div(id='standalone-upload', style='display:none; position:fixed; inset:0; z-index:2200; overflow:hidden; padding:0;',
    # No sidebar for login - center the login card on the page

    # Centered login card (no sidebar)
  div(class='standalone-main', style='padding:24px 32px; height:100vh; display:flex; align-items:center; justify-content:center; margin-left:0; width:100%;',
      # removed larger container -- use a narrower, responsive login card
  div(style='width:720px; max-width:95%; margin:0 auto;',
        div(class='login-row',
          div(class='login-card', style='border-radius:12px; padding:40px;',
            # prominent LOGIN title
            tags$h1('LOGIN', class='login-title'),
            # welcome/typewriter subline inside the card
            div(class='card-header-welcome',
              tags$div(class='typewriter', id='login-typewriter', 'Welcome to National data upload portal — the modern digitization transformation.')
            ),
            div(class='login-right',
              
              tags$div(style='text-align:center; margin-bottom:14px; color:rgba(255,255,255,0.85);', 'National Data Intelligence Platform'),

            # Shiny login inputs (match login image)
            div(style='display:flex; flex-direction:column; gap:12px;',
              tags$label('Email', style='font-weight:700; color:#333;'),
              textInput('ndip_email', NULL, placeholder = 'your.email@gov.rw', width = '100%'),
              tags$label('Password', style='font-weight:700; color:#333;'),
              passwordInput('ndip_password', NULL, placeholder = 'Enter your password', width = '100%'),
              actionButton('ndip_signin', 'Sign In', class = 'btn btn-primary')
            ),

            div(style='margin-top:16px; color:#556; font-size:13px;',
              tags$div(HTML('<strong>Demo Accounts:</strong>')),
              tags$div(HTML('<strong>Admin:</strong> admin@nisr.gov.rw')),
              tags$div(HTML('<strong>Institution:</strong> health@moh.gov.rw')),
              tags$div(HTML('<strong>Reviewer:</strong> reviewer@nisr.gov.rw')),
              tags$div(HTML('<strong>Password:</strong> demo123'))
            )
            )
          )
        )
      )
    ),

    # small script to toggle this upload page when hash is #login
  tags$script(HTML("(function(){\n      function toggleUpload(){ var el = document.getElementById('standalone-upload'); if(location.hash === '#login'){ if(el) el.style.display='block'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} } else { if(el) el.style.display='none'; try{ document.querySelector('body').style.overflow='auto'; }catch(e){} } }\n      window.addEventListener('hashchange', toggleUpload); setTimeout(toggleUpload, 30);\n      var closeLeft = document.getElementById('close-upload-left'); if(closeLeft) closeLeft.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      // Shiny custom handler to allow server to set/clear hash\n      if(window.Shiny && Shiny.addCustomMessageHandler){ Shiny.addCustomMessageHandler('setHash', function(message){ try{ if(message && message.hash !== undefined) location.hash = message.hash; }catch(e){} }); }\n    })();"))
  ),

  # Typewriter script specifically for the standalone login typewriter
  tags$script(HTML("(function(){\n      function typeWrite(el, text, speed){ if(!el) return; el.textContent = ''; var i=0; function step(){ if(i<=text.length){ el.textContent = text.substring(0,i); i++; setTimeout(step, speed); } } step(); }\n      function runLoginTypewriter(){ var el = document.getElementById('login-typewriter'); if(!el) return; var text = 'the modern digitization transformation.'; typeWrite(el, text, 40); }\n      // Trigger when overlay opens based on hashchange + on load if hash present\n      function watch(){ if(location.hash === '#login'){ runLoginTypewriter(); } }
      window.addEventListener('hashchange', function(){ watch(); }); setTimeout(watch, 40);
    })();")),

  # Standalone Tourism Dashboard page (hidden by default)
  div(id='standalone-tourism', style='display:none; position:fixed; inset:0; background:#ffffff; z-index:2000; overflow:auto; padding:0;',
    # Left fixed sidebar (steelblue) using new standalone-sidebar class
    div(class='standalone-sidebar',
      div(class='brand', 'NDIP'),
      tags$div(class='side-nav',
        tags$ul(
          tags$li(HTML('<a href="#home" class="side-link"><span class="side-icon"><i class="fas fa-home"></i></span><span class="side-text">NDP</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#overview" class="side-link"><span class="side-icon"><i class="fas fa-chart-pie"></i></span><span class="side-text">Overview</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#visitor_stats" class="side-link"><span class="side-icon"><i class="fas fa-users"></i></span><span class="side-text">Visitor Statistics</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#tourism_revenue" class="side-link"><span class="side-icon"><i class="fas fa-dollar-sign"></i></span><span class="side-text">Tourism Revenue</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#predict" class="side-link"><span class="side-icon"><i class="fas fa-brain"></i></span><span class="side-text">Predictive Analysis</span><span class="side-pill"></span></a>'))
        )
      ),
      tags$div(style='margin-top:auto; font-size:13px; opacity:0.95; color:#fff;', HTML('<a href="#" id="close-tourism-left" style="color:#fff; text-decoration:none; font-weight:800;">Close</a>'))
    ),

  # Main content area shifted right to accommodate fixed sidebar
  div(class='standalone-main', style='padding:24px 32px; min-height:100vh;',
        div(style='display:flex; align-items:center; gap:12px; justify-content:space-between;',
          div(style='display:flex; align-items:center; gap:12px;',
              tags$a(href='#sectors', id='go-back-sectors-tourism', style='display:inline-block; padding:8px 12px; border-radius:10px; background:#fff; color:#0B78A0; font-weight:800; text-decoration:none; box-shadow:0 6px 18px rgba(11,120,160,0.08);', HTML('&#8592; Go back')),
              tags$h2('Rwanda Tourism Sector Dashboard', style='margin:0; color:#042A3B;')
          ),
          tags$a(href='#', id='close-tourism-standalone', 'Close', style='color:#0B78A0; font-weight:700; text-decoration:none;')
        ),

  # Tourism dashboard body (placeholder)
  div(id='tourism-dashboard-body', style='min-height:600px; background:transparent; padding:0; border-radius:0; box-shadow:none;')
      ),

  # JS for hash routing + side-link behavior for tourism
  tags$script(HTML("(function(){\n      function showOrHide(){\n        var econ = document.getElementById('standalone-economic');\n        var gov = document.getElementById('standalone-governance');\n        var tour = document.getElementById('standalone-tourism');\n        if(location.hash === '#page=economic'){ if(econ) econ.style.display='block'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=governance'){ if(gov) gov.style.display='block'; if(econ) econ.style.display='none'; if(tour) tour.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=tourism'){ if(tour) tour.style.display='block'; if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else { if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; try{ document.querySelector('body').style.overflow='auto'; }catch(e){} }\n      }\n      window.addEventListener('hashchange', showOrHide);\n      // close handlers for tourism standalone\n      var closeTour = document.getElementById('close-tourism-standalone'); if(closeTour) closeTour.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var closeLeft = document.getElementById('close-tourism-left'); if(closeLeft) closeLeft.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var goBackTour = document.getElementById('go-back-sectors-tourism'); if(goBackTour){ goBackTour.addEventListener('click', function(e){ e.preventDefault(); location.hash = '#sectors'; showOrHide(); setTimeout(function(){ var el = document.getElementById('sectors'); if(el) el.scrollIntoView({behavior:'smooth'}); }, 100); }); }\n      var links = document.querySelectorAll('#standalone-tourism .side-link');\n      function clearActive(){ links.forEach(function(a){ a.classList.remove('active'); }); }\n      links.forEach(function(a){ a.addEventListener('click', function(e){ e.preventDefault(); var href = a.getAttribute('href'); var id = href && href.replace('#',''); var target = document.getElementById(id); if(target){ target.scrollIntoView({behavior:'smooth', block:'start'}); } clearActive(); a.classList.add('active'); }); });\n      setTimeout(showOrHide, 30);\n    })();"))
  ),

  # Standalone Health Dashboard page (hidden by default)
  div(id='standalone-health', style='display:none; position:fixed; inset:0; background:#ffffff; z-index:2000; overflow:auto; padding:0;',
    div(class='standalone-sidebar',
      div(class='brand', 'NDIP'),
      tags$div(class='side-nav',
        tags$ul(
          tags$li(HTML('<a href="#home" class="side-link"><span class="side-icon"><i class="fas fa-home"></i></span><span class="side-text">NDP</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#overview" class="side-link"><span class="side-icon"><i class="fas fa-chart-pie"></i></span><span class="side-text">Overview</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#health_indicators" class="side-link"><span class="side-icon"><i class="fas fa-notes-medical"></i></span><span class="side-text">Health Indicators</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#disease_surveillance" class="side-link"><span class="side-icon"><i class="fas fa-virus"></i></span><span class="side-text">Disease Surveillance</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#predict" class="side-link"><span class="side-icon"><i class="fas fa-brain"></i></span><span class="side-text">Predictive Analysis</span><span class="side-pill"></span></a>'))
        )
      ),
      tags$div(style='margin-top:auto; font-size:13px; opacity:0.95; color:#fff;', HTML('<a href="#" id="close-health-left" style="color:#fff; text-decoration:none; font-weight:800;">Close</a>'))
    ),

  div(class='standalone-main', style='padding:24px 32px; min-height:100vh;',
        div(style='display:flex; align-items:center; gap:12px; justify-content:space-between;',
          div(style='display:flex; align-items:center; gap:12px;',
              tags$a(href='#sectors', id='go-back-sectors-health', style='display:inline-block; padding:8px 12px; border-radius:10px; background:#fff; color:#0B78A0; font-weight:800; text-decoration:none; box-shadow:0 6px 18px rgba(11,120,160,0.08);', HTML('&#8592; Go back')),
              tags$h2('Rwanda Health Sector Dashboard', style='margin:0; color:#042A3B;')
          ),
          tags$a(href='#', id='close-health-standalone', 'Close', style='color:#0B78A0; font-weight:700; text-decoration:none;')
        ),
  div(id='health-dashboard-body', style='min-height:600px; background:transparent; padding:0; border-radius:0; box-shadow:none;',
  div(id='health_home', style='padding:12px 8px;',
    tags$h3('Health & Education Home'),
    tags$p('Summary KPIs for health and education.')
  ),
  div(id='health_overview', style='padding:12px 8px;',
    tags$h3('Overview'),
    fluidRow(
      column(6, plotlyOutput('health_indicators_plot', height = '360px')),
      column(6, plotlyOutput('schools_enrollment_plot', height = '360px'))
    )
  ),
  div(id='health_indicators', style='padding:12px 8px;',
    tags$h3('Health Indicators'),
    DT::dataTableOutput('health_table'),
    plotlyOutput('health_trend_plot', height = '420px')
  ),
  div(id='education_schools', style='padding:12px 8px;',
    tags$h3('Schools & Enrollment'),
    DT::dataTableOutput('schools_table'),
    plotlyOutput('schools_trend_plot', height = '420px')
  ),
  div(id='health_predict', style='padding:12px 8px;',
    tags$h3('Predictive Analysis (Health)'),
    selectInput('health_pred_var', 'Select numeric variable', choices = NULL),
    actionButton('health_run_pred', 'Run forecast'),
    plotlyOutput('health_pred_plot')
  )
  )
      ),

  # JS for health routing and side-link behavior
  tags$script(HTML("(function(){\n      function showOrHide(){\n        var econ = document.getElementById('standalone-economic');\n        var gov = document.getElementById('standalone-governance');\n        var tour = document.getElementById('standalone-tourism');\n        var health = document.getElementById('standalone-health');\n        if(location.hash === '#page=economic'){ if(econ) econ.style.display='block'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; if(health) health.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=governance'){ if(gov) gov.style.display='block'; if(econ) econ.style.display='none'; if(tour) tour.style.display='none'; if(health) health.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=tourism'){ if(tour) tour.style.display='block'; if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(health) health.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=health'){ if(health) health.style.display='block'; if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else { if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; if(health) health.style.display='none'; try{ document.querySelector('body').style.overflow='auto'; }catch(e){} }\n      }\n      window.addEventListener('hashchange', showOrHide);\n      var closeHealth = document.getElementById('close-health-standalone'); if(closeHealth) closeHealth.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var closeLeft = document.getElementById('close-health-left'); if(closeLeft) closeLeft.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var goBackHealth = document.getElementById('go-back-sectors-health'); if(goBackHealth){ goBackHealth.addEventListener('click', function(e){ e.preventDefault(); location.hash = '#sectors'; showOrHide(); setTimeout(function(){ var el = document.getElementById('sectors'); if(el) el.scrollIntoView({behavior:'smooth'}); }, 100); }); }\n      var links = document.querySelectorAll('#standalone-health .side-link');\n      function clearActive(){ links.forEach(function(a){ a.classList.remove('active'); }); }\n      links.forEach(function(a){ a.addEventListener('click', function(e){ e.preventDefault(); var href = a.getAttribute('href'); var id = href && href.replace('#',''); var target = document.getElementById(id); if(target){ target.scrollIntoView({behavior:'smooth', block:'start'}); } clearActive(); a.classList.add('active'); }); });\n      setTimeout(showOrHide, 30);\n    })();"))
  ),

  # Standalone Education Dashboard page (hidden by default)
  div(id='standalone-education', style='display:none; position:fixed; inset:0; background:#ffffff; z-index:2000; overflow:auto; padding:0;',
    div(class='standalone-sidebar',
      div(class='brand', 'NDIP'),
      tags$div(class='side-nav',
        tags$ul(
          tags$li(HTML('<a href="#home" class="side-link"><span class="side-icon"><i class="fas fa-home"></i></span><span class="side-text">NDP</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#overview" class="side-link"><span class="side-icon"><i class="fas fa-chart-pie"></i></span><span class="side-text">Overview</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#enrollment_metrics" class="side-link"><span class="side-icon"><i class="fas fa-user-graduate"></i></span><span class="side-text">Enrollment Metrics</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#academic_performance" class="side-link"><span class="side-icon"><i class="fas fa-award"></i></span><span class="side-text">Academic Performance</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#predict" class="side-link"><span class="side-icon"><i class="fas fa-brain"></i></span><span class="side-text">Predictive Analysis</span><span class="side-pill"></span></a>'))
        )
      ),
      tags$div(style='margin-top:auto; font-size:13px; opacity:0.95; color:#fff;', HTML('<a href="#" id="close-education-left" style="color:#fff; text-decoration:none; font-weight:800;">Close</a>'))
    ),

  div(class='standalone-main', style='padding:24px 32px; min-height:100vh;',
        div(style='display:flex; align-items:center; gap:12px; justify-content:space-between;',
          div(style='display:flex; align-items:center; gap:12px;',
              tags$a(href='#sectors', id='go-back-sectors-education', style='display:inline-block; padding:8px 12px; border-radius:10px; background:#fff; color:#0B78A0; font-weight:800; text-decoration:none; box-shadow:0 6px 18px rgba(11,120,160,0.08);', HTML('&#8592; Go back')),
              tags$h2('Rwanda Education Sector Dashboard', style='margin:0; color:#042A3B;')
          ),
          tags$a(href='#', id='close-education-standalone', 'Close', style='color:#0B78A0; font-weight:700; text-decoration:none;')
        ),
  div(id='education-dashboard-body', style='min-height:600px; background:transparent; padding:0; border-radius:0; box-shadow:none;')
      ),

  # JS for education routing and side-link behavior
  tags$script(HTML("(function(){\n      function showOrHide(){\n        var econ = document.getElementById('standalone-economic');\n        var gov = document.getElementById('standalone-governance');\n        var tour = document.getElementById('standalone-tourism');\n        var health = document.getElementById('standalone-health');\n        var edu = document.getElementById('standalone-education');\n        if(location.hash === '#page=economic'){ if(econ) econ.style.display='block'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; if(health) health.style.display='none'; if(edu) edu.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=governance'){ if(gov) gov.style.display='block'; if(econ) econ.style.display='none'; if(tour) tour.style.display='none'; if(health) health.style.display='none'; if(edu) edu.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=tourism'){ if(tour) tour.style.display='block'; if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(health) health.style.display='none'; if(edu) edu.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=health'){ if(health) health.style.display='block'; if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; if(edu) edu.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=education'){ if(edu) edu.style.display='block'; if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; if(health) health.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else { if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; if(health) health.style.display='none'; if(edu) edu.style.display='none'; try{ document.querySelector('body').style.overflow='auto'; }catch(e){} }\n      }\n      window.addEventListener('hashchange', showOrHide);\n      var closeEdu = document.getElementById('close-education-standalone'); if(closeEdu) closeEdu.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var closeLeft = document.getElementById('close-education-left'); if(closeLeft) closeLeft.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var goBackEdu = document.getElementById('go-back-sectors-education'); if(goBackEdu){ goBackEdu.addEventListener('click', function(e){ e.preventDefault(); location.hash = '#sectors'; showOrHide(); setTimeout(function(){ var el = document.getElementById('sectors'); if(el) el.scrollIntoView({behavior:'smooth'}); }, 100); }); }\n      var links = document.querySelectorAll('#standalone-education .side-link');\n      function clearActive(){ links.forEach(function(a){ a.classList.remove('active'); }); }\n      links.forEach(function(a){ a.addEventListener('click', function(e){ e.preventDefault(); var href = a.getAttribute('href'); var id = href && href.replace('#',''); var target = document.getElementById(id); if(target){ target.scrollIntoView({behavior:'smooth', block:'start'}); } clearActive(); a.classList.add('active'); }); });\n      setTimeout(showOrHide, 30);\n    })();"))
  ),

  # Standalone Demographics & Agriculture Dashboard page (hidden by default)
  div(id='standalone-demographics', style='display:none; position:fixed; inset:0; background:#ffffff; z-index:2000; overflow:auto; padding:0;',
    div(class='standalone-sidebar',
      div(class='brand', 'NDIP'),
      tags$div(class='side-nav',
        tags$ul(
          tags$li(HTML('<a href="#home" class="side-link"><span class="side-icon"><i class="fas fa-home"></i></span><span class="side-text">NDP</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#overview" class="side-link"><span class="side-icon"><i class="fas fa-chart-pie"></i></span><span class="side-text">Overview</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#population_data" class="side-link"><span class="side-icon"><i class="fas fa-users"></i></span><span class="side-text">Population Data</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#agricultural_output" class="side-link"><span class="side-icon"><i class="fas fa-tractor"></i></span><span class="side-text">Agricultural Output</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#predict" class="side-link"><span class="side-icon"><i class="fas fa-brain"></i></span><span class="side-text">Predictive Analysis</span><span class="side-pill"></span></a>'))
        )
      ),
      tags$div(style='margin-top:auto; font-size:13px; opacity:0.95; color:#fff;', HTML('<a href="#" id="close-demographics-left" style="color:#fff; text-decoration:none; font-weight:800;">Close</a>'))
    ),

  div(class='standalone-main', style='padding:24px 32px; min-height:100vh;',
        div(style='display:flex; align-items:center; gap:12px; justify-content:space-between;',
          div(style='display:flex; align-items:center; gap:12px;',
              tags$a(href='#sectors', id='go-back-sectors-demographics', style='display:inline-block; padding:8px 12px; border-radius:10px; background:#fff; color:#0B78A0; font-weight:800; text-decoration:none; box-shadow:0 6px 18px rgba(11,120,160,0.08);', HTML('&#8592; Go back')),
              tags$h2('Rwanda Demographics & Agriculture Sector Dashboard', style='margin:0; color:#042A3B;')
          ),
          tags$a(href='#', id='close-demographics-standalone', 'Close', style='color:#0B78A0; font-weight:700; text-decoration:none;')
        ),
  div(id='demographics-dashboard-body', style='min-height:600px; background:transparent; padding:0; border-radius:0; box-shadow:none;',
    # Internal sections referenced by the sidebar links: home, overview, population_data, agricultural_output, predict
    div(id='home', style='padding:12px 8px;',
      tags$h3('Demographics & Agriculture Home'),
      tags$p('Quick links and summary KPIs for the sector.')
    ),

    div(id='overview', style='padding:12px 8px;',
      tags$h3('Overview'),
      fluidRow(
      column(6, plotlyOutput('dem_pop_plot', height = '360px')),
      column(6, plotlyOutput('dem_agri_plot', height = '360px'))
      ),
      fluidRow(
      column(6, plotlyOutput('dem_vital_plot', height = '320px')),
      column(6, plotlyOutput('dem_labour_plot', height = '320px'))
      )
    ),

    div(id='population_data', style='padding:12px 8px;',
      tags$h3('Population'),
      DT::dataTableOutput('dem_pop_table'),
      plotlyOutput('dem_pop_trend', height = '420px')
    ),

    div(id='agricultural_output', style='padding:12px 8px;',
      tags$h3('Agriculture'),
      DT::dataTableOutput('dem_agri_table'),
      plotlyOutput('dem_agri_trend', height = '420px')
    ),

    div(id='predict', style='padding:12px 8px;',
      tags$h3('Predictive Analysis'),
      tags$p('Simple linear forecast examples for population and agriculture.'),
      selectInput('dem_pred_ds', 'Dataset', choices = c('Population' = 'population', 'Agriculture' = 'agriculture')), 
      uiOutput('dem_pred_var_ui'),
      actionButton('dem_run_pred', 'Run forecast'),
      plotlyOutput('dem_pred_plot')
    )
  )
      ),

  # JS for demographics routing and side-link behavior
  tags$script(HTML("(function(){\n      function showOrHide(){\n        var econ = document.getElementById('standalone-economic');\n        var gov = document.getElementById('standalone-governance');\n        var tour = document.getElementById('standalone-tourism');\n        var health = document.getElementById('standalone-health');\n        var edu = document.getElementById('standalone-education');\n        var demo = document.getElementById('standalone-demographics');\n        if(location.hash === '#page=economic'){ if(econ) econ.style.display='block'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; if(health) health.style.display='none'; if(edu) edu.style.display='none'; if(demo) demo.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=governance'){ if(gov) gov.style.display='block'; if(econ) econ.style.display='none'; if(tour) tour.style.display='none'; if(health) health.style.display='none'; if(edu) edu.style.display='none'; if(demo) demo.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=tourism'){ if(tour) tour.style.display='block'; if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(health) health.style.display='none'; if(edu) edu.style.display='none'; if(demo) demo.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=health'){ if(health) health.style.display='block'; if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; if(edu) edu.style.display='none'; if(demo) demo.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=education'){ if(edu) edu.style.display='block'; if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; if(health) health.style.display='none'; if(demo) demo.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=demographics'){ if(demo) demo.style.display='block'; if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; if(health) health.style.display='none'; if(edu) edu.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else { if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; if(tour) tour.style.display='none'; if(health) health.style.display='none'; if(edu) edu.style.display='none'; if(demo) demo.style.display='none'; try{ document.querySelector('body').style.overflow='auto'; }catch(e){} }\n      }\n      window.addEventListener('hashchange', showOrHide);\n      var closeDemo = document.getElementById('close-demographics-standalone'); if(closeDemo) closeDemo.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var closeLeft = document.getElementById('close-demographics-left'); if(closeLeft) closeLeft.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var goBackDemo = document.getElementById('go-back-sectors-demographics'); if(goBackDemo){ goBackDemo.addEventListener('click', function(e){ e.preventDefault(); location.hash = '#sectors'; showOrHide(); setTimeout(function(){ var el = document.getElementById('sectors'); if(el) el.scrollIntoView({behavior:'smooth'}); }, 100); }); }\n      var links = document.querySelectorAll('#standalone-demographics .side-link');\n      function clearActive(){ links.forEach(function(a){ a.classList.remove('active'); }); }\n      links.forEach(function(a){ a.addEventListener('click', function(e){ e.preventDefault(); var href = a.getAttribute('href'); var id = href && href.replace('#',''); var target = document.getElementById(id); if(target){ target.scrollIntoView({behavior:'smooth', block:'start'}); } clearActive(); a.classList.add('active'); }); });\n      setTimeout(showOrHide, 30);\n    })();"))
  ),

  # Admin Dashboard Page (hidden by default)
  div(id='standalone-admin', style='display:none; position:fixed; inset:0; background:#ffffff; z-index:2000; overflow:auto; padding:0;',
    div(class='standalone-sidebar',
      div(class='brand', 'NDIP'),
      tags$div(class='side-nav',
        tags$ul(
          tags$li(HTML('<a href="#" onclick="Shiny.setInputValue(\'admin_tab\', \'overview\'); return false;" class="side-link"><span class="side-icon"><i class="fas fa-chart-pie"></i></span><span class="side-text">Overview</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#" onclick="Shiny.setInputValue(\'admin_tab\', \'submissions\'); return false;" class="side-link"><span class="side-icon"><i class="fas fa-file-upload"></i></span><span class="side-text">Submissions</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#" onclick="Shiny.setInputValue(\'admin_tab\', \'users\'); return false;" class="side-link"><span class="side-icon"><i class="fas fa-users"></i></span><span class="side-text">Users</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#" onclick="Shiny.setInputValue(\'admin_tab\', \'settings\'); return false;" class="side-link"><span class="side-icon"><i class="fas fa-cog"></i></span><span class="side-text">Settings</span><span class="side-pill"></span></a>'))
        )
      ),
      tags$div(style='margin-top:auto; font-size:13px; opacity:0.95; color:#fff;', HTML('<a href="#" id="close-admin-left" style="color:#fff; text-decoration:none; font-weight:800;">Close</a>'))
    ),
    div(class='standalone-main', style='padding:24px 32px; min-height:100vh;',
      div(style='display:flex; align-items:center; gap:12px; justify-content:space-between;',
        div(style='display:flex; align-items:center; gap:12px;',
          tags$a(href='#', id='go-back-home-admin', style='display:inline-block; padding:8px 12px; border-radius:10px; background:#fff; color:#2563eb; font-weight:800; text-decoration:none; box-shadow:0 6px 18px rgba(37,99,235,0.08);', HTML('&#8592; Back to Home')),
          tags$h2('Admin Dashboard', style='margin:0; color:#1f2937;')
        ),
        tags$a(href='#', id='close-admin-standalone', 'Close', style='color:#2563eb; font-weight:700; text-decoration:none;')
      ),
      div(id='admin-dashboard-body', style='min-height:600px; background:transparent; padding:0; border-radius:0; box-shadow:none;',
        # Dynamic content based on selected tab
        conditionalPanel(
          condition = "input.admin_tab == 'overview'",
          # Admin Stats
          div(style = "display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; margin-bottom: 24px;",
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px; border-left: 4px solid #2563eb;",
              tags$h4(style = "margin: 0 0 8px; color: #1f2937; font-size: 24px;", textOutput("admin_total_submissions")),
              tags$p(style = "margin: 0; color: #6b7280; font-size: 14px;", "Total Submissions"),
              tags$p(style = "margin: 4px 0 0; color: #10b981; font-size: 12px;", textOutput("admin_submission_growth"))
            ),
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px; border-left: 4px solid #d97706;",
              tags$h4(style = "margin: 0 0 8px; color: #d97706; font-size: 24px;", textOutput("admin_pending_reviews")),
              tags$p(style = "margin: 0; color: #6b7280; font-size: 14px;", "Pending Review"),
              tags$p(style = "margin: 4px 0 0; color: #6b7280; font-size: 12px;", textOutput("admin_avg_processing"))
            ),
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px; border-left: 4px solid #059669;",
              tags$h4(style = "margin: 0 0 8px; color: #059669; font-size: 24px;", textOutput("admin_approval_rate")),
              tags$p(style = "margin: 0; color: #6b7280; font-size: 14px;", "Approval Rate"),
              tags$p(style = "margin: 4px 0 0; color: #059669; font-size: 12px;", textOutput("admin_performance"))
            ),
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px; border-left: 4px solid #7c3aed;",
              tags$h4(style = "margin: 0 0 8px; color: #1f2937; font-size: 24px;", textOutput("admin_active_institutions")),
              tags$p(style = "margin: 0; color: #6b7280; font-size: 14px;", "Active Institutions"),
              tags$p(style = "margin: 4px 0 0; color: #059669; font-size: 12px;", textOutput("admin_participation"))
            )
          ),
          # Charts Row
          div(style = "display: grid; grid-template-columns: 2fr 1fr; gap: 16px; margin-bottom: 24px;",
            # Main Chart
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px;",
              tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "Submissions Over Time"),
              plotlyOutput("admin_chart", height = "300px")
            ),
            # Institution Performance
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px;",
              tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "Top Performing Institutions"),
              plotlyOutput("admin_institution_chart", height = "300px")
            )
          ),
          # Recent Activity
          div(style = "background: #f8fafc; border-radius: 8px; padding: 16px; margin-bottom: 16px;",
            tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "Recent Activity"),
            DT::dataTableOutput("admin_recent_activity", height = "200px")
          )
        ),
        
        conditionalPanel(
          condition = "input.admin_tab == 'submissions'",
          # Submissions Management
          div(style = "background: #f8fafc; border-radius: 8px; padding: 16px; margin-bottom: 16px;",
            div(style = "display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;",
              tags$h5(style = "margin: 0; color: #1f2937;", "Data Submissions Management"),
              div(style = "display: flex; gap: 8px;",
                selectInput("submission_filter", "Filter:", choices = c("All", "Pending", "Approved", "Rejected"), selected = "All", width = "120px"),
                actionButton("refresh_submissions", "Refresh", class = "btn btn-sm btn-outline-primary")
              )
            ),
            DT::dataTableOutput("admin_submissions_table", height = "400px")
          )
        ),
        
        conditionalPanel(
          condition = "input.admin_tab == 'users'",
          # User Management
          div(style = "background: #f8fafc; border-radius: 8px; padding: 16px; margin-bottom: 16px;",
            div(style = "display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;",
              tags$h5(style = "margin: 0; color: #1f2937;", "User Management"),
              div(style = "display: flex; gap: 8px;",
                actionButton("add_user", "Add User", class = "btn btn-sm btn-primary"),
                actionButton("export_users", "Export", class = "btn btn-sm btn-outline-secondary")
              )
            ),
            DT::dataTableOutput("admin_users_table", height = "400px")
          )
        ),
        
        conditionalPanel(
          condition = "input.admin_tab == 'settings'",
          # System Settings
          div(style = "display: grid; grid-template-columns: 1fr 1fr; gap: 16px;",
            # General Settings
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px;",
              tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "General Settings"),
              textInput("system_name", "System Name:", value = "NDIP Rwanda", width = "100%"),
              numericInput("max_file_size", "Max File Size (MB):", value = 50, min = 1, max = 500, width = "100%"),
              numericInput("session_timeout", "Session Timeout (minutes):", value = 30, min = 5, max = 120, width = "100%"),
              checkboxInput("email_notifications", "Enable Email Notifications", value = TRUE),
              checkboxInput("auto_approval", "Enable Auto-Approval", value = FALSE),
              br(),
              actionButton("save_settings", "Save Settings", class = "btn btn-primary")
            ),
            # Security Settings
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px;",
              tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "Security Settings"),
              numericInput("password_min_length", "Min Password Length:", value = 8, min = 6, max = 20, width = "100%"),
              numericInput("login_attempts", "Max Login Attempts:", value = 5, min = 3, max = 10, width = "100%"),
              checkboxInput("two_factor_auth", "Enable Two-Factor Authentication", value = FALSE),
              checkboxInput("ip_whitelist", "Enable IP Whitelist", value = FALSE),
              br(),
              actionButton("test_connection", "Test Database Connection", class = "btn btn-outline-primary")
            )
          )
        )
      )
    ),
    # JS for admin routing
    tags$script(HTML("(function(){\n      function showOrHide(){\n        var admin = document.getElementById('standalone-admin');\n        var inst = document.getElementById('standalone-institution');\n        if(location.hash === '#admin'){ if(admin) admin.style.display='block'; if(inst) inst.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#institution'){ if(inst) inst.style.display='block'; if(admin) admin.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else { if(admin) admin.style.display='none'; if(inst) inst.style.display='none'; try{ document.querySelector('body').style.overflow='auto'; }catch(e){} }\n      }\n      window.addEventListener('hashchange', showOrHide);\n      var closeAdmin = document.getElementById('close-admin-standalone'); if(closeAdmin) closeAdmin.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var closeLeft = document.getElementById('close-admin-left'); if(closeLeft) closeLeft.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var goBackAdmin = document.getElementById('go-back-home-admin'); if(goBackAdmin){ goBackAdmin.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; }); }\n      setTimeout(showOrHide, 30);\n    })();"))
  ),

  # Institution Dashboard Page (hidden by default)
  div(id='standalone-institution', style='display:none; position:fixed; inset:0; background:#ffffff; z-index:2000; overflow:auto; padding:0;',
    div(class='standalone-sidebar',
      div(class='brand', 'NDIP'),
      tags$div(class='side-nav',
        tags$ul(
          tags$li(HTML('<a href="#" onclick="Shiny.setInputValue(\'inst_tab\', \'overview\'); return false;" class="side-link"><span class="side-icon"><i class="fas fa-chart-pie"></i></span><span class="side-text">Overview</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#" onclick="Shiny.setInputValue(\'inst_tab\', \'submissions\'); return false;" class="side-link"><span class="side-icon"><i class="fas fa-file-upload"></i></span><span class="side-text">My Submissions</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#" onclick="Shiny.setInputValue(\'inst_tab\', \'analytics\'); return false;" class="side-link"><span class="side-icon"><i class="fas fa-chart-line"></i></span><span class="side-text">Analytics</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#" onclick="Shiny.setInputValue(\'inst_tab\', \'settings\'); return false;" class="side-link"><span class="side-icon"><i class="fas fa-cog"></i></span><span class="side-text">Settings</span><span class="side-pill"></span></a>'))
        )
      ),
      tags$div(style='margin-top:auto; font-size:13px; opacity:0.95; color:#fff;', HTML('<a href="#" id="close-institution-left" style="color:#fff; text-decoration:none; font-weight:800;">Close</a>'))
    ),
    div(class='standalone-main', style='padding:24px 32px; min-height:100vh;',
      div(style='display:flex; align-items:center; gap:12px; justify-content:space-between;',
        div(style='display:flex; align-items:center; gap:12px;',
          tags$a(href='#', id='go-back-home-institution', style='display:inline-block; padding:8px 12px; border-radius:10px; background:#fff; color:#0ea5e9; font-weight:800; text-decoration:none; box-shadow:0 6px 18px rgba(14,165,233,0.08);', HTML('&#8592; Back to Home')),
          tags$h2('Institution Dashboard', style='margin:0; color:#1f2937;')
        ),
        tags$a(href='#', id='close-institution-standalone', 'Close', style='color:#0ea5e9; font-weight:700; text-decoration:none;')
      ),
      div(id='institution-dashboard-body', style='min-height:600px; background:transparent; padding:0; border-radius:0; box-shadow:none;',
        # Dynamic content based on selected tab
        conditionalPanel(
          condition = "input.inst_tab == 'overview'",
          # Welcome message
          div(style = "background: #f0f9ff; border-radius: 8px; padding: 16px; margin-bottom: 20px; border-left: 4px solid #0ea5e9;",
            tags$h4(style = "margin: 0 0 8px; color: #0c4a6e;", textOutput("inst_welcome_message")),
            tags$p(style = "margin: 0; color: #075985; font-size: 14px;", "Access your data submission portal and view your organization's analytics.")
          ),
          # Institution stats
          div(style = "display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; margin-bottom: 24px;",
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px; border-left: 4px solid #0ea5e9;",
              tags$h4(style = "margin: 0 0 8px; color: #0c4a6e; font-size: 24px;", textOutput("inst_my_submissions")),
              tags$p(style = "margin: 0; color: #6b7280; font-size: 14px;", "My Submissions"),
              tags$p(style = "margin: 4px 0 0; color: #0ea5e9; font-size: 12px;", textOutput("inst_last_updated"))
            ),
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px; border-left: 4px solid #10b981;",
              tags$h4(style = "margin: 0 0 8px; color: #047857; font-size: 24px;", textOutput("inst_approval_rate")),
              tags$p(style = "margin: 0; color: #6b7280; font-size: 14px;", "Approval Rate"),
              tags$p(style = "margin: 4px 0 0; color: #10b981; font-size: 12px;", textOutput("inst_performance"))
            ),
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px; border-left: 4px solid #f59e0b;",
              tags$h4(style = "margin: 0 0 8px; color: #92400e; font-size: 24px;", textOutput("inst_pending_updates")),
              tags$p(style = "margin: 0; color: #6b7280; font-size: 14px;", "Pending Updates"),
              tags$p(style = "margin: 4px 0 0; color: #f59e0b; font-size: 12px;", textOutput("inst_due_date"))
            )
          ),
          # Charts Row
          div(style = "display: grid; grid-template-columns: 2fr 1fr; gap: 16px; margin-bottom: 24px;",
            # Main Chart
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px;",
              tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "My Submission Trends"),
              plotlyOutput("institution_chart", height = "300px")
            ),
            # Quick Actions
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px;",
              tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "Quick Actions"),
              div(style = "display: flex; flex-direction: column; gap: 8px;",
                actionButton('quick_submit', 'Submit New Data', class = 'btn btn-primary', style = "width: 100%;"),
                actionButton('quick_view', 'View Submissions', class = 'btn btn-outline-primary', style = "width: 100%;"),
                actionButton('quick_analytics', 'View Analytics', class = 'btn btn-outline-secondary', style = "width: 100%;")
              )
            )
          ),
          # Recent Submissions
          div(style = "background: #f8fafc; border-radius: 8px; padding: 16px; margin-bottom: 16px;",
            tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "Recent Submissions"),
            DT::dataTableOutput("inst_recent_submissions", height = "200px")
          )
        ),
        
        conditionalPanel(
          condition = "input.inst_tab == 'submissions'",
          # Data Submission Form
          div(style = "background: #f8fafc; border-radius: 8px; padding: 16px; margin-bottom: 16px;",
            tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "Submit New Data"),
            div(style = "display: grid; grid-template-columns: 1fr 1fr; gap: 16px;",
              # Form
              div(
                textInput("data_title", "Data Title:", placeholder = "Enter data title", width = "100%"),
                selectInput("data_category", "Category:", choices = c("Economic", "Health", "Education", "Agriculture", "Demographics", "Infrastructure"), width = "100%"),
                textAreaInput("data_description", "Description:", placeholder = "Describe your data", rows = 3, width = "100%"),
                fileInput("data_file", "Upload File:", accept = c(".csv", ".xlsx", ".json"), width = "100%"),
                div(style = "display: flex; gap: 8px; margin-top: 16px;",
                  actionButton("submit_data", "Submit Data", class = "btn btn-primary"),
                  actionButton("save_draft", "Save Draft", class = "btn btn-outline-secondary")
                )
              ),
              # Guidelines
              div(style = "background: #e0f2fe; border-radius: 8px; padding: 16px;",
                tags$h6(style = "margin: 0 0 12px; color: #0277bd;", "Submission Guidelines"),
                tags$ul(style = "margin: 0; padding-left: 20px; color: #01579b; font-size: 14px;",
                  tags$li("File size must be under 50MB"),
                  tags$li("Supported formats: CSV, Excel, JSON"),
                  tags$li("Include clear column headers"),
                  tags$li("Data must be accurate and complete"),
                  tags$li("Provide detailed descriptions")
                )
              )
            )
          ),
          # My Submissions Table
          div(style = "background: #f8fafc; border-radius: 8px; padding: 16px;",
            div(style = "display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;",
              tags$h5(style = "margin: 0; color: #1f2937;", "My Submissions"),
              div(style = "display: flex; gap: 8px;",
                selectInput("inst_submission_filter", "Filter:", choices = c("All", "Pending", "Approved", "Rejected"), selected = "All", width = "120px"),
                actionButton("refresh_inst_submissions", "Refresh", class = "btn btn-sm btn-outline-primary")
              )
            ),
            DT::dataTableOutput("inst_submissions_table", height = "400px")
          )
        ),
        
        conditionalPanel(
          condition = "input.inst_tab == 'analytics'",
          # Analytics Dashboard
          div(style = "display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;",
            # Performance Metrics
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px;",
              tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "Performance Metrics"),
              plotlyOutput("inst_performance_chart", height = "300px")
            ),
            # Data Quality Score
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px;",
              tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "Data Quality Score"),
              plotlyOutput("inst_quality_chart", height = "300px")
            )
          ),
          # Detailed Analytics
          div(style = "background: #f8fafc; border-radius: 8px; padding: 16px;",
            tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "Detailed Analytics"),
            DT::dataTableOutput("inst_analytics_table", height = "300px")
          )
        ),
        
        conditionalPanel(
          condition = "input.inst_tab == 'settings'",
          # Institution Settings
          div(style = "display: grid; grid-template-columns: 1fr 1fr; gap: 16px;",
            # Profile Settings
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px;",
              tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "Profile Settings"),
              textInput("inst_name", "Institution Name:", value = "Ministry of Health", width = "100%"),
              textInput("inst_email", "Contact Email:", value = "health@moh.gov.rw", width = "100%"),
              textInput("inst_phone", "Phone Number:", value = "+250 123 456 789", width = "100%"),
              textAreaInput("inst_address", "Address:", value = "Kigali, Rwanda", rows = 2, width = "100%"),
              br(),
              actionButton("update_profile", "Update Profile", class = "btn btn-primary")
            ),
            # Notification Settings
            div(style = "background: #f8fafc; border-radius: 8px; padding: 16px;",
              tags$h5(style = "margin: 0 0 16px; color: #1f2937;", "Notification Settings"),
              checkboxInput("email_notifications_inst", "Email Notifications", value = TRUE),
              checkboxInput("sms_notifications", "SMS Notifications", value = FALSE),
              checkboxInput("approval_notifications", "Approval Notifications", value = TRUE),
              checkboxInput("rejection_notifications", "Rejection Notifications", value = TRUE),
              br(),
              actionButton("update_notifications", "Update Settings", class = "btn btn-primary")
            )
          )
        )
      )
    ),
    # JS for institution routing
    tags$script(HTML("(function(){\n      function showOrHide(){\n        var admin = document.getElementById('standalone-admin');\n        var inst = document.getElementById('standalone-institution');\n        if(location.hash === '#admin'){ if(admin) admin.style.display='block'; if(inst) inst.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#institution'){ if(inst) inst.style.display='block'; if(admin) admin.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else { if(admin) admin.style.display='none'; if(inst) inst.style.display='none'; try{ document.querySelector('body').style.overflow='auto'; }catch(e){} }\n      }\n      window.addEventListener('hashchange', showOrHide);\n      var closeInst = document.getElementById('close-institution-standalone'); if(closeInst) closeInst.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var closeLeft = document.getElementById('close-institution-left'); if(closeLeft) closeLeft.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var goBackInst = document.getElementById('go-back-home-institution'); if(goBackInst){ goBackInst.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; }); }\n      setTimeout(showOrHide, 30);\n    })();"))
  ),

  # Main content wrapper: grows to fill available height so footer can sit at the bottom
  # Main content wrapper: keep minimal bottom padding so footer sits directly after content
  div(id='page-content', style='flex:1 0 auto; display:flex; flex-direction:column; padding-bottom:0;',
  
  # Top navigation (single-page anchors)
  div(class='topnav',
    div(class='topnav-inner',
      div(class='brand', 'NDIP-RW'),
      div(class='navlinks',
        tags$a(href='#home','Home'),
        tags$a(href='#overview','Overview'),
        tags$a(href='#sectors','Sectors'),
        tags$a(href='#guide','User Guide')
      ),
  div(class='nav-cta', HTML('<a class="cta-btn" href="#login">Login</a>'))
    )
  ),
  
  # MAIN: Home / hero section
  div(
    id = 'home', class = 'section',
    
    div(
      class = 'hero',
      
      # Left side content (replaced per request)
      div(
        class = 'hero-left',
        div(class='badge', 'Real-time Data Platform'),
        tags$h1(class='hero-title', 'Welcome to Rwanda in numbers'),
        tags$p(class='hero-sub', 'National Data Integration Platform - Empowering Rwanda through transparent, accessible, and actionable data insights'),
        div(class='hero-ctas',
            tags$a(class='btn-primary', href='#overview', HTML('<i class="fas fa-chart-line" style="margin-right:8px;"></i> Explore Data')),
            tags$a(class='btn-outline', href='#sectors', HTML('<i class="fas fa-database" style="margin-right:8px;"></i> View Sectors'))
        ),
        # stats removed from hero-left; moved to cards below hero
      ),
      
      # Right side with sliding images (500x220)
      div(
        class = 'hero-right',
        div(id = 'hero_slider', class = 'image-carousel')
      )
    ),
    # Menya chatbot JS: open/close and send queries to Shiny
    tags$script(HTML("document.addEventListener(\"DOMContentLoaded\", function(){\n  try{\n    var btn = document.getElementById('menyaBtn');\n    var modal = document.getElementById('menyaModal');\n    var closeBtn = document.getElementById('menyaClose');\n    var send = document.getElementById('menyaSend');\n    var input = document.getElementById('menyaInput');\n    var msgs = document.getElementById('menyaMessages');\n    function openModal(){ if(modal){ modal.style.display = 'flex'; if(input) input.focus(); } }\n    function closeModal(){ if(modal){ modal.style.display = 'none'; } }\n    if(btn) btn.addEventListener('click', openModal);\n    if(closeBtn) closeBtn.addEventListener('click', closeModal);\n    if(send){ send.addEventListener('click', function(){ var q = input && input.value && input.value.trim(); if(!q) return; var el = document.createElement('div'); el.style.margin = '8px 0'; el.innerHTML = \"<div style=\\\"font-weight:700;color:#042A3B;\\\">You</div><div style=\\\"color:#004056;\\\">\" + q + \"</div>\"; if(msgs){ msgs.appendChild(el); msgs.scrollTop = msgs.scrollHeight; } if(window.Shiny && Shiny.setInputValue){ Shiny.setInputValue('menya_query', q, {priority: 'event'}); } if(input) input.value = ''; }); }\n    if(input){ input.addEventListener('keydown', function(e){ if(e.key === 'Enter'){ e.preventDefault(); if(send) send.click(); } }); }\n  }catch(e){ console.warn('menya init failed', e); }\n}));")),

    # Home stats cards (moved below hero)
    div(class='home-stats',
        div(class='stat-card',
          div(class='stat-icon', HTML('<i class="fas fa-chart-bar"></i>')),
          div(
            div(class='num', HTML('<span class="count" data-target="250" data-decimals="0">0</span><span class="suffix">+</span>')),
            div(class='label', 'Active Datasets'),
            div(class='small', 'Live data from government institutions')
          )
        ),
        div(class='stat-card',
          div(class='stat-icon', HTML('<i class="fas fa-layer-group"></i>')),
          div(
            div(class='num', HTML('<span class="count" data-target="6" data-decimals="0">0</span>')),
            div(class='label', 'Key Sectors'),
            div(class='small', 'Comprehensive coverage of national development')
          )
        ),
        div(class='stat-card',
          div(class='stat-icon', HTML('<i class="fas fa-check-circle"></i>')),
          div(
            div(class='num', HTML('<span class="count" data-target="98" data-decimals="0">0</span><span class="suffix">%</span>')),
            div(class='label', 'Data Accuracy'),
            div(class='small', 'Validated and verified information')
          )
        )
      ),

    # Overview section
  
  # Overview section
  div(id='overview', class='section', style='padding-top:24px; padding-bottom:4px; min-height:0;',
      div(style='max-width:1100px; margin:0 auto;',
          div(style='margin-left:-200px;',
            h2(class='fade-in-up', 'Explore the NDIP overview'),
            div(class='fade-in-up',
                p("An integrated overview of NDIP connecting data, innovation and insights to drive Rwanda's sustainable development.")
            )
          ),
          div(style='display: flex; flex-direction: column; gap: 32px; margin-top: 32px;',
            # Top Row with Bar Chart and First Two Info Boxes
            div(style='display: flex; gap: 32px; align-items: flex-start; justify-content: flex-start;',
              # Bar Chart
              div(style='flex:1.5; padding:0; min-width:440px; display:flex; align-items:flex-start; justify-content:flex-start; margin-left:-200px; margin-top:-11px;',
                plotlyOutput('pop_bar', height = '440px')
              ),
              # First Column of Info Boxes
              div(style='flex:1; display:flex; flex-direction:column; gap:20px; justify-content:flex-start;',
                # GDP Box
                div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('gdp_click', Math.random())", 
                    style='background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:28px; height:200px; min-width:480px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease;',
                  htmlOutput('gdp_box')
                ),
                # Literacy Box
                div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('literacy_click', Math.random())",
                    style='background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:28px; height:200px; min-width:480px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease;',
                  htmlOutput('literacy_box')
                )
              )
            ),
            # Bottom Row of Info Boxes
            div(style='display: flex; gap: 32px; margin-left:-200px;',
              # CPI Box
              div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('cpi_click', Math.random())",
                  style='flex:1; background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:28px; height:200px; min-width:360px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease;',
                htmlOutput('cpi_box')
              ),
              # Electricity Access Box
              div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('electricity_click', Math.random())",
                  style='flex:1; background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:28px; height:200px; min-width:360px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease;',
                htmlOutput('electricity_box')
              ),
              # Life Expectancy Box
              div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('life_exp_click', Math.random())",
                  style='flex:1; background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:28px; height:200px; min-width:360px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease;',
                htmlOutput('life_exp_box')
              ),
              # Poverty Rate Box
              div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('poverty_click', Math.random())",
                  style='flex:1; background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:34px; height:220px; min-width:380px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease;',
                htmlOutput('poverty_box')
              )
            )
          
  # Sector Performance Analysis (expanded card layout)
  ,div(class='sector-section', style='margin-top:8px;',
        h3(class='sector-title', 'Sector Performance Analysis'),
        div(class='sector-subtitle', 'Comprehensive analysis of Rwanda\'s six key development sectors'),
        div(class='high-perf-header', h4(style='color:var(--accent); margin:0;','\u2197 High Performing Sectors')),
        # Row 1 - High performing
        div(class='sector-row',
          div(class='sector-card fade-in-up',
            div(class='card-head',
              div(class='left-icon', HTML('<i class="fas fa-building"></i>')),
              h4('Economic Development', tags$span(class='sector-badge', 'High Performing')),
              span(class='sector-change', HTML('<i class="fas fa-arrow-up"></i> +8.2%'))
            ),
            div(class='perf-line',
              div(class='perf-bar', tags$div(class='fill', `data-fill`='85%')), 
              span(class='score', '85%')
            ),
            div(class='sector-desc', 'Strong GDP growth and business environment improvements')
          ),
          div(class='sector-card fade-in-up',
            div(class='card-head',
              div(class='left-icon', HTML('<i class="fas fa-shield-alt"></i>')),
              h4('Governance & Security', tags$span(class='sector-badge', 'High Performing')),
              span(class='sector-change', HTML('<i class="fas fa-arrow-up"></i> +4.1%'))
            ),
            div(class='perf-line',
              div(class='perf-bar', tags$div(class='fill', `data-fill`='88%')), 
              span(class='score', '88%')
            ),
            div(class='sector-desc', 'Excellent governance indicators and security stability')
          ),
          div(class='sector-card fade-in-up',
            div(class='card-head',
              div(class='left-icon', HTML('<i class="fas fa-map-marker-alt"></i>')),
              h4('Tourism', tags$span(class='sector-badge', 'High Performing')),
              span(class='sector-change', HTML('<i class="fas fa-arrow-up"></i> +15.3%'))
            ),
            div(class='perf-line',
              div(class='perf-bar', tags$div(class='fill', `data-fill`='78%')), 
              span(class='score', '78%')
            ),
            div(class='sector-desc', 'Rapid recovery and growth in tourism sector')
          )
        ),
  # Row 2 - Developing
  div(class='developing-header', HTML('<i class="fas fa-leaf"></i>'), h4('Developing Sectors')),
  div(class='sector-row',
          div(class='sector-card fade-in-up',
            div(class='card-head',
              div(class='left-icon', HTML('<i class="fas fa-heart"></i>')),
              h4('Health', tags$span(class='sector-badge', 'Developing')),
              span(class='sector-change', HTML('<i class="fas fa-arrow-up"></i> +3.2%'))
            ),
            div(class='perf-line',
              div(class='perf-bar', tags$div(class='fill', `data-fill`='68%')), 
              span(class='score', '68%')
            ),
            div(class='sector-desc', 'Ongoing investments to expand primary and advanced healthcare services')
          ),
          div(class='sector-card fade-in-up',
            div(class='card-head',
              div(class='left-icon', HTML('<i class="fas fa-graduation-cap"></i>')),
              h4('Education', tags$span(class='sector-badge', 'Developing')),
              span(class='sector-change', HTML('<i class="fas fa-arrow-up"></i> +2.8%'))
            ),
            div(class='perf-line',
              div(class='perf-bar', tags$div(class='fill', `data-fill`='72%')), 
              span(class='score', '72%')
            ),
            div(class='sector-desc', 'Improved access and quality, with ongoing teacher training programs')
          ),
          div(class='sector-card fade-in-up',
            div(class='card-head',
              div(class='left-icon', HTML('<i class="fas fa-seedling"></i>')),
              h4('Demographics & Agriculture', tags$span(class='sector-badge', 'Developing')),
              span(class='sector-change', HTML('<i class="fas fa-arrow-up"></i> +1.9%'))
            ),
            div(class='perf-line',
              div(class='perf-bar', tags$div(class='fill', `data-fill`='71%')), 
              span(class='score', '71%')
            ),
            div(class='sector-desc', 'Steady productivity gains; focus on sustainable farming techniques')
          )
        )
      )
    )
  ),

  # Predictive Analysis Section (inserted below the overview/sector blocks)
  # override default .section min-height so it doesn't create large vertical gap
  div(class='section', style='min-height:0; padding-top:0px; margin-top:-8px; padding-bottom:2px; background: transparent;',
    div(style='max-width:1200px; margin:0 auto;',
      div(class='predict-section',
        h3(class='predict-title', 'Predictive Analysis'),
        div(class='predict-row',
        div(class='predict-card', `data-id`='predict_gdp',
          div(class='predict-header',
            div(style='display:flex; align-items:center; gap:10px;', HTML('<div class="left-icon"><i class="fas fa-chart-line"></i></div><div><strong>GDP Projection</strong></div>')),
            span(class='predict-year', '2028')
          ),
          div(class='predict-confidence', 'Confidence: High (85%)'),
          div(class='predict-body',
            div(class='current', HTML('<div style="font-size:12px; color:#556;">Current GDP Growth</div><div class="val">8.2%</div>')),
            div(class='predicted', HTML('<div style="font-size:12px; color:#556;">Predicted Growth</div><div class="val">9.5%</div>'))
          ),
          div(class='predict-growth up', HTML('<i class="fas fa-arrow-up"></i> +1.3%')),
          div(class='predict-bar', tags$div(class='predict-fill', `data-fill`='72%')),
          div(class='predict-desc', 'Model indicates accelerating growth driven by services and FDI.')
        ),
        div(class='predict-card', `data-id`='predict_population',
          div(class='predict-header',
            div(style='display:flex; align-items:center; gap:10px;', HTML('<div class="left-icon"><i class="fas fa-users"></i></div><div><strong>Population Projection</strong></div>')),
            span(class='predict-year', '2030')
          ),
          div(class='predict-confidence', 'Confidence: Medium (72%)'),
          div(class='predict-body',
            div(class='current', HTML('<div style="font-size:12px; color:#556;">Current Population</div><div class="val">13,000,000</div>')),
            div(class='predicted', HTML('<div style="font-size:12px; color:#556;">Predicted Population</div><div class="val">14,200,000</div>'))
          ),
          div(class='predict-growth up', HTML('<i class="fas fa-arrow-up"></i> +9.2%')),
          div(class='predict-bar', tags$div(class='predict-fill', `data-fill`='60%')),
          div(class='predict-desc', 'Projected increase driven by natural growth and improved health services.')
        ),
        div(class='predict-card', `data-id`='predict_poverty',
          div(class='predict-header',
            div(style='display:flex; align-items:center; gap:10px;', HTML('<div class="left-icon"><i class="fas fa-chart-area"></i></div><div><strong>Poverty Rate Projection</strong></div>')),
            span(class='predict-year', '2029')
          ),
          div(class='predict-confidence', 'Confidence: Medium (68%)'),
          div(class='predict-body',
            div(class='current', HTML('<div style="font-size:12px; color:#556;">Current Poverty Rate</div><div class="val">35.6%</div>')),
            div(class='predicted', HTML('<div style="font-size:12px; color:#556;">Predicted Poverty Rate</div><div class="val">32.1%</div>'))
          ),
          div(class='predict-growth down', HTML('<i class="fas fa-arrow-down"></i> -3.5%')),
          div(class='predict-bar', tags$div(class='predict-fill', `data-fill`='48%')),
          div(class='predict-desc', 'Projected decline reflecting social protection and employment programs.')
        )
        )
      )
    )
  ),
  
  # Sectors section (organized two-row grid inside the Sectors tab)
  div(id = 'sectors', class='section', style='min-height:0; padding-top:0px; padding-bottom:2px; margin-top:-8px; margin-left:-90px;',
      h2(class='fade-in-up', 'Sector Dashboards'),
      div(class='fade-in-up sd-sub', 'Explore detailed insights across Rwanda\'s key development sectors'),
      # Grid with three cards (Economic, Demographics & Agriculture, Health & Education)
      div(class='fade-in-up sd-grid', style='margin-top:8px; gap:28px; margin-left:0;',
        div(class='sd-card fade-in-up', onclick = "Shiny.setInputValue('sector_dashboard_click', 'Economic Development|' + Math.random())",
          div(class='sd-top', HTML('<div class="left-icon"><i class="fas fa-building"></i></div><div class="sd-title-inline">Economic Development</div>')),
          div(class='sd-desc', 'GDP growth, business environment, trade, and economic indicators'),
          div(class='sd-kpi', HTML('<div class="kpi-label">GDP Growth Rate</div><div class="kpi-val"><span class="count" data-target="8.2" data-decimals="1">0</span>%</div>')),
          div(class='sd-footer', HTML('<a class="sd-button" href="#page=economic">View Dashboard</a>'))
        ),
        div(class='sd-card fade-in-up', onclick = "Shiny.setInputValue('sector_dashboard_click', 'Demographics & Agriculture|' + Math.random())",
          div(class='sd-top', HTML('<div class="left-icon"><i class="fas fa-seedling"></i></div><div class="sd-title-inline">Demographics & Agriculture</div>')),
          div(class='sd-desc', 'Population dynamics, agricultural productivity, and rural development'),
          div(class='sd-kpi', HTML('<div class="kpi-label">Agricultural Growth</div><div class="kpi-val"><span class="count" data-target="5.1" data-decimals="1">0</span>%</div>')),
          div(class='sd-footer', HTML('<a class="sd-button" href="#page=demographics">View Dashboard</a>'))
        ),
        div(class='sd-card fade-in-up', onclick = "Shiny.setInputValue('sector_dashboard_click', 'Health & Education|' + Math.random())",
          div(class='sd-top', HTML('<div class="left-icon"><i class="fas fa-heart"></i></div><div class="sd-title-inline">Health & Education</div>')),
          div(class='sd-desc', 'Healthcare access, outcomes, education access, and learning outcomes'),
          div(class='sd-kpi', HTML('<div class="kpi-label">Health / Education</div><div class="kpi-val"><span class="count" data-target="70.2" data-decimals="1">0</span></div>')),
          # Show the existing health standalone dashboard (keeps existing standalone page as-is)
          div(class='sd-footer', HTML('<a class="sd-button" href="#page=health">View Dashboard</a>'))
        )
    )
  ),
  
  # User guide (interactive accordion-style)
  
  # make this section container-free: remove the section-alt background and reset min-height
  div(id='guide', class='section', style='min-height:0; background:transparent; padding-top:12px; padding-bottom:6px; margin-left:-90px;',
    h2(class='fade-in-up','User Guide'),

    tags$style(HTML('
      .ug-accordion { display:flex; flex-direction:column; gap:18px; margin-top:10px; }
      .ug-item { background:#f4f7f8; border-radius:12px; border:1px solid rgba(11,120,160,0.06); box-shadow:0 10px 30px rgba(11,120,160,0.04); overflow:hidden; }
      .ug-hdr { display:flex; align-items:center; padding:16px 18px; cursor:pointer; }
      .ug-hdr .icon { width:48px; height:48px; background:#e9f6f7; border-radius:10px; display:flex; align-items:center; justify-content:center; margin-right:16px; color:#0B78A0; font-size:18px; }
      .ug-hdr .title { flex:1; font-weight:700; color:#123; font-size:16px; }
      .ug-hdr .chev { color:#2b2b2b; transition:transform .25s ease; }
      .ug-body { padding:0 18px 18px 82px; max-height:0; overflow:hidden; transition:max-height .35s ease; color:#334; line-height:1.6; }
      .ug-item.open .ug-hdr { background: linear-gradient(90deg,#b7e3b8,#57c06a); }
      .ug-item.open .icon { background:#dff3df; color:#0b5f2f; }
      .ug-item.open .chev { transform: rotate(180deg); }
      .ug-item.open .ug-body { /* max-height expanded by JS based on content */ }
      @media (max-width:800px) { .ug-body { padding-left:18px; } .ug-hdr .title{ font-size:15px } }
    ')),

    div(class='fade-in-up ug-accordion',
      # Getting Started (expanded by default)
      div(class='ug-item open',
        div(class='ug-hdr',
          div(class='icon', HTML('<i class="fas fa-home"></i>')),
          div(class='title', 'Getting Started'),
          div(class='chev', HTML('<i class="fas fa-chevron-down"></i>'))
        ),
        div(class='ug-body',
          tags$p('Welcome to NDIP Rwanda — your gateway to comprehensive national data insights.'),
          tags$ul(
            tags$li(HTML('<strong>Navigate:</strong> Use the top navigation to jump between Home, Overview, Sectors and the User Guide.')),
            tags$li(HTML('<strong>Explore:</strong> Click any overview card or sector tile to open a detailed dashboard or modal.')),
            tags$li(HTML('<strong>Search & Filters:</strong> Use search and the quick filters at the top of dashboards to narrow down time, region, or indicators.'))
          ),
          tags$p('Tip: Click the left icon or the header to expand/collapse any guide card. The first card is expanded for quick access.' )
        )
      ),

      # Understanding the Overview
      div(class='ug-item',
        div(class='ug-hdr',
          div(class='icon', HTML('<i class="fas fa-chart-bar"></i>')),
          div(class='title', 'Understanding the Overview'),
          div(class='chev', HTML('<i class="fas fa-chevron-down"></i>'))
        ),
        div(class='ug-body',
          tags$p('The Overview section summarizes key national metrics with interactive cards and mini-plots.'),
          tags$ol(
            tags$li(HTML('<strong>Cards:</strong> Click a card to open a modal with a short time-series and context.')),
            tags$li(HTML('<strong>Mini-plots:</strong> Hover to reveal tooltips and use the Plotly toolbar to zoom or download figures.'))
          )
        )
      ),

      # Exploring Sector Dashboards
      div(class='ug-item',
        div(class='ug-hdr',
          div(class='icon', HTML('<i class="fas fa-building"></i>')),
          div(class='title', 'Exploring Sector Dashboards'),
          div(class='chev', HTML('<i class="fas fa-chevron-down"></i>'))
        ),
        div(class='ug-body',
          tags$p('Each sector dashboard contains KPIs, trends, maps and downloadable data. Use filters to change region and timeframe.'),
          tags$ul(
            tags$li('Click any "View Dashboard" button to navigate to the sector page.'),
            tags$li('Use the export tools to download CSV snapshots where available.')
          )
        )
      ),

      
    ),

    tags$script(HTML("\
      (function(){\
        function setHeights(){\
          document.querySelectorAll('.ug-item').forEach(function(item){\
            var body = item.querySelector('.ug-body');\
            if(item.classList.contains('open')){ body.style.maxHeight = body.scrollHeight + 'px'; } else { body.style.maxHeight = '0'; }\
          });\
        }\
        document.addEventListener('click', function(e){\
          var hdr = e.target.closest('.ug-hdr');\
          if(!hdr) return;\
          var item = hdr.parentElement;\
          // close others (accordion behavior)\
          document.querySelectorAll('.ug-item').forEach(function(i){ if(i!==item) i.classList.remove('open'); });\
          item.classList.toggle('open');\
          setHeights();\
        });\
        // initial heights on load\
        window.addEventListener('load', setHeights);\
        // also adjust on resize (small debounce)\
        var t; window.addEventListener('resize', function(){ clearTimeout(t); t=setTimeout(setHeights,120); });\
      })();\
    ")),

  # contact block removed as requested
  ),
  
  # Close main content wrapper so footer is a sibling pushed to bottom
  ),

  # Footer: standard block at the end of the page (not fixed). It will appear after the User Guide section.
  # Menya chatbot (floating button + modal)
  div(class='menya-btn', id='menyaBtn', HTML('<svg width="26" height="26" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 2C6.48 2 2 5.58 2 10c0 2.4 1.56 4.55 4 5.84V22l4.01-2.22C11.64 19.99 11.82 20 12 20c5.52 0 10-3.58 10-8s-4.48-10-10-10z" fill="white"/></svg>')),

  # Standalone Economic Dashboard page (hidden by default)
  div(id='standalone-economic', style='display:none; position:fixed; inset:0; background:#ffffff; z-index:2000; overflow:auto; padding:0;',
    # Left fixed sidebar (steelblue) using new standalone-sidebar class
    div(class='standalone-sidebar',
      div(class='brand', 'NDIP'),
      tags$div(class='side-nav',
        tags$ul(
          tags$li(HTML('<a href="#home" class="side-link"><span class="side-icon"><i class="fas fa-home"></i></span><span class="side-text">NDP</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#overview" class="side-link"><span class="side-icon"><i class="fas fa-chart-pie"></i></span><span class="side-text">Overview</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#gdp" class="side-link"><span class="side-icon"><i class="fas fa-chart-line"></i></span><span class="side-text">GDP</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#production" class="side-link"><span class="side-icon"><i class="fas fa-industry"></i></span><span class="side-text">Production Output</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#inflation" class="side-link"><span class="side-icon"><i class="fas fa-percentage"></i></span><span class="side-text">Inflation</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#predict" class="side-link"><span class="side-icon"><i class="fas fa-brain"></i></span><span class="side-text">Predictive Analysis</span><span class="side-pill"></span></a>'))
        )
      ),
      tags$div(style='margin-top:auto; font-size:13px; opacity:0.95; color:#fff;', HTML('<a href="#" id="close-standalone-left" style="color:#fff; text-decoration:none; font-weight:800;">Close</a>'))
    ),

  # Main content area shifted right to accommodate fixed sidebar (left intentionally blank)
  div(class='standalone-main', style='padding:24px 32px; min-height:100vh;',
        div(style='display:flex; align-items:center; gap:12px; justify-content:space-between;',
          div(style='display:flex; align-items:center; gap:12px;',
              tags$a(href='#sectors', id='go-back-sectors', style='display:inline-block; padding:8px 12px; border-radius:10px; background:#fff; color:#0B78A0; font-weight:800; text-decoration:none; box-shadow:0 6px 18px rgba(11,120,160,0.08);', HTML('&#8592; Go back')),
              tags$h2('Rwanda Economic Sector Dashboard', style='margin:0; color:#042A3B;')
          ),
          tags$a(href='#', id='close-standalone', 'Close', style='color:#0B78A0; font-weight:700; text-decoration:none;')
        ),

  # Dashboard body with Overview / GDP / Inflation / Production / Predictive tabs
  div(id='dashboard-body', style='min-height:600px; background:transparent; padding:20px; border-radius:0; box-shadow:none;',
    # Overview
    div(id='overview', style='padding:12px 8px;',
      tags$h3('Overview'),
      tags$p('Key economic indicators for Rwanda. Use the sidebar to navigate to individual metrics.'),
      fluidRow(
      column(4, div(class='infobox', style='padding:12px; background:#f7fcfb; border-radius:8px;',
             tags$h4('GDP (Most recent)'), tags$p(textOutput('overview_gdp_text')))),
      column(4, div(class='infobox', style='padding:12px; background:#f7fbff; border-radius:8px;',
             tags$h4('Inflation (Most recent)'), tags$p(textOutput('overview_inflation_text')))),
      column(4, div(class='infobox', style='padding:12px; background:#fff7f7; border-radius:8px;',
             tags$h4('Production Output (Latest)'), tags$p(textOutput('overview_production_text'))))
      )
    ),

    # GDP section
    div(id='gdp', style='padding:12px 8px; margin-top:18px;',
      tags$h3('GDP'),
      plotlyOutput('rwanda_gdp_plot', height = '420px')
    ),

    # Production Output section
    div(id='production', style='padding:12px 8px; margin-top:18px;',
      tags$h3('Production Output'),
      plotlyOutput('rwanda_production_plot', height = '420px')
    ),

    # Inflation section
    div(id='inflation', style='padding:12px 8px; margin-top:18px;',
      tags$h3('Inflation'),
      plotlyOutput('rwanda_inflation_plot', height = '420px')
    ),

    # Predictive placeholder (existing predictive area preserved)
    div(id='predict', style='padding:12px 8px; margin-top:18px;',
      tags$h3('Predictive Analysis'),
      tags$p('Predictive models and scenario analysis will be shown here.')
    )
  )
      ),

  # JS for hash routing + simplified side-link behavior (no white highlight); click sets active class
  tags$script(HTML("(function(){\n      function showOrHide(){\n        if(location.hash === '#page=economic'){\n          var el = document.getElementById('standalone-economic'); if(el) el.style.display='block';\n          try{ document.querySelector('body').style.overflow='hidden'; }catch(e){}\n        } else {\n          var el = document.getElementById('standalone-economic'); if(el) el.style.display='none';\n          try{ document.querySelector('body').style.overflow='auto'; }catch(e){}\n        }\n      }\n      window.addEventListener('hashchange', showOrHide);\n      var closeMain = document.getElementById('close-standalone'); if(closeMain) closeMain.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var closeLeft = document.getElementById('close-standalone-left'); if(closeLeft) closeLeft.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      // Go back to sectors button behavior\n      var goBack = document.getElementById('go-back-sectors');\n      if(goBack){ goBack.addEventListener('click', function(e){ e.preventDefault(); location.hash = '#sectors'; showOrHide(); setTimeout(function(){ var el = document.getElementById('sectors'); if(el) el.scrollIntoView({behavior:'smooth'}); }, 100); }); }\n      // side-link behavior: smooth scroll and active class (no inline colors)\n      var links = document.querySelectorAll('.side-link');\n      function clearActive(){ links.forEach(function(a){ a.classList.remove('active'); }); }\n      links.forEach(function(a){ a.addEventListener('click', function(e){ e.preventDefault(); var href = a.getAttribute('href'); var id = href && href.replace('#',''); var target = document.getElementById(id); if(target){ target.scrollIntoView({behavior:'smooth', block:'start'}); } clearActive(); a.classList.add('active'); }); });\n      // initial check\n      setTimeout(showOrHide, 30);\n    })();"))
  ),

  # Standalone Governance & Security Dashboard page (hidden by default)
  div(id='standalone-governance', style='display:none; position:fixed; inset:0; background:#ffffff; z-index:2000; overflow:auto; padding:0;',
    # Left fixed sidebar (steelblue) using new standalone-sidebar class
    div(class='standalone-sidebar',
      div(class='brand', 'NDIP'),
      tags$div(class='side-nav',
        tags$ul(
          tags$li(HTML('<a href="#overview" class="side-link"><span class="side-icon"><i class="fas fa-chart-pie"></i></span><span class="side-text">Overview</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#security_metrics" class="side-link"><span class="side-icon"><i class="fas fa-shield-alt"></i></span><span class="side-text">Security Metrics</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#governance_indicators" class="side-link"><span class="side-icon"><i class="fas fa-gavel"></i></span><span class="side-text">Governance Indicators</span><span class="side-pill"></span></a>')),
          tags$li(HTML('<a href="#predict" class="side-link"><span class="side-icon"><i class="fas fa-brain"></i></span><span class="side-text">Predictive Analysis</span><span class="side-pill"></span></a>'))
        )
      ),
      tags$div(style='margin-top:auto; font-size:13px; opacity:0.95; color:#fff;', HTML('<a href="#" id="close-governance-left" style="color:#fff; text-decoration:none; font-weight:800;">Close</a>'))
    ),

  # Main content area shifted right to accommodate fixed sidebar (left intentionally blank)
  div(class='standalone-main', style='padding:24px 32px; min-height:100vh;',
        div(style='display:flex; align-items:center; gap:12px; justify-content:space-between;',
          div(style='display:flex; align-items:center; gap:12px;',
              tags$a(href='#sectors', id='go-back-sectors-governance', style='display:inline-block; padding:8px 12px; border-radius:10px; background:#fff; color:#0B78A0; font-weight:800; text-decoration:none; box-shadow:0 6px 18px rgba(11,120,160,0.08);', HTML('&#8592; Go back')),
              tags$h2('Rwanda Governance and Security Sector Dashboard', style='margin:0; color:#042A3B;')
          ),
          tags$a(href='#', id='close-governance-standalone', 'Close', style='color:#0B78A0; font-weight:700; text-decoration:none;')
        ),

  # Governance dashboard body (placeholder for parity with economic dashboard layout)
  div(id='governance-dashboard-body', style='min-height:600px; background:transparent; padding:0; border-radius:0; box-shadow:none;')
      ),

  # JS for hash routing + simplified side-link behavior (no white highlight); click sets active class - governance
  tags$script(HTML("(function(){\n      // extend showOrHide to handle governance page\n      function showOrHide(){\n        var econ = document.getElementById('standalone-economic');\n        var gov = document.getElementById('standalone-governance');\n        if(location.hash === '#page=economic'){ if(econ) econ.style.display='block'; if(gov) gov.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else if(location.hash === '#page=governance'){ if(gov) gov.style.display='block'; if(econ) econ.style.display='none'; try{ document.querySelector('body').style.overflow='hidden'; }catch(e){} }\n        else { if(econ) econ.style.display='none'; if(gov) gov.style.display='none'; try{ document.querySelector('body').style.overflow='auto'; }catch(e){} }\n      }\n      window.addEventListener('hashchange', showOrHide);\n      // close handlers for governance standalone\n      var closeGov = document.getElementById('close-governance-standalone'); if(closeGov) closeGov.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var closeLeft = document.getElementById('close-governance-left'); if(closeLeft) closeLeft.addEventListener('click', function(e){ e.preventDefault(); location.hash = ''; });\n      var goBackGov = document.getElementById('go-back-sectors-governance'); if(goBackGov){ goBackGov.addEventListener('click', function(e){ e.preventDefault(); location.hash = '#sectors'; showOrHide(); setTimeout(function(){ var el = document.getElementById('sectors'); if(el) el.scrollIntoView({behavior:'smooth'}); }, 100); }); }\n      // side-link behavior specific to governance page: smooth scroll and active class\n      var links = document.querySelectorAll('#standalone-governance .side-link');\n      function clearActive(){ links.forEach(function(a){ a.classList.remove('active'); }); }\n      links.forEach(function(a){ a.addEventListener('click', function(e){ e.preventDefault(); var href = a.getAttribute('href'); var id = href && href.replace('#',''); var target = document.getElementById(id); if(target){ target.scrollIntoView({behavior:'smooth', block:'start'}); } clearActive(); a.classList.add('active'); }); });\n      // initial check\n      setTimeout(showOrHide, 30);\n    })();"))
  ),

  div(class='footer', style = 'color: #0D1B2A; padding: 28px 20px; display:flex; flex-wrap:wrap; gap:18px; align-items:flex-start; justify-content:space-between; box-sizing:border-box; min-height:120px; border-top: 1px solid rgba(255,255,255,0.06);',
    # Left: logo + description
    div(style='display:flex; gap:18px; align-items:flex-start; flex:1 1 420px; min-width:300px;',
      div(style='width:56px; height:56px; border-radius:10px; background:#0B78A0; color:#fff; display:flex; align-items:center; justify-content:center; font-weight:800; font-size:18px;', 'RW'),
      div(
        tags$div(style='font-weight:800; color:#0D1B2A; font-size:18px; margin-bottom:4px;', 'NDIP Rwanda'),
        tags$div(style='color:#556; font-size:13px; margin-bottom:10px;', 'National Data Integration Platform'),
        tags$p(style='margin:0; color:#445; max-width:520px;', 'Empowering Rwanda through transparent, accessible, and actionable data insights.')
      )
    ),

    # Platform column
    div(style='flex:1 1 180px; min-width:160px;',
      tags$h4('Platform', style='margin:0 0 8px 0; color:#0D1B2A; font-weight:800;'),
      tags$ul(style='list-style:none; padding:0; margin:0; line-height:1.9; color:#445;',
        tags$li(a(href='#overview', 'Overview', style='color:inherit; text-decoration:none;')),
        tags$li(a(href='#sectors', 'Sectors', style='color:inherit; text-decoration:none;')),
        tags$li(a(href='#guide', 'User Guide', style='color:inherit; text-decoration:none;'))
      )
    ),

    # Resources & Sources column (include NISR and curated links)
    div(style='flex:1 1 220px; min-width:180px;',
      tags$h4('Resources & Sources', style='margin:0 0 8px 0; color:#0D1B2A; font-weight:800;'),
      tags$ul(style='list-style:none; padding:0; margin:0; line-height:1.9; color:#445;',
        tags$li(HTML('<strong>NISR</strong> — National Institute of Statistics of Rwanda')),
        tags$li(a(href='https://institutional-portal.example', 'Institutional Portal', target='_blank', style='color:inherit; text-decoration:none;')),
        tags$li(a(href='#', 'API Documentation', style='color:inherit; text-decoration:none;'))
      ),
      tags$div(style='margin-top:8px; color:#556; font-size:13px;', 'Data curated from national and international agencies for accuracy and transparency.')
    ),

    # Contact column
    div(style='flex:1 1 220px; min-width:200px;',
      tags$h4('Contact', style='margin:0 0 8px 0; color:#0D1B2A; font-weight:800;'),
      tags$p(HTML('<i class="fas fa-envelope" style="margin-right:8px;color:#0B78A0;"></i><a href="mailto:ndip@gmail.com" style="color:inherit; text-decoration:none;">ndip@gmail.com</a>'), style='margin:0 0 8px 0;'),
      tags$p(HTML('<i class="fas fa-phone" style="margin-right:8px;color:#0B78A0;"></i><a href="tel:+250785694467" style="color:inherit; text-decoration:none;">+250 785 694 467</a>'), style='margin:0;')
    ),

    # Footer bottom row (full-width)
  div(style='width:70%; margin-top:6px; padding-top:6px; text-align:center;',
    tags$div(style='color:#556; font-weight:600; font-size:14px;', HTML('&copy; 2025 Republic of Rwanda. All rights reserved. | Built with transparency and innovation.'))
  )
  )
)
)
)


# # SERVER --------------------------------------------------------------
server <- function(input, output, session) {
  # Sample data frames for trends (2020-2025)
  trend_years <- 2020:2025
  
  gdp_data <- data.frame(
    Year = trend_years,
    Value = c(7.2, 7.8, 8.1, 8.4, 8.6, 8.2)
  )
  
  literacy_data <- data.frame(
    Year = trend_years,
    Value = c(70.2, 71.5, 73.1, 74.8, 75.5, 76.3)
  )
  
  cpi_data <- data.frame(
    Year = trend_years,
    Value = c(62, 64, 65, 67, 68, 69)
  )

  # Additional small trend datasets so modal mini-charts render correctly
  electricity_data <- data.frame(
    Year = trend_years,
    Value = c(70.1, 71.8, 73.4, 75.2, 78.6, 82.5)
  )
  life_exp_data <- data.frame(
    Year = trend_years,
    Value = c(67.8, 68.4, 68.9, 69.3, 69.5, 70.2)
  )
  poverty_data <- data.frame(
    Year = trend_years,
    Value = c(42.0, 40.5, 39.1, 38.2, 36.9, 35.6)
  )

  # ...existing trend datasets...
  
  # Render trend charts with animations

  # Render other charts...
  # Animated trend charts
  output$gdp_trend <- renderPlotly({
    plot_ly(data = gdp_data, x = ~Year, y = ~Value) %>%
      add_trace(
        type = 'scatter',
        mode = 'lines+markers',
        line = list(
          shape = 'spline',
          smoothing = 1.3,
          width = 3,
          color = '#157A4A'
        ),
        marker = list(
          color = '#157A4A',
          size = 8,
          symbol = 'circle',
          line = list(color = '#fff', width = 2)
        ),
        hoverinfo = 'text',
        hovertext = ~paste(
          "Year:", Year, "<br>",
          "Growth Rate:", sprintf("%.1f%%", Value)
        )
      ) %>%
      layout(
        showlegend = FALSE,
        plot_bgcolor = 'transparent',
        paper_bgcolor = 'transparent',
        xaxis = list(
          title = "Year",
          showgrid = TRUE,
          gridcolor = 'rgba(255,255,255,0.1)'
        ),
        yaxis = list(
          title = "GDP Growth Rate (%)",
          showgrid = TRUE,
          gridcolor = 'rgba(255,255,255,0.1)',
          ticksuffix = "%"
        ),
        hoverlabel = list(
          bgcolor = "white",
          font = list(size = 14)
        )
      ) %>%
      animation_opts(
        frame = 100,
        transition = 500,
        redraw = FALSE,
        mode = "immediate"
      ) %>%
      animation_button(
        x = 1, xanchor = "right",
        y = 0, yanchor = "bottom"
      ) %>%
      animation_slider(
        currentvalue = list(prefix = "Year ")
      )
  })
  
  output$literacy_trend <- renderPlotly({
    plot_ly(data = literacy_data, x = ~Year, y = ~Value) %>%
      add_trace(
        type = 'scatter',
        mode = 'lines+markers',
        line = list(
          shape = 'spline',
          smoothing = 1.3,
          width = 3,
          color = '#0B78A0'
        ),
        marker = list(
          color = '#0B78A0',
          size = 8,
          symbol = 'circle',
          line = list(color = '#fff', width = 2)
        ),
        hoverinfo = 'text',
        hovertext = ~paste(
          "Year:", Year, "<br>",
          "Literacy Rate:", sprintf("%.1f%%", Value)
        )
      ) %>%
      layout(
        showlegend = FALSE,
        plot_bgcolor = 'transparent',
        paper_bgcolor = 'transparent',
        xaxis = list(
          title = "Year",
          showgrid = TRUE,
          gridcolor = 'rgba(255,255,255,0.1)'
        ),
        yaxis = list(
          title = "Literacy Rate (%)",
          showgrid = TRUE,
          gridcolor = 'rgba(255,255,255,0.1)',
          ticksuffix = "%"
        ),
        hoverlabel = list(
          bgcolor = "white",
          font = list(size = 14)
        )
      ) %>%
      animation_opts(
        frame = 100,
        transition = 500,
        redraw = FALSE,
        mode = "immediate"
      ) %>%
      animation_button(
        x = 1, xanchor = "right",
        y = 0, yanchor = "bottom"
      )
  })
  
  output$cpi_trend <- renderPlotly({
    plot_ly(data = cpi_data, x = ~Year, y = ~Value) %>%
      add_trace(
        type = 'scatter',
        mode = 'lines+markers',
        line = list(
          shape = 'spline',
          smoothing = 1.3,
          width = 3,
          color = '#157A4A'
        ),
        marker = list(
          color = '#157A4A',
          size = 8,
          symbol = 'circle',
          line = list(color = '#fff', width = 2)
        ),
        hoverinfo = 'text',
        hovertext = ~paste(
          "Year:", Year, "<br>",
          "CPI Score:", sprintf("%.0f", Value)
        )
      ) %>%
      layout(
        showlegend = FALSE,
        plot_bgcolor = 'transparent',
        paper_bgcolor = 'transparent',
        xaxis = list(
          title = "Year",
          showgrid = TRUE,
          gridcolor = 'rgba(255,255,255,0.1)'
        ),
        yaxis = list(
          title = "CPI Score",
          showgrid = TRUE,
          gridcolor = 'rgba(255,255,255,0.1)'
        ),
        hoverlabel = list(
          bgcolor = "white",
          font = list(size = 14)
        )
      ) %>%
      animation_opts(
        frame = 100,
        transition = 500,
        redraw = FALSE,
        mode = "immediate"
      ) %>%
      animation_button(
        x = 1, xanchor = "right",
        y = 0, yanchor = "bottom"
      )
  })

  # Electricity access mini chart (used in modal)
  output$electricity_trend <- renderPlotly({
    plot_ly(data = electricity_data, x = ~Year, y = ~Value) %>%
      add_trace(type = 'scatter', mode = 'lines+markers', line = list(color = '#FFD100', width = 3), marker = list(size = 6, color = '#FFD100')) %>%
      layout(showlegend = FALSE, xaxis = list(title = ''), yaxis = list(title = 'Access (%)', ticksuffix = '%'), plot_bgcolor = 'transparent', paper_bgcolor = 'transparent') %>%
      config(displayModeBar = FALSE)
  })

  # Life expectancy mini chart (used in modal)
  output$life_exp_trend <- renderPlotly({
    plot_ly(data = life_exp_data, x = ~Year, y = ~Value) %>%
      add_trace(type = 'scatter', mode = 'lines+markers', line = list(color = '#157A4A', width = 3), marker = list(size = 6, color = '#157A4A')) %>%
      layout(showlegend = FALSE, xaxis = list(title = ''), yaxis = list(title = 'Years'), plot_bgcolor = 'transparent', paper_bgcolor = 'transparent') %>%
      config(displayModeBar = FALSE)
  })
  
  # Poverty rate mini chart (used in modal)
  output$poverty_trend <- renderPlotly({
    plot_ly(data = poverty_data, x = ~Year, y = ~Value) %>%
      add_trace(type = 'scatter', mode = 'lines+markers', line = list(color = '#ff4444', width = 3), marker = list(size = 6, color = '#ff4444')) %>%
      layout(showlegend = FALSE, xaxis = list(title = ''), yaxis = list(title = 'Poverty (%)', ticksuffix = '%'), plot_bgcolor = 'transparent', paper_bgcolor = 'transparent') %>%
      config(displayModeBar = FALSE)
  })

  # --- Demographics & Agriculture visualizations and tables ---
  # Population plot and table
  output$dem_pop_table <- DT::renderDataTable({
    if(exists('Rwanda_population')) return(DT::datatable(Rwanda_population, options = list(pageLength = 10)))
    NULL
  })

  output$dem_pop_trend <- renderPlotly({
    if(!exists('Rwanda_population')) return(plotly_empty())
    df <- as.data.frame(Rwanda_population)
    # try common columns
    xcol <- names(df)[1]
    ycol <- names(df)[2]
    plot_ly(df, x = ~get(xcol), y = ~get(ycol), type = 'scatter', mode = 'lines+markers') %>% layout(title = 'Population Trend', xaxis = list(title = xcol), yaxis = list(title = ycol))
  })

  output$dem_pop_plot <- renderPlotly({
    if(!exists('Rwanda_population')) return(plotly_empty())
    df <- as.data.frame(Rwanda_population)
    xcol <- names(df)[1]
    ycol <- names(df)[2]
    plot_ly(df, x = ~get(xcol), y = ~get(ycol), type = 'bar') %>% layout(title = 'Population (overview)')
  })

  # Vital statistics
  output$dem_vital_plot <- renderPlotly({
    if(!exists('Rwanda_vital_statistics')) return(plotly_empty())
    df <- as.data.frame(Rwanda_vital_statistics)
    nums <- names(df)[sapply(df, is.numeric)]
    if(length(nums) < 1) return(plotly_empty())
    plot_ly(df, x = ~get(names(df)[1]), y = ~get(nums[1]), type = 'bar') %>% layout(title = 'Vital Statistics')
  })

  output$dem_vital_table <- DT::renderDataTable({
    if(exists('Rwanda_vital_statistics')) return(DT::datatable(Rwanda_vital_statistics, options = list(pageLength = 10)))
    NULL
  })

  # Labour force
  output$dem_labour_plot <- renderPlotly({
    if(!exists('Rwanda_labor_force')) return(plotly_empty())
    df <- as.data.frame(Rwanda_labor_force)
    nums <- names(df)[sapply(df, is.numeric)]
    if(length(nums) < 1) return(plotly_empty())
    plot_ly(df, x = ~get(names(df)[1]), y = ~get(nums[1]), type = 'scatter', mode = 'lines+markers') %>% layout(title = 'Labor Force')
  })

  output$dem_labour_table <- DT::renderDataTable({
    if(exists('Rwanda_labor_force')) return(DT::datatable(Rwanda_labor_force, options = list(pageLength = 10)))
    NULL
  })

  # Agriculture
  output$dem_agri_table <- DT::renderDataTable({
    if(exists('Rwanda_agriculture')) return(DT::datatable(Rwanda_agriculture, options = list(pageLength = 10)))
    NULL
  })

  output$dem_agri_trend <- renderPlotly({
    if(!exists('Rwanda_agriculture')) return(plotly_empty())
    df <- as.data.frame(Rwanda_agriculture)
    nums <- names(df)[sapply(df, is.numeric)]
    if(length(nums) < 1) return(plotly_empty())
    plot_ly(df, x = ~get(names(df)[1]), y = ~get(nums[1]), type = 'bar') %>% layout(title = 'Agricultural Output')
  })

  output$dem_agri_plot <- renderPlotly({
    if(!exists('Rwanda_agriculture')) return(plotly_empty())
    df <- as.data.frame(Rwanda_agriculture)
    xcol <- names(df)[1]
    ycol <- names(df)[sapply(df, is.numeric)][1]
    plot_ly(df, x = ~get(xcol), y = ~get(ycol), type = 'bar') %>% layout(title = 'Agriculture (overview)')
  })

  # Land use
  output$dem_landuse_plot <- renderPlotly({
    if(!exists('Rwanda_land_use')) return(plotly_empty())
    df <- as.data.frame(Rwanda_land_use)
    nums <- names(df)[sapply(df, is.numeric)]
    if(length(nums) < 1) return(plotly_empty())
    plot_ly(df, x = ~get(names(df)[1]), y = ~get(nums[1]), type = 'bar') %>% layout(title = 'Land Use')
  })

  output$dem_landuse_table <- DT::renderDataTable({
    if(exists('Rwanda_land_use')) return(DT::datatable(Rwanda_land_use, options = list(pageLength = 10)))
    NULL
  })

  # Predictive analysis UI
  output$dem_pred_var_ui <- renderUI({
    ds <- input$dem_pred_ds
    df <- switch(ds, population = if(exists('Rwanda_population')) as.data.frame(Rwanda_population) else NULL,
                 agriculture = if(exists('Rwanda_agriculture')) as.data.frame(Rwanda_agriculture) else NULL)
    if(is.null(df)) return(tags$em('No data available'))
    nums <- names(df)[sapply(df, is.numeric)]
    selectInput('dem_pred_var', 'Variable', choices = nums)
  })

  # --- Health & Education visualizations ---
  output$health_table <- DT::renderDataTable({
    if(exists('Rwanda_health')) return(DT::datatable(Rwanda_health, options = list(pageLength = 10)))
    NULL
  })

  output$health_indicators_plot <- renderPlotly({
    if(!exists('Rwanda_health')) return(plotly_empty())
    df <- as.data.frame(Rwanda_health)
    nums <- names(df)[sapply(df, is.numeric)]
    if(length(nums) < 1) return(plotly_empty())
    xcol <- names(df)[1]
    ycol <- nums[1]
    plot_ly(df, x = ~get(xcol), y = ~get(ycol), type = 'bar') %>% layout(title = 'Health Indicator Overview')
  })

  output$health_trend_plot <- renderPlotly({
    if(!exists('Rwanda_health')) return(plotly_empty())
    df <- as.data.frame(Rwanda_health)
    nums <- names(df)[sapply(df, is.numeric)]
    if(length(nums) < 2) return(plotly_empty())
    plot_ly(df, x = ~get(names(df)[1]), y = ~get(nums[1]), type = 'scatter', mode = 'lines+markers') %>% layout(title = 'Health Trend')
  })

  # Schools / education
  output$schools_table <- DT::renderDataTable({
    if(exists('Rwanda_schools')) return(DT::datatable(Rwanda_schools, options = list(pageLength = 10)))
    NULL
  })

  output$schools_enrollment_plot <- renderPlotly({
    if(!exists('Rwanda_schools')) return(plotly_empty())
    df <- as.data.frame(Rwanda_schools)
    nums <- names(df)[sapply(df, is.numeric)]
    if(length(nums) < 1) return(plotly_empty())
    xcol <- names(df)[1]
    ycol <- nums[1]
    plot_ly(df, x = ~get(xcol), y = ~get(ycol), type = 'bar') %>% layout(title = 'School Enrollment Overview')
  })

  output$schools_trend_plot <- renderPlotly({
    if(!exists('Rwanda_schools')) return(plotly_empty())
    df <- as.data.frame(Rwanda_schools)
    nums <- names(df)[sapply(df, is.numeric)]
    if(length(nums) < 1) return(plotly_empty())
    plot_ly(df, x = ~get(names(df)[1]), y = ~get(nums[1]), type = 'scatter', mode = 'lines+markers') %>% layout(title = 'Schools Trend')
  })

  # Populate health predictive variable choices when data exists
  observe({
    if(exists('Rwanda_health')){
      df <- as.data.frame(Rwanda_health)
      nums <- names(df)[sapply(df, is.numeric)]
      updateSelectInput(session, 'health_pred_var', choices = nums)
    }
  })

  observeEvent(input$health_run_pred, {
    req(input$health_pred_var)
    if(!exists('Rwanda_health')) return(NULL)
    df <- as.data.frame(Rwanda_health)
    y <- as.numeric(df[[input$health_pred_var]])
    years <- grep('year|date', tolower(names(df)), value = TRUE)
    if(length(years) > 0) x <- as.numeric(df[[years[1]]]) else x <- seq_along(y)
    model <- lm(y ~ x)
    newx <- data.frame(x = max(x, na.rm = TRUE) + seq(1,5))
    preds <- predict(model, newdata = newx, interval = 'prediction')
    pred_df <- data.frame(x = c(x, newx$x), observed = c(y, rep(NA, nrow(newx))), forecast = c(rep(NA, length(y)), preds[,1]), lwr = c(rep(NA, length(y)), preds[,2]), upr = c(rep(NA, length(y)), preds[,3]))
    output$health_pred_plot <- renderPlotly({
      plot_ly(pred_df, x = ~x) %>% add_lines(y = ~forecast, name = 'Forecast') %>% add_ribbons(ymin = ~lwr, ymax = ~upr, name = 'PI', opacity = 0.2) %>% add_markers(data = data.frame(x = x, y = y), x = ~x, y = ~y, name = 'Observed')
    })
  })

  observeEvent(input$dem_run_pred, {
    ds <- input$dem_pred_ds
    df <- switch(ds, population = if(exists('Rwanda_population')) as.data.frame(Rwanda_population) else NULL,
                 agriculture = if(exists('Rwanda_agriculture')) as.data.frame(Rwanda_agriculture) else NULL)
    req(df, input$dem_pred_var)
    y <- as.numeric(df[[input$dem_pred_var]])
    # find year-like column
    years <- grep('year|date', tolower(names(df)), value = TRUE)
    if(length(years) > 0) x <- as.numeric(df[[years[1]]]) else x <- seq_along(y)
    model <- lm(y ~ x)
    newx <- data.frame(x = max(x, na.rm = TRUE) + seq(1,5))
    preds <- predict(model, newdata = newx, interval = 'prediction')
    pred_df <- data.frame(x = c(x, newx$x), observed = c(y, rep(NA, nrow(newx))), forecast = c(rep(NA, length(y)), preds[,1]), lwr = c(rep(NA, length(y)), preds[,2]), upr = c(rep(NA, length(y)), preds[,3]))
    output$dem_pred_plot <- renderPlotly({
      plot_ly(pred_df, x = ~x) %>% add_lines(y = ~forecast, name = 'Forecast') %>% add_ribbons(ymin = ~lwr, ymax = ~upr, name = 'PI', opacity = 0.2) %>% add_markers(data = data.frame(x = x, y = y), x = ~x, y = ~y, name = 'Observed')
    })
  })

  # --- Economic sector visualizations added: Rwanda GDP, Inflation, Production Output ---
  output$rwanda_gdp_plot <- renderPlotly({
    if(exists('Rwanda_GDP')){
      df <- as.data.frame(Rwanda_GDP)
      # Attempt to find sensible column names
      year_col <- names(df)[1]
      value_col <- names(df)[2]
      p <- plot_ly(df, x = ~get(year_col), y = ~get(value_col), type = 'scatter', mode = 'lines+markers') %>%
        layout(title = 'Rwanda GDP', xaxis = list(title = year_col), yaxis = list(title = value_col))
      p
    } else plotly_empty()
  })

  output$rwanda_inflation_plot <- renderPlotly({
    if(exists('Rwanda_inflation')){
      df <- as.data.frame(Rwanda_inflation)
      year_col <- names(df)[1]
      value_col <- names(df)[2]
      plot_ly(df, x = ~get(year_col), y = ~get(value_col), type = 'scatter', mode = 'lines+markers') %>%
        layout(title = 'Rwanda Inflation', xaxis = list(title = year_col), yaxis = list(title = value_col))
    } else plotly_empty()
  })

  output$rwanda_production_plot <- renderPlotly({
    if(exists('Rwanda_production_output')){
      df <- as.data.frame(Rwanda_production_output)
      year_col <- names(df)[1]
      value_col <- names(df)[2]
      plot_ly(df, x = ~get(year_col), y = ~get(value_col), type = 'scatter', mode = 'lines+markers') %>%
        layout(title = 'Rwanda Production Output', xaxis = list(title = year_col), yaxis = list(title = value_col))
    } else plotly_empty()
  })

  # Overview small text outputs (show latest values)
  output$overview_gdp_text <- renderText({
    if(exists('Rwanda_GDP')){
      df <- as.data.frame(Rwanda_GDP)
      last_row <- tail(df, 1)
      sprintf('%s: %s', names(df)[2], as.character(last_row[[2]]))
    } else 'No GDP data available'
  })

  output$overview_inflation_text <- renderText({
    if(exists('Rwanda_inflation')){
      df <- as.data.frame(Rwanda_inflation)
      last_row <- tail(df, 1)
      sprintf('%s: %s', names(df)[2], as.character(last_row[[2]]))
    } else 'No inflation data available'
  })

  output$overview_production_text <- renderText({
    if(exists('Rwanda_production_output')){
      df <- as.data.frame(Rwanda_production_output)
      last_row <- tail(df, 1)
      sprintf('%s: %s', names(df)[2], as.character(last_row[[2]]))
    } else 'No production data available'
  })
  
  # Hero slider - Modern CSS-based carousel
  observe({
    imgs <- c(
      "homepage.pic11.jpg.jpg",
      "homepage.pic2.jpg.jpg",
      "homepage.pic3.jpg.jpg",
      "homepage.pic4.jpg (2).jpg",
      "homepage.pic5.jpg.jpg"
    )
    
    # Create carousel HTML using the professional CSS already defined
    carousel_html <- paste0('
      <div class="carousel-container">
        <div class="carousel-track">',
      paste0('<div class="carousel-slide"><img src="', imgs, '" alt="Rwanda Development" /></div>', collapse = ''),
      '</div>
        <div class="carousel-dots">',
      paste0('<span class="dot" data-slide="', 0:(length(imgs)-1), '"></span>', collapse = ''),
      '</div>
      </div>
    ')
    
    # Insert the carousel HTML
    runjs(paste0("document.getElementById('hero_slider').innerHTML = `", carousel_html, "`;"))
  })
  
  # Interactive box click handlers
  observeEvent(input$gdp_click, {
    showModal(modalDialog(
      title = "GDP Growth Details",
      div(style = "background:#fff; padding:15px; max-height:400px; overflow-y:auto;",
        div(style = "display:flex; gap:20px; align-items:start;",
          div(style = "flex:1;",
            tags$ul(style = "list-style:none; padding:0; margin:0;",
              tags$li(style = "margin-bottom:10px;", HTML("<b>Annual Growth Rate:</b> <span style='color:#157A4A'>8.2%</span>")),
              tags$li(style = "margin-bottom:10px;", HTML("<b>Total GDP:</b> $13.7 Billion")),
              tags$li(style = "margin-bottom:10px;", HTML("<b>Key Sectors:</b> Services, Industry")),
              tags$li(HTML("<b>FDI Growth:</b> <span style='color:#157A4A'>+12%</span>"))
            )
          ),
          div(style = "flex:1; text-align:right;", plotlyOutput("gdp_trend", height = "150px"))
        )
      ),
      size = "m",
      easyClose = TRUE
    ))
  })
  
  observeEvent(input$literacy_click, {
    showModal(modalDialog(
      title = "Literacy Rate Analysis",
      div(style = "background:#fff; padding:15px; max-height:400px; overflow-y:auto;",
        div(style = "display:flex; gap:20px; align-items:start;",
          div(style = "flex:1;",
            tags$ul(style = "list-style:none; padding:0; margin:0;",
              tags$li(style = "margin-bottom:10px;", HTML("<b>Current Rate:</b> <span style='color:#157A4A'>76.3%</span>")),
              tags$li(style = "margin-bottom:10px;", HTML("<b>Youth Literacy:</b> 85.8%")),
              tags$li(style = "margin-bottom:10px;", HTML("<b>Female:</b> 74.2%")),
              tags$li(HTML("<b>Male:</b> 78.4%"))
            )
          ),
          div(style = "flex:1; text-align:right;", plotlyOutput("literacy_trend", height = "150px"))
        )
      ),
      size = "m",
      easyClose = TRUE
    ))
  })
  
  observeEvent(input$cpi_click, {
    showModal(modalDialog(
      title = "Corruption Perception Index",
      div(style = "background:#fff; padding:15px; max-height:400px; overflow-y:auto;",
        div(style = "display:flex; gap:20px; align-items:start;",
          div(style = "flex:1;",
            tags$ul(style = "list-style:none; padding:0; margin:0;",
              tags$li(style = "margin-bottom:10px;", HTML("<b>Global Rank:</b> 49th")),
              tags$li(style = "margin-bottom:10px;", HTML("<b>African Rank:</b> 3rd")),
              tags$li(style = "margin-bottom:10px;", HTML("<b>Score:</b> 69/100")),
              tags$li(HTML("<b>Change:</b> <span style='color:#157A4A'>+2 points</span>"))
            )
          ),
          div(style = "flex:1; text-align:right;", plotlyOutput("cpi_trend", height = "150px"))
        )
      ),
      size = "m",
      easyClose = TRUE
    ))
  })
  
  observeEvent(input$electricity_click, {
    showModal(modalDialog(
      title = "Electricity Access",
      div(style = "background:#fff; padding:15px; max-height:400px; overflow-y:auto;",
        div(style = "display:flex; gap:20px; align-items:start;",
          div(style = "flex:1;",
            tags$ul(style = "list-style:none; padding:0; margin:0;",
              tags$li(style = "margin-bottom:10px;", HTML("<b>National Coverage:</b> <span style='color:#157A4A'>82.5%</span>")),
              tags$li(style = "margin-bottom:10px;", HTML("<b>Rural Access:</b> 75%")),
              tags$li(style = "margin-bottom:10px;", HTML("<b>Urban Access:</b> 95%")),
              tags$li(HTML("<b>Renewable Share:</b> 52%"))
            )
          ),
          div(style = "flex:1; text-align:right;", plotlyOutput("electricity_trend", height = "150px"))
        )
      ),
      size = "m",
      easyClose = TRUE
    ))
  })
  
  observeEvent(input$life_exp_click, {
    showModal(modalDialog(
      title = "Life Expectancy",
      div(style = "background:#fff; padding:15px; max-height:400px; overflow-y:auto;",
        div(style = "display:flex; gap:20px; align-items:start;",
          div(style = "flex:1;",
            tags$ul(style = "list-style:none; padding:0; margin:0;",
              tags$li(style = "margin-bottom:10px;", HTML("<b>Current:</b> 70.2 years")),
              tags$li(style = "margin-bottom:10px;", HTML("<b>Female:</b> 72.1 years")),
              tags$li(style = "margin-bottom:10px;", HTML("<b>Male:</b> 68.3 years")),
              tags$li(HTML("<b>Change:</b> <span style='color:#157A4A'>+0.7 years</span>"))
            )
          ),
          div(style = "flex:1; text-align:right;", plotlyOutput("life_exp_trend", height = "150px"))
        )
      ),
      size = "m",
      easyClose = TRUE
    ))
  })
  
  observeEvent(input$poverty_click, {
    showModal(modalDialog(
      title = "Poverty Rate",
      div(style = "background:#fff; padding:15px; max-height:400px; overflow-y:auto;",
        div(style = "display:flex; gap:20px; align-items:start;",
          div(style = "flex:1;",
            tags$ul(style = "list-style:none; padding:0; margin:0;",
              tags$li(style = "margin-bottom:10px;", HTML("<b>Current Rate:</b> 35.6%")),
              tags$li(style = "margin-bottom:10px;", HTML("<b>Rural Poverty:</b> 40.2%")),
              tags$li(style = "margin-bottom:10px;", HTML("<b>Urban Poverty:</b> 28.7%")),
              tags$li(HTML("<b>Reduction:</b> <span style='color:#157A4A'>-2.6%</span>"))
            )
          ),
          div(style = "flex:1; text-align:right;", plotlyOutput("poverty_trend", height = "150px"))
        )
      ),
      size = "m",
      easyClose = TRUE
    ))
  })

  # Modals for logins
  observeEvent(input$inst_login, {
    showModal(modalDialog("Institution Login Portal", easyClose=TRUE))
  })
  
  observeEvent(input$review_login, {
    showModal(modalDialog("Reviewer Login Portal", easyClose=TRUE))
  })
  
  observeEvent(input$admin_login, {
    showModal(modalDialog("Admin Login Portal", easyClose=TRUE))
  })

  # Sector card click handler (from JS Shiny.setInputValue)
  observeEvent(input$sector_card_click, {
    # input comes as 'Title|random' from JS
    parts <- strsplit(as.character(input$sector_card_click), '\\|')[[1]]
    title <- parts[1]
    showModal(modalDialog(
      title = paste0(title, ' — Sector Details'),
      div(style = 'background:#fff; padding:16px;',
          tags$p(HTML(paste0('<b>', title, '</b> is a key sector for Rwanda. More detailed metrics and mini-charts can be added here.')))
      ),
      size = 'm', easyClose = TRUE
    ))
  })

  # Predictive card click handler
  observeEvent(input$predict_card_click, {
    parts <- strsplit(as.character(input$predict_card_click), '\\|')[[1]]
    id <- parts[1]
    # Create a simple modal based on id
    title <- switch(id,
                    'predict_gdp' = 'GDP Projection (2028)',
                    'predict_population' = 'Population Projection (2030)',
                    'predict_poverty' = 'Poverty Rate Projection (2029)',
                    id)
    body_html <- switch(id,
                        'predict_gdp' = tags$div('GDP projection details will appear here.'),
                        'predict_population' = tags$div('Population projection details will appear here.'),
                        'predict_poverty' = tags$div('Poverty projection details will appear here.'),
                        tags$div('No details available.')
    )
    showModal(modalDialog(
      title = title,
      body_html,
      size = 'm', easyClose = TRUE
    ))
  })

  # Sector dashboard card click handler
  observeEvent(input$sector_dashboard_click, {
    parts <- strsplit(as.character(input$sector_dashboard_click), '\\|')[[1]]
    title <- parts[1]
    showModal(modalDialog(
      title = paste0(title, ' — Dashboard'),
      div(style = 'background:#fff; padding:12px;', HTML(paste0('<p>Open the ', title, ' dashboard to explore KPIs, trends and maps for this sector.</p>'))),
      size = 'm', easyClose = TRUE
    ))
  })
  
  # Demo data for population with animation frames
  pop_base <- data.frame(
    Category = c('Total Population', 'Male', 'Female'),
    Population = c(13000000, 6300000, 6700000),
    Frame = c(1, 2, 3)  # Frame order for animation
  )
  
  # Note: pop_base contains frame information (Frame = 1,2,3). We'll use it directly in the plot.
  
  output$pop_bar <- plotly::renderPlotly({
    # Show all categories together in the overview (Total, Male, Female)
    plot_ly(
      data = pop_base,
      x = ~Category,
      y = ~Population,
      type = 'bar',
      marker = list(
        color = c('#0B78A0', '#157A4A', '#FFD100'),
        line = list(color = '#ffffff', width = 1.5)
      ),
      text = ~formatC(Population, format = "f", big.mark = ",", digits = 0),
      textposition = 'auto',
      hoverinfo = 'text',
      hovertext = ~paste(Category, "<br>", "Population: ", formatC(Population, format = "f", big.mark = ",", digits = 0))
    ) %>%
      layout(
        showlegend = FALSE,
        xaxis = list(title = "", showgrid = FALSE),
        yaxis = list(title = "Population", showgrid = TRUE, gridcolor = 'rgba(255,255,255,0.08)', range = c(0, max(pop_base$Population) * 1.15)),
        plot_bgcolor = 'transparent',
        paper_bgcolor = 'transparent',
        font = list(color = '#111'),
        margin = list(t = 10, r = 10, b = 40),
        hoverlabel = list(bgcolor = "white", font = list(size = 12))
      ) %>%
      config(displayModeBar = FALSE)
  })

  # GDP info box
  gdp_current <- 13.7 # in billion USD (example)
  gdp_last <- 12.9 # last year
  gdp_change <- round((gdp_current - gdp_last) / gdp_last * 100, 1)
  output$gdp_box <- renderUI({
    txt <- paste0(
      '<div style="display:flex; gap:12px; align-items:center; width:100%;">',
  '<div class="infobox-icon"><i class="fas fa-chart-line"></i></div>',
        '<div style="flex:1;">',
          '<div style="font-weight:700; font-size:1.22em; color:#000; margin-bottom:12px; text-align:left;">GDP Growth</div>',
          '<div style="font-size:2.8em; font-weight:600; color:#0B78A0; margin-bottom:auto;">', gdp_change, '%</div>',
          '<div style="font-size:0.95em; color:', ifelse(gdp_change>=0,'#157A4A','#ff4444'), '; display:flex; align-items:center; gap:4px; margin-top:auto;">',
            '<span>', ifelse(gdp_change>=0,'↑','↓'), '</span>',
            ifelse(gdp_change>=0,'+',''), gdp_change, '% from last year</div>',
        '</div>',
      '</div>'
    )
    HTML(txt)
  })
  
  # Literacy info box data
  literacy <- c('2022' = 73.2, '2023' = 74.1, '2024' = 75.0, '2025' = 76.3) # example
  literacy_change <- round((literacy["2025"] - literacy["2024"]) / literacy["2024"] * 100, 1)
  
  # Corruption Perception Index data
  cpi <- c('2024' = 67, '2025' = 69) # example (0-100 scale, higher is better)
  cpi_change <- round((cpi["2025"] - cpi["2024"]), 1)
  output$cpi_box <- renderUI({
    txt <- paste0(
      '<div style="display:flex; gap:12px; align-items:center; width:100%;">',
  '<div class="infobox-icon"><i class="fas fa-gavel"></i></div>',
        '<div style="flex:1;">',
          '<div style="font-weight:700; font-size:1.22em; color:#000; margin-bottom:12px; text-align:left;">Corruption Perception Index</div>',
          '<div style="font-size:2.8em; font-weight:600; color:#0B78A0; margin-bottom:auto;">', cpi["2025"], '</div>',
          '<div style="font-size:0.95em; color:', ifelse(cpi_change>=0,'#157A4A','#ff4444'), '; display:flex; align-items:center; gap:4px; margin-top:auto;">',
            '<span>', ifelse(cpi_change>=0,'↑','↓'), '</span>',
            ifelse(cpi_change>=0,'+',''), cpi_change, ' points from last year</div>',
        '</div>',
      '</div>'
    )
    HTML(txt)
  })
  
  # Electricity Access data
  electricity <- c('2024' = 75.2, '2025' = 82.5) # example percentage
  electricity_change <- round((electricity["2025"] - electricity["2024"]), 1)
  output$electricity_box <- renderUI({
    txt <- paste0(
      '<div style="display:flex; gap:12px; align-items:center; width:100%;">',
  '<div class="infobox-icon"><i class="fas fa-bolt"></i></div>',
        '<div style="flex:1;">',
          '<div style="font-weight:700; font-size:1.22em; color:#000; margin-bottom:12px; text-align:left;">Electricity Access</div>',
          '<div style="font-size:2.8em; font-weight:600; color:#0B78A0; margin-bottom:auto;">', electricity["2025"], '%</div>',
          '<div style="font-size:0.95em; color:', ifelse(electricity_change>=0,'#157A4A','#ff4444'), '; display:flex; align-items:center; gap:4px; margin-top:auto;">',
            '<span>', ifelse(electricity_change>=0,'↑','↓'), '</span>',
            ifelse(electricity_change>=0,'+',''), electricity_change, '% from last year</div>',
        '</div>',
      '</div>'
    )
    HTML(txt)
  })
  
  # Life Expectancy data
  life_exp <- c('2024' = 69.5, '2025' = 70.2) # example years
  life_exp_change <- round((life_exp["2025"] - life_exp["2024"]), 1)
  output$life_exp_box <- renderUI({
    txt <- paste0(
      '<div style="display:flex; gap:12px; align-items:center; width:100%;">',
  '<div class="infobox-icon"><i class="fas fa-heartbeat"></i></div>',
        '<div style="flex:1;">',
          '<div style="font-weight:700; font-size:1.22em; color:#000; margin-bottom:12px; text-align:left;">Life Expectancy</div>',
          '<div style="font-size:2.8em; font-weight:600; color:#0B78A0; margin-bottom:auto;">', life_exp["2025"], '</div>',
          '<div style="font-size:0.95em; color:', ifelse(life_exp_change>=0,'#157A4A','#ff4444'), '; display:flex; align-items:center; gap:4px; margin-top:auto;">',
            '<span>', ifelse(life_exp_change>=0,'↑','↓'), '</span>',
            ifelse(life_exp_change>=0,'+',''), life_exp_change, ' years from last year</div>',
        '</div>',
      '</div>'
    )
    HTML(txt)
  })
  
  # Poverty Rate data
  poverty <- c('2024' = 38.2, '2025' = 35.6) # example percentage
  poverty_change <- round((poverty["2025"] - poverty["2024"]), 1)
  output$poverty_box <- renderUI({
    txt <- paste0(
      '<div style="display:flex; gap:12px; align-items:center; width:100%;">',
  '<div class="infobox-icon"><i class="fas fa-chart-area"></i></div>',
        '<div style="flex:1;">',
          '<div style="font-weight:700; font-size:1.22em; color:#000; margin-bottom:12px; text-align:left;">Poverty Rate</div>',
          '<div style="font-size:2.8em; font-weight:600; color:#0B78A0; margin-bottom:auto;">', poverty["2025"], '%</div>',
          '<div style="font-size:0.95em; color:', ifelse(poverty_change<0,'#157A4A','#ff4444'), '; display:flex; align-items:center; gap:4px; margin-top:auto;">',
            '<span>', ifelse(poverty_change<0,'↓','↑'), '</span>',
            ifelse(poverty_change<0,'','+'), poverty_change, '% from last year</div>',
        '</div>',
      '</div>'
    )
    HTML(txt)
  })

  # --- placeholders for standalone economic dashboard (renderers removed from in-page view)

  output$literacy_box <- renderUI({
    txt <- paste0(
      '<div style="display:flex; gap:12px; align-items:center; width:100%;">',
  '<div class="infobox-icon"><i class="fas fa-book"></i></div>',
        '<div style="flex:1;">',
          '<div style="font-weight:700; font-size:1.22em; color:#000; margin-bottom:12px; text-align:left;">Literacy Rate</div>',
          '<div style="font-size:2.8em; font-weight:600; color:#0B78A0; margin-bottom:auto;">', literacy["2025"], '%</div>',
          '<div style="font-size:0.95em; color:', ifelse(literacy_change>=0,'#157A4A','#ff4444'), '; display:flex; align-items:center; gap:4px; margin-top:auto;">',
            '<span>', ifelse(literacy_change>=0,'↑','↓'), '</span>',
            ifelse(literacy_change>=0,'+',''), literacy_change, '% from last year</div>',
        '</div>',
      '</div>'
    )
    HTML(txt)
  })


  # --- Login handling for NDIP (demo accounts) ---
  observeEvent(input$ndip_signin, {
    req(input$ndip_email)
    req(input$ndip_password)
    email <- tolower(trimws(input$ndip_email))
    pwd <- input$ndip_password

    # Demo credentials
    demo_accounts <- list(
      admin = list(email = 'admin@nisr.gov.rw', password = 'demo123', role = 'Admin'),
      institution = list(email = 'health@moh.gov.rw', password = 'demo123', role = 'Institution'),
      reviewer = list(email = 'reviewer@nisr.gov.rw', password = 'demo123', role = 'Reviewer')
    )

    matched <- NULL
    for(acc in demo_accounts){
      if(email == acc$email && pwd == acc$password){ matched <- acc; break }
    }

    if(!is.null(matched)){
      # store current user in session and navigate immediately
      session$userData$current_user <- matched
      if(!is.null(matched$role) && tolower(matched$role) == 'admin'){
          # For admin, navigate to admin dashboard page
          session$userData$show_admin <- TRUE
          
          # Close the login overlay and navigate to admin page
          session$sendCustomMessage(type = 'setHash', message = list(hash = '#admin'))
      } else {
          # For institution and reviewer accounts, navigate to institution dashboard page
          session$userData$show_institution <- TRUE
          
          # Close the login overlay and navigate to institution page
          session$sendCustomMessage(type = 'setHash', message = list(hash = '#institution'))
      }
    } else {
      showModal(modalDialog(
        title = 'Login failed',
        'Invalid email or password. Use one of the demo accounts listed on the page.',
        easyClose = TRUE
      ))
    }
  })

  # Admin dashboard chart
  output$admin_chart <- renderPlotly({
    months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep")
    subs <- c(15, 20, 24, 32, 28, 35, 46, 38, 12)
    
    plot_ly(x = months, y = subs, type = 'scatter', mode = 'lines+markers', 
            line = list(color = '#2563eb'), 
            marker = list(color = '#2563eb', size = 8)) %>%
      layout(
        xaxis = list(title = 'Month', gridcolor = '#e5e7eb'),
        yaxis = list(title = 'Submissions', gridcolor = '#e5e7eb'),
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        font = list(color = '#374151')
      )
  })
  
  # Institution dashboard chart
  output$institution_chart <- renderPlotly({
    months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep")
    
    if(!is.null(session$userData$current_user) && session$userData$current_user$role == "Institution") {
      # Institution view - submission trends
      submissions <- c(2, 3, 1, 4, 3, 2, 5, 4, 1)
      plot_ly(x = months, y = submissions, type = 'scatter', mode = 'lines+markers', 
              line = list(color = '#0ea5e9'), 
              marker = list(color = '#0ea5e9', size = 8)) %>%
        layout(
          xaxis = list(title = 'Month', gridcolor = '#e5e7eb'),
          yaxis = list(title = 'Submissions', gridcolor = '#e5e7eb'),
          plot_bgcolor = '#ffffff',
          paper_bgcolor = '#ffffff',
          font = list(color = '#374151')
        )
    } else {
      # Reviewer view - review activity
      reviews <- c(5, 8, 6, 12, 9, 7, 15, 11, 4)
      plot_ly(x = months, y = reviews, type = 'scatter', mode = 'lines+markers', 
              line = list(color = '#10b981'), 
              marker = list(color = '#10b981', size = 8)) %>%
        layout(
          xaxis = list(title = 'Month', gridcolor = '#e5e7eb'),
          yaxis = list(title = 'Reviews Completed', gridcolor = '#e5e7eb'),
          plot_bgcolor = '#ffffff',
          paper_bgcolor = '#ffffff',
          font = list(color = '#374151')
        )
    }
  })
  
  # Admin Dashboard Outputs
  output$admin_total_submissions <- renderText({
    nrow(submissions_data())
  })
  
  output$admin_submission_growth <- renderText({
    "+12% from last month"
  })
  
  output$admin_pending_reviews <- renderText({
    nrow(submissions_data()[submissions_data()$status == "Pending", ])
  })
  
  output$admin_avg_processing <- renderText({
    "Avg. processing: 2.3 days"
  })
  
  output$admin_approval_rate <- renderText({
    approved <- nrow(submissions_data()[submissions_data()$status == "Approved", ])
    total <- nrow(submissions_data())
    paste0(round((approved/total) * 100, 1), "%")
  })
  
  output$admin_performance <- renderText({
    "Excellent performance"
  })
  
  output$admin_active_institutions <- renderText({
    "12/15"
  })
  
  output$admin_participation <- renderText({
    "80% participation"
  })
  
  # Institution Dashboard Outputs
  output$inst_welcome_message <- renderText({
    if(!is.null(session$userData$current_user)) {
      paste("Welcome,", session$userData$current_user$role, "!")
    } else {
      "Welcome, Institution!"
    }
  })
  
  output$inst_my_submissions <- renderText({
    nrow(inst_submissions_data())
  })
  
  output$inst_last_updated <- renderText({
    "Last updated: 2 days ago"
  })
  
  output$inst_approval_rate <- renderText({
    approved <- nrow(inst_submissions_data()[inst_submissions_data()$status == "Approved", ])
    total <- nrow(inst_submissions_data())
    if(total > 0) {
      paste0(round((approved/total) * 100, 1), "%")
    } else {
      "0%"
    }
  })
  
  output$inst_performance <- renderText({
    "Above average"
  })
  
  output$inst_pending_updates <- renderText({
    nrow(inst_submissions_data()[inst_submissions_data()$status == "Pending", ])
  })
  
  output$inst_due_date <- renderText({
    "Due this week"
  })
  
  # Data Tables
  submissions_data <- reactive({
    data.frame(
      id = 1:20,
      title = paste("Data Submission", 1:20),
      institution = c(rep("Ministry of Health", 5), rep("Ministry of Education", 5), rep("Ministry of Agriculture", 5), rep("NISR", 5)),
      category = sample(c("Health", "Education", "Agriculture", "Economic"), 20, replace = TRUE),
      status = sample(c("Pending", "Approved", "Rejected"), 20, replace = TRUE, prob = c(0.3, 0.6, 0.1)),
      submitted_date = Sys.Date() - sample(1:30, 20, replace = TRUE),
      reviewer = sample(c("Admin User", "Reviewer 1", "Reviewer 2"), 20, replace = TRUE),
      stringsAsFactors = FALSE
    )
  })
  
  inst_submissions_data <- reactive({
    data.frame(
      id = 1:15,
      title = paste("My Submission", 1:15),
      category = sample(c("Health", "Education", "Agriculture", "Economic"), 15, replace = TRUE),
      status = sample(c("Pending", "Approved", "Rejected"), 15, replace = TRUE, prob = c(0.2, 0.7, 0.1)),
      submitted_date = Sys.Date() - sample(1:30, 15, replace = TRUE),
      reviewer = sample(c("Admin User", "Reviewer 1", "Reviewer 2"), 15, replace = TRUE),
      stringsAsFactors = FALSE
    )
  })
  
  # Admin Data Tables
  output$admin_recent_activity <- DT::renderDataTable({
    recent_activity <- data.frame(
      time = Sys.time() - runif(10, 0, 3600),
      action = sample(c("New submission", "Approved data", "Rejected data", "User login", "System backup"), 10, replace = TRUE),
      user = sample(c("Admin", "Reviewer 1", "Ministry of Health", "NISR"), 10, replace = TRUE),
      details = paste("Action performed on", sample(c("Health Data", "Education Data", "Economic Data"), 10, replace = TRUE)),
      stringsAsFactors = FALSE
    )
    
    DT::datatable(recent_activity, 
                  options = list(pageLength = 5, dom = 't', ordering = FALSE),
                  rownames = FALSE) %>%
      DT::formatStyle(columns = 1:4, fontSize = '12px')
  })
  
  output$admin_submissions_table <- DT::renderDataTable({
    data <- submissions_data()
    if(input$submission_filter != "All") {
      data <- data[data$status == input$submission_filter, ]
    }
    
    DT::datatable(data, 
                  options = list(pageLength = 10, dom = 'frtip'),
                  rownames = FALSE,
                  selection = 'single') %>%
      DT::formatStyle(columns = 1:7, fontSize = '12px') %>%
      DT::formatDate(columns = 6, method = 'toLocaleDateString')
  })
  
  output$admin_users_table <- DT::renderDataTable({
    users_data <- data.frame(
      id = 1:25,
      name = paste("User", 1:25),
      email = paste("user", 1:25, "@example.com"),
      role = sample(c("Admin", "Reviewer", "Institution"), 25, replace = TRUE, prob = c(0.1, 0.3, 0.6)),
      institution = sample(c("Ministry of Health", "Ministry of Education", "NISR", "Ministry of Agriculture"), 25, replace = TRUE),
      status = sample(c("Active", "Inactive"), 25, replace = TRUE, prob = c(0.9, 0.1)),
      last_login = Sys.Date() - sample(1:30, 25, replace = TRUE),
      stringsAsFactors = FALSE
    )
    
    DT::datatable(users_data, 
                  options = list(pageLength = 10, dom = 'frtip'),
                  rownames = FALSE,
                  selection = 'single') %>%
      DT::formatStyle(columns = 1:7, fontSize = '12px') %>%
      DT::formatDate(columns = 7, method = 'toLocaleDateString')
  })
  
  # Institution Data Tables
  output$inst_recent_submissions <- DT::renderDataTable({
    recent_data <- inst_submissions_data()[1:5, ]
    
    DT::datatable(recent_data, 
                  options = list(pageLength = 5, dom = 't', ordering = FALSE),
                  rownames = FALSE) %>%
      DT::formatStyle(columns = 1:6, fontSize = '12px') %>%
      DT::formatDate(columns = 5, method = 'toLocaleDateString')
  })
  
  output$inst_submissions_table <- DT::renderDataTable({
    data <- inst_submissions_data()
    if(input$inst_submission_filter != "All") {
      data <- data[data$status == input$inst_submission_filter, ]
    }
    
    DT::datatable(data, 
                  options = list(pageLength = 10, dom = 'frtip'),
                  rownames = FALSE,
                  selection = 'single') %>%
      DT::formatStyle(columns = 1:6, fontSize = '12px') %>%
      DT::formatDate(columns = 5, method = 'toLocaleDateString')
  })
  
  output$inst_analytics_table <- DT::renderDataTable({
    analytics_data <- data.frame(
      metric = c("Data Quality Score", "Submission Frequency", "Approval Rate", "Response Time", "Data Completeness"),
      value = c("92%", "3.2/week", "87%", "1.8 days", "94%"),
      trend = c("↗ +5%", "↗ +12%", "↗ +3%", "↘ -0.5 days", "↗ +2%"),
      benchmark = c("85%", "2.5/week", "80%", "2.0 days", "90%"),
      stringsAsFactors = FALSE
    )
    
    DT::datatable(analytics_data, 
                  options = list(pageLength = 10, dom = 't', ordering = FALSE),
                  rownames = FALSE) %>%
      DT::formatStyle(columns = 1:4, fontSize = '12px')
  })
  
  # Additional Charts
  output$admin_institution_chart <- renderPlotly({
    institutions <- c("Ministry of Health", "Ministry of Education", "NISR", "Ministry of Agriculture", "Ministry of Finance")
    submissions <- c(45, 38, 52, 41, 35)
    
    plot_ly(x = submissions, y = institutions, type = 'bar', orientation = 'h',
            marker = list(color = '#2563eb')) %>%
      layout(
        title = "",
        xaxis = list(title = 'Submissions'),
        yaxis = list(title = ''),
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        font = list(color = '#374151')
      )
  })
  
  output$inst_performance_chart <- renderPlotly({
    months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun")
    performance <- c(85, 88, 92, 89, 94, 91)
    
    plot_ly(x = months, y = performance, type = 'scatter', mode = 'lines+markers',
            line = list(color = '#0ea5e9', width = 3),
            marker = list(color = '#0ea5e9', size = 8)) %>%
      layout(
        title = "",
        xaxis = list(title = 'Month'),
        yaxis = list(title = 'Performance Score'),
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        font = list(color = '#374151')
      )
  })
  
  output$inst_quality_chart <- renderPlotly({
    categories <- c("Completeness", "Accuracy", "Timeliness", "Consistency", "Validity")
    scores <- c(94, 89, 92, 87, 91)
    
    plot_ly(x = categories, y = scores, type = 'bar',
            marker = list(color = '#10b981')) %>%
      layout(
        title = "",
        xaxis = list(title = 'Quality Dimension'),
        yaxis = list(title = 'Score (%)'),
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        font = list(color = '#374151')
      )
  })
  
  # Admin Dashboard Button Handlers
  observeEvent(input$refresh_submissions, {
    showNotification("Submissions data refreshed!", type = "success")
  })
  
  observeEvent(input$add_user, {
    showModal(modalDialog(
      title = "Add New User",
      div(
        textInput("new_user_name", "Full Name:", width = "100%"),
        textInput("new_user_email", "Email:", width = "100%"),
        selectInput("new_user_role", "Role:", choices = c("Admin", "Reviewer", "Institution"), width = "100%"),
        selectInput("new_user_institution", "Institution:", choices = c("Ministry of Health", "Ministry of Education", "NISR", "Ministry of Agriculture"), width = "100%"),
        br(),
        div(style = "display: flex; gap: 8px;",
          actionButton("confirm_add_user", "Add User", class = "btn btn-primary"),
          actionButton("cancel_add_user", "Cancel", class = "btn btn-secondary")
        )
      ),
      size = "m",
      easyClose = TRUE
    ))
  })
  
  observeEvent(input$confirm_add_user, {
    removeModal()
    showNotification("User added successfully!", type = "success")
  })
  
  observeEvent(input$cancel_add_user, {
    removeModal()
  })
  
  observeEvent(input$export_users, {
    showNotification("User data exported to CSV!", type = "success")
  })
  
  observeEvent(input$save_settings, {
    showNotification("Settings saved successfully!", type = "success")
  })
  
  observeEvent(input$test_connection, {
    showNotification("Database connection test successful!", type = "success")
  })
  
  # Institution Dashboard Button Handlers
  observeEvent(input$quick_submit, {
    updateTabsetPanel(session, "inst_tab", "submissions")
  })
  
  observeEvent(input$quick_view, {
    updateTabsetPanel(session, "inst_tab", "submissions")
  })
  
  observeEvent(input$quick_analytics, {
    updateTabsetPanel(session, "inst_tab", "analytics")
  })
  
  observeEvent(input$submit_data, {
    if(is.null(input$data_file)) {
      showNotification("Please select a file to upload!", type = "error")
      return()
    }
    if(input$data_title == "") {
      showNotification("Please enter a data title!", type = "error")
      return()
    }
    
    showNotification("Data submitted successfully! It will be reviewed within 2-3 business days.", type = "success")
    
    # Reset form
    updateTextInput(session, "data_title", value = "")
    updateTextAreaInput(session, "data_description", value = "")
  })
  
  observeEvent(input$save_draft, {
    showNotification("Draft saved successfully!", type = "success")
  })
  
  observeEvent(input$refresh_inst_submissions, {
    showNotification("Submissions data refreshed!", type = "success")
  })
  
  observeEvent(input$update_profile, {
    showNotification("Profile updated successfully!", type = "success")
  })
  
  observeEvent(input$update_notifications, {
    showNotification("Notification settings updated!", type = "success")
  })
  
  # Tab Navigation Handlers
  observeEvent(input$admin_tab, {
    # Tab switching is handled by conditionalPanel
  })
  
  observeEvent(input$inst_tab, {
    # Tab switching is handled by conditionalPanel
  })

  
}

shinyApp(ui, server)



