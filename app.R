# ============================================================================
# NDIP PROJECT 1 - Main Application File
# ============================================================================
# This file has been refactored to use a modular structure
# Modules are sourced from the modules/ directory
# ============================================================================

# Source global configuration and data loading
source("modules/global.R")

# Source database connection
source("scripts/db_connection.R")

# Source login module
source("modules/login_module.R")

# Source role-specific dashboards (Phase 3)
source("modules/admin_dashboard.R")
source("modules/reviewer_dashboard.R")
source("modules/institution_dashboard.R")

# Source all dashboard modules
source("modules/economic_dashboard_module.R")
source("modules/demographics_agriculture_dashboard_module.R")
source("modules/health_education_dashboard_module.R")

custom_css <- "/* Premium Professional NDIP Styling - Classy & Sophisticated */

/* Force no bottom spacing anywhere - CRITICAL FIX */
html, body {
  margin: 0 !important;
  padding: 0 !important;
  height: 100%;
  overflow-x: hidden;
}

/* Target all possible containers */
body > div,
body > div:last-child,
.container-fluid,
.container-fluid > *:last-child,
.shiny-html-output,
div[style*='width:100vw'] {
  margin-bottom: 0 !important;
  padding-bottom: 0 !important;
}

/* Force footer to bottom */
body > div:last-of-type {
  margin-bottom: 0 !important;
}

* {
  box-sizing: border-box;
}

:root {
  --primary-blue: #0B78A0;
  --primary-blue-dark: #085a75;
  --primary-blue-light: #0ea5e9;
  --secondary-green: #157A4A;
  --secondary-green-dark: #0f5a36;
  --accent-gold: #f59e0b;
  --text-primary: #0f172a;
  --text-secondary: #475569;
  --text-muted: #64748b;
  --bg-primary: #ffffff;
  --bg-secondary: #f8fafc;
  --bg-tertiary: #f1f5f9;
  --border-light: #e2e8f0;
  --border-medium: #cbd5e1;
  --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
  --shadow-2xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  --shadow-colored: 0 10px 30px -5px rgba(11, 120, 160, 0.15);
}

html, body { 
  scroll-behavior: smooth; 
  height: 100%;
  margin: 0;
  padding: 0;
  overflow-x: hidden;
}

body { 
  background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; 
  color: var(--text-primary); 
  line-height: 1.7;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  width: 100%;
  max-width: 100vw;
  font-weight: 400;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* Premium Navbar - Glassmorphism & Elegant */
html {
  scroll-behavior: smooth;
}

.topnav { 
  display: flex; 
  align-items: center; 
  justify-content: center; 
  position: fixed; 
  top: 24px; 
  left: 50%; 
  transform: translateX(-50%); 
  z-index: 1000; 
  width: calc(100% - 48px); 
  max-width: 1400px; 
  padding: 16px 32px; 
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(20px) saturate(180%);
  -webkit-backdrop-filter: blur(20px) saturate(180%);
  border-radius: 20px; 
  box-shadow: var(--shadow-xl), 0 0 0 1px rgba(255, 255, 255, 0.5) inset;
  border: 1px solid rgba(226, 232, 240, 0.8);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.topnav:hover {
  background: rgba(255, 255, 255, 0.95);
  box-shadow: var(--shadow-2xl), 0 0 0 1px rgba(255, 255, 255, 0.6) inset;
  transform: translateX(-50%) translateY(-2px);
}

/* Premium Infobox cards - Glassmorphism & Elegant */
.infobox {
  padding: 28px;
  border-radius: 20px;
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  cursor: pointer;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  box-shadow: var(--shadow-md);
  border: 1px solid rgba(226, 232, 240, 0.8);
  position: relative;
  overflow: hidden;
}

.infobox::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, var(--primary-blue), var(--secondary-green));
  transform: scaleX(0);
  transform-origin: left;
  transition: transform 0.4s ease;
}

.infobox:hover::before {
  transform: scaleX(1);
}

.infobox:hover, .infobox:focus {
  transform: translateY(-8px) scale(1.02);
  box-shadow: var(--shadow-2xl), var(--shadow-colored);
  background: rgba(255, 255, 255, 0.95);
  border-color: rgba(11, 120, 160, 0.3);
}

.infobox h4 { 
  margin: 0 0 12px 0; 
  font-size: 18px; 
  color: var(--text-primary);
  font-weight: 700;
  letter-spacing: -0.3px;
}

.infobox .infobox-value { 
  font-size: 28px; 
  color: var(--primary-blue); 
  font-weight: 800;
  letter-spacing: -0.5px;
}

.infobox.gdp { 
  background: linear-gradient(135deg, rgba(232, 246, 251, 0.9) 0%, rgba(223, 243, 251, 0.9) 100%);
  border-left: 4px solid var(--primary-blue);
}

.infobox.inflation { 
  background: linear-gradient(135deg, rgba(238, 247, 251, 0.9) 0%, rgba(230, 241, 251, 0.9) 100%);
  border-left: 4px solid var(--primary-blue-light);
}

.infobox.production { 
  background: linear-gradient(135deg, rgba(255, 246, 246, 0.9) 0%, rgba(255, 239, 239, 0.9) 100%);
  border-left: 4px solid var(--secondary-green);
}

/* subtle pulse when new data loads */
@keyframes pulseBg {
  0% { box-shadow: 0 6px 18px rgba(11,120,160,0.04); }
  50% { box-shadow: 0 22px 44px rgba(11,120,160,0.14); }
  100% { box-shadow: 0 6px 18px rgba(11,120,160,0.04); }
}
.infobox.pulse { animation: pulseBg 1.6s ease-in-out 1; }

.brand { 
  font-weight: 800; 
  color: var(--primary-blue); 
  font-size: 20px; 
  margin-right: 40px;
  letter-spacing: -0.5px;
  background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-light) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  transition: all 0.3s ease;
}

.brand:hover {
  transform: scale(1.05);
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
  color: var(--text-secondary); 
  text-decoration: none; 
  font-weight: 600; 
  font-size: 15px; 
  padding: 10px 20px; 
  border-radius: 12px; 
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
  cursor: pointer;
  display: inline-block;
}

.navlinks a.nav-link.active {
  color: var(--primary-blue);
  background: rgba(11, 120, 160, 0.1);
  transform: scale(1.05);
}

.navlinks a::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(11, 120, 160, 0.1) 0%, rgba(21, 122, 74, 0.1) 100%);
  opacity: 0;
  transition: opacity 0.3s ease;
  border-radius: 12px;
}

.navlinks a:hover::before,
.navlinks a.nav-link.active::before {
  opacity: 1;
}

.navlinks a:hover,
.navlinks a.nav-link.active { 
  background: rgba(11, 120, 160, 0.08);
  color: var(--primary-blue);
  transform: translateY(-2px);
}

.nav-cta .cta-btn { 
  background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-light) 100%);
  color: #ffffff; 
  padding: 12px 24px; 
  border-radius: 12px; 
  font-weight: 700; 
  text-decoration: none; 
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: var(--shadow-md);
  position: relative;
  overflow: hidden;
}

.nav-cta .cta-btn::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
  transition: left 0.5s ease;
}

.nav-cta .cta-btn:hover::before {
  left: 100%;
}

.nav-cta .cta-btn:hover { 
  background: linear-gradient(135deg, var(--primary-blue-dark) 0%, var(--primary-blue) 100%);
  transform: translateY(-2px);
  box-shadow: var(--shadow-lg);
}

/* Responsive Navbar */
/* Hamburger Menu Button */
.hamburger {
  display: none;
  flex-direction: column;
  gap: 5px;
  background: none;
  border: none;
  cursor: pointer;
  padding: 8px;
  z-index: 1001;
}

.hamburger span {
  display: block;
  width: 25px;
  height: 3px;
  background: var(--primary-blue);
  border-radius: 3px;
  transition: all 0.3s ease;
}

.hamburger.active span:nth-child(1) {
  transform: rotate(45deg) translate(8px, 8px);
}

.hamburger.active span:nth-child(2) {
  opacity: 0;
}

.hamburger.active span:nth-child(3) {
  transform: rotate(-45deg) translate(7px, -7px);
}

/* Mobile Responsive Styles */
@media (max-width: 1024px) {
  .topnav {
    width: calc(100% - 32px);
    padding: 12px 20px;
  }
  
  .topnav-inner {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
  }
  
  .brand {
    font-size: 18px;
  }
  
  .navlinks {
    gap: 20px;
  }
  
  .navlinks a {
    font-size: 14px;
    padding: 8px 16px;
  }
}

@media (max-width: 768px) { 
  .topnav { 
    width: calc(100% - 20px); 
    padding: 10px 16px; 
    top: 12px;
  } 
  
  .topnav-inner {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
  }
  
  .brand {
    font-size: 16px;
    font-weight: 800;
  }
  
  .hamburger {
    display: flex;
    order: 2;
  }
  
  .navlinks { 
    position: fixed;
    top: 70px;
    right: -100%;
    width: 280px;
    max-width: 85vw;
    height: calc(100vh - 70px);
    background: rgba(255, 255, 255, 0.98);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    flex-direction: column;
    gap: 0;
    padding: 20px 0;
    box-shadow: -4px 0 20px rgba(0, 0, 0, 0.15);
    transition: right 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    z-index: 1000;
    overflow-y: auto;
  }
  
  .navlinks.active {
    right: 0;
  }
  
  .navlinks a {
    font-size: 16px;
    padding: 16px 30px;
    border-radius: 0;
    width: 100%;
    text-align: left;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    margin: 0;
    display: block;
  }
  
  .navlinks a:hover,
  .navlinks a:active {
    background: rgba(11, 120, 160, 0.1);
    transform: translateX(5px);
    color: var(--primary-blue);
  }
  
  .navlinks .login-btn {
    margin-top: 8px;
    border-top: 2px solid rgba(11, 120, 160, 0.1);
    padding-top: 20px;
  }
  
  .nav-cta { 
    display: none; 
  }
}

@media (max-width: 480px) {
  .topnav {
    width: calc(100% - 16px);
    padding: 8px 12px;
    top: 8px;
  }
  
  .brand {
    font-size: 14px;
  }
  
  .navlinks {
    width: 260px;
    max-width: 90vw;
  }
  
  .navlinks a {
    font-size: 15px;
    padding: 14px 24px;
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
  background: linear-gradient(135deg, rgba(11, 120, 160, 0.1) 0%, rgba(21, 122, 74, 0.1) 100%);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  color: var(--primary-blue); 
  padding: 8px 16px; 
  border-radius: 24px; 
  font-weight: 700; 
  font-size: 14px; 
  margin-bottom: 20px;
  border: 1px solid rgba(11, 120, 160, 0.2);
  box-shadow: var(--shadow-sm);
  letter-spacing: 0.5px;
  transition: all 0.3s ease;
}

.hero-left .badge:hover {
  transform: scale(1.05);
  box-shadow: var(--shadow-md);
}

.hero-left .hero-title { 
  font-size: 56px; 
  font-weight: 900; 
  color: var(--text-primary);
  margin: 0 0 20px 0; 
  line-height: 1.1;
  letter-spacing: -1.5px;
  background: linear-gradient(135deg, var(--text-primary) 0%, var(--primary-blue) 50%, var(--secondary-green) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  background-size: 200% auto;
  animation: gradient-shift 8s ease infinite;
}

@keyframes gradient-shift {
  0%, 100% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
}

.hero-left .hero-sub { 
  font-size: 22px; 
  color: var(--text-secondary); 
  margin-bottom: 40px; 
  line-height: 1.6;
  font-weight: 400;
  letter-spacing: -0.2px;
}

.hero-left .hero-ctas { 
  display: flex; 
  gap: 16px; 
  margin-bottom: 40px; 
}

.hero-left .btn-primary { 
  background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-light) 100%);
  color: #ffffff; 
  padding: 16px 32px; 
  border-radius: 14px; 
  font-weight: 700; 
  text-decoration: none; 
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  border: none; 
  cursor: pointer; 
  box-shadow: var(--shadow-lg);
  position: relative;
  overflow: hidden;
  letter-spacing: 0.3px;
}

.hero-left .btn-primary::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
  transition: left 0.5s ease;
}

.hero-left .btn-primary:hover::before {
  left: 100%;
}

.hero-left .btn-primary:hover { 
  background: linear-gradient(135deg, var(--primary-blue-dark) 0%, var(--primary-blue) 100%);
  transform: translateY(-3px);
  box-shadow: var(--shadow-xl), var(--shadow-colored);
}

.hero-left .btn-outline { 
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 2px solid rgba(11, 120, 160, 0.3); 
  color: var(--primary-blue); 
  padding: 14px 30px; 
  border-radius: 14px; 
  text-decoration: none; 
  font-weight: 700; 
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: var(--shadow-md);
  letter-spacing: 0.3px;
}

.hero-left .btn-outline:hover { 
  background: rgba(255, 255, 255, 1);
  border-color: var(--primary-blue);
  color: var(--primary-blue-dark);
  transform: translateY(-3px);
  box-shadow: var(--shadow-lg);
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
  border-radius: 24px; 
  box-shadow: var(--shadow-2xl), 0 0 0 1px rgba(255, 255, 255, 0.1) inset;
  border: 1px solid rgba(226, 232, 240, 0.5);
  transition: all 0.3s ease;
}

.carousel-container:hover {
  box-shadow: var(--shadow-2xl), 0 0 40px rgba(11, 120, 160, 0.2);
  transform: scale(1.01);
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
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border-radius: 24px; 
  padding: 36px 28px; 
  box-shadow: var(--shadow-lg);
  border: 1px solid rgba(226, 232, 240, 0.8);
  display: flex; 
  gap: 24px; 
  align-items: center; 
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
}

.stat-card::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(11, 120, 160, 0.03) 0%, rgba(21, 122, 74, 0.03) 100%);
  opacity: 0;
  transition: opacity 0.4s ease;
}

.stat-card:hover::after {
  opacity: 1;
}

.stat-card:hover {
  transform: translateY(-8px) scale(1.02);
  box-shadow: var(--shadow-2xl), var(--shadow-colored);
  border-color: rgba(11, 120, 160, 0.2);
}

.stat-card .stat-icon { 
  width: 72px; 
  height: 72px; 
  border-radius: 20px; 
  background: linear-gradient(135deg, rgba(11, 120, 160, 0.1) 0%, rgba(21, 122, 74, 0.1) 100%);
  display: flex; 
  align-items: center; 
  justify-content: center; 
  color: var(--primary-blue); 
  font-size: 28px; 
  flex-shrink: 0;
  box-shadow: var(--shadow-md);
  transition: all 0.3s ease;
  position: relative;
  z-index: 1;
}

.stat-card:hover .stat-icon {
  transform: scale(1.1) rotate(5deg);
  background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-green) 100%);
  color: white;
  box-shadow: var(--shadow-lg);
}

.stat-card .num { 
  font-size: 36px; 
  font-weight: 900; 
  color: var(--text-primary); 
  line-height: 1.1; 
  margin-bottom: 6px;
  letter-spacing: -1px;
  background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-green) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
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

/* Layout helpers to keep hero/overview content centered without negative margins */
.section-inner {
  max-width: 1100px;
  width: 100%;
  margin: 0 auto;
}

.overview-row {
  display:flex;
  gap:24px;
  align-items:stretch;
  justify-content:flex-start;
  flex-wrap:wrap;
  width:100%;
}

.overview-chart {
  flex:1.5 1 360px;
  min-width:280px;
  margin:0;
}

.overview-card-stack {
  flex:1 1 320px;
  display:flex;
  flex-direction:column;
  gap:20px;
  width:100%;
}

.overview-grid {
  display:grid;
  grid-template-columns:repeat(auto-fit, minmax(240px, 1fr));
  gap:24px;
  width:100%;
  align-items:stretch;
}

.overview-grid .animated-infobox,
.overview-card-stack .animated-infobox {
  width:100%;
  min-width:0;
  box-sizing:border-box;
  min-height:220px;
  display:flex;
  flex-direction:column;
}

.overview-grid .animated-infobox {
  max-width:100%;
}

@media (max-width: 1200px) {
  .overview-grid {
    grid-template-columns:repeat(auto-fit, minmax(220px, 1fr));
    gap:20px;
  }
}

@media (max-width: 768px) {
  .overview-row {
    gap:20px;
    flex-direction:column;
  }
  .overview-grid {
    grid-template-columns:1fr;
    gap:20px;
  }
  .overview-chart {
    min-width:100%;
  }
  .overview-card-stack {
    min-width:100%;
  }
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
  /* Make footer span full viewport width and remove external spacing */
  width: 100% !important;
  margin: 0 !important;
  padding: 0 !important;
  box-sizing: border-box;
  background: #f5f8fa;
  text-align: center;
  color: black;
  border-radius: 0;
}

/* Inner footer content: keep readable centered content while background is full-bleed */
.footer .footer-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 50px 16px;
  box-sizing: border-box;
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
.sector-section {
  margin: 0 auto;
  padding: 32px clamp(16px, 4vw, 32px);
  max-width: 1200px;
  width: 100%;
  box-sizing: border-box;
}
.sector-title { color: #0B78A0; font-weight:800; margin-bottom:18px; text-align:left; }
.sector-row { display:flex; gap:24px; align-items:stretch; margin-bottom:22px; flex-wrap:wrap; }
.sector-card { background: var(--network-gray); border-radius:14px; padding:28px; box-shadow: 0 16px 40px rgba(0,0,0,0.25); border:1px solid rgba(0,0,0,0.35); flex:1 1 320px; min-width:260px; max-width:100%; position:relative; transition: transform 220ms ease, box-shadow 220ms ease; cursor: pointer; min-height:220px; color: #fff; box-sizing:border-box; }
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
.predict-section {
  margin: 0 auto;
  padding: 32px clamp(16px, 4vw, 32px);
  max-width: 1200px;
  width: 100%;
  box-sizing: border-box;
}
.predict-title { color: #0B78A0; font-weight:800; margin-bottom:12px; text-align:left; }
.predict-title { margin-top:0; }
.predict-row { display:flex; gap:24px; align-items:stretch; margin-bottom:22px; flex-wrap:wrap; }
.predict-card { background: var(--network-gray); border-radius:14px; padding:22px; box-shadow: 0 14px 36px rgba(0,0,0,0.06); border:1px solid rgba(0,0,0,0.06); flex:1 1 280px; min-width:260px; width:100%; box-sizing:border-box; position:relative; transition: transform 220ms ease, box-shadow 220ms ease; cursor: pointer; min-height:260px; color: #0D1B2A; }
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
.sector-dashboards {
  margin: 0 auto;
  padding: 24px clamp(16px, 4vw, 32px) 28px;
  max-width: 1200px;
  width: 100%;
  box-sizing: border-box;
}
.sd-header { display:flex; flex-direction:column; gap:6px; margin-bottom:18px; }
.sd-title { font-size:34px; font-weight:900; text-align:left; color:#0D1B2A; margin:0 0 6px 0; }
.sd-sub { text-align:center; color:#556; margin:0 auto 18px; max-width:880px; }
/* New grid layout for sector cards to ensure consistent ordering and spacing */
.sd-grid { display:grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap:32px; align-items:stretch; width:100%; }
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
  .sector-section { padding: 24px clamp(16px, 4vw, 32px); }
  .sector-row { flex-direction: column; }
}    
.footer {
  width: 100% !important;
  margin: 0 !important;
  padding: 0 !important;
  border: none !important;
}

.footer *,
.footer-shell,
.footer-bar {
  box-sizing: border-box;
  width: 100%;
}
/* Standalone Economic Dashboard Sidebar (steelblue + pill hover effect) */
.standalone-sidebar { position:fixed; left:0; top:0; bottom:0; width:300px; background:#4682B4; padding:28px 18px; color:#fff; box-shadow: 0 30px 60px rgba(3,105,161,0.08); display:flex; flex-direction:column; gap:18px; align-items:flex-start; border-top-right-radius:12px; border-bottom-right-radius:12px; overflow:visible; z-index:2100; transition: transform 0.3s ease, width 0.3s ease; }
.standalone-sidebar .brand { font-weight:900; font-size:20px; color:#fff; margin-bottom:8px; }
.side-nav ul { list-style:none; padding:0; margin:12px 0 0 0; width:100%; display:flex; flex-direction:column; gap:12px; }
.side-link { position:relative; display:flex; align-items:center; gap:12px; padding:12px 14px; color:#fff; text-decoration:none; border-radius:999px; font-weight:800; font-size:18px; z-index:2; transition: color .24s ease; overflow:visible; }
.side-link .side-icon { width:26px; text-align:center; font-size:18px; color:inherit; z-index:3; flex-shrink:0; }
.side-link .side-text { display:inline-block; white-space:nowrap; z-index:3; }
.side-link .side-pill { position:absolute; left:8px; top:50%; transform:translateY(-50%); width:0; height: calc(100% + 12px); background:#ffffff; border-radius:28px; transition: width .36s cubic-bezier(.2,.9,.2,1); box-shadow: 0 12px 30px rgba(2,6,23,0.08); z-index:1; }
.side-link:hover .side-pill, .side-link.active .side-pill { width:290px; }
.side-link:hover { color:#2a5d73; }
.side-link:focus { outline:none; }
.standalone-main { margin-left:300px !important; transition: margin-left .28s ease; }
.sidebar-toggle { display:none; position:fixed; top:20px; left:20px; z-index:2200; background:#4682B4; color:#fff; border:none; padding:12px; border-radius:8px; font-size:20px; cursor:pointer; box-shadow:0 4px 12px rgba(0,0,0,0.15); }
.sidebar-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,0.5); z-index:2099; }
@media(max-width:900px) {
  .standalone-sidebar { width:84px; padding:18px 12px; align-items:center; }
  .standalone-sidebar .brand { font-size:16px; }
  .side-link { justify-content:center; padding:12px; font-size:16px; }
  .side-link .side-text { display:none; }
  .standalone-main { margin-left:84px !important; }
  .side-link .side-pill { display:none; }
}
@media(max-width:768px) {
  .sidebar-toggle { display:block; }
  .standalone-sidebar { transform:translateX(-100%); width:280px; }
  .standalone-sidebar.sidebar-open { transform:translateX(0); }
  .standalone-main { margin-left:0 !important; padding:24px 16px !important; }
  .sidebar-overlay.sidebar-open { display:block; }
  .side-link .side-text { display:inline-block; }
  .side-link { justify-content:flex-start; }
}
@media(max-width:480px) {
  .standalone-sidebar { width:260px; padding:20px 14px; }
  .standalone-main { padding:20px 12px !important; }
  .side-link { padding:10px 12px; font-size:16px; }
}

/* Login Button in Navbar */
.navlinks .login-btn {
  background: linear-gradient(135deg, #0B78A0 0%, #157A4A 100%);
  color: white !important;
  padding: 10px 24px;
  border-radius: 12px;
  font-weight: 700;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(11,120,160,0.2);
}

.navlinks .login-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(11,120,160,0.35);
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
    tags$link(rel = "stylesheet", href = "   https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"),
  # Footer styles (local)
  tags$link(rel = "stylesheet", href = "footer.css"),
    # Inter font for professional typography
    tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"),
    # Ensure the top-level Shiny container is a column flex so footer can be pushed to bottom
    tags$style(HTML('
      body, html { margin: 0 !important; padding: 0 !important; }
      .container-fluid{display:flex; flex-direction:column; min-height:100vh; padding:0 !important; margin:0 !important;}
      .container-fluid > .row{flex:1 0 auto; margin:0 !important; padding-bottom:0 !important;}
      #app-container, .shiny-html-output{margin-bottom:0 !important; padding-bottom:0 !important;}
      body > div:last-child, .container-fluid > div:last-child { margin-bottom: 0 !important; padding-bottom: 0 !important; }
    ')),
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

  # Standalone Health Dashboard page (hidden by default) - Now using health_education_dashboard_module
  health_education_dashboard_ui(),

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
      )
  ),

  # Standalone Demographics & Agriculture Dashboard page (hidden by default) - Now using demographics_agriculture_dashboard_module
  demographics_agriculture_dashboard_ui(),

  # Standalone Login Page
  login_ui(),
  admin_dashboard_ui("admin_dashboard_module"),
  reviewer_dashboard_ui("reviewer_dashboard_module"),
  institution_dashboard_ui("institution_dashboard_module"),

  # Main content wrapper: keep minimal bottom padding so footer sits directly after content
  div(id='page-content', style='flex:1 0 auto; display:flex; flex-direction:column; padding-bottom:0;'),
  
  # Top navigation (single-page anchors)
  div(class='topnav',
    div(class='topnav-inner',
      div(class='brand', 'NDIP-RW'),
      # Hamburger menu button (hidden on desktop, shown on mobile)
      tags$button(
        class='hamburger',
        id='hamburger-btn',
        onclick='toggleMobileMenu()',
        HTML('<span></span><span></span><span></span>')
      ),
      div(class='navlinks', id='navlinks',
        tags$a(href='#home', class='nav-link', 'Home'),
        tags$a(href='#overview', class='nav-link', 'Overview'),
        tags$a(href='#sectors', class='nav-link', 'Sectors'),
        tags$a(href='#guide', class='nav-link', 'User Guide'),
        tags$a(
          href='#login', 
          class='login-btn nav-link', 
          id='navbar-login-btn',
          HTML('<i class="fas fa-sign-in-alt" style="margin-right:6px;"></i>Login')
        )
      )
    )
  ),
  
  # Professional Navbar JavaScript with Smooth Scrolling
  tags$script(HTML("
    (function() {
      'use strict';
      
      // Get navbar height for offset calculation
      function getNavbarHeight() {
        var topnav = document.querySelector('.topnav');
        return topnav ? topnav.offsetHeight : 80;
      }
      
      // Toggle mobile menu
      function toggleMobileMenu() {
        var navlinks = document.getElementById('navlinks');
        var hamburger = document.getElementById('hamburger-btn');
        
        if (navlinks && hamburger) {
          navlinks.classList.toggle('active');
          hamburger.classList.toggle('active');
        }
      }
      
      // Close mobile menu
      function closeMobileMenu() {
        var navlinks = document.getElementById('navlinks');
        var hamburger = document.getElementById('hamburger-btn');
        
        if (navlinks && hamburger) {
          navlinks.classList.remove('active');
          hamburger.classList.remove('active');
        }
      }
      
      // Professional smooth scroll function with offset for navbar
      function smoothScrollToSection(hash) {
        if (!hash) return false;
        
        var targetId = hash.replace('#', '');
        if (!targetId) return false;
        
        var targetElement = document.getElementById(targetId);
        if (!targetElement) {
          console.warn('Target element not found:', targetId);
          return false;
        }
        
        // Close any open dashboards first
        var dashboards = ['standalone-economic', 'standalone-health', 'standalone-demographics', 
                         'standalone-tourism', 'standalone-governance', 'standalone-education',
                         'standalone-login', 'admin-dashboard', 'reviewer-dashboard', 'institution-dashboard'];
        dashboards.forEach(function(id) {
          var el = document.getElementById(id);
          if (el) el.style.display = 'none';
        });
        
        // Reset body overflow
        document.body.style.overflow = 'auto';
        
        // Clear dashboard hash to show main content
        if (location.hash && (location.hash.startsWith('#page=') || 
            location.hash.startsWith('#admin') || 
            location.hash.startsWith('#reviewer') || 
            location.hash.startsWith('#institution') || 
            location.hash.startsWith('#login'))) {
          history.replaceState(null, null, ' ');
        }
        
        // Close mobile menu
        closeMobileMenu();
        
        // Wait for any transitions to complete
        setTimeout(function() {
          var pageContent = document.getElementById('page-content');
          if (pageContent) {
            pageContent.style.display = 'flex';
          }
          
          // Calculate offset for fixed navbar
          var navbarHeight = getNavbarHeight();
          var elementPosition = targetElement.getBoundingClientRect().top;
          var offsetPosition = elementPosition + window.pageYOffset - navbarHeight - 20;
          
          // Smooth scroll with offset
          window.scrollTo({
            top: offsetPosition,
            behavior: 'smooth'
          });
          
          // Update URL hash without triggering scroll
          if (history.pushState) {
            history.pushState(null, null, hash);
          } else {
            location.hash = hash;
          }
          
          // Add active class to clicked link
          var navLinks = document.querySelectorAll('.navlinks a.nav-link');
          navLinks.forEach(function(link) {
            link.classList.remove('active');
            if (link.getAttribute('href') === hash) {
              link.classList.add('active');
              setTimeout(function() {
                link.classList.remove('active');
              }, 2000);
            }
          });
        }, 150);
        
        return true;
      }
      
      // Initialize navigation when DOM is ready
      function initNavigation() {
        // Handle navbar link clicks
        var navLinks = document.querySelectorAll('.navlinks a.nav-link[href^=\"#\"]');
        navLinks.forEach(function(link) {
          link.addEventListener('click', function(e) {
            var href = this.getAttribute('href');
            if (href && href.startsWith('#') && 
                !href.startsWith('#page=') && 
                !href.startsWith('#admin') && 
                !href.startsWith('#reviewer') && 
                !href.startsWith('#institution') && 
                !href.startsWith('#login')) {
              e.preventDefault();
              e.stopPropagation();
              smoothScrollToSection(href);
            }
          });
        });
        
        // Handle footer links
        var footerLinks = document.querySelectorAll('div[style*=\"width:100vw\"] a[href^=\"#\"]');
        footerLinks.forEach(function(link) {
          link.addEventListener('click', function(e) {
            var href = this.getAttribute('href');
            if (href && href.startsWith('#') && 
                !href.startsWith('#page=') && 
                !href.startsWith('#admin') && 
                !href.startsWith('#reviewer') && 
                !href.startsWith('#institution') && 
                !href.startsWith('#login')) {
              e.preventDefault();
              e.stopPropagation();
              smoothScrollToSection(href);
            }
          });
        });
        
        // Handle hash changes (browser back/forward)
        window.addEventListener('hashchange', function() {
          var hash = location.hash;
          if (hash && 
              !hash.startsWith('#page=') && 
              !hash.startsWith('#admin') && 
              !hash.startsWith('#reviewer') && 
              !hash.startsWith('#institution') && 
              !hash.startsWith('#login')) {
            setTimeout(function() {
              smoothScrollToSection(hash);
            }, 100);
          }
        });
        
        // Handle initial hash on page load
        if (location.hash && 
            !location.hash.startsWith('#page=') && 
            !location.hash.startsWith('#admin') && 
            !location.hash.startsWith('#reviewer') && 
            !location.hash.startsWith('#institution') && 
            !location.hash.startsWith('#login')) {
          setTimeout(function() {
            smoothScrollToSection(location.hash);
          }, 500);
        }
      }
      
      // Close mobile menu when clicking outside
      document.addEventListener('click', function(event) {
        var navlinks = document.getElementById('navlinks');
        var hamburger = document.getElementById('hamburger-btn');
        var topnav = document.querySelector('.topnav');
        
        if (navlinks && hamburger && topnav) {
          if (!topnav.contains(event.target) && navlinks.classList.contains('active')) {
            closeMobileMenu();
          }
        }
      });
      
      // Make functions globally available
      window.toggleMobileMenu = toggleMobileMenu;
      window.closeMobileMenu = closeMobileMenu;
      
      // Initialize when DOM is ready
      if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initNavigation);
      } else {
        initNavigation();
      }
      
      // Also initialize after a short delay to ensure all elements are rendered
      setTimeout(initNavigation, 300);
    })();
  ")),
  
  # Login routing JavaScript
  tags$script(HTML("
    // Login page routing - Enhanced version
    (function() {
      console.log('Login routing initialized');
      
      function toggleLogin() {
        var loginPage = document.getElementById('standalone-login');
        var pageContent = document.getElementById('page-content');
        
        console.log('toggleLogin called, hash:', location.hash);
        console.log('Login page element found:', !!loginPage);
        console.log('Page content element found:', !!pageContent);
        
        if (location.hash === '#login') {
          // Show login page
          console.log('Showing login page');
          if (loginPage) {
            loginPage.style.display = 'block';
            loginPage.style.visibility = 'visible';
            loginPage.style.opacity = '1';
          } else {
            console.error('Login page element not found!');
          }
          if (pageContent) {
            pageContent.style.display = 'none';
          }
          // Lock body scroll
          try {
            document.body.style.overflow = 'hidden';
          } catch(e) {
            console.error('Error setting body overflow:', e);
          }
        } else {
          // Hide login page
          console.log('Hiding login page');
          if (loginPage) {
            loginPage.style.display = 'none';
            loginPage.style.visibility = 'hidden';
            loginPage.style.opacity = '0';
          }
          if (pageContent) {
            pageContent.style.display = 'flex';
          }
          // Restore body scroll
          try {
            document.body.style.overflow = 'auto';
          } catch(e) {
            console.error('Error restoring body overflow:', e);
          }
        }
      }
      
      // Listen for hash changes
      window.addEventListener('hashchange', function() {
        console.log('Hash changed to:', location.hash);
        toggleLogin();
      });
      
      // Make function globally available for debugging
      window.toggleLogin = toggleLogin;
      
      // Initial call with multiple attempts to ensure elements are loaded
      setTimeout(function() {
        console.log('First toggle attempt');
        toggleLogin();
      }, 100);
      
      setTimeout(function() {
        console.log('Second toggle attempt');
        toggleLogin();
      }, 500);
      
      // Also trigger immediately
      if (document.readyState === 'complete') {
        toggleLogin();
      } else {
        window.addEventListener('load', toggleLogin);
      }
      
    })();
    
    // Login button click handler (backup)
    (function() {
      function setupLoginButton() {
        var loginBtn = document.getElementById('navbar-login-btn');
        if (loginBtn) {
          console.log('Login button found, adding click listener');
          loginBtn.addEventListener('click', function(e) {
            console.log('Login button clicked via event listener');
            // Let the href handle navigation, but ensure it triggers
            setTimeout(function() {
              if (location.hash !== '#login') {
                location.hash = '#login';
              }
              window.toggleLogin();
            }, 50);
          });
        } else {
          console.warn('Login button not found, retrying...');
          setTimeout(setupLoginButton, 100);
        }
      }
      
      setTimeout(setupLoginButton, 200);
    })();
    
    // Dashboard redirection handler
    Shiny.addCustomMessageHandler('redirectToDashboard', function(dashboard) {
      console.log('Redirecting to:', dashboard);
      
      // Hide login page
      var loginPage = document.getElementById('standalone-login');
      if (loginPage) {
        loginPage.style.display = 'none';
      }
      
      // Redirect based on dashboard type
      if (dashboard === 'admin') {
        window.location.hash = '#admin-dashboard';
      } else if (dashboard === 'reviewer') {
        window.location.hash = '#reviewer-dashboard';
      } else if (dashboard === 'institution') {
        window.location.hash = '#institution-dashboard';
      } else if (dashboard === 'home') {
        window.location.hash = '';
      }
      
      if (window.toggleRoleDashboards) {
        window.toggleRoleDashboards();
      }
    });
  ")),
    # Role dashboard routing script
  tags$script(HTML("
    (function() {
      const dashboardMap = {
        '#admin-dashboard': 'admin-dashboard',
        '#reviewer-dashboard': 'reviewer-dashboard',
        '#institution-dashboard': 'institution-dashboard'
      };
      
      function toggleRoleDashboards() {
        var active = false;
        Object.entries(dashboardMap).forEach(function(entry) {
          var hash = entry[0];
          var id = entry[1];
          var el = document.getElementById(id);
          if (!el) { return; }
          if (location.hash === hash) {
            el.style.display = 'flex';
            active = true;
            // Trigger Shiny to recalculate outputs when dashboard becomes visible
            console.log('Dashboard visible:', id);
            setTimeout(function() {
              $(window).trigger('resize'); // Force Shiny to recalculate
              
              // Force Shiny to bind outputs in the newly visible dashboard
              if (window.Shiny) {
                console.log('Forcing Shiny output binding for:', id);
                window.Shiny.bindAll(el); // Re-bind all Shiny outputs in this container
                window.Shiny.setInputValue('dashboard_visible', id + '_' + Date.now(), {priority: 'event'});
              }
            }, 150);
          } else {
            el.style.display = 'none';
          }
        });
        
        var pageContent = document.getElementById('page-content');
        if (pageContent) {
          pageContent.style.display = active ? 'none' : 'flex';
        }
        
        if (active) {
          document.body.style.overflow = 'hidden';
        } else if (location.hash !== '#login') {
          document.body.style.overflow = 'auto';
        }
      }
      
      window.addEventListener('hashchange', function() {
        toggleRoleDashboards();
      });
      
      window.toggleRoleDashboards = toggleRoleDashboards;
      
      setTimeout(toggleRoleDashboards, 150);
      setTimeout(toggleRoleDashboards, 400);
    })();
  ")),
  
  # Login page
  login_ui(),
  
  # Role-specific dashboards (already initialized above with IDs)
  # admin_dashboard_ui("admin_dashboard_module"),  # Already initialized on line 1548
  # reviewer_dashboard_ui("reviewer_dashboard_module"),  # Already initialized on line 1549
  # institution_dashboard_ui("institution_dashboard_module"),  # Already initialized on line 1550
  
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

    # WHAT IS NDIP? Section - Professional explanation
    div(
      class='why-ndip-section',
      style='margin-top:80px; margin-bottom:60px; padding:60px 0; background:linear-gradient(135deg, #f8fafc 0%, #ffffff 100%); border-radius:24px; position:relative; overflow:hidden;',
      tags$style(HTML("
        .why-ndip-section::before {
          content: '';
          position: absolute;
          top: 0;
          left: 0;
          right: 0;
          height: 4px;
          background: linear-gradient(90deg, #0B78A0 0%, #157A4A 50%, #0B78A0 100%);
        }
        .why-ndip-header {
          text-align: center;
          margin-bottom: 48px;
        }
        .why-ndip-header h2 {
          font-size: 42px;
          font-weight: 800;
          color: #042A3B;
          margin-bottom: 16px;
          letter-spacing: -0.5px;
          background: linear-gradient(135deg, #0B78A0 0%, #157A4A 100%);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
          background-clip: text;
        }
        .why-ndip-header p {
          font-size: 18px;
          color: #64748b;
          max-width: 800px;
          margin: 0 auto;
          line-height: 1.7;
        }
        .why-ndip-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
          gap: 32px;
          max-width: 1200px;
          margin: 0 auto;
          padding: 0 24px;
        }
        .why-ndip-card {
          background: #ffffff;
          border-radius: 20px;
          padding: 36px;
          box-shadow: 0 4px 20px rgba(11, 120, 160, 0.08);
          border: 1px solid rgba(11, 120, 160, 0.1);
          transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
          position: relative;
          overflow: hidden;
        }
        .why-ndip-card::before {
          content: '';
          position: absolute;
          top: 0;
          left: 0;
          width: 4px;
          height: 100%;
          background: linear-gradient(180deg, #0B78A0 0%, #157A4A 100%);
          transform: scaleY(0);
          transition: transform 0.3s ease;
        }
        .why-ndip-card:hover {
          transform: translateY(-8px);
          box-shadow: 0 12px 40px rgba(11, 120, 160, 0.15);
        }
        .why-ndip-card:hover::before {
          transform: scaleY(1);
        }
        .why-ndip-icon {
          width: 64px;
          height: 64px;
          border-radius: 16px;
          background: linear-gradient(135deg, rgba(11, 120, 160, 0.1) 0%, rgba(21, 122, 74, 0.1) 100%);
          display: flex;
          align-items: center;
          justify-content: center;
          margin-bottom: 24px;
          font-size: 28px;
          color: #0B78A0;
        }
        .why-ndip-card h3 {
          font-size: 22px;
          font-weight: 700;
          color: #042A3B;
          margin-bottom: 12px;
          letter-spacing: -0.3px;
        }
        .why-ndip-card p {
          font-size: 15px;
          color: #64748b;
          line-height: 1.7;
          margin: 0;
        }
        .why-ndip-stats {
          display: flex;
          justify-content: center;
          gap: 48px;
          margin-top: 48px;
          padding: 40px 24px;
          background: rgba(11, 120, 160, 0.03);
          border-radius: 16px;
          max-width: 1000px;
          margin-left: auto;
          margin-right: auto;
        }
        .why-ndip-stat-item {
          text-align: center;
        }
        .why-ndip-stat-number {
          font-size: 36px;
          font-weight: 800;
          color: #0B78A0;
          margin-bottom: 8px;
          letter-spacing: -0.5px;
        }
        .why-ndip-stat-label {
          font-size: 14px;
          color: #64748b;
          font-weight: 600;
          text-transform: uppercase;
          letter-spacing: 0.5px;
        }
        @media (max-width: 768px) {
          .why-ndip-header h2 {
            font-size: 32px;
          }
          .why-ndip-grid {
            grid-template-columns: 1fr;
            gap: 24px;
            padding: 0 16px;
          }
          .why-ndip-stats {
            flex-direction: column;
            gap: 32px;
          }
        }
      ")),
      div(
        class='why-ndip-header',
        tags$h2('WHAT IS NDIP?'),
        tags$p('A centralized data intelligence platform that digitizes, coordinates, and transforms Rwanda\'s complex and big country data into easy-to-understand stories using visualizations from various sectors. Rwanda has positioned itself as Africa\'s leading hub for data-driven innovation, artificial intelligence, and digital transformation. NDIP empowers evidence-based decision-making by providing real-time actionable insights across all sectors.')
      ),
      div(
        class='why-ndip-grid',
        div(
          class='why-ndip-card',
          div(class='why-ndip-icon', HTML('<i class="fas fa-network-wired"></i>')),
          tags$h3('Centralized Intelligence Hub'),
          tags$p('NDIP serves as Rwanda\'s unified data ecosystem, seamlessly coordinating multiple government institutions and agencies. By consolidating fragmented data sources into a single, accessible platform, we eliminate silos and create a comprehensive view of national development metrics.')
        ),
        div(
          class='why-ndip-card',
          div(class='why-ndip-icon', HTML('<i class="fas fa-sync-alt"></i>')),
          tags$h3('Real-Time Data Synchronization'),
          tags$p('Experience live data updates as they happen. Our digitized infrastructure ensures that every metric, statistic, and indicator reflects the current state of Rwanda\'s progress. No delays, no outdated information—just real-time intelligence at your fingertips.')
        ),
        div(
          class='why-ndip-card',
          div(class='why-ndip-icon', HTML('<i class="fas fa-chart-line"></i>')),
          tags$h3('Rwanda in Numbers'),
          tags$p('Transform complex data into clear, visual narratives. NDIP translates Rwanda\'s development story into comprehensive dashboards, interactive charts, and predictive analytics that make national progress tangible and understandable for policymakers, researchers, and citizens alike.')
        ),
        div(
          class='why-ndip-card',
          div(class='why-ndip-icon', HTML('<i class="fas fa-building"></i>')),
          tags$h3('Institutional Coordination'),
          tags$p('Foster seamless collaboration across ministries, agencies, and institutions. NDIP\'s integrated workflow enables data submission, quality review, and publication processes that ensure accuracy, consistency, and transparency in national reporting.')
        ),
        div(
          class='why-ndip-card',
          div(class='why-ndip-icon', HTML('<i class="fas fa-brain"></i>')),
          tags$h3('Predictive Analytics & Forecasting'),
          tags$p('Go beyond historical data with advanced ARIMA modeling and machine learning algorithms. NDIP provides statistically robust forecasts that help anticipate trends, plan interventions, and optimize resource allocation for Rwanda\'s sustainable development goals.')
        ),
        div(
          class='why-ndip-card',
          div(class='why-ndip-icon', HTML('<i class="fas fa-shield-check"></i>')),
          tags$h3('Data Quality & Validation'),
          tags$p('Every dataset undergoes rigorous quality assurance through our multi-tier review system. Automated validation, expert review, and institutional verification ensure that NDIP maintains the highest standards of data accuracy and reliability.')
        )
      ),
      div(
        class='why-ndip-stats',
        div(
          class='why-ndip-stat-item',
          div(class='why-ndip-stat-number', '250+'),
          div(class='why-ndip-stat-label', 'Active Datasets')
        ),
        div(
          class='why-ndip-stat-item',
          div(class='why-ndip-stat-number', '15+'),
          div(class='why-ndip-stat-label', 'Institutions')
        ),
        div(
          class='why-ndip-stat-item',
          div(class='why-ndip-stat-number', '98%'),
          div(class='why-ndip-stat-label', 'Data Accuracy')
        ),
        div(
          class='why-ndip-stat-item',
          div(class='why-ndip-stat-number', '24/7'),
          div(class='why-ndip-stat-label', 'Real-Time Updates')
        )
      )
    ),

    # Overview section
  
  # Overview section
  div(id='overview', class='section', style='padding-top:24px; padding-bottom:4px; min-height:0;',
      div(class='section-inner',
          div(
            h2(class='fade-in-up', 'Explore the NDIP overview'),
            div(class='fade-in-up',
                p("An integrated overview of NDIP connecting data, innovation and insights to drive Rwanda's sustainable development.")
            )
          ),
          div(style='display: flex; flex-direction: column; gap: 40px; margin-top: 40px;',
            # Top Row with Bar Chart and First Two Info Boxes
            div(class='overview-row',
              # Bar Chart
              div(class='overview-chart',
                plotlyOutput('pop_bar', height = '440px')
              ),
              # First Column of Info Boxes
              div(class='overview-card-stack',
                # GDP Box
                div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('gdp_click', Math.random())", 
                    style='background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:28px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease; width:100%;',
                  htmlOutput('gdp_box')
                ),
                # Literacy Box
                div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('literacy_click', Math.random())",
                    style='background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:28px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease; width:100%;',
                  htmlOutput('literacy_box')
                )
              )
            ),
            # Bottom Row of Info Boxes
            div(class='overview-row overview-grid',
              # CPI Box
              div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('cpi_click', Math.random())",
                  style='background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:28px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease; width:100%;',
                htmlOutput('cpi_box')
              ),
              # Electricity Access Box
              div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('electricity_click', Math.random())",
                  style='background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:28px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease; width:100%;',
                htmlOutput('electricity_box')
              ),
              # Life Expectancy Box
              div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('life_exp_click', Math.random())",
                  style='background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:28px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease; width:100%;',
                htmlOutput('life_exp_box')
              ),
              # Poverty Rate Box
              div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('poverty_click', Math.random())",
                  style='background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:28px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease; width:100%;',
                htmlOutput('poverty_box')
              ),
              # Rwanda Geography & Administration Box
              div(class='animated-infobox interactive-box', onclick = "Shiny.setInputValue('geography_click', Math.random())",
                  style='background:#f5f5f5; border-radius:22px; box-shadow:0 2px 18px rgba(0,0,0,0.12); padding:28px; display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-start; font-size:15px; position:relative; cursor:pointer; transition:all 0.2s ease; width:100%;',
                htmlOutput('geography_box')
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
            div(class='current', HTML('<div style="font-size:12px; color:#556;">Current Population</div><div class="val">14,104,969</div>')),
            div(class='predicted', HTML('<div style="font-size:12px; color:#556;">Predicted Population (2030)</div><div class="val">20,100,000</div>'))
          ),
          div(class='predict-growth up', HTML('<i class="fas fa-arrow-up"></i> +42.5%')),
          div(class='predict-bar', tags$div(class='predict-fill', `data-fill`='90%')),
          div(class='predict-desc', 'Projected increase driven by natural growth and improved health services.')
        ),
        div(class='predict-card', `data-id`='predict_poverty',
          div(class='predict-header',
            div(style='display:flex; align-items:center; gap:10px;', HTML('<div class="left-icon"><i class="fas fa-chart-area"></i></div><div><strong>Poverty Rate Projection</strong></div>')),
            span(class='predict-year', '2029')
          ),
          div(class='predict-confidence', 'Confidence: Medium (68%)'),
          div(class='predict-body',
            div(class='current', HTML('<div style="font-size:12px; color:#556;">Current Poverty Rate</div><div class="val">27.4%</div>')),
            div(class='predicted', HTML('<div style="font-size:12px; color:#556;">Predicted Poverty Rate</div><div class="val">10.0%</div>'))
          ),
          div(class='predict-growth down', HTML('<i class="fas fa-arrow-down"></i> -17.4%')),
          div(class='predict-bar', tags$div(class='predict-fill', `data-fill`='10%')),
          div(class='predict-desc', 'Projected decline reflecting social protection and employment programs.')
        )
        )
      )
    )
  ),
  
  # Sectors section (organized two-row grid inside the Sectors tab)
  div(id = 'sectors', class='section', style='min-height:0; padding-top:0px; padding-bottom:2px; margin-top:-8px;',
      h2(class='fade-in-up', 'Sector Dashboards'),
      div(class='fade-in-up sd-sub', 'Explore detailed insights across Rwanda\'s key development sectors'),
      # Grid with three cards (Economic, Demographics & Agriculture, Health & Education)
      div(class='fade-in-up sd-grid', style='margin-top:8px; gap:28px; margin-left:0;',
        div(class='sd-card fade-in-up', onclick = "Shiny.setInputValue('sector_dashboard_click', 'Economic Development|' + Math.random())",
          div(class='sd-top', HTML('<div class="left-icon"><i class="fas fa-building"></i></div><div class="sd-title-inline">Economic Development</div>')),
          div(class='sd-desc', 'GDP growth, business environment, trade, and economic indicators'),
          div(class='sd-kpi', HTML('<div class="kpi-label">GDP Growth Rate</div><div class="kpi-val">8.2%</div>')),
          div(class='sd-footer', HTML('<a class="sd-button" href="#page=economic">View Dashboard</a>'))
        ),
        div(class='sd-card fade-in-up', onclick = "Shiny.setInputValue('sector_dashboard_click', 'Demographics & Agriculture|' + Math.random())",
          div(class='sd-top', HTML('<div class="left-icon"><i class="fas fa-seedling"></i></div><div class="sd-title-inline">Demographics & Agriculture</div>')),
          div(class='sd-desc', 'Population dynamics, agricultural productivity, and rural development'),
          div(class='sd-kpi', HTML('<div class="kpi-label">Agricultural Growth</div><div class="kpi-val">5.2%</div>')),
          div(class='sd-footer', HTML('<a class="sd-button" href="#page=demographics">View Dashboard</a>'))
        ),
        div(class='sd-card fade-in-up', onclick = "Shiny.setInputValue('sector_dashboard_click', 'Health & Education|' + Math.random())",
          div(class='sd-top', HTML('<div class="left-icon"><i class="fas fa-heart"></i></div><div class="sd-title-inline">Health & Education</div>')),
          div(class='sd-desc', 'Healthcare access, outcomes, education access, and learning outcomes'),
          div(class='sd-kpi', HTML('<div class="kpi-label">Education Growth</div><div class="kpi-val">5.4%</div>')),
          # Show the existing health standalone dashboard (keeps existing standalone page as-is)
          div(class='sd-footer', HTML('<a class="sd-button" href="#page=health">View Dashboard</a>'))
        )
    )
  ),
  
  # User guide (interactive accordion-style)
  
  # make this section container-free: remove the section-alt background and reset min-height
  div(id='guide', class='section', style='min-height:0; background:transparent; padding-top:12px; padding-bottom:6px;',
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

  # Standalone Economic Dashboard page (hidden by default) - Now using economic_dashboard_module
  economic_dashboard_ui(),

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

  # Footer Responsive CSS
  tags$style(HTML("
    /* Footer Responsive Styles */
    @media (max-width: 768px) {
      div[style*='width:100vw'][style*='background:linear-gradient'] {
        padding-left: 24px !important;
        padding-right: 24px !important;
        padding-top: 32px !important;
        padding-bottom: 32px !important;
      }
      div[style*='width:100vw'][style*='background:linear-gradient'] .fluidRow {
        flex-direction: column !important;
        gap: 24px !important;
      }
      div[style*='width:100vw'][style*='background:linear-gradient'] .column {
        width: 100% !important;
        margin-bottom: 16px;
      }
    }
    @media (max-width: 480px) {
      div[style*='width:100vw'][style*='background:linear-gradient'] {
        padding-left: 16px !important;
        padding-right: 16px !important;
        padding-top: 24px !important;
        padding-bottom: 24px !important;
      }
    }
  ")),
  
  # Inline footer (matches provided reference design)
  div(
    style = "width:100vw; position:relative; left:50%; right:50%; margin-left:-50vw; margin-right:-50vw; background:linear-gradient(135deg, #5DADE2 0%, #85C1E9 100%); padding-top:48px; padding-bottom:48px; padding-left:clamp(40px,6vw,80px); padding-right:clamp(40px,6vw,80px); margin-top:40px; margin-bottom:0 !important;",
    div(
      style = "width:100%; line-height:1.5; color:#ffffff;",
      fluidRow(
        style = "gap:24px;",
        column(
          width = 4,
          div(
            style = "display:flex; gap:14px; align-items:flex-start;",
            div(
              style = "width:48px; height:48px; border-radius:10px; background:#ffffff; color:#0B78A0; display:flex; align-items:center; justify-content:center; font-weight:700;",
              "RW"
            ),
            div(
              tags$div(style="font-weight:700; font-size:20px; color:#ffffff;", "NDIP Rwanda"),
              tags$div(style="color:#e3f2fd; font-size:14px; margin-bottom:10px;", "National Data Integration Platform"),
              tags$p(style="margin:0; color:#ffffff;", "Empowering Rwanda through transparent, accessible, and actionable data insights.")
            )
          )
        ),
        column(
          width = 2,
          tags$div(style="font-weight:600; font-size:16px; color:#ffffff; margin-bottom:12px;", "Platform"),
          tags$a(href="#home", style="display:block; margin:4px 0; color:#e3f2fd; text-decoration:none; cursor:pointer; transition:color 0.2s ease;", onmouseover="this.style.color='#ffffff'", onmouseout="this.style.color='#e3f2fd'", "Home"),
          tags$a(href="#overview", style="display:block; margin:4px 0; color:#e3f2fd; text-decoration:none; cursor:pointer; transition:color 0.2s ease;", onmouseover="this.style.color='#ffffff'", onmouseout="this.style.color='#e3f2fd'", "Overview"),
          tags$a(href="#sectors", style="display:block; margin:4px 0; color:#e3f2fd; text-decoration:none; cursor:pointer; transition:color 0.2s ease;", onmouseover="this.style.color='#ffffff'", onmouseout="this.style.color='#e3f2fd'", "Sectors"),
          tags$a(href="#guide", style="display:block; margin:4px 0; color:#e3f2fd; text-decoration:none; cursor:pointer; transition:color 0.2s ease;", onmouseover="this.style.color='#ffffff'", onmouseout="this.style.color='#e3f2fd'", "User Guide")
        ),
        column(
          width = 2,
          tags$div(style="font-weight:600; font-size:16px; color:#ffffff; margin-bottom:12px;", "Resources"),
          tags$p(style="margin:4px 0; color:#e3f2fd;", tagList("Institutional Portal ", icon("arrow-up-right-from-square"))),
          tags$p(style="margin:4px 0; color:#e3f2fd;", "API Documentation"),
          tags$p(style="margin:4px 0; color:#e3f2fd;", "Data Standards")
        ),
        column(
          width = 3,
          tags$div(style="font-weight:600; font-size:16px; color:#ffffff; margin-bottom:12px;", "Contact"),
          div(
            style = "display:flex; align-items:center; gap:10px; margin-bottom:6px; color:#e3f2fd;",
            icon("envelope"),
            tags$span("ndip@gmail.com")
          ),
          div(
            style = "display:flex; align-items:center; gap:10px; color:#e3f2fd;",
            icon("phone"),
            tags$span("+250-785-694-467")
          )
        )
      ),
      tags$hr(style="margin-top:25px; margin-bottom:20px; border-color:rgba(255,255,255,0.3);"),
      tags$p(
        style = "margin:0; text-align:center; color:#ffffff; font-weight:500;",
        "© 2025 Republic of Rwanda. All rights reserved. | Built with transparency and innovation. | Created by Gatete"
      )
    )
  ),
  
  # Force remove any space after footer - comprehensive fix
  tags$style(HTML("
    /* Remove all bottom spacing */
    body, html { 
      margin: 0 !important; 
      padding: 0 !important; 
      overflow-x: hidden !important;
    }
    body > *:last-child, 
    .container-fluid,
    .container-fluid > div:last-child,
    div[style*='width:100vw']:last-child { 
      margin-bottom: 0 !important; 
      padding-bottom: 0 !important;
    }
    /* Ensure footer extends to bottom */
    body > div, body > div > div {
      margin-bottom: 0 !important;
      padding-bottom: 0 !important;
    }
  ")),
  
  # JavaScript fix to remove any bottom spacing after page load
  tags$script(HTML("
    (function() {
      function removeBottomSpacing() {
        // Remove bottom margin/padding from body and last elements
        document.body.style.marginBottom = '0';
        document.body.style.paddingBottom = '0';
        
        // Get all direct children of body
        var bodyChildren = document.body.children;
        if (bodyChildren.length > 0) {
          var lastChild = bodyChildren[bodyChildren.length - 1];
          lastChild.style.marginBottom = '0';
          lastChild.style.paddingBottom = '0';
        }
        
        // Target container-fluid specifically
        var containers = document.querySelectorAll('.container-fluid');
        containers.forEach(function(container) {
          container.style.marginBottom = '0';
          container.style.paddingBottom = '0';
        });
      }
      
      // Run on load and after a delay
      if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', removeBottomSpacing);
      } else {
        removeBottomSpacing();
      }
      
      // Run again after a short delay to catch any dynamic content
      setTimeout(removeBottomSpacing, 100);
      setTimeout(removeBottomSpacing, 500);
    })();
  "))

))



# # SERVER --------------------------------------------------------------
server <- function(input, output, session) {
  
  # Set file upload size limit to 50MB (as per requirements)
  options(shiny.maxRequestSize = 50 * 1024^2)
  
  # Initialize login system
  user_session <- login_server(input, output, session)
  
  # Load economic data directly (optimized for fast loading like demographics)
  if (!exists('Rwanda_GDP') || is.null(Rwanda_GDP)) {
    tryCatch({
      message("[ECONOMIC] Loading GDP data from CSV...")
      Rwanda_GDP <<- read.csv("data/datasets/Rwanda_GDP_Yearly_2010_2025.csv", stringsAsFactors = FALSE)
      message("[ECONOMIC] ✅ GDP data loaded")
    }, error = function(e) {
      message(sprintf("[ECONOMIC] ❌ Failed to load GDP: %s", e$message))
    })
  }
  
  if (!exists('Rwanda_inflation') || is.null(Rwanda_inflation)) {
    tryCatch({
      message("[ECONOMIC] Loading inflation data from CSV...")
      Rwanda_inflation <<- read.csv("data/datasets/Rwanda_Inflation.csv", stringsAsFactors = FALSE)
      message("[ECONOMIC] ✅ Inflation data loaded")
    }, error = function(e) {
      message(sprintf("[ECONOMIC] ❌ Failed to load inflation: %s", e$message))
    })
  }
  
  if (!exists('Rwanda_production_output') || is.null(Rwanda_production_output)) {
    tryCatch({
      message("[ECONOMIC] Loading production data from CSV...")
      Rwanda_production_output <<- read.csv("data/datasets/Rwanda_Production_Output.csv", stringsAsFactors = FALSE)
      message("[ECONOMIC] ✅ Production data loaded")
    }, error = function(e) {
      message(sprintf("[ECONOMIC] ❌ Failed to load production: %s", e$message))
    })
  }
  
  if (!exists('Rwanda_trade') || is.null(Rwanda_trade)) {
    tryCatch({
      message("[ECONOMIC] Loading trade data from CSV...")
      Rwanda_trade <<- read.csv("data/datasets/Rwanda_Trade.csv", stringsAsFactors = FALSE)
      message("[ECONOMIC] ✅ Trade data loaded")
    }, error = function(e) {
      message(sprintf("[ECONOMIC] ❌ Failed to load trade: %s", e$message))
    })
  }
  
  # Create reactive data source (now just returns already-loaded data)
  data_source <- reactive({
    list(
      gdp = if(exists('Rwanda_GDP')) Rwanda_GDP else NULL,
      inflation = if(exists('Rwanda_inflation')) Rwanda_inflation else NULL
    )
  })
  
  # Create reactive time series
  gdp_ts_data <- reactive({
    data <- data_source()$gdp
    if(input$gdp_metric == 'growth_rate') {
      ts_data <- ts(data$Real_GDP_Growth_., start=2010, frequency=1)
    } else {
      ts_data <- ts(data$Nominal_GDP_USD_Billions, start=2010, frequency=1)
    }
    return(ts_data)
  })
  
  # Create reactive inflation time series
  inflation_ts_data <- reactive({
    # Ensure data source is available
    data <- req(data_source())$inflation
    
    # Check if data exists
    if (is.null(data) || nrow(data) == 0) {
      validate(need(FALSE, "Inflation data is not available"))
    }
    
    # Check column name (handle both dot and hyphen versions)
    col_name <- NULL
    if ("Annual.averg.Inflation_Rate_Percent" %in% names(data)) {
      col_name <- "Annual.averg.Inflation_Rate_Percent"
    } else if ("Annual averg-Inflation_Rate_Percent" %in% names(data)) {
      col_name <- "Annual averg-Inflation_Rate_Percent"
    }
    
    if (is.null(col_name)) {
      validate(need(FALSE, "Inflation rate column not found in data"))
    }
    
    # Get the column values
    inflation_values <- data[[col_name]]
    
    # Validate data exists
    if (is.null(inflation_values)) {
      validate(need(FALSE, "Inflation rate data is missing"))
    }
    
    # Convert to numeric if needed and remove NAs
    inflation_values_numeric <- tryCatch({
      as.numeric(inflation_values)
    }, warning = function(w) {
      NULL
    }, error = function(e) {
      NULL
    })
    
    if (is.null(inflation_values_numeric)) {
      validate(need(FALSE, "Inflation rate data cannot be converted to numeric"))
    }
    
    # Remove NA values
    inflation_values_clean <- inflation_values_numeric[!is.na(inflation_values_numeric)]
    
    if (length(inflation_values_clean) == 0) {
      validate(need(FALSE, "No inflation rate observations"))
    }
    
    # Get year column
    year_col <- if ("Year" %in% names(data)) data$Year else if ("year" %in% names(data)) data$year else NULL
    if (is.null(year_col)) {
      validate(need(FALSE, "Year column not found in inflation data"))
    }
    
    # Ensure year and inflation values have same length
    if (length(inflation_values_clean) != length(year_col)) {
      # Try to match by index
      year_col <- year_col[!is.na(inflation_values)][1:length(inflation_values_clean)]
    }
    
    # Create time series
    ts_data <- ts(inflation_values_clean, 
                 start = min(year_col, na.rm = TRUE), 
                 frequency = 1)
    
    return(ts_data)
  })
  
  # Fit inflation ARIMA model
  inflation_model <- reactive({
    # Get time series data
    ts_data <- req(inflation_ts_data())
    
    # Fit model based on selection
    tryCatch({
      if(input$inflation_model == "arima111") {
        model <- Arima(ts_data, order=c(1,1,1))
      } else {
        model <- Arima(ts_data, order=c(2,1,2))
      }
      return(model)
    }, error = function(e) {
      validate(need(FALSE, paste("Error fitting inflation model:", e$message)))
    })
  })

  # Function to fit selected model
  fit_gdp_model <- reactive({
    ts_data <- gdp_ts_data()
    
    model <- switch(input$gdp_model_type,
      "arima_111" = Arima(ts_data, order=c(1,1,1)),
      "arima_212" = Arima(ts_data, order=c(2,1,2))
    )
    
    return(model)
  })

  # GDP Forecast Plot
  output$gdp_forecast_plot <- renderPlotly({
    model <- fit_gdp_model()
    ts_data <- gdp_ts_data()
    
    # Generate forecast
    forecast_data <- forecast(model, h=5)  # 5 years ahead
    
    # Set metric-specific parameters
    if(input$gdp_metric == 'growth_rate') {
      y_title <- "GDP Growth Rate (%)"
      hist_name <- "Historical GDP Growth"
      plot_title <- "GDP Growth Rate Forecast"
    } else {
      y_title <- "GDP (USD Billions)"
      hist_name <- "Historical GDP"
      plot_title <- "Nominal GDP Forecast"
    }
    
    # Create plot
    p <- plot_ly() %>%
      # Historical data
      add_lines(x = 2010:2024, y = as.numeric(ts_data),
                name = hist_name,
                line = list(color = "#0B78A0", width = 2)) %>%
      # Forecast
      add_lines(x = 2025:2029, y = as.numeric(forecast_data$mean),
                name = "Forecast",
                line = list(color = "#157A4A", width = 2, dash = "dash")) %>%
      # Confidence intervals
      add_ribbons(x = 2025:2029,
                 ymin = as.numeric(forecast_data$lower[,"95%"]),
                 ymax = as.numeric(forecast_data$upper[,"95%"]),
                 name = "95% CI",
                 fillcolor = "rgba(21, 122, 74, 0.2)",
                 line = list(color = "transparent")) %>%
      layout(
        title = list(
          text = paste(plot_title, "-", 
                      switch(input$gdp_model_type,
                            "arima_111" = "ARIMA(1,1,1)",
                            "arima_212" = "ARIMA(2,1,2)")),
          x = 0
        ),
        xaxis = list(title = "Year", 
                    tickmode = "linear",
                    dtick = 1),
        yaxis = list(title = y_title,
                    zeroline = TRUE,
                    zerolinecolor = '#ccc',
                    gridcolor = '#f0f0f0'),
        showlegend = TRUE,
        legend = list(x = 0.7, y = 0.9),
        hovermode = "x unified"
      )
    
    p
  })

  # Model performance metrics
  output$gdp_model_metrics <- renderPrint({
    model <- fit_gdp_model()
    cat("Model Information:\n")
    cat("------------------\n")
    cat("AIC:", round(model$aic, 2), "\n")
    cat("BIC:", round(model$bic, 2), "\n")
    cat("RMSE:", round(sqrt(mean(model$residuals^2)), 2), "\n")
    cat("MAE:", round(mean(abs(model$residuals)), 2), "\n")
  })

  # GDP Interpretation
  output$gdp_interpretation <- renderText({
    model <- fit_gdp_model()
    forecast_data <- forecast(model, h=5)
    ts_data <- gdp_ts_data()
    
    # Get next year's forecast and current year's value
    next_year <- forecast_data$mean[1]
    current_value <- tail(ts_data, 1)
    lower_ci <- forecast_data$lower[1, "95%"]
    upper_ci <- forecast_data$upper[1, "95%"]
    
    # Calculate year-over-year change
    yoy_change <- ((next_year - current_value) / current_value) * 100
    
    if(input$gdp_metric == 'growth_rate') {
      # ARIMA(1,1,1) interpretation for growth rate
      if(input$gdp_model_type == "arima_111") {
        sprintf(
          "Using the ARIMA(1,1,1) model, Rwanda's GDP growth rate is forecasted to be %.1f%% in 2025 (95%% CI: %.1f%% to %.1f%%). This represents a %.1f percentage point change from the current rate of %.1f%%. %s",
          next_year,
          lower_ci,
          upper_ci,
          next_year - current_value,
          current_value,
          if(next_year > current_value) 
            "The model indicates accelerating economic growth ahead." 
          else 
            "The model suggests a moderation in the growth pace."
        )
      } else {
        # ARIMA(2,1,2) interpretation for growth rate
        sprintf(
          "The more complex ARIMA(2,1,2) model projects a GDP growth rate of %.1f%% for 2025 (95%% CI: %.1f%% to %.1f%%). Compared to the current rate of %.1f%%, this represents a %.1f percentage point change. %s The model's wider parameter set suggests %s.",
          next_year,
          lower_ci,
          upper_ci,
          current_value,
          next_year - current_value,
          if(next_year > current_value) 
            "This points to strengthening economic momentum."
          else 
            "This indicates a potential cooling in economic activity.",
          if(abs(upper_ci - lower_ci) < 2)
            "high forecast confidence"
          else
            "moderate forecast uncertainty"
        )
      }
    } else {
      # ARIMA(1,1,1) interpretation for nominal GDP
      if(input$gdp_model_type == "arima_111") {
        sprintf(
          "The ARIMA(1,1,1) model forecasts Rwanda's nominal GDP to reach %.1f USD billions in 2025 (95%% CI: %.1f to %.1f USD billions). This represents a %.1f%% increase from the current level of %.1f USD billions. %s",
          next_year,
          lower_ci,
          upper_ci,
          yoy_change,
          current_value,
          if(yoy_change > 0) 
            "The projection indicates robust economic expansion in nominal terms."
          else 
            "The forecast suggests potential economic headwinds ahead."
        )
      } else {
        # ARIMA(2,1,2) interpretation for nominal GDP
        sprintf(
          "Using the ARIMA(2,1,2) model's advanced specification, Rwanda's nominal GDP is projected to reach %.1f USD billions in 2025 (95%% CI: %.1f to %.1f USD billions). From the current %.1f USD billions, this implies a %.1f%% change. %s The model's additional parameters capture %s in the GDP trajectory.",
          next_year,
          lower_ci,
          upper_ci,
          current_value,
          yoy_change,
          if(yoy_change > 0)
            "This suggests sustained economic growth momentum."
          else
            "This indicates potential economic adjustment periods ahead.",
          if(abs(upper_ci - lower_ci) < (current_value * 0.1))
            "finer nuances"
          else
            "broader variations"
        )
      }
    }
  })
  
  # Function to fit selected inflation model
  inflation_model <- reactive({
    # Get and validate time series data
    ts_data <- req(inflation_ts_data())
    validate(need(!is.null(ts_data) && length(ts_data) > 0, 
                 "Time series data must have observations"))
    
    tryCatch({
      # Fit model based on selection
      if(input$inflation_model == "arima111") {
        Arima(ts_data, order=c(1,1,1))
      } else {
        Arima(ts_data, order=c(2,1,2))
      }
    }, error = function(e) {
      validate(need(FALSE, paste("Error fitting model:", e$message)))
    })
  })

  # Inflation Forecast Plot
  output$inflation_forecast_plot <- renderPlotly({
    # Use the loaded Rwanda_inflation data frame and ensure required cols exist
    req(exists("Rwanda_inflation"))
    df <- Rwanda_inflation
    req(all(c("Year", "Annual averg-Inflation_Rate_Percent") %in% names(df)))

    df <- df %>%
      mutate(Year = as.integer(Year),
             Rate = as.numeric(`Annual averg-Inflation_Rate_Percent`)) %>%
      arrange(Year)

    # Build time series
    ts_data <- ts(df$Rate, start = min(df$Year), frequency = 1)

    # Select model
    model <- tryCatch({
      if (isTruthy(input$inflation_model) && input$inflation_model == 'arima111') {
        Arima(ts_data, order = c(1,1,1))
      } else if (isTruthy(input$inflation_model) && input$inflation_model == 'arima212') {
        Arima(ts_data, order = c(2,1,2))
      } else {
        auto.arima(ts_data)
      }
    }, error = function(e) {
      validate(need(FALSE, paste('ARIMA fit error:', e$message)))
    })

    # Forecast (5-year horizon to match other charts)
    h <- 5
    fcast <- forecast(model, h = h)

    hist_years <- df$Year
    hist_values <- df$Rate
    max_year <- max(hist_years)
    f_years <- seq(max_year + 1, max_year + h)

    # Plot historical, forecast and CI
    p <- plot_ly() %>%
      add_lines(x = hist_years, y = hist_values, name = 'Historical', line = list(color = '#0B78A0', width = 2)) %>%
      add_lines(x = f_years, y = as.numeric(fcast$mean), name = 'Forecast', line = list(color = '#157A4A', width = 2, dash = 'dash')) %>%
      add_ribbons(x = f_years,
                  ymin = as.numeric(fcast$lower[,'95%']),
                  ymax = as.numeric(fcast$upper[,'95%']),
                  name = '95% CI', fillcolor = 'rgba(21,122,74,0.15)', line = list(color = 'transparent')) %>%
      layout(
        title = list(text = paste('Inflation Rate Forecast -',
                                  ifelse(input$inflation_model == 'arima111', 'ARIMA(1,1,1)',
                                         ifelse(input$inflation_model == 'arima212', 'ARIMA(2,1,2)', 'Auto ARIMA'))),
                     font = list(size = 18, color = '#0B78A0')),
        xaxis = list(title = 'Year', tickmode = 'linear', dtick = 1, range = c(min(hist_years), max(f_years))),
        yaxis = list(title = 'Annual averg-Inflation_Rate_Percent', tickformat = '.1f'),
        hovermode = 'x unified', showlegend = TRUE
      )

    p
  })
  
  # Production Output Forecast Plot
  output$production_forecast_plot <- renderPlotly({
    req(exists('Rwanda_production_output'))
    df <- Rwanda_production_output
    req(all(c('Year', 'Agricultural_Yield_Billion_USD','Industrial_Output_Billion_USD','Service_Output_Billion_USD') %in% names(df)))

    var_col <- req(input$production_variable)
    model_choice <- req(input$production_model)

    df2 <- df %>%
      mutate(Year = as.integer(Year),
             Value = as.numeric(.data[[var_col]])) %>%
      arrange(Year)

    ts_data <- ts(df2$Value, start = min(df2$Year), frequency = 1)

    model <- tryCatch({
      if(model_choice == 'arima111') Arima(ts_data, order = c(1,1,1))
      else Arima(ts_data, order = c(2,1,2))
    }, error = function(e) validate(need(FALSE, paste('Error fitting model:', e$message))))

    h <- 5
    fcast <- forecast(model, h = h)

    hist_years <- df2$Year
    hist_values <- df2$Value
    max_year <- max(hist_years)
    f_years <- seq(max_year + 1, max_year + h)

    y_title <- switch(var_col,
                      'Agricultural_Yield_Billion_USD' = 'Agricultural Yield (Billion USD)',
                      'Industrial_Output_Billion_USD' = 'Industrial Output (Billion USD)',
                      'Service_Output_Billion_USD' = 'Service Output (Billion USD)')

    # Use bar chart for historical data and show forecast as distinct bars with a semi-transparent CI ribbon
    p <- plot_ly()
    # Historical bars
    p <- p %>% add_bars(x = hist_years, y = hist_values, name = 'Historical', marker = list(color = '#0B78A0'), hovertemplate = paste('<b>Year</b>: %{x}<br><b>', y_title, '</b>: %{y}<extra></extra>'))
    # Forecast bars (if forecast succeeded)
    if(!is.null(fcast)){
      p <- p %>% add_bars(x = f_years, y = as.numeric(fcast$mean), name = 'Forecast (mean)', marker = list(color = 'rgba(21,122,74,0.8)'), hovertemplate = paste('<b>Year</b>: %{x}<br><b>Forecast</b>: %{y}<extra></extra>')) %>%
        add_ribbons(x = f_years,
                    ymin = as.numeric(fcast$lower[,'95%']),
                    ymax = as.numeric(fcast$upper[,'95%']),
                    name = '95% CI', fillcolor = 'rgba(21,122,74,0.15)', line = list(color = 'transparent'), hoverinfo = 'none')
    }

    p <- p %>% layout(title = list(text = paste(y_title, ' - Historical & Forecast'), font = list(size = 18, color = '#0B78A0')),
                       xaxis = list(title = 'Year', tickmode = 'linear', dtick = 1, range = c(min(hist_years), max(f_years))),
                       yaxis = list(title = y_title),
                       barmode = 'group',
                       hovermode = 'x unified', showlegend = TRUE)

    p
  })
  
  # Interpretations
  output$gdp_interpretation <- renderText({
    model <- fit_gdp_model()
    forecast_data <- forecast(model, h=5)
    ts_data <- gdp_ts_data()
    
    # Get next year's forecast and current year's value
    next_year <- forecast_data$mean[1]
    current_value <- tail(ts_data, 1)
    lower_ci <- forecast_data$lower[1, "95%"]
    upper_ci <- forecast_data$upper[1, "95%"]
    
    # Calculate year-over-year change
    yoy_change <- ((next_year - current_value) / current_value) * 100
    
    if(input$gdp_metric == 'growth_rate') {
      if(input$gdp_model_type == 'arima_111') {
        # ARIMA(1,1,1) Growth Rate Interpretation
        sprintf(
          "Based on the ARIMA(1,1,1) model analysis, Rwanda's GDP growth rate is projected to be %.1f%% in 2025 (95%% CI: %.1f%% to %.1f%%). This represents a %.1f percentage point change from the current %.1f%% growth rate. %s The model's performance metrics suggest %s.",
          next_year,
          lower_ci,
          upper_ci,
          next_year - current_value,
          current_value,
          if(next_year > current_value) 
            "The projection indicates strengthening economic momentum."
          else 
            "The forecast suggests a moderation in growth dynamics.",
          if(abs(upper_ci - lower_ci) < 2)
            "high forecast reliability"
          else
            "moderate forecast uncertainty"
        )
      } else {
        # ARIMA(2,1,2) Growth Rate Interpretation
        sprintf(
          "Using the more sophisticated ARIMA(2,1,2) model, which captures longer-term economic patterns, Rwanda's GDP growth is forecast at %.1f%% for 2025 (95%% CI: %.1f%% to %.1f%%). From the current %.1f%% rate, this %.1f percentage point shift %s The model's broader parameter set %s in the growth trajectory.",
          next_year,
          lower_ci,
          upper_ci,
          current_value,
          next_year - current_value,
          if(next_year > current_value)
            "indicates accelerating economic expansion."
          else
            "suggests a tempering of growth momentum.",
          if(abs(upper_ci - lower_ci) < 2)
            "provides increased confidence"
          else
            "reflects some uncertainty"
        )
      }
    } else {
      # Nominal GDP interpretations
      if(input$gdp_model_type == 'arima_111') {
        # ARIMA(1,1,1) Nominal GDP Interpretation
        sprintf(
          "The ARIMA(1,1,1) model forecasts Rwanda's nominal GDP to reach %.1f USD billions in 2025 (95%% CI: %.1f to %.1f USD billions). This represents a %.1f%% change from the current level of %.1f USD billions. %s The confidence interval suggests %s in this projection.",
          next_year,
          lower_ci,
          upper_ci,
          yoy_change,
          current_value,
          if(yoy_change > 0)
            "The forecast indicates continued economic expansion in nominal terms."
          else
            "The projection suggests potential economic headwinds ahead.",
          if(abs(upper_ci - lower_ci) < (current_value * 0.1))
            "high confidence"
          else
            "moderate uncertainty"
        )
      } else {
        # ARIMA(2,1,2) Nominal GDP Interpretation
        sprintf(
          "Utilizing the ARIMA(2,1,2) model's enhanced specifications, Rwanda's nominal GDP is projected to reach %.1f USD billions in 2025 (95%% CI: %.1f to %.1f USD billions). From the current %.1f USD billions, this %.1f%% change %s %s in the economic outlook.",
          next_year,
          lower_ci,
          upper_ci,
          current_value,
          yoy_change,
          if(yoy_change > 0)
            "reflects robust economic growth."
          else
            "indicates potential economic adjustments.",
          if(abs(upper_ci - lower_ci) < (current_value * 0.1))
            "The narrow confidence interval suggests high reliability"
          else
            "The wider confidence bounds indicate increased uncertainty"
        )
      }
    }
  })
  
  # Inflation Model Performance Metrics
  output$inflation_model_metrics <- renderPrint({
    # Get model
    model <- req(inflation_model())
    
    # Calculate metrics
    residuals <- residuals(model)
    rmse <- sqrt(mean(residuals^2))
    mae <- mean(abs(residuals))
    
    # Print metrics with better formatting
    cat("\nModel Performance Metrics:\n")
    cat("========================\n")
    cat(sprintf("AIC:  %8.2f\n", model$aic))
    cat(sprintf("BIC:  %8.2f\n", model$bic))
    cat(sprintf("RMSE: %8.2f\n", rmse))
    cat(sprintf("MAE:  %8.2f\n", mae))
    
    # Add model diagnostics
    cat("\nModel Diagnostics:\n")
    cat("=================\n")
    cat(sprintf("Variance: %8.2f\n", var(residuals)))
    cat(sprintf("Std Dev:  %8.2f\n", sd(residuals)))
  })

  # Inflation Interpretation
  output$inflation_interpretation <- renderText({
    # Get model and generate forecast
    model <- req(inflation_model())
    ts_data <- req(inflation_ts_data())
    forecast_data <- forecast(model, h=5)
    
    # Get current and forecasted values
    current_value <- tail(ts_data, 1)
    next_year <- forecast_data$mean[1]
    change <- next_year - current_value
    
    # Get confidence intervals
    lower_ci <- forecast_data$lower[1, "95%"]
    upper_ci <- forecast_data$upper[1, "95%"]
    ci_width <- upper_ci - lower_ci
    
    # Get next year's forecast and current value
    next_year <- forecast_data$mean[1]
    current_value <- tail(inflation_ts_data(), 1)
    lower_ci <- forecast_data$lower[1, "95%"]
    upper_ci <- forecast_data$upper[1, "95%"]
    
    if(input$inflation_model == 'arima111') {
      # ARIMA(1,1,1) Inflation Interpretation
      sprintf(
        paste(
          "Based on the ARIMA(1,1,1) model analysis, Rwanda's annual average inflation rate",
          "is projected to be %.1f%% in the next year (95%% CI: %.1f%% to %.1f%%).",
          "This represents a %.1f percentage point change from the current rate of %.1f%%.",
          "%s The forecast confidence interval of %.1f percentage points indicates %s."
        ),
        next_year,
        lower_ci,
        upper_ci,
        change,
        current_value,
        if(change > 0) 
          "This suggests potential upward price pressures ahead."
        else 
          "This indicates possible moderation in price levels.",
        ci_width,
        if(ci_width < 2)
          "high forecast reliability"
        else if(ci_width < 4)
          "moderate forecast uncertainty"
        else
          "considerable forecast uncertainty"
      )
    } else {
      # ARIMA(2,1,2) Inflation Interpretation
      sprintf(
        paste(
          "Using the more sophisticated ARIMA(2,1,2) model, which captures complex inflation patterns,",
          "Rwanda's annual average inflation rate is forecast at %.1f%% (95%% CI: %.1f%% to %.1f%%).",
          "From the current rate of %.1f%%, this %.1f percentage point shift %s",
          "The model's broader parameter set and %.1f point confidence interval width %s in the inflation trajectory."
        ),
        next_year,
        lower_ci,
        upper_ci,
        current_value,
        change,
        if(change > 0)
          "suggests potential inflationary pressures building up."
        else
          "indicates a possible moderation in price levels.",
        ci_width,
        if(ci_width < 2)
          "provides high confidence"
        else if(ci_width < 4)
          "indicates moderate uncertainty"
        else
          "suggests careful monitoring may be needed"
      )
    }
  })
  
  output$production_model_metrics <- renderPrint({
    req(exists('Rwanda_production_output'))
    df <- Rwanda_production_output
    var_col <- req(input$production_variable)
    df2 <- df %>% mutate(Value = as.numeric(.data[[var_col]]))
    ts_data <- ts(df2$Value, start = min(df$Year), frequency = 1)
    model_choice <- req(input$production_model)
    model <- tryCatch({
      if(model_choice == 'arima111') Arima(ts_data, order = c(1,1,1))
      else Arima(ts_data, order = c(2,1,2))
    }, error = function(e) NULL)
    if(is.null(model)){
      cat('Model fit error')
      return()
    }
    res <- residuals(model)
    rmse <- sqrt(mean(res^2, na.rm = TRUE))
    mae <- mean(abs(res), na.rm = TRUE)
    cat('Model Performance Metrics:\n')
    cat('========================\n')
    cat(sprintf('AIC:  %6.2f\n', model$aic))
    cat(sprintf('BIC:  %6.2f\n', model$bic))
    cat(sprintf('RMSE: %6.2f\n', rmse))
    cat(sprintf('MAE:  %6.2f\n', mae))
    cat('\nModel Diagnostics:\n')
    cat('=================\n')
    cat(sprintf('Variance: %6.2f\n', var(res, na.rm = TRUE)))
    cat(sprintf('Std Dev:  %6.2f\n', sd(res, na.rm = TRUE)))
  })

  output$production_interpretation <- renderText({
    req(exists('Rwanda_production_output'))
    df <- Rwanda_production_output
    var_col <- req(input$production_variable)
    model_choice <- req(input$production_model)
    df2 <- df %>% mutate(Value = as.numeric(.data[[var_col]]))
    ts_data <- ts(df2$Value, start = min(df$Year), frequency = 1)
    model <- tryCatch({
      if(model_choice == 'arima111') Arima(ts_data, order = c(1,1,1))
      else Arima(ts_data, order = c(2,1,2))
    }, error = function(e) NULL)
    if(is.null(model)) return('Model fit error')
    fcast <- forecast(model, h = 1)
    nxt <- as.numeric(fcast$mean[1])
    cur <- as.numeric(tail(ts_data,1))
    lower <- as.numeric(fcast$lower[1,'95%'])
    upper <- as.numeric(fcast$upper[1,'95%'])
    change <- nxt - cur
    var_label <- switch(var_col,
                        'Agricultural_Yield_Billion_USD' = 'Agricultural yield',
                        'Industrial_Output_Billion_USD' = 'Industrial output',
                        'Service_Output_Billion_USD' = 'Service output')
    if (model_choice == 'arima111') {
      if (change > 0) {
        concl <- "This suggests a near-term increase in the series."
      } else {
        concl <- "This suggests near-term moderation or decline."
      }
      msg <- sprintf(
        "Based on the ARIMA(1,1,1) model, Rwanda's %s is projected at %.2f (95%% CI: %.2f to %.2f). This is a %.2f change from the current %.2f. %s",
        var_label, nxt, lower, upper, change, cur, concl
      )
      msg
    } else {
      ciw <- upper - lower
      if (ciw < abs(cur) * 0.1) conf_text <- "higher confidence" else if (ciw < abs(cur) * 0.3) conf_text <- "moderate uncertainty" else conf_text <- "considerable uncertainty"
      msg <- sprintf(
        "Using ARIMA(2,1,2), Rwanda's %s is forecast at %.2f (95%% CI: %.2f to %.2f). Change from current %.2f is %.2f. CI width %.2f suggests %s.",
        var_label, nxt, lower, upper, cur, change, ciw, conf_text
      )
      msg
    }
  })
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
    Value = c(67.8, 68.4, 68.9, 69.3, 69.5, 70.7)
  )
  poverty_data <- data.frame(
    Year = trend_years,
    Value = c(42.0, 40.5, 39.1, 38.2, 36.9, 27.4)
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
        frame = 1000,
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
        frame = 1000,
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
        frame = 1000,
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
  format_dem_count_value <- function(value, format = "plain", decimals = 0) {
    if (format == "comma") {
      formatC(value, format = "f", big.mark = ",", digits = decimals)
    } else {
      sprintf(paste0("%.", decimals, "f"), value)
    }
  }
  
  build_dem_count_span <- function(value,
                                   format = "plain",
                                   decimals = 0,
                                   suffix = "",
                                   prefix = "",
                                   duration = 1400) {
    if (is.null(value) || is.na(value)) {
      return(tags$span("N/A"))
    }
    
    formatted <- format_dem_count_value(value, format, decimals)
    tags$span(
      class = "dem-count",
      `data-count-target` = signif(value, 10),
      `data-count-format` = format,
      `data-count-decimals` = decimals,
      `data-count-suffix` = suffix,
      `data-count-prefix` = prefix,
      `data-count-duration` = duration,
      `data-count-display` = paste0(prefix, formatted, suffix),
      paste0(prefix, formatted, suffix)
    )
  }
  # Population Chart - Professional statistical visualization
  output$dem_population_chart <- renderPlotly({
    pop_data <- load_population_data()
    if (is.null(pop_data) || !is.data.frame(pop_data) || nrow(pop_data) == 0) {
      return(plotly_empty() %>% layout(title = "No data available"))
    }
    
    # Ensure year column exists and is numeric
    if (!"year" %in% names(pop_data)) {
      return(plotly_empty() %>% layout(title = "Invalid data structure"))
    }
    
    # Sort by year ascending
    pop_data <- pop_data[order(as.numeric(pop_data$year)), ]
    
    # Convert population from millions to actual numbers for display
    pop_data$population_actual <- pop_data$population_millions * 1000000
    
    # Calculate growth rate if not present
    if (!"population_growth_rate_percent" %in% names(pop_data) || all(is.na(pop_data$population_growth_rate_percent))) {
      pop_data$population_growth_rate_percent <- c(NA, round(diff(pop_data$population_actual) / head(pop_data$population_actual, -1) * 100, 2))
    }
    
    # Create dual-axis chart: Population (bars) and Growth Rate (line)
    p <- plot_ly(pop_data, x = ~year, hovermode = 'x unified') %>%
      add_bars(
        y = ~population_actual,
        name = 'Population',
        marker = list(
          color = 'rgba(30, 64, 175, 0.8)',
          line = list(color = 'rgba(30, 64, 175, 1.0)', width = 1.5)
        ),
        hovertemplate = '<b>Year:</b> %{x}<br><b>Population:</b> %{y:,.0f}<extra></extra>'
      ) %>%
      add_trace(
        y = ~population_growth_rate_percent,
        name = 'Growth Rate (%)',
        type = 'scatter',
        mode = 'lines+markers',
        line = list(color = '#0ea5e9', width = 3),
        marker = list(size = 8, color = '#0ea5e9'),
        yaxis = 'y2',
        hovertemplate = '<b>Year:</b> %{x}<br><b>Growth Rate:</b> %{y:.2f}%<extra></extra>'
      ) %>%
      layout(
        title = list(
          text = 'Rwanda Population Trends (2010-2024)',
          font = list(size = 20, color = '#1e40af', family = 'Arial, sans-serif')
        ),
        xaxis = list(
          title = list(text = 'Year', font = list(size = 14, color = '#475569')),
          showgrid = TRUE,
          gridcolor = 'rgba(0,0,0,0.1)',
          tickmode = 'linear',
          dtick = 1
        ),
        yaxis = list(
          title = list(text = 'Population', font = list(size = 14, color = '#475569')),
          rangemode = 'tozero',
          showgrid = TRUE,
          gridcolor = 'rgba(0,0,0,0.1)',
          tickformat = ',.0f'
        ),
        yaxis2 = list(
          title = list(text = 'Growth Rate (%)', font = list(size = 14, color = '#0ea5e9')),
          overlaying = 'y',
          side = 'right',
          showgrid = FALSE
        ),
        legend = list(
          orientation = 'h',
          x = 0.5,
          xanchor = 'center',
          y = 1.15,
          font = list(size = 12)
        ),
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        margin = list(t = 80, r = 80, b = 60, l = 80),
        hoverlabel = list(
          bgcolor = 'rgba(255,255,255,0.95)',
          bordercolor = '#1e40af',
          font = list(size = 12, color = '#1e40af')
        )
      ) %>%
      config(displayModeBar = TRUE, displaylogo = FALSE)
    
    return(p)
  })
  
  # Helper function to load agriculture data from CSV
  load_agriculture_data <- function() {
    agri_data <- NULL
    
    # Use CSV directly for faster loading
    if (exists('Rwanda_agriculture') && !is.null(Rwanda_agriculture)) {
      message("[AGRICULTURE] ✅ Loading from CSV")
      agri_data <- as.data.frame(Rwanda_agriculture)
    } else {
      # Try to load from file if not in global environment
      tryCatch({
        agri_data <- read.csv("data/datasets/rwanda_agriculture yields crops_ to GDP.csv")
        message("[AGRICULTURE] ✅ Loaded from CSV file")
      }, error = function(e) {
        message(sprintf("[AGRICULTURE] ❌ Could not load CSV: %s", e$message))
      })
    }
    
    return(agri_data)
  }
  
  # Helper function to load labor force data from CSV
  load_labor_force_data <- function() {
    labor_data <- NULL
    
    # Use CSV directly for faster loading
    if (exists('Rwanda_labor_force') && !is.null(Rwanda_labor_force)) {
      message("[LABOR FORCE] ✅ Loading from CSV")
      labor_data <- as.data.frame(Rwanda_labor_force)
    } else {
      # Try to load from file if not in global environment
      tryCatch({
        labor_data <- read.csv("data/datasets/Rwanda_Labour_Force.csv")
        message("[LABOR FORCE] ✅ Loaded from CSV file")
      }, error = function(e) {
        message(sprintf("[LABOR FORCE] ❌ Could not load CSV: %s", e$message))
      })
    }
    
    return(labor_data)
  }

  # Helper function to load population data from database
  load_population_data <- function() {
    pop_data <- NULL
    
    # Try database first
    tryCatch({
      conn <- get_neon_connection()
      on.exit({
        if (!is.null(conn) && dbIsValid(conn)) {
          dbDisconnect(conn)
        }
      }, add = TRUE)
      
      # First, try to find the table and get column names
      schema_variations <- c(
        '"demographic & agriculture"',
        'demographic_agriculture',
        'demographic',
        '"demographics & agriculture"',
        'demographics',
        'public'
      )
      
      found_table <- FALSE
      for (schema_name in schema_variations) {
        tryCatch({
          # First check if table exists and get column names
          if (grepl('"', schema_name)) {
            check_query <- sprintf('SELECT column_name FROM information_schema.columns WHERE table_schema = %s AND table_name = \'rwanda_population\'', schema_name)
          } else {
            check_query <- sprintf('SELECT column_name FROM information_schema.columns WHERE table_schema = \'%s\' AND table_name = \'rwanda_population\'', schema_name)
          }
          
          cols <- dbGetQuery(conn, check_query)
          if (!is.null(cols) && nrow(cols) > 0) {
            # Found the table! Get the actual column names
            col_names <- cols$column_name
            message(sprintf("[POPULATION] ✅ Found table in schema: %s", schema_name))
            message(sprintf("[POPULATION] Columns: %s", paste(col_names, collapse=", ")))
            
            # Find the growth rate column (might be truncated)
            growth_col <- col_names[grepl('growth|rate', col_names, ignore.case = TRUE)][1]
            if (is.na(growth_col)) growth_col <- NULL
            
            # Build query with actual column names
            if (!is.null(growth_col)) {
              query <- sprintf('SELECT year, population_millions, "%s" as population_growth_rate_percent FROM %s.rwanda_population ORDER BY year DESC', growth_col, schema_name)
            } else {
              query <- sprintf('SELECT year, population_millions FROM %s.rwanda_population ORDER BY year DESC', schema_name)
            }
            
            pop_data <- dbGetQuery(conn, query)
            if (!is.null(pop_data) && nrow(pop_data) > 0) {
              found_table <- TRUE
              message(sprintf("[POPULATION] ✅ Loaded %d rows from database", nrow(pop_data)))
              break
            }
          }
        }, error = function(e) {
          # Schema doesn't exist or table not found, continue
        })
      }
      
      # Try without schema (public schema or no schema)
      if (!found_table) {
        tryCatch({
          # Get column names first
          cols <- dbGetQuery(conn, "SELECT column_name FROM information_schema.columns WHERE table_name = 'rwanda_population' LIMIT 10")
          if (!is.null(cols) && nrow(cols) > 0) {
            col_names <- cols$column_name
            growth_col <- col_names[grepl('growth|rate', col_names, ignore.case = TRUE)][1]
            
            if (!is.null(growth_col) && !is.na(growth_col)) {
              query <- sprintf('SELECT year, population_millions, "%s" as population_growth_rate_percent FROM rwanda_population ORDER BY year DESC', growth_col)
            } else {
              query <- "SELECT year, population_millions FROM rwanda_population ORDER BY year DESC"
            }
            
            pop_data <- dbGetQuery(conn, query)
            if (!is.null(pop_data) && nrow(pop_data) > 0) {
              message("[POPULATION] ✅ Loaded without schema")
            }
          }
        }, error = function(e) {
          message(sprintf("[POPULATION] Direct query failed: %s", e$message))
        })
      }
    }, error = function(e) {
      message(sprintf("[POPULATION] Database connection failed: %s", e$message))
    })
    
    # Fallback to CSV if database fails
    if (is.null(pop_data) || nrow(pop_data) == 0) {
      if (exists('Rwanda_population') && !is.null(Rwanda_population)) {
        message("[POPULATION] Using CSV fallback")
        pop_data <- as.data.frame(Rwanda_population)
        
        # Ensure it's a data frame with proper structure
        if (is.data.frame(pop_data) && nrow(pop_data) > 0) {
          # Find year column (usually first column)
          year_col <- names(pop_data)[1]
          names(pop_data)[1] <- "year"
          
          # Find population column (numeric columns)
          pop_cols <- names(pop_data)[sapply(pop_data, is.numeric)]
          if (length(pop_cols) > 0 && !("year" %in% pop_cols)) {
            # Use first numeric column as population
            pop_col <- pop_cols[1]
            names(pop_data)[which(names(pop_data) == pop_col)] <- "population_millions"
          } else if ("year" %in% pop_cols && length(pop_cols) > 1) {
            # Use second numeric column
            pop_col <- pop_cols[pop_cols != "year"][1]
            names(pop_data)[which(names(pop_data) == pop_col)] <- "population_millions"
          }
          
          # Find growth rate column if exists
          growth_cols <- names(pop_data)[grepl('growth|rate', names(pop_data), ignore.case = TRUE)]
          if (length(growth_cols) > 0) {
            names(pop_data)[which(names(pop_data) == growth_cols[1])] <- "population_growth_rate_percent"
          } else {
            # Calculate growth rate
            pop_data <- pop_data[order(pop_data$year), ]
            if (nrow(pop_data) > 1 && "population_millions" %in% names(pop_data)) {
              pop_data$population_growth_rate_percent <- c(NA, round(diff(pop_data$population_millions) / head(pop_data$population_millions, -1) * 100, 2))
            }
          }
          
          # Ensure year is numeric
          pop_data$year <- as.numeric(pop_data$year)
        }
      }
    }
    
    # Ensure data structure is correct
    if (!is.null(pop_data) && is.data.frame(pop_data) && nrow(pop_data) > 0) {
      # Ensure required columns exist
      if (!"year" %in% names(pop_data) && ncol(pop_data) > 0) {
        names(pop_data)[1] <- "year"
      }
      if (!"population_millions" %in% names(pop_data) && ncol(pop_data) > 1) {
        numeric_cols <- names(pop_data)[sapply(pop_data, is.numeric)]
        numeric_cols <- numeric_cols[numeric_cols != "year"]
        if (length(numeric_cols) > 0) {
          names(pop_data)[which(names(pop_data) == numeric_cols[1])] <- "population_millions"
        }
      }
    }
    
    return(pop_data)
  }
  
  # Demographics Overview Stat Cards
  # Population Current
  output$dem_pop_current <- renderUI({
    pop_data <- load_population_data()
    if (is.null(pop_data) || nrow(pop_data) == 0) return(tags$span('N/A'))
    
    # Normalize column names
    if ("Year" %in% names(pop_data)) names(pop_data)[names(pop_data) == "Year"] <- "year"
    
    # Sort by year descending to get latest first
    if ("year" %in% names(pop_data)) {
      pop_data <- pop_data[order(as.numeric(pop_data$year), decreasing = TRUE), ]
    }
    
    # Find population column
    if ("population_millions" %in% names(pop_data)) {
      latest_pop_millions <- as.numeric(pop_data$population_millions[1])
    } else {
      # Try to find population column
      pop_cols <- names(pop_data)[grepl('population|pop', names(pop_data), ignore.case = TRUE) & sapply(pop_data, is.numeric)]
      if (length(pop_cols) > 0) {
        latest_pop_millions <- as.numeric(pop_data[[pop_cols[1]]][1])
      } else {
        # Use first numeric column (excluding year)
        numeric_cols <- names(pop_data)[sapply(pop_data, is.numeric) & names(pop_data) != "year"]
        if (length(numeric_cols) > 0) {
          latest_pop_millions <- as.numeric(pop_data[[numeric_cols[1]]][1])
        } else {
          return(tags$span('N/A'))
        }
      }
    }
    
    if (is.na(latest_pop_millions)) return(tags$span('N/A'))
    
    # Convert to actual population (millions * 1,000,000)
    latest_pop <- latest_pop_millions * 1000000
    
    build_dem_count_span(latest_pop, format = 'comma', decimals = 0)
  })
  
  output$dem_pop_change_pct <- renderText({
    pop_data <- load_population_data()
    if (is.null(pop_data) || nrow(pop_data) < 2) return('N/A')
    
    # Normalize column names
    if ("Year" %in% names(pop_data)) names(pop_data)[names(pop_data) == "Year"] <- "year"
    
    # Sort by year descending
    if ("year" %in% names(pop_data)) {
      pop_data <- pop_data[order(as.numeric(pop_data$year), decreasing = TRUE), ]
    }
    
    # Use growth rate from data if available
    if ("population_growth_rate_percent" %in% names(pop_data) && !is.na(pop_data$population_growth_rate_percent[1])) {
      growth_rate <- as.numeric(pop_data$population_growth_rate_percent[1])
      sign <- ifelse(growth_rate >= 0, '+', '')
      return(paste0(sign, sprintf('%.1f%%', growth_rate)))
    }
    
    # Find population column
    if ("population_millions" %in% names(pop_data)) {
      current <- as.numeric(pop_data$population_millions[1])
      previous <- as.numeric(pop_data$population_millions[2])
    } else {
      pop_cols <- names(pop_data)[grepl('population|pop', names(pop_data), ignore.case = TRUE) & sapply(pop_data, is.numeric)]
      if (length(pop_cols) > 0) {
        current <- as.numeric(pop_data[[pop_cols[1]]][1])
        previous <- as.numeric(pop_data[[pop_cols[1]]][2])
      } else {
        numeric_cols <- names(pop_data)[sapply(pop_data, is.numeric) & names(pop_data) != "year"]
        if (length(numeric_cols) > 0) {
          current <- as.numeric(pop_data[[numeric_cols[1]]][1])
          previous <- as.numeric(pop_data[[numeric_cols[1]]][2])
        } else {
          return('N/A')
        }
      }
    }
    
    if(is.na(current) || is.na(previous) || previous == 0) return('N/A')
    
    change_pct <- ((current - previous) / previous) * 100
    sign <- ifelse(change_pct >= 0, '+', '')
    paste0(sign, sprintf('%.1f%%', change_pct))
  })
  
  output$dem_pop_label <- renderText({
    pop_data <- load_population_data()
    if (is.null(pop_data) || nrow(pop_data) == 0) return('Data unavailable')
    
    # Normalize column names
    if ("Year" %in% names(pop_data)) names(pop_data)[names(pop_data) == "Year"] <- "year"
    
    # Sort by year descending
    if ("year" %in% names(pop_data)) {
      pop_data <- pop_data[order(as.numeric(pop_data$year), decreasing = TRUE), ]
      latest_year <- pop_data$year[1]
    } else {
      latest_year <- "N/A"
    }
    
    paste0('As of ', latest_year)
  })
  
  # Agricultural Land Use Percentage
  output$dem_agri_percent <- renderUI({
    land_data <- load_land_use_data()
    if (is.null(land_data) || !is.data.frame(land_data) || nrow(land_data) == 0) return(tags$span('N/A'))
    
    df <- as.data.frame(land_data)
    
    # Find year column
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
    }
    
    # Method 1: If we have category-based data (like pie chart), find and sum agricultural categories
    # Look for category column (non-numeric, not year) - same logic as pie chart
    non_numeric_cols <- names(df)[!sapply(df, is.numeric) & !grepl('year|Year', names(df), ignore.case = TRUE)]
    category_col <- NULL
    if (length(non_numeric_cols) > 0) {
      category_col <- non_numeric_cols[1]
    }
    
    # Look for percentage/value columns - same logic as pie chart
    pct_cols <- names(df)[grepl('percent|%|pct|share|value', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    value_col <- NULL
    if (length(pct_cols) > 0) {
      value_col <- pct_cols[1]
    } else {
      # Use first numeric column (excluding year)
      numeric_cols <- names(df)[sapply(df, is.numeric) & !names(df) %in% year_cols]
      if (length(numeric_cols) > 0) {
        value_col <- numeric_cols[1]
      }
    }
    
    # If we have category and value columns, find agricultural rows
    if (!is.null(category_col) && !is.null(value_col) && category_col %in% names(df) && value_col %in% names(df)) {
      # Get all rows for latest year if year column exists
      if (length(year_cols) > 0) {
        latest_year <- df[[year_col]][1]
        df_year <- df[df[[year_col]] == latest_year, ]
      } else {
        df_year <- df
      }
      
      # Find agricultural categories - try multiple patterns
      agri_patterns <- c('agricultural', 'arable', 'farm', 'crop', 'cultivated', 'agriculture')
      agri_pct <- 0
      
      for (pattern in agri_patterns) {
        agri_rows <- df_year[grepl(pattern, as.character(df_year[[category_col]]), ignore.case = TRUE), ]
        if (nrow(agri_rows) > 0) {
          agri_values <- as.numeric(agri_rows[[value_col]])
          agri_pct <- agri_pct + sum(agri_values[!is.na(agri_values)], na.rm = TRUE)
        }
      }
      
      if (agri_pct > 0 && agri_pct <= 100) {
        return(build_dem_count_span(agri_pct, format = 'decimal', decimals = 1, suffix = '%'))
      }
    }
    
    # Method 2: If no category column, check if first column contains categories (row-based data)
    if (is.null(category_col) && ncol(df) >= 2) {
      # First column might be categories, second might be values
      first_col <- names(df)[1]
      if (!grepl('year|Year', first_col, ignore.case = TRUE) && !sapply(df, is.numeric)[1]) {
        # First column is likely categories
        if (length(year_cols) > 0) {
          latest_year <- df[[year_col]][1]
          df_year <- df[df[[year_col]] == latest_year, ]
        } else {
          df_year <- df
        }
        
        # Find value column (first numeric column after first column)
        value_cols <- names(df_year)[sapply(df_year, is.numeric) & !names(df_year) %in% year_cols]
        if (length(value_cols) > 0) {
          value_col <- value_cols[1]
          
          # Find agricultural rows
          agri_patterns <- c('agricultural', 'arable', 'farm', 'crop', 'cultivated', 'agriculture')
          agri_pct <- 0
          
          for (pattern in agri_patterns) {
            agri_rows <- df_year[grepl(pattern, as.character(df_year[[first_col]]), ignore.case = TRUE), ]
            if (nrow(agri_rows) > 0) {
              agri_values <- as.numeric(agri_rows[[value_col]])
              agri_pct <- agri_pct + sum(agri_values[!is.na(agri_values)], na.rm = TRUE)
            }
          }
          
          if (agri_pct > 0 && agri_pct <= 100) {
            return(build_dem_count_span(agri_pct, format = 'decimal', decimals = 1, suffix = '%'))
          }
        }
      }
    }
    
    # Method 3: Try to find agricultural percentage directly in column names
    pct_cols <- names(df)[grepl('agricultural.*percent|percent.*agricultural|agricultural.*%|%.*agricultural|agri.*pct|agricultural.*share', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    if (length(pct_cols) > 0) {
      if (length(year_cols) > 0) {
        latest_pct <- as.numeric(df[[pct_cols[1]]][1])
      } else {
        latest_pct <- as.numeric(df[[pct_cols[1]]][nrow(df)])
      }
      if (!is.na(latest_pct) && latest_pct > 0) {
        return(build_dem_count_span(latest_pct, format = 'decimal', decimals = 1, suffix = '%'))
      }
    }
    
    # Method 4: Try all rows and find agricultural row directly by checking all columns
    if (nrow(df) > 0) {
      # Get latest year's data
      if (length(year_cols) > 0) {
        latest_year <- df[[year_col]][1]
        df_year <- df[df[[year_col]] == latest_year, ]
      } else {
        df_year <- df
      }
      
      # Look through all rows to find agricultural-related entries
      for (i in 1:nrow(df_year)) {
        row_data <- df_year[i, ]
        row_text <- paste(as.character(row_data), collapse = " ")
        
        # Check if this row contains agricultural keywords
        if (grepl('agricultural|arable|farm|crop|cultivated|agriculture', row_text, ignore.case = TRUE)) {
          # Find numeric columns in this row
          for (col in names(row_data)) {
            if (sapply(df_year, is.numeric)[col]) {
              val <- as.numeric(row_data[[col]])
              if (!is.na(val) && val > 0 && val <= 100) {
                return(build_dem_count_span(val, format = 'decimal', decimals = 1, suffix = '%'))
              }
            }
          }
        }
      }
      
      # Method 5: If still not found, check for value around 60.6 (agricultural land use)
      # This is a fallback to find the agricultural percentage even if category name doesn't match
      for (col in names(df_year)) {
        if (sapply(df_year, is.numeric)[col]) {
          values <- as.numeric(df_year[[col]])
          # Look for values between 50 and 70 (likely agricultural percentage)
          agri_candidates <- values[!is.na(values) & values >= 50 & values <= 70]
          if (length(agri_candidates) > 0) {
            # Check if any row with this value has agricultural-related text
            for (i in 1:nrow(df_year)) {
              if (!is.na(df_year[i, col]) && df_year[i, col] >= 50 && df_year[i, col] <= 70) {
                row_text <- paste(as.character(df_year[i, ]), collapse = " ")
                if (grepl('agricultural|arable|farm|crop|cultivated|agriculture|land', row_text, ignore.case = TRUE)) {
                  val <- as.numeric(df_year[i, col])
                  return(build_dem_count_span(val, format = 'decimal', decimals = 1, suffix = '%'))
                }
              }
            }
            # If no match found but we have a value around 60, use it (likely agricultural)
            if (length(agri_candidates) == 1) {
              return(build_dem_count_span(agri_candidates[1], format = 'decimal', decimals = 1, suffix = '%'))
            }
          }
        }
      }
    }
    
    return(tags$span('N/A'))
  })
  
  output$dem_agri_change_pct <- renderText({
    land_data <- load_land_use_data()
    if (is.null(land_data) || !is.data.frame(land_data) || nrow(land_data) < 2) return('N/A')
    
    df <- as.data.frame(land_data)
    
    # Find year column
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) == 0) return('N/A')
    
    year_col <- year_cols[1]
    df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
    
    # Try to get percentage values for current and previous year
    pct_cols <- names(df)[grepl('agricultural.*percent|percent.*agricultural|agricultural.*%|%.*agricultural', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    if (length(pct_cols) == 0) {
      pct_cols <- names(df)[grepl('percent|%|pct', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    }
    
    if (length(pct_cols) == 0) return('N/A')
    
    current <- as.numeric(df[[pct_cols[1]]][1])
    previous <- as.numeric(df[[pct_cols[1]]][2])
    
    if (is.na(current) || is.na(previous)) return('N/A')
    
    change_pct <- current - previous
    sign <- ifelse(change_pct >= 0, '+', '')
    paste0(sign, sprintf('%.1f%%', change_pct))
  })
  
  output$dem_agri_label <- renderText({
    land_data <- load_land_use_data()
    if (is.null(land_data) || !is.data.frame(land_data) || nrow(land_data) == 0) return('Data unavailable')
    
    df <- as.data.frame(land_data)
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
      latest_year <- df[[year_col]][1]
      paste0('As of ', latest_year)
    } else {
      'Data unavailable'
    }
  })
  
  output$dem_land_use_pie <- renderPlotly({
    req(exists('Rwanda_land_use'))
    df <- as.data.frame(Rwanda_land_use)
    category_col <- names(df)[grepl('category', names(df), ignore.case = TRUE)][1]
    value_col <- names(df)[grepl('share|percent|%|value', names(df), ignore.case = TRUE) & sapply(df, is.numeric)][1]
    req(!is.na(category_col), !is.na(value_col))
    
    labels <- as.character(df[[category_col]])
    values <- as.numeric(df[[value_col]])
    total <- sum(values, na.rm = TRUE)
    
    plot_ly(
      labels = c('Total Land', labels),
      parents = c('', rep('Total Land', length(labels))),
      values = c(total, values),
      type = 'sunburst',
      branchvalues = 'total',
      hovertemplate = '%{label}: %{value:.1f}%<extra></extra>',
      insidetextorientation = 'radial'
    ) %>%
      layout(
        title = 'Land Use Composition',
        margin = list(t = 60, l = 0, r = 0, b = 0),
        sunburstcolorway = c('#0B78A0','#34D399','#FBBF24','#F472B6','#60A5FA','#A78BFA','#F97316'),
        extendsunburstcolors = TRUE
      )
  })
  
  # Birth Rate
  output$dem_birth_rate <- renderUI({
    if(!exists('Rwanda_vital_statistics')) return(tags$span('N/A'))
    df <- as.data.frame(Rwanda_vital_statistics)
    
    # Find year column
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
    } else {
      year_col <- names(df)[1]  # Use first column as fallback
    }
    
    # Find birth rate column
    birth_cols <- names(df)[grepl('birth|birthrate|birth_rate|crude.*birth|fertility', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    
    if(length(birth_cols) == 0) return(tags$span('N/A'))
    
    latest_birth <- as.numeric(df[[birth_cols[1]]][1])
    
    if(is.na(latest_birth)) return(tags$span('N/A'))
    build_dem_count_span(latest_birth, format = 'decimal', decimals = 2, suffix = '‰')
  })
  
  output$dem_birth_change_pct <- renderText({
    if(!exists('Rwanda_vital_statistics')) return('N/A')
    df <- as.data.frame(Rwanda_vital_statistics)
    
    if (nrow(df) < 2) return('N/A')
    
    # Find year column
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
    } else {
      year_col <- names(df)[1]
    }
    
    birth_cols <- names(df)[grepl('birth|birthrate|birth_rate|crude.*birth|fertility', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    
    if(length(birth_cols) == 0) return('N/A')
    
    current <- as.numeric(df[[birth_cols[1]]][1])
    previous <- as.numeric(df[[birth_cols[1]]][2])
    
    if(is.na(current) || is.na(previous)) return('N/A')
    
    change_pct <- ((current - previous) / previous) * 100
    sign <- ifelse(change_pct >= 0, '+', '')
    paste0(sign, sprintf('%.1f%%', change_pct))
  })
  
  output$dem_birth_label <- renderText({
    if(!exists('Rwanda_vital_statistics')) return('Data unavailable')
    df <- as.data.frame(Rwanda_vital_statistics)
    
    # Find year column
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
      latest_year <- df[[year_col]][1]
    } else {
      latest_year <- "N/A"
    }
    
    paste0('Per 1,000 population (', latest_year, ')')
  })
  
  # Death Rate
  output$dem_death_rate <- renderUI({
    if(!exists('Rwanda_vital_statistics')) return(tags$span('N/A'))
    df <- as.data.frame(Rwanda_vital_statistics)
    
    # Find year column
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
    } else {
      year_col <- names(df)[1]
    }
    
    # Find death rate column
    death_cols <- names(df)[grepl('death|deathrate|death_rate|mortality|crude.*death', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    
    if(length(death_cols) == 0) return(tags$span('N/A'))
    
    latest_death <- as.numeric(df[[death_cols[1]]][1])
    
    if(is.na(latest_death)) return(tags$span('N/A'))
    build_dem_count_span(latest_death, format = 'decimal', decimals = 2, suffix = '‰')
  })
  
  output$dem_death_change_pct <- renderText({
    if(!exists('Rwanda_vital_statistics')) return('N/A')
    df <- as.data.frame(Rwanda_vital_statistics)
    
    if (nrow(df) < 2) return('N/A')
    
    # Find year column
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
    } else {
      year_col <- names(df)[1]
    }
    
    death_cols <- names(df)[grepl('death|deathrate|death_rate|mortality|crude.*death', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    
    if(length(death_cols) == 0) return('N/A')
    
    current <- as.numeric(df[[death_cols[1]]][1])
    previous <- as.numeric(df[[death_cols[1]]][2])
    
    if(is.na(current) || is.na(previous)) return('N/A')
    
    change_pct <- ((current - previous) / previous) * 100
    sign <- ifelse(change_pct >= 0, '+', '')
    paste0(sign, sprintf('%.1f%%', change_pct))
  })
  
  output$dem_death_label <- renderText({
    if(!exists('Rwanda_vital_statistics')) return('Data unavailable')
    df <- as.data.frame(Rwanda_vital_statistics)
    
    # Find year column
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
      latest_year <- df[[year_col]][1]
    } else {
      latest_year <- "N/A"
    }
    
    paste0('Per 1,000 population (', latest_year, ')')
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
  # Agriculture Chart - Professional statistical visualization with dropdown
  output$dem_agriculture_chart <- renderPlotly({
    req(input$dem_agriculture_variable)
    
    agri_data <- load_agriculture_data()
    if (is.null(agri_data) || !is.data.frame(agri_data) || nrow(agri_data) == 0) {
      return(plotly_empty() %>% layout(title = "No data available"))
    }
    
    # Ensure year column exists
    if (!"year" %in% names(agri_data) && !"Year" %in% names(agri_data)) {
      return(plotly_empty() %>% layout(title = "Invalid data structure"))
    }
    
    # Normalize column names
    if ("Year" %in% names(agri_data)) names(agri_data)[names(agri_data) == "Year"] <- "year"
    
    # Sort by year
    agri_data <- agri_data[order(as.numeric(agri_data$year)), ]
    
    # Find all crop columns (exclude year and non-numeric columns)
    crop_cols <- names(agri_data)[sapply(agri_data, is.numeric) & names(agri_data) != "year"]
    
    if (length(crop_cols) == 0) {
      return(plotly_empty() %>% layout(title = "No crop data found"))
    }
    
    # Get selected variable
    selected_var <- input$dem_agriculture_variable
    if (!selected_var %in% crop_cols) {
      selected_var <- crop_cols[1]  # Default to first if selection invalid
    }
    
    # Clean column name for display
    display_name <- gsub('_', ' ', gsub('_tonnes', '', selected_var))
    display_name <- tools::toTitleCase(display_name)
    
    # Create single-line chart with selected crop
    p <- plot_ly(agri_data, x = ~year, hovermode = 'x unified') %>%
      add_trace(
        y = ~get(selected_var),
        name = display_name,
        type = 'scatter',
        mode = 'lines+markers',
        line = list(color = '#1e40af', width = 3),
        marker = list(size = 8, color = '#1e40af'),
        hovertemplate = paste0('<b>', display_name, ':</b> %{y:,.0f} tonnes<extra></extra>')
      ) %>%
      layout(
        title = list(
          text = paste('Rwanda Agricultural Production -', display_name),
          font = list(size = 20, color = '#1e40af', family = 'Arial, sans-serif')
        ),
        xaxis = list(
          title = list(text = 'Year', font = list(size = 14, color = '#475569')),
          showgrid = TRUE,
          gridcolor = 'rgba(0,0,0,0.1)',
          tickmode = 'linear',
          dtick = 1
        ),
        yaxis = list(
          title = list(text = 'Production (Tonnes)', font = list(size = 14, color = '#475569')),
          rangemode = 'tozero',
          showgrid = TRUE,
          gridcolor = 'rgba(0,0,0,0.1)',
          tickformat = ',.0f'
        ),
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        margin = list(t = 80, r = 80, b = 60, l = 80),
        hoverlabel = list(
          bgcolor = 'rgba(255,255,255,0.95)',
          bordercolor = '#1e40af',
          font = list(size = 12, color = '#1e40af')
        )
      ) %>%
      config(displayModeBar = TRUE, displaylogo = FALSE)
    
    return(p)
  })
  
  # Agriculture variable selector
  output$dem_agriculture_variable_ui <- renderUI({
    agri_data <- load_agriculture_data()
    if (is.null(agri_data) || !is.data.frame(agri_data) || nrow(agri_data) == 0) {
      return(NULL)
    }
    
    # Normalize column names
    if ("Year" %in% names(agri_data)) names(agri_data)[names(agri_data) == "Year"] <- "year"
    
    # Find all crop columns
    crop_cols <- names(agri_data)[sapply(agri_data, is.numeric) & names(agri_data) != "year"]
    
    if (length(crop_cols) == 0) {
      return(NULL)
    }
    
    # Create display names for dropdown
    display_names <- gsub('_', ' ', gsub('_tonnes', '', crop_cols))
    display_names <- tools::toTitleCase(display_names)
    
    # Create named list for selectInput
    choices_list <- setNames(crop_cols, display_names)
    
    selectInput(
      'dem_agriculture_variable',
      'Select Crop Variable:',
      choices = choices_list,
      selected = crop_cols[1],
      width = '100%'
    )
  })
  
  # Labor Force Chart - Professional statistical visualization with dropdown
  output$dem_labor_force_chart <- renderPlotly({
    req(input$dem_labor_force_variable)
    
    labor_data <- load_labor_force_data()
    if (is.null(labor_data) || !is.data.frame(labor_data) || nrow(labor_data) == 0) {
      return(plotly_empty() %>% layout(title = "No data available"))
    }
    
    # Ensure year column exists
    if (!"year" %in% names(labor_data) && !"Year" %in% names(labor_data)) {
      return(plotly_empty() %>% layout(title = "Invalid data structure"))
    }
    
    # Normalize column names
    if ("Year" %in% names(labor_data)) names(labor_data)[names(labor_data) == "Year"] <- "year"
    
    # Sort by year
    labor_data <- labor_data[order(as.numeric(labor_data$year)), ]
    
    # Find all labor force columns (exclude year and non-numeric columns)
    labor_cols <- names(labor_data)[sapply(labor_data, is.numeric) & names(labor_data) != "year"]
    
    if (length(labor_cols) == 0) {
      return(plotly_empty() %>% layout(title = "No labor force data found"))
    }
    
    # Get selected variable
    selected_var <- input$dem_labor_force_variable
    if (!selected_var %in% labor_cols) {
      selected_var <- labor_cols[1]  # Default to first if selection invalid
    }
    
    # Clean column name for display
    display_name <- gsub('_', ' ', selected_var)
    display_name <- tools::toTitleCase(display_name)
    
    # Create single-line chart with selected variable
    p <- plot_ly(labor_data, x = ~year, hovermode = 'x unified') %>%
      add_trace(
        y = ~get(selected_var),
        name = display_name,
        type = 'scatter',
        mode = 'lines+markers',
        line = list(color = '#1e40af', width = 3),
        marker = list(size = 8, color = '#1e40af'),
        hovertemplate = paste0('<b>', display_name, ':</b> %{y:,.2f}<extra></extra>')
      ) %>%
      layout(
        title = list(
          text = paste('Rwanda Labor Force -', display_name),
          font = list(size = 20, color = '#1e40af', family = 'Arial, sans-serif')
        ),
        xaxis = list(
          title = list(text = 'Year', font = list(size = 14, color = '#475569')),
          showgrid = TRUE,
          gridcolor = 'rgba(0,0,0,0.1)',
          tickmode = 'linear',
          dtick = 1
        ),
        yaxis = list(
          title = list(text = display_name, font = list(size = 14, color = '#475569')),
          rangemode = 'tozero',
          showgrid = TRUE,
          gridcolor = 'rgba(0,0,0,0.1)',
          tickformat = ',.2f'
        ),
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        margin = list(t = 80, r = 80, b = 60, l = 80),
        hoverlabel = list(
          bgcolor = 'rgba(255,255,255,0.95)',
          bordercolor = '#1e40af',
          font = list(size = 12, color = '#1e40af')
        )
      ) %>%
      config(displayModeBar = TRUE, displaylogo = FALSE)
    
    return(p)
  })
  
  # Labor force variable selector
  output$dem_labor_force_variable_ui <- renderUI({
    labor_data <- load_labor_force_data()
    if (is.null(labor_data) || !is.data.frame(labor_data) || nrow(labor_data) == 0) {
      return(NULL)
    }
    
    # Normalize column names
    if ("Year" %in% names(labor_data)) names(labor_data)[names(labor_data) == "Year"] <- "year"
    
    # Find all labor force columns
    labor_cols <- names(labor_data)[sapply(labor_data, is.numeric) & names(labor_data) != "year"]
    
    if (length(labor_cols) == 0) {
      return(NULL)
    }
    
    # Create display names for dropdown
    display_names <- gsub('_', ' ', labor_cols)
    display_names <- tools::toTitleCase(display_names)
    
    # Create named list for selectInput
    choices_list <- setNames(labor_cols, display_names)
    
    selectInput(
      'dem_labor_force_variable',
      'Select Labor Force Variable:',
      choices = choices_list,
      selected = labor_cols[1],
      width = '100%'
    )
  })
  
  # Helper function to load land use data from CSV
  load_land_use_data <- function() {
    land_data <- NULL
    
    # Use CSV directly for faster loading
    if (exists('Rwanda_land_use') && !is.null(Rwanda_land_use)) {
      message("[LAND USE] ✅ Loading from CSV")
      land_data <- as.data.frame(Rwanda_land_use)
    } else {
      # Try to load from file if not in global environment
      tryCatch({
        land_data <- read.csv("data/datasets/rwanda_land_use_data.csv")
        message("[LAND USE] ✅ Loaded from CSV file")
      }, error = function(e) {
        message(sprintf("[LAND USE] ❌ Could not load CSV: %s", e$message))
      })
    }
    
    return(land_data)
  }
  
  # Helper function to load agriculture GDP data from CSV
  load_agriculture_gdp_data <- function() {
    agri_gdp_data <- NULL
    
    # Use CSV directly for faster loading
    if (exists('Rwanda_agri_gdp') && !is.null(Rwanda_agri_gdp)) {
      message("[AGRICULTURE GDP] ✅ Loading from CSV")
      agri_gdp_data <- as.data.frame(Rwanda_agri_gdp)
    } else {
      # Try to load from file if not in global environment
      tryCatch({
        agri_gdp_data <- read.csv("data/datasets/rwanda_agriculture_% to GDP data.csv")
        message("[AGRICULTURE GDP] ✅ Loaded from CSV file")
      }, error = function(e) {
        message(sprintf("[AGRICULTURE GDP] ❌ Could not load CSV: %s", e$message))
      })
    }
    
    return(agri_gdp_data)
  }
  
  # Land Use Pie Chart - Professional statistical visualization
  output$dem_land_use_pie_chart <- renderPlotly({
    land_data <- load_land_use_data()
    if (is.null(land_data) || !is.data.frame(land_data) || nrow(land_data) == 0) {
      return(plotly_empty() %>% layout(title = "No data available"))
    }
    
    # Find category and value columns
    # Look for columns that might contain categories (non-numeric, non-year)
    year_cols <- names(land_data)[grepl('year|Year', names(land_data), ignore.case = TRUE)]
    numeric_cols <- names(land_data)[sapply(land_data, is.numeric)]
    
    # Get the latest year's data if year column exists
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      land_data <- land_data[order(land_data[[year_col]], decreasing = TRUE), ]
      latest_data <- land_data[1, ]
    } else {
      latest_data <- land_data
    }
    
    # Try to find category and percentage columns
    # Common patterns: category/type column + percentage/value column
    category_col <- NULL
    value_col <- NULL
    
    # Look for category column (non-numeric, not year)
    non_numeric_cols <- names(latest_data)[!sapply(latest_data, is.numeric) & !grepl('year|Year', names(latest_data), ignore.case = TRUE)]
    if (length(non_numeric_cols) > 0) {
      category_col <- non_numeric_cols[1]
    }
    
    # Look for percentage/value columns
    pct_cols <- names(latest_data)[grepl('percent|%|pct|share|value', names(latest_data), ignore.case = TRUE) & sapply(latest_data, is.numeric)]
    if (length(pct_cols) > 0) {
      value_col <- pct_cols[1]
    } else if (length(numeric_cols) > 0) {
      # Use first numeric column (excluding year)
      value_col <- numeric_cols[!numeric_cols %in% year_cols][1]
    }
    
    # If no category column, use row names or create categories from column names
    if (is.null(category_col)) {
      # Use column names as categories (excluding year and non-numeric)
      value_cols <- names(latest_data)[sapply(latest_data, is.numeric) & !names(latest_data) %in% year_cols]
      if (length(value_cols) > 0) {
        labels <- gsub('_', ' ', value_cols)
        labels <- tools::toTitleCase(labels)
        values <- as.numeric(latest_data[1, value_cols])
      } else {
        return(plotly_empty() %>% layout(title = "Invalid data structure"))
      }
    } else {
      labels <- as.character(latest_data[[category_col]])
      if (!is.null(value_col)) {
        values <- as.numeric(latest_data[[value_col]])
      } else {
        return(plotly_empty() %>% layout(title = "No value column found"))
      }
    }
    
    # Remove NA values
    valid_idx <- !is.na(values) & values > 0
    labels <- labels[valid_idx]
    values <- values[valid_idx]
    
    if (length(labels) == 0 || length(values) == 0) {
      return(plotly_empty() %>% layout(title = "No valid data found"))
    }
    
    # Professional color palette for Rwanda (green, blue, earth tones)
    colors <- c('#157A4A', '#0B78A0', '#1e40af', '#0284c7', '#0ea5e9', '#06b6d4', '#10b981', '#059669', '#0d9488', '#14b8a6', '#0891b2', '#0c4a6e')
    
    # Create pie chart
    p <- plot_ly(
      labels = labels,
      values = values,
      type = 'pie',
      hole = 0.4,  # Donut chart for modern look
      textinfo = 'label+percent',
      textposition = 'outside',
      marker = list(
        colors = colors[1:length(labels)],
        line = list(color = '#ffffff', width = 2)
      ),
      hovertemplate = '<b>%{label}</b><br>Value: %{value:.2f}%<br>Percentage: %{percent}<extra></extra>'
    ) %>%
      layout(
        title = list(
          text = 'Rwanda Land Use Distribution',
          font = list(size = 20, color = '#1e40af', family = 'Arial, sans-serif'),
          x = 0.5
        ),
        showlegend = TRUE,
        legend = list(
          orientation = 'v',
          x = 1.05,
          y = 0.5,
          font = list(size = 12)
        ),
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        margin = list(t = 80, r = 150, b = 60, l = 60),
        hoverlabel = list(
          bgcolor = 'rgba(255,255,255,0.95)',
          bordercolor = '#1e40af',
          font = list(size = 12, color = '#1e40af')
        )
      ) %>%
      config(displayModeBar = TRUE, displaylogo = FALSE)
    
    return(p)
  })
  
  # Agriculture to GDP Chart - Professional statistical visualization
  output$dem_agriculture_gdp_chart <- renderPlotly({
    agri_gdp_data <- load_agriculture_gdp_data()
    if (is.null(agri_gdp_data) || !is.data.frame(agri_gdp_data) || nrow(agri_gdp_data) == 0) {
      return(plotly_empty() %>% layout(title = "No data available"))
    }
    
    # Ensure year column exists
    if (!"year" %in% names(agri_gdp_data) && !"Year" %in% names(agri_gdp_data)) {
      return(plotly_empty() %>% layout(title = "Invalid data structure"))
    }
    
    # Normalize column names
    if ("Year" %in% names(agri_gdp_data)) names(agri_gdp_data)[names(agri_gdp_data) == "Year"] <- "year"
    
    # Sort by year
    agri_gdp_data <- agri_gdp_data[order(as.numeric(agri_gdp_data$year)), ]
    
    # Find agriculture percentage column
    pct_cols <- names(agri_gdp_data)[grepl('percent|%|pct|agriculture|gdp', names(agri_gdp_data), ignore.case = TRUE) & sapply(agri_gdp_data, is.numeric)]
    
    if (length(pct_cols) == 0) {
      # Try to find any numeric column (excluding year)
      numeric_cols <- names(agri_gdp_data)[sapply(agri_gdp_data, is.numeric) & names(agri_gdp_data) != "year"]
      if (length(numeric_cols) > 0) {
        pct_col <- numeric_cols[1]
      } else {
        return(plotly_empty() %>% layout(title = "No percentage data found"))
      }
    } else {
      pct_col <- pct_cols[1]
    }
    
    # Clean column name for display
    display_name <- gsub('_', ' ', pct_col)
    display_name <- tools::toTitleCase(display_name)
    
    # Create line chart
    p <- plot_ly(agri_gdp_data, x = ~year, hovermode = 'x unified') %>%
      add_trace(
        y = ~get(pct_col),
        name = 'Agriculture % to GDP',
        type = 'scatter',
        mode = 'lines+markers',
        fill = 'tozeroy',
        fillcolor = 'rgba(21, 122, 74, 0.2)',  # Green with transparency
        line = list(color = '#157A4A', width = 3),
        marker = list(size = 8, color = '#157A4A'),
        hovertemplate = paste0('<b>Year:</b> %{x}<br><b>Agriculture % to GDP:</b> %{y:.2f}%<extra></extra>')
      ) %>%
      layout(
        title = list(
          text = 'Agriculture Contribution to Rwanda GDP (%)',
          font = list(size = 20, color = '#1e40af', family = 'Arial, sans-serif')
        ),
        xaxis = list(
          title = list(text = 'Year', font = list(size = 14, color = '#475569')),
          showgrid = TRUE,
          gridcolor = 'rgba(0,0,0,0.1)',
          tickmode = 'linear',
          dtick = 1
        ),
        yaxis = list(
          title = list(text = 'Percentage (%)', font = list(size = 14, color = '#475569')),
          rangemode = 'tozero',
          showgrid = TRUE,
          gridcolor = 'rgba(0,0,0,0.1)',
          tickformat = '.2f',
          ticksuffix = '%'
        ),
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        margin = list(t = 80, r = 80, b = 60, l = 80),
        hoverlabel = list(
          bgcolor = 'rgba(255,255,255,0.95)',
          bordercolor = '#157A4A',
          font = list(size = 12, color = '#157A4A')
        )
      ) %>%
      config(displayModeBar = TRUE, displaylogo = FALSE)
    
    return(p)
  })
  
  # Old agriculture outputs (kept for backward compatibility but not used in UI)
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
  # Health & Education Overview Cardboxes
  # Life Expectancy Card
  output$health_life_expectancy <- renderUI({
    if(!exists('Rwanda_health')) return(tags$span('N/A'))
    df <- as.data.frame(Rwanda_health)
    
    # Find year column
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
      # Get 2024 data
      df_2024 <- df[df[[year_col]] == 2024, ]
      if (nrow(df_2024) == 0) {
        # Use latest year if 2024 not available
        df_2024 <- df[1, ]
      }
    } else {
      df_2024 <- df[nrow(df), ]
    }
    
    # Find life expectancy column
    life_cols <- names(df_2024)[grepl('life.*expectancy|expectancy', names(df_2024), ignore.case = TRUE) & sapply(df_2024, is.numeric)]
    if (length(life_cols) > 0) {
      life_val <- as.numeric(df_2024[[life_cols[1]]][1])
      if (!is.na(life_val)) {
        return(build_dem_count_span(life_val, format = 'decimal', decimals = 1, suffix = ' years'))
      }
    }
    
    return(tags$span('N/A'))
  })
  
  output$health_life_expectancy_change_pct <- renderText({
    if(!exists('Rwanda_health')) return('N/A')
    df <- as.data.frame(Rwanda_health)
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) == 0 || nrow(df) < 2) return('N/A')
    
    year_col <- year_cols[1]
    df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
    
    life_cols <- names(df)[grepl('life.*expectancy|expectancy', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    if (length(life_cols) == 0) return('N/A')
    
    current <- as.numeric(df[[life_cols[1]]][1])
    previous <- as.numeric(df[[life_cols[1]]][2])
    if (is.na(current) || is.na(previous)) return('N/A')
    
    change_pct <- ((current - previous) / previous) * 100
    sign <- ifelse(change_pct >= 0, '+', '')
    paste0(sign, sprintf('%.1f%%', change_pct))
  })
  
  output$health_life_expectancy_label <- renderText({
    if(!exists('Rwanda_health')) return('Data unavailable')
    df <- as.data.frame(Rwanda_health)
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
      latest_year <- df[[year_col]][1]
      paste0('As of ', latest_year)
    } else {
      'Data unavailable'
    }
  })
  
  # Access to Health Care Card
  output$health_access_care <- renderUI({
    if(!exists('Rwanda_health')) return(tags$span('N/A'))
    df <- as.data.frame(Rwanda_health)
    
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
      df_2024 <- df[df[[year_col]] == 2024, ]
      if (nrow(df_2024) == 0) {
        df_2024 <- df[1, ]
      }
    } else {
      df_2024 <- df[nrow(df), ]
    }
    
    # Find access to health care column
    access_cols <- names(df_2024)[grepl('access.*health|health.*access|healthcare.*access|access.*care', names(df_2024), ignore.case = TRUE) & sapply(df_2024, is.numeric)]
    if (length(access_cols) > 0) {
      access_val <- as.numeric(df_2024[[access_cols[1]]][1])
      if (!is.na(access_val)) {
        return(build_dem_count_span(access_val, format = 'decimal', decimals = 1, suffix = '%'))
      }
    }
    
    return(tags$span('N/A'))
  })
  
  output$health_access_change_pct <- renderText({
    if(!exists('Rwanda_health')) return('N/A')
    df <- as.data.frame(Rwanda_health)
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) == 0 || nrow(df) < 2) return('N/A')
    
    year_col <- year_cols[1]
    df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
    
    access_cols <- names(df)[grepl('access.*health|health.*access|healthcare.*access|access.*care', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    if (length(access_cols) == 0) return('N/A')
    
    current <- as.numeric(df[[access_cols[1]]][1])
    previous <- as.numeric(df[[access_cols[1]]][2])
    if (is.na(current) || is.na(previous)) return('N/A')
    
    change_pct <- ((current - previous) / previous) * 100
    sign <- ifelse(change_pct >= 0, '+', '')
    paste0(sign, sprintf('%.1f%%', change_pct))
  })
  
  output$health_access_label <- renderText({
    if(!exists('Rwanda_health')) return('Data unavailable')
    df <- as.data.frame(Rwanda_health)
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
      latest_year <- df[[year_col]][1]
      paste0('As of ', latest_year)
    } else {
      'Data unavailable'
    }
  })
  
  # Gross School Enrollment Card
  output$health_gross_enrollment <- renderUI({
    if(!exists('Rwanda_education')) return(tags$span('N/A'))
    df <- as.data.frame(Rwanda_education)
    
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
      df_2024 <- df[df[[year_col]] == 2024, ]
      if (nrow(df_2024) == 0) {
        df_2024 <- df[1, ]
      }
    } else {
      df_2024 <- df[nrow(df), ]
    }
    
    # Find gross enrollment column
    gross_cols <- names(df_2024)[grepl('gross.*enrollment|gross.*enrolment|gross.*enroll', names(df_2024), ignore.case = TRUE) & sapply(df_2024, is.numeric)]
    if (length(gross_cols) > 0) {
      gross_val <- as.numeric(df_2024[[gross_cols[1]]][1])
      if (!is.na(gross_val)) {
        return(build_dem_count_span(gross_val, format = 'decimal', decimals = 1, suffix = '%'))
      }
    }
    
    return(tags$span('N/A'))
  })
  
  output$health_gross_enrollment_change_pct <- renderText({
    if(!exists('Rwanda_education')) return('N/A')
    df <- as.data.frame(Rwanda_education)
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) == 0 || nrow(df) < 2) return('N/A')
    
    year_col <- year_cols[1]
    df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
    
    gross_cols <- names(df)[grepl('gross.*enrollment|gross.*enrolment|gross.*enroll', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    if (length(gross_cols) == 0) return('N/A')
    
    current <- as.numeric(df[[gross_cols[1]]][1])
    previous <- as.numeric(df[[gross_cols[1]]][2])
    if (is.na(current) || is.na(previous)) return('N/A')
    
    change_pct <- ((current - previous) / previous) * 100
    sign <- ifelse(change_pct >= 0, '+', '')
    paste0(sign, sprintf('%.1f%%', change_pct))
  })
  
  output$health_gross_enrollment_label <- renderText({
    if(!exists('Rwanda_education')) return('Data unavailable')
    df <- as.data.frame(Rwanda_education)
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
      latest_year <- df[[year_col]][1]
      paste0('As of ', latest_year)
    } else {
      'Data unavailable'
    }
  })
  
  # Net School Enrollment Card
  output$health_net_enrollment <- renderUI({
    if(!exists('Rwanda_education')) return(tags$span('N/A'))
    df <- as.data.frame(Rwanda_education)
    
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
      df_2024 <- df[df[[year_col]] == 2024, ]
      if (nrow(df_2024) == 0) {
        df_2024 <- df[1, ]
      }
    } else {
      df_2024 <- df[nrow(df), ]
    }
    
    # Find net enrollment column
    net_cols <- names(df_2024)[grepl('net.*enrollment|net.*enrolment|net.*enroll', names(df_2024), ignore.case = TRUE) & sapply(df_2024, is.numeric)]
    if (length(net_cols) > 0) {
      net_val <- as.numeric(df_2024[[net_cols[1]]][1])
      if (!is.na(net_val)) {
        return(build_dem_count_span(net_val, format = 'decimal', decimals = 1, suffix = '%'))
      }
    }
    
    return(tags$span('N/A'))
  })
  
  output$health_net_enrollment_change_pct <- renderText({
    if(!exists('Rwanda_education')) return('N/A')
    df <- as.data.frame(Rwanda_education)
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) == 0 || nrow(df) < 2) return('N/A')
    
    year_col <- year_cols[1]
    df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
    
    net_cols <- names(df)[grepl('net.*enrollment|net.*enrolment|net.*enroll', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    if (length(net_cols) == 0) return('N/A')
    
    current <- as.numeric(df[[net_cols[1]]][1])
    previous <- as.numeric(df[[net_cols[1]]][2])
    if (is.na(current) || is.na(previous)) return('N/A')
    
    change_pct <- ((current - previous) / previous) * 100
    sign <- ifelse(change_pct >= 0, '+', '')
    paste0(sign, sprintf('%.1f%%', change_pct))
  })
  
  output$health_net_enrollment_label <- renderText({
    if(!exists('Rwanda_education')) return('Data unavailable')
    df <- as.data.frame(Rwanda_education)
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = TRUE), ]
      latest_year <- df[[year_col]][1]
      paste0('As of ', latest_year)
    } else {
      'Data unavailable'
    }
  })
  
  # Education Indicators Variable Selector
  output$health_education_variable_ui <- renderUI({
    if(!exists('Rwanda_education')) return(NULL)
    df <- as.data.frame(Rwanda_education)
    
    # Find all education indicator columns (numeric, excluding year)
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    edu_cols <- names(df)[sapply(df, is.numeric) & !names(df) %in% year_cols]
    
    if (length(edu_cols) == 0) return(NULL)
    
    # Create display names
    display_names <- gsub('_', ' ', edu_cols)
    display_names <- tools::toTitleCase(display_names)
    
    choices_list <- setNames(edu_cols, display_names)
    
    selectInput(
      'health_education_variable',
      'Select Education Indicator:',
      choices = choices_list,
      selected = edu_cols[1],
      width = '100%'
    )
  })
  
  # Education Indicators Chart
  output$health_education_chart <- renderPlotly({
    req(input$health_education_variable)
    if(!exists('Rwanda_education')) return(plotly_empty() %>% layout(title = "No data available"))
    
    df <- as.data.frame(Rwanda_education)
    
    # Find year column
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = FALSE), ]
    } else {
      year_col <- names(df)[1]
    }
    
    var_name <- input$health_education_variable
    if (!var_name %in% names(df)) return(plotly_empty() %>% layout(title = "Variable not found"))
    
    # Create professional chart
    p <- plot_ly(
      data = df,
      x = ~get(year_col),
      y = ~get(var_name),
      type = 'scatter',
      mode = 'lines+markers',
      line = list(color = '#1e40af', width = 3),
      marker = list(color = '#1e40af', size = 8, line = list(color = '#fff', width = 2)),
      name = gsub('_', ' ', var_name)
    ) %>%
      layout(
        title = list(
          text = paste('Rwanda Education Indicators:', gsub('_', ' ', tools::toTitleCase(var_name))),
          font = list(size = 18, color = '#1e40af')
        ),
        xaxis = list(title = 'Year', tickmode = 'linear', dtick = 1),
        yaxis = list(
          title = gsub('_', ' ', tools::toTitleCase(var_name)), 
          range = c(0, 200),
          tickmode = 'linear',
          dtick = 20
        ),
        hovermode = 'x unified',
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        margin = list(t = 80, r = 80, b = 60, l = 80)
      ) %>%
      config(displayModeBar = TRUE, displaylogo = FALSE)
    
    return(p)
  })
  
  # School Type Percentages Variable Selector
  output$health_school_type_variable_ui <- renderUI({
    if(!exists('Rwanda_schools')) return(NULL)
    df <- as.data.frame(Rwanda_schools)
    
    # Find all school type columns (numeric, excluding year)
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    school_cols <- names(df)[sapply(df, is.numeric) & !names(df) %in% year_cols]
    
    if (length(school_cols) == 0) return(NULL)
    
    # Create display names
    display_names <- gsub('_', ' ', school_cols)
    display_names <- tools::toTitleCase(display_names)
    
    choices_list <- setNames(school_cols, display_names)
    
    selectInput(
      'health_school_type_variable',
      'Select School Type:',
      choices = choices_list,
      selected = school_cols[1],
      width = '100%'
    )
  })
  
  # School Type Percentages Chart
  output$health_school_type_chart <- renderPlotly({
    req(input$health_school_type_variable)
    if(!exists('Rwanda_schools')) return(plotly_empty() %>% layout(title = "No data available"))
    
    df <- as.data.frame(Rwanda_schools)
    
    # Find year column
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = FALSE), ]
    } else {
      year_col <- names(df)[1]
    }
    
    var_name <- input$health_school_type_variable
    if (!var_name %in% names(df)) return(plotly_empty() %>% layout(title = "Variable not found"))
    
    # Create professional chart
    p <- plot_ly(
      data = df,
      x = ~get(year_col),
      y = ~get(var_name),
      type = 'scatter',
      mode = 'lines+markers',
      line = list(color = '#0ea5e9', width = 3),
      marker = list(color = '#0ea5e9', size = 8, line = list(color = '#fff', width = 2)),
      fill = 'tozeroy',
      fillcolor = 'rgba(14, 165, 233, 0.1)',
      name = gsub('_', ' ', var_name)
    ) %>%
      layout(
        title = list(
          text = paste('School Type Percentages:', gsub('_', ' ', tools::toTitleCase(var_name))),
          font = list(size = 18, color = '#1e40af')
        ),
        xaxis = list(title = 'Year', tickmode = 'linear', dtick = 1),
        yaxis = list(
          title = 'Percentage (%)', 
          range = c(0, 100),
          tickmode = 'linear',
          dtick = 10
        ),
        hovermode = 'x unified',
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        margin = list(t = 80, r = 80, b = 60, l = 80)
      ) %>%
      config(displayModeBar = TRUE, displaylogo = FALSE)
    
    return(p)
  })
  
  # Health Indicators Variable Selector
  output$health_indicators_variable_ui <- renderUI({
    if(!exists('Rwanda_health')) return(NULL)
    df <- as.data.frame(Rwanda_health)
    
    # Find all health indicator columns (numeric, excluding year)
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    health_cols <- names(df)[sapply(df, is.numeric) & !names(df) %in% year_cols]
    
    if (length(health_cols) == 0) return(NULL)
    
    # Ensure life expectancy is included - check if it exists, if not add it
    # Look for life expectancy column (might be named differently)
    life_cols <- names(df)[grepl('life.*expectancy|expectancy', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    if (length(life_cols) > 0 && !life_cols[1] %in% health_cols) {
      health_cols <- c(life_cols[1], health_cols)
    }
    
    # Create display names
    display_names <- gsub('_', ' ', health_cols)
    display_names <- tools::toTitleCase(display_names)
    
    choices_list <- setNames(health_cols, display_names)
    
    # Select life expectancy as default if available, otherwise first column
    default_selection <- if (length(life_cols) > 0) life_cols[1] else health_cols[1]
    
    selectInput(
      'health_indicators_variable',
      'Select Health Indicator:',
      choices = choices_list,
      selected = default_selection,
      width = '100%'
    )
  })
  
  # Health Indicators Chart
  output$health_indicators_chart <- renderPlotly({
    req(input$health_indicators_variable)
    if(!exists('Rwanda_health')) return(plotly_empty() %>% layout(title = "No data available"))
    
    df <- as.data.frame(Rwanda_health)
    
    # Find year column
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    if (length(year_cols) > 0) {
      year_col <- year_cols[1]
      df <- df[order(as.numeric(df[[year_col]]), decreasing = FALSE), ]
    } else {
      year_col <- names(df)[1]
    }
    
    var_name <- input$health_indicators_variable
    if (!var_name %in% names(df)) return(plotly_empty() %>% layout(title = "Variable not found"))
    
    # Create professional chart
    p <- plot_ly(
      data = df,
      x = ~get(year_col),
      y = ~get(var_name),
      type = 'scatter',
      mode = 'lines+markers',
      line = list(color = '#0ea5e9', width = 3),
      marker = list(color = '#0ea5e9', size = 8, line = list(color = '#fff', width = 2)),
      name = gsub('_', ' ', var_name)
    ) %>%
      layout(
        title = list(
          text = paste('Rwanda Health Indicators:', gsub('_', ' ', tools::toTitleCase(var_name))),
          font = list(size = 18, color = '#1e40af')
        ),
        xaxis = list(title = 'Year', tickmode = 'linear', dtick = 1),
        yaxis = list(
          title = gsub('_', ' ', tools::toTitleCase(var_name)), 
          range = c(0, 100),
          tickmode = 'linear',
          dtick = 10
        ),
        hovermode = 'x unified',
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        margin = list(t = 80, r = 80, b = 60, l = 80),
        hoverlabel = list(
          bgcolor = 'rgba(255,255,255,0.95)',
          bordercolor = '#0ea5e9',
          font = list(size = 12, color = '#1e40af')
        )
      ) %>%
      config(displayModeBar = TRUE, displaylogo = FALSE)
    
    return(p)
  })

  # Education Indicators Forecast Variable Selector
  output$health_education_forecast_variable_ui <- renderUI({
    if(!exists('Rwanda_education')) return(NULL)
    df <- as.data.frame(Rwanda_education)
    
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    edu_cols <- names(df)[sapply(df, is.numeric) & !names(df) %in% year_cols]
    
    if (length(edu_cols) == 0) return(NULL)
    
    display_names <- gsub('_', ' ', edu_cols)
    display_names <- tools::toTitleCase(display_names)
    
    choices_list <- setNames(edu_cols, display_names)
    
    selectInput(
      'health_education_forecast_variable',
      'Select Education Indicator:',
      choices = choices_list,
      selected = edu_cols[1],
      width = '100%'
    )
  })
  
  # Education Indicators Forecast Chart
  output$health_education_forecast_chart <- renderPlotly({
    req(input$health_education_forecast_variable, input$health_education_forecast_model)
    
    if(!exists('Rwanda_education')) return(plotly_empty() %>% layout(title = "No data available"))
    
    df <- as.data.frame(Rwanda_education)
    
    # Normalize column names
    if ("Year" %in% names(df)) names(df)[names(df) == "Year"] <- "year"
    if ("year" %in% names(df)) {
      df <- df[order(as.numeric(df$year), decreasing = FALSE), ]
    }
    
    var_name <- input$health_education_forecast_variable
    if (!var_name %in% names(df)) return(plotly_empty() %>% layout(title = "Variable not found"))
    
    forecast_data <- create_arima_forecast(df, var_name, input$health_education_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(plotly_empty() %>% layout(title = paste("Error:", forecast_data$error)))
    }
    
    # Create plot
    var_display <- gsub('_', ' ', tools::toTitleCase(var_name))
    if (!is.null(forecast_data$used_auto) && forecast_data$used_auto) {
      model_display <- paste("ARIMA", paste(forecast_data$model$arma[c(1,6,2)], collapse=","), sep="")
    } else {
      model_display <- if(input$health_education_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    }
    
    p <- plot_ly() %>%
      add_bars(
        x = forecast_data$hist_years,
        y = forecast_data$hist_values,
        name = 'Historical',
        marker = list(color = '#1e40af', opacity = 0.8)
      ) %>%
      add_bars(
        x = forecast_data$f_years,
        y = forecast_data$f_mean,
        name = 'Forecast (mean)',
        marker = list(color = '#157A4A', opacity = 0.8)
      ) %>%
      add_ribbons(
        x = forecast_data$f_years,
        ymin = forecast_data$f_lower,
        ymax = forecast_data$f_upper,
        name = '95% CI',
        fillcolor = 'rgba(21, 122, 74, 0.2)',
        line = list(color = 'transparent')
      ) %>%
      layout(
        title = list(
          text = paste(var_display, '- Historical & Forecast -', model_display),
          font = list(size = 18, color = '#1e40af')
        ),
        xaxis = list(title = 'Year', tickmode = 'linear', dtick = 1),
        yaxis = list(title = var_display, range = c(0, 200), tickmode = 'linear', dtick = 20),
        barmode = 'group',
        hovermode = 'x unified',
        showlegend = TRUE,
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff'
      )
    
    return(p)
  })
  
  # Education Indicators Forecast Metrics
  output$health_education_forecast_model_metrics <- renderUI({
    req(input$health_education_forecast_variable, input$health_education_forecast_model)
    
    if(!exists('Rwanda_education')) return(HTML("No data available"))
    
    df <- as.data.frame(Rwanda_education)
    if ("Year" %in% names(df)) names(df)[names(df) == "Year"] <- "year"
    if ("year" %in% names(df)) {
      df <- df[order(as.numeric(df$year), decreasing = FALSE), ]
    }
    
    var_name <- input$health_education_forecast_variable
    if (!var_name %in% names(df)) return(HTML("<p style='color:red;'>Variable not found</p>"))
    
    forecast_data <- create_arima_forecast(df, var_name, input$health_education_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(HTML(paste0("<p style='color:red;'>Error: ", forecast_data$error, "</p>")))
    }
    
    m <- forecast_data$metrics
    model_info <- if(!is.null(forecast_data$used_auto) && forecast_data$used_auto) {
      paste("Auto-selected ARIMA", paste(forecast_data$model$arma[c(1,6,2)], collapse=","), sep="")
    } else {
      if(input$health_education_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    }
    
    metrics_text <- paste0(
      "<div style='font-size:12px; line-height:1.8;'>",
      "<strong>Model:</strong> ", model_info, "<br><br>",
      "<strong>Model Performance Metrics:</strong><br>",
      "AIC: ", sprintf("%.2f", m$aic), "<br>",
      "BIC: ", sprintf("%.2f", m$bic), "<br>",
      "RMSE: ", sprintf("%.2f", m$rmse), "<br>",
      "MAE: ", sprintf("%.2f", m$mae), "<br><br>",
      "<strong>Model Diagnostics:</strong><br>",
      "Variance: ", sprintf("%.2f", m$variance), "<br>",
      "Std Dev: ", sprintf("%.2f", m$std_dev),
      "</div>"
    )
    return(HTML(metrics_text))
  })
  
  # Education Indicators Forecast Interpretation
  output$health_education_forecast_interpretation <- renderUI({
    req(input$health_education_forecast_variable, input$health_education_forecast_model)
    
    if(!exists('Rwanda_education')) return(HTML("No data available"))
    
    df <- as.data.frame(Rwanda_education)
    if ("Year" %in% names(df)) names(df)[names(df) == "Year"] <- "year"
    if ("year" %in% names(df)) {
      df <- df[order(as.numeric(df$year), decreasing = FALSE), ]
    }
    
    var_name <- input$health_education_forecast_variable
    if (!var_name %in% names(df)) return(HTML("<p style='color:red;'>Variable not found</p>"))
    
    forecast_data <- create_arima_forecast(df, var_name, input$health_education_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(HTML(paste0("<p style='color:red;'>Error: ", forecast_data$error, "</p>")))
    }
    
    if (!is.null(forecast_data$used_auto) && forecast_data$used_auto) {
      model_display <- paste("ARIMA", paste(forecast_data$model$arma[c(1,6,2)], collapse=","), sep="")
    } else {
      model_display <- if(input$health_education_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    }
    var_display <- gsub('_', ' ', tools::toTitleCase(var_name))
    
    change_desc <- if(forecast_data$change >= 0) "increase" else "decrease"
    trend_desc <- if(abs(forecast_data$change_pct) < 1) "near-term stabilization" else if(forecast_data$change_pct > 0) "positive growth trend" else "moderation or decline"
    
    forecast_val <- sprintf("%.2f", forecast_data$forecast_value)
    lower_val <- sprintf("%.2f", forecast_data$f_lower[1])
    upper_val <- sprintf("%.2f", forecast_data$f_upper[1])
    change_val <- sprintf("%.2f", forecast_data$change)
    current_val <- sprintf("%.2f", forecast_data$current_value)
    change_pct_val <- sprintf("%.1f%%", forecast_data$change_pct)
    
    interpretation_text <- paste0(
      "<div style='font-size:12px; line-height:1.8; color:#475569;'>",
      "Based on the ", model_display, " model, Rwanda's ", var_display, " is projected at ",
      forecast_val, " (95% CI: ", lower_val, " to ", upper_val, "). ",
      "This is a ", change_val, " change from the current ", current_val, 
      " (", change_pct_val, "). This suggests ", trend_desc, ".",
      "</div>"
    )
    return(HTML(interpretation_text))
  })
  
  # School Type Percentages Forecast Variable Selector
  output$health_school_type_forecast_variable_ui <- renderUI({
    if(!exists('Rwanda_schools')) return(NULL)
    df <- as.data.frame(Rwanda_schools)
    
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    school_cols <- names(df)[sapply(df, is.numeric) & !names(df) %in% year_cols]
    
    if (length(school_cols) == 0) return(NULL)
    
    display_names <- gsub('_', ' ', school_cols)
    display_names <- tools::toTitleCase(display_names)
    
    choices_list <- setNames(school_cols, display_names)
    
    selectInput(
      'health_school_type_forecast_variable',
      'Select School Type:',
      choices = choices_list,
      selected = school_cols[1],
      width = '100%'
    )
  })
  
  # School Type Percentages Forecast Chart
  output$health_school_type_forecast_chart <- renderPlotly({
    req(input$health_school_type_forecast_variable, input$health_school_type_forecast_model)
    
    if(!exists('Rwanda_schools')) return(plotly_empty() %>% layout(title = "No data available"))
    
    df <- as.data.frame(Rwanda_schools)
    
    # Normalize column names
    if ("Year" %in% names(df)) names(df)[names(df) == "Year"] <- "year"
    if ("year" %in% names(df)) {
      df <- df[order(as.numeric(df$year), decreasing = FALSE), ]
    }
    
    var_name <- input$health_school_type_forecast_variable
    if (!var_name %in% names(df)) return(plotly_empty() %>% layout(title = "Variable not found"))
    
    forecast_data <- create_arima_forecast(df, var_name, input$health_school_type_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(plotly_empty() %>% layout(title = paste("Error:", forecast_data$error)))
    }
    
    # Create plot
    var_display <- gsub('_', ' ', tools::toTitleCase(var_name))
    if (!is.null(forecast_data$used_auto) && forecast_data$used_auto) {
      model_display <- paste("ARIMA", paste(forecast_data$model$arma[c(1,6,2)], collapse=","), sep="")
    } else {
      model_display <- if(input$health_school_type_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    }
    
    p <- plot_ly() %>%
      add_bars(
        x = forecast_data$hist_years,
        y = forecast_data$hist_values,
        name = 'Historical',
        marker = list(color = '#0ea5e9', opacity = 0.8)
      ) %>%
      add_bars(
        x = forecast_data$f_years,
        y = forecast_data$f_mean,
        name = 'Forecast (mean)',
        marker = list(color = '#157A4A', opacity = 0.8)
      ) %>%
      add_ribbons(
        x = forecast_data$f_years,
        ymin = forecast_data$f_lower,
        ymax = forecast_data$f_upper,
        name = '95% CI',
        fillcolor = 'rgba(21, 122, 74, 0.2)',
        line = list(color = 'transparent')
      ) %>%
      layout(
        title = list(
          text = paste(var_display, '- Historical & Forecast -', model_display),
          font = list(size = 18, color = '#1e40af')
        ),
        xaxis = list(title = 'Year', tickmode = 'linear', dtick = 1),
        yaxis = list(title = 'Percentage (%)', range = c(0, 100), tickmode = 'linear', dtick = 10),
        barmode = 'group',
        hovermode = 'x unified',
        showlegend = TRUE,
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff'
      )
    
    return(p)
  })
  
  # School Type Percentages Forecast Metrics
  output$health_school_type_forecast_model_metrics <- renderUI({
    req(input$health_school_type_forecast_variable, input$health_school_type_forecast_model)
    
    if(!exists('Rwanda_schools')) return(HTML("No data available"))
    
    df <- as.data.frame(Rwanda_schools)
    if ("Year" %in% names(df)) names(df)[names(df) == "Year"] <- "year"
    if ("year" %in% names(df)) {
      df <- df[order(as.numeric(df$year), decreasing = FALSE), ]
    }
    
    var_name <- input$health_school_type_forecast_variable
    if (!var_name %in% names(df)) return(HTML("<p style='color:red;'>Variable not found</p>"))
    
    forecast_data <- create_arima_forecast(df, var_name, input$health_school_type_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(HTML(paste0("<p style='color:red;'>Error: ", forecast_data$error, "</p>")))
    }
    
    m <- forecast_data$metrics
    model_info <- if(!is.null(forecast_data$used_auto) && forecast_data$used_auto) {
      paste("Auto-selected ARIMA", paste(forecast_data$model$arma[c(1,6,2)], collapse=","), sep="")
    } else {
      if(input$health_school_type_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    }
    
    metrics_text <- paste0(
      "<div style='font-size:12px; line-height:1.8;'>",
      "<strong>Model:</strong> ", model_info, "<br><br>",
      "<strong>Model Performance Metrics:</strong><br>",
      "AIC: ", sprintf("%.2f", m$aic), "<br>",
      "BIC: ", sprintf("%.2f", m$bic), "<br>",
      "RMSE: ", sprintf("%.2f", m$rmse), "<br>",
      "MAE: ", sprintf("%.2f", m$mae), "<br><br>",
      "<strong>Model Diagnostics:</strong><br>",
      "Variance: ", sprintf("%.2f", m$variance), "<br>",
      "Std Dev: ", sprintf("%.2f", m$std_dev),
      "</div>"
    )
    return(HTML(metrics_text))
  })
  
  # School Type Percentages Forecast Interpretation
  output$health_school_type_forecast_interpretation <- renderUI({
    req(input$health_school_type_forecast_variable, input$health_school_type_forecast_model)
    
    if(!exists('Rwanda_schools')) return(HTML("No data available"))
    
    df <- as.data.frame(Rwanda_schools)
    if ("Year" %in% names(df)) names(df)[names(df) == "Year"] <- "year"
    if ("year" %in% names(df)) {
      df <- df[order(as.numeric(df$year), decreasing = FALSE), ]
    }
    
    var_name <- input$health_school_type_forecast_variable
    if (!var_name %in% names(df)) return(HTML("<p style='color:red;'>Variable not found</p>"))
    
    forecast_data <- create_arima_forecast(df, var_name, input$health_school_type_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(HTML(paste0("<p style='color:red;'>Error: ", forecast_data$error, "</p>")))
    }
    
    if (!is.null(forecast_data$used_auto) && forecast_data$used_auto) {
      model_display <- paste("ARIMA", paste(forecast_data$model$arma[c(1,6,2)], collapse=","), sep="")
    } else {
      model_display <- if(input$health_school_type_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    }
    var_display <- gsub('_', ' ', tools::toTitleCase(var_name))
    
    change_desc <- if(forecast_data$change >= 0) "increase" else "decrease"
    trend_desc <- if(abs(forecast_data$change_pct) < 1) "near-term stabilization" else if(forecast_data$change_pct > 0) "positive growth trend" else "moderation or decline"
    
    forecast_val <- sprintf("%.2f", forecast_data$forecast_value)
    lower_val <- sprintf("%.2f", forecast_data$f_lower[1])
    upper_val <- sprintf("%.2f", forecast_data$f_upper[1])
    change_val <- sprintf("%.2f", forecast_data$change)
    current_val <- sprintf("%.2f", forecast_data$current_value)
    change_pct_val <- sprintf("%.1f%%", forecast_data$change_pct)
    
    interpretation_text <- paste0(
      "<div style='font-size:12px; line-height:1.8; color:#475569;'>",
      "Based on the ", model_display, " model, Rwanda's ", var_display, " is projected at ",
      forecast_val, " (95% CI: ", lower_val, " to ", upper_val, "). ",
      "This is a ", change_val, " change from the current ", current_val, 
      " (", change_pct_val, "). This suggests ", trend_desc, ".",
      "</div>"
    )
    return(HTML(interpretation_text))
  })
  
  # Health Indicators Forecast Variable Selector
  output$health_indicators_forecast_variable_ui <- renderUI({
    if(!exists('Rwanda_health')) return(NULL)
    df <- as.data.frame(Rwanda_health)
    
    year_cols <- names(df)[grepl('year|Year', names(df), ignore.case = TRUE)]
    health_cols <- names(df)[sapply(df, is.numeric) & !names(df) %in% year_cols]
    
    if (length(health_cols) == 0) return(NULL)
    
    # Ensure life expectancy is included
    life_cols <- names(df)[grepl('life.*expectancy|expectancy', names(df), ignore.case = TRUE) & sapply(df, is.numeric)]
    if (length(life_cols) > 0 && !life_cols[1] %in% health_cols) {
      health_cols <- c(life_cols[1], health_cols)
    }
    
    display_names <- gsub('_', ' ', health_cols)
    display_names <- tools::toTitleCase(display_names)
    
    choices_list <- setNames(health_cols, display_names)
    
    default_selection <- if (length(life_cols) > 0) life_cols[1] else health_cols[1]
    
    selectInput(
      'health_indicators_forecast_variable',
      'Select Health Indicator:',
      choices = choices_list,
      selected = default_selection,
      width = '100%'
    )
  })
  
  # Health Indicators Forecast Chart
  output$health_indicators_forecast_chart <- renderPlotly({
    req(input$health_indicators_forecast_variable, input$health_indicators_forecast_model)
    
    if(!exists('Rwanda_health')) return(plotly_empty() %>% layout(title = "No data available"))
    
    df <- as.data.frame(Rwanda_health)
    
    # Normalize column names
    if ("Year" %in% names(df)) names(df)[names(df) == "Year"] <- "year"
    if ("year" %in% names(df)) {
      df <- df[order(as.numeric(df$year), decreasing = FALSE), ]
    }
    
    var_name <- input$health_indicators_forecast_variable
    if (!var_name %in% names(df)) return(plotly_empty() %>% layout(title = "Variable not found"))
    
    forecast_data <- create_arima_forecast(df, var_name, input$health_indicators_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(plotly_empty() %>% layout(title = paste("Error:", forecast_data$error)))
    }
    
    # Create plot
    var_display <- gsub('_', ' ', tools::toTitleCase(var_name))
    if (!is.null(forecast_data$used_auto) && forecast_data$used_auto) {
      model_display <- paste("ARIMA", paste(forecast_data$model$arma[c(1,6,2)], collapse=","), sep="")
    } else {
      model_display <- if(input$health_indicators_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    }
    
    p <- plot_ly() %>%
      add_bars(
        x = forecast_data$hist_years,
        y = forecast_data$hist_values,
        name = 'Historical',
        marker = list(color = '#0ea5e9', opacity = 0.8)
      ) %>%
      add_bars(
        x = forecast_data$f_years,
        y = forecast_data$f_mean,
        name = 'Forecast (mean)',
        marker = list(color = '#157A4A', opacity = 0.8)
      ) %>%
      add_ribbons(
        x = forecast_data$f_years,
        ymin = forecast_data$f_lower,
        ymax = forecast_data$f_upper,
        name = '95% CI',
        fillcolor = 'rgba(21, 122, 74, 0.2)',
        line = list(color = 'transparent')
      ) %>%
      layout(
        title = list(
          text = paste(var_display, '- Historical & Forecast -', model_display),
          font = list(size = 18, color = '#1e40af')
        ),
        xaxis = list(title = 'Year', tickmode = 'linear', dtick = 1),
        yaxis = list(title = var_display, range = c(0, 100), tickmode = 'linear', dtick = 10),
        barmode = 'group',
        hovermode = 'x unified',
        showlegend = TRUE,
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff'
      )
    
    return(p)
  })
  
  # Health Indicators Forecast Metrics
  output$health_indicators_forecast_model_metrics <- renderUI({
    req(input$health_indicators_forecast_variable, input$health_indicators_forecast_model)
    
    if(!exists('Rwanda_health')) return(HTML("No data available"))
    
    df <- as.data.frame(Rwanda_health)
    if ("Year" %in% names(df)) names(df)[names(df) == "Year"] <- "year"
    if ("year" %in% names(df)) {
      df <- df[order(as.numeric(df$year), decreasing = FALSE), ]
    }
    
    var_name <- input$health_indicators_forecast_variable
    if (!var_name %in% names(df)) return(HTML("<p style='color:red;'>Variable not found</p>"))
    
    forecast_data <- create_arima_forecast(df, var_name, input$health_indicators_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(HTML(paste0("<p style='color:red;'>Error: ", forecast_data$error, "</p>")))
    }
    
    m <- forecast_data$metrics
    model_info <- if(!is.null(forecast_data$used_auto) && forecast_data$used_auto) {
      paste("Auto-selected ARIMA", paste(forecast_data$model$arma[c(1,6,2)], collapse=","), sep="")
    } else {
      if(input$health_indicators_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    }
    
    metrics_text <- paste0(
      "<div style='font-size:12px; line-height:1.8;'>",
      "<strong>Model:</strong> ", model_info, "<br><br>",
      "<strong>Model Performance Metrics:</strong><br>",
      "AIC: ", sprintf("%.2f", m$aic), "<br>",
      "BIC: ", sprintf("%.2f", m$bic), "<br>",
      "RMSE: ", sprintf("%.2f", m$rmse), "<br>",
      "MAE: ", sprintf("%.2f", m$mae), "<br><br>",
      "<strong>Model Diagnostics:</strong><br>",
      "Variance: ", sprintf("%.2f", m$variance), "<br>",
      "Std Dev: ", sprintf("%.2f", m$std_dev),
      "</div>"
    )
    return(HTML(metrics_text))
  })
  
  # Health Indicators Forecast Interpretation
  output$health_indicators_forecast_interpretation <- renderUI({
    req(input$health_indicators_forecast_variable, input$health_indicators_forecast_model)
    
    if(!exists('Rwanda_health')) return(HTML("No data available"))
    
    df <- as.data.frame(Rwanda_health)
    if ("Year" %in% names(df)) names(df)[names(df) == "Year"] <- "year"
    if ("year" %in% names(df)) {
      df <- df[order(as.numeric(df$year), decreasing = FALSE), ]
    }
    
    var_name <- input$health_indicators_forecast_variable
    if (!var_name %in% names(df)) return(HTML("<p style='color:red;'>Variable not found</p>"))
    
    forecast_data <- create_arima_forecast(df, var_name, input$health_indicators_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(HTML(paste0("<p style='color:red;'>Error: ", forecast_data$error, "</p>")))
    }
    
    if (!is.null(forecast_data$used_auto) && forecast_data$used_auto) {
      model_display <- paste("ARIMA", paste(forecast_data$model$arma[c(1,6,2)], collapse=","), sep="")
    } else {
      model_display <- if(input$health_indicators_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    }
    var_display <- gsub('_', ' ', tools::toTitleCase(var_name))
    
    change_desc <- if(forecast_data$change >= 0) "increase" else "decrease"
    trend_desc <- if(abs(forecast_data$change_pct) < 1) "near-term stabilization" else if(forecast_data$change_pct > 0) "positive growth trend" else "moderation or decline"
    
    forecast_val <- sprintf("%.2f", forecast_data$forecast_value)
    lower_val <- sprintf("%.2f", forecast_data$f_lower[1])
    upper_val <- sprintf("%.2f", forecast_data$f_upper[1])
    change_val <- sprintf("%.2f", forecast_data$change)
    current_val <- sprintf("%.2f", forecast_data$current_value)
    change_pct_val <- sprintf("%.1f%%", forecast_data$change_pct)
    
    interpretation_text <- paste0(
      "<div style='font-size:12px; line-height:1.8; color:#475569;'>",
      "Based on the ", model_display, " model, Rwanda's ", var_display, " is projected at ",
      forecast_val, " (95% CI: ", lower_val, " to ", upper_val, "). ",
      "This is a ", change_val, " change from the current ", current_val, 
      " (", change_pct_val, "). This suggests ", trend_desc, ".",
      "</div>"
    )
    return(HTML(interpretation_text))
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

  # Helper function to create ARIMA forecast
  create_arima_forecast <- function(data, variable, model_type, forecast_years = 5) {
    tryCatch({
      # Get data values
      values <- as.numeric(data[[variable]])
      years <- if("year" %in% names(data)) as.numeric(data$year) else if("Year" %in% names(data)) as.numeric(data$Year) else seq_along(values)
      
      # Remove NA values
      valid_idx <- !is.na(values) & !is.na(years)
      values <- values[valid_idx]
      years <- years[valid_idx]
      
      if(length(values) < 4) {
        return(list(error = "Insufficient data for forecasting"))
      }
      
      # Sort by year to ensure proper time series order
      sort_idx <- order(years)
      years <- years[sort_idx]
      values <- values[sort_idx]
      
      # Remove any remaining invalid values
      valid_final <- !is.na(values) & is.finite(values)
      if(sum(valid_final) < 4) {
        return(list(error = "Insufficient valid data for forecasting"))
      }
      years <- years[valid_final]
      values <- values[valid_final]
      
      # Create time series
      start_year <- min(years)
      ts_data <- ts(values, start = start_year, frequency = 1)
      
      # Fit ARIMA model with error handling and fallback
      model <- NULL
      model_error <- NULL
      used_auto <- FALSE
      
      # Try to fit the specified model first
      tryCatch({
        if(model_type == "arima111") {
          model <- Arima(ts_data, order = c(1, 1, 1), method = "ML")
        } else {
          model <- Arima(ts_data, order = c(2, 1, 2), method = "ML")
        }
        message(sprintf("[FORECAST] Successfully fitted %s model", ifelse(model_type == "arima111", "ARIMA(1,1,1)", "ARIMA(2,1,2)")))
      }, error = function(e) {
        model_error <<- e$message
        message(sprintf("[FORECAST] ML method failed: %s, trying CSS", e$message))
        # Try with CSS method as fallback
        tryCatch({
          if(model_type == "arima111") {
            model <<- Arima(ts_data, order = c(1, 1, 1), method = "CSS")
          } else {
            model <<- Arima(ts_data, order = c(2, 1, 2), method = "CSS")
          }
          message(sprintf("[FORECAST] Successfully fitted %s model with CSS method", ifelse(model_type == "arima111", "ARIMA(1,1,1)", "ARIMA(2,1,2)")))
        }, error = function(e2) {
          message(sprintf("[FORECAST] CSS method also failed: %s, using auto.arima", e2$message))
          # If both fail, use auto.arima as final fallback
          tryCatch({
            model <<- auto.arima(ts_data, seasonal = FALSE, stepwise = TRUE, approximation = FALSE, max.order = 5)
            used_auto <<- TRUE
            message(sprintf("[FORECAST] Using auto.arima fallback: ARIMA%s", paste(model$arma[c(1,6,2)], collapse=",")))
          }, error = function(e3) {
            model_error <<- paste("All ARIMA fitting methods failed. Last error:", e3$message)
          })
        })
      })
      
      # If model still failed, return error
      if(is.null(model)) {
        return(list(error = ifelse(is.null(model_error), "Failed to fit ARIMA model", model_error)))
      }
      
      # Generate forecast
      forecast_result <- forecast(model, h = forecast_years)
      
      # Prepare data for plotting
      hist_years <- years
      hist_values <- values
      f_years <- (max(years) + 1):(max(years) + forecast_years)
      f_mean <- as.numeric(forecast_result$mean)
      f_lower <- as.numeric(forecast_result$lower[, "95%"])
      f_upper <- as.numeric(forecast_result$upper[, "95%"])
      
      # Calculate metrics
      residuals <- residuals(model)
      aic <- AIC(model)
      bic <- BIC(model)
      rmse <- sqrt(mean(residuals^2, na.rm = TRUE))
      mae <- mean(abs(residuals), na.rm = TRUE)
      variance <- var(residuals, na.rm = TRUE)
      std_dev <- sd(residuals, na.rm = TRUE)
      
      return(list(
        hist_years = hist_years,
        hist_values = hist_values,
        f_years = f_years,
        f_mean = f_mean,
        f_lower = f_lower,
        f_upper = f_upper,
        model = model,
        used_auto = used_auto,
        metrics = list(aic = aic, bic = bic, rmse = rmse, mae = mae, variance = variance, std_dev = std_dev),
        current_value = tail(values, 1),
        forecast_value = f_mean[1],
        change = f_mean[1] - tail(values, 1),
        change_pct = ((f_mean[1] - tail(values, 1)) / tail(values, 1)) * 100
      ))
    }, error = function(e) {
      return(list(error = e$message))
    })
  }
  
  # Population Forecast Chart
  output$dem_pop_forecast_chart <- renderPlotly({
    req(input$dem_pop_forecast_variable, input$dem_pop_forecast_model)
    
    pop_data <- load_population_data()
    if (is.null(pop_data) || !is.data.frame(pop_data) || nrow(pop_data) == 0) {
      return(plotly_empty() %>% layout(title = "No data available"))
    }
    
    # Normalize column names
    if ("Year" %in% names(pop_data)) names(pop_data)[names(pop_data) == "Year"] <- "year"
    
    # Get variable name
    var_name <- input$dem_pop_forecast_variable
    if (!var_name %in% names(pop_data)) {
      # Try to find similar column
      if (var_name == "population_millions") {
        numeric_cols <- names(pop_data)[sapply(pop_data, is.numeric) & names(pop_data) != "year"]
        if (length(numeric_cols) > 0) var_name <- numeric_cols[1]
      } else if (var_name == "population_growth_rate_percent") {
        growth_cols <- names(pop_data)[grepl('growth|rate', names(pop_data), ignore.case = TRUE) & sapply(pop_data, is.numeric)]
        if (length(growth_cols) > 0) var_name <- growth_cols[1]
      }
    }
    
    forecast_data <- create_arima_forecast(pop_data, var_name, input$dem_pop_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(plotly_empty() %>% layout(title = paste("Error:", forecast_data$error)))
    }
    
    # Create plot
    var_display <- if(input$dem_pop_forecast_variable == "population_millions") "Population (Millions)" else "Growth Rate (%)"
    if (!is.null(forecast_data$used_auto) && forecast_data$used_auto) {
      model_display <- paste("ARIMA", paste(forecast_data$model$arma[c(1,6,2)], collapse=","), sep="")
    } else {
      model_display <- if(input$dem_pop_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    }
    
    p <- plot_ly() %>%
      add_bars(
        x = forecast_data$hist_years,
        y = forecast_data$hist_values,
        name = 'Historical',
        marker = list(color = '#1e40af', opacity = 0.8)
      ) %>%
      add_bars(
        x = forecast_data$f_years,
        y = forecast_data$f_mean,
        name = 'Forecast (mean)',
        marker = list(color = '#157A4A', opacity = 0.8)
      ) %>%
      add_ribbons(
        x = forecast_data$f_years,
        ymin = forecast_data$f_lower,
        ymax = forecast_data$f_upper,
        name = '95% CI',
        fillcolor = 'rgba(21, 122, 74, 0.2)',
        line = list(color = 'transparent')
      ) %>%
      layout(
        title = list(
          text = paste(var_display, '- Historical & Forecast -', model_display),
          font = list(size = 18, color = '#1e40af')
        ),
        xaxis = list(title = 'Year', tickmode = 'linear', dtick = 1),
        yaxis = list(title = var_display, rangemode = 'tozero'),
        barmode = 'group',
        hovermode = 'x unified',
        showlegend = TRUE,
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff'
      )
    
    return(p)
  })
  
  # Population Forecast Metrics
  output$dem_pop_model_metrics <- renderUI({
    req(input$dem_pop_forecast_variable, input$dem_pop_forecast_model)
    
    pop_data <- load_population_data()
    if (is.null(pop_data)) return(HTML("No data available"))
    
    # Normalize and sort data (same logic as chart)
    if ("Year" %in% names(pop_data)) names(pop_data)[names(pop_data) == "Year"] <- "year"
    if ("year" %in% names(pop_data)) {
      pop_data <- pop_data[order(as.numeric(pop_data$year)), ]
    }
    
    # Map variable name (same logic as chart)
    var_name <- input$dem_pop_forecast_variable
    if (var_name == "population_millions") {
      if ("population_millions" %in% names(pop_data)) {
        var_name <- "population_millions"
      } else {
        pop_cols <- names(pop_data)[grepl('population|pop', names(pop_data), ignore.case = TRUE) & sapply(pop_data, is.numeric)]
        if (length(pop_cols) > 0) {
          var_name <- pop_cols[1]
        } else {
          numeric_cols <- names(pop_data)[sapply(pop_data, is.numeric) & names(pop_data) != "year"]
          if (length(numeric_cols) > 0) var_name <- numeric_cols[1]
        }
      }
    } else if (var_name == "population_growth_rate_percent") {
      if ("population_growth_rate_percent" %in% names(pop_data)) {
        var_name <- "population_growth_rate_percent"
      } else {
        growth_cols <- names(pop_data)[grepl('growth|rate', names(pop_data), ignore.case = TRUE) & sapply(pop_data, is.numeric)]
        if (length(growth_cols) > 0) {
          var_name <- growth_cols[1]
        } else {
          pop_col <- names(pop_data)[grepl('population|pop', names(pop_data), ignore.case = TRUE) & sapply(pop_data, is.numeric)][1]
          if (!is.na(pop_col) && length(pop_col) > 0) {
            pop_data$calculated_growth_rate <- c(NA, round(diff(pop_data[[pop_col]]) / head(pop_data[[pop_col]], -1) * 100, 2))
            var_name <- "calculated_growth_rate"
          }
        }
      }
    }
    
    if (!var_name %in% names(pop_data)) {
      return(HTML("<p style='color:red;'>Variable not found</p>"))
    }
    
    forecast_data <- create_arima_forecast(pop_data, var_name, input$dem_pop_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(HTML(paste0("<p style='color:red;'>Error: ", forecast_data$error, "</p>")))
    }
    
    m <- forecast_data$metrics
    model_info <- if(!is.null(forecast_data$used_auto) && forecast_data$used_auto) {
      paste("Auto-selected ARIMA", paste(forecast_data$model$arma[c(1,6,2)], collapse=","), sep="")
    } else {
      if(input$dem_pop_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    }
    
    metrics_text <- paste0(
      "<div style='font-size:12px; line-height:1.8;'>",
      "<strong>Model:</strong> ", model_info, "<br><br>",
      "<strong>Model Performance Metrics:</strong><br>",
      "AIC: ", sprintf("%.2f", m$aic), "<br>",
      "BIC: ", sprintf("%.2f", m$bic), "<br>",
      "RMSE: ", sprintf("%.2f", m$rmse), "<br>",
      "MAE: ", sprintf("%.2f", m$mae), "<br><br>",
      "<strong>Model Diagnostics:</strong><br>",
      "Variance: ", sprintf("%.2f", m$variance), "<br>",
      "Std Dev: ", sprintf("%.2f", m$std_dev),
      "</div>"
    )
    return(HTML(metrics_text))
  })
  
  # Population Forecast Interpretation
  output$dem_pop_interpretation <- renderUI({
    req(input$dem_pop_forecast_variable, input$dem_pop_forecast_model)
    
    pop_data <- load_population_data()
    if (is.null(pop_data)) return(HTML("No data available"))
    
    # Normalize and sort data (same logic as chart)
    if ("Year" %in% names(pop_data)) names(pop_data)[names(pop_data) == "Year"] <- "year"
    if ("year" %in% names(pop_data)) {
      pop_data <- pop_data[order(as.numeric(pop_data$year)), ]
    }
    
    # Map variable name (same logic as chart)
    var_name <- input$dem_pop_forecast_variable
    if (var_name == "population_millions") {
      if ("population_millions" %in% names(pop_data)) {
        var_name <- "population_millions"
      } else {
        pop_cols <- names(pop_data)[grepl('population|pop', names(pop_data), ignore.case = TRUE) & sapply(pop_data, is.numeric)]
        if (length(pop_cols) > 0) {
          var_name <- pop_cols[1]
        } else {
          numeric_cols <- names(pop_data)[sapply(pop_data, is.numeric) & names(pop_data) != "year"]
          if (length(numeric_cols) > 0) var_name <- numeric_cols[1]
        }
      }
    } else if (var_name == "population_growth_rate_percent") {
      if ("population_growth_rate_percent" %in% names(pop_data)) {
        var_name <- "population_growth_rate_percent"
      } else {
        growth_cols <- names(pop_data)[grepl('growth|rate', names(pop_data), ignore.case = TRUE) & sapply(pop_data, is.numeric)]
        if (length(growth_cols) > 0) {
          var_name <- growth_cols[1]
        } else {
          pop_col <- names(pop_data)[grepl('population|pop', names(pop_data), ignore.case = TRUE) & sapply(pop_data, is.numeric)][1]
          if (!is.na(pop_col) && length(pop_col) > 0) {
            pop_data$calculated_growth_rate <- c(NA, round(diff(pop_data[[pop_col]]) / head(pop_data[[pop_col]], -1) * 100, 2))
            var_name <- "calculated_growth_rate"
          }
        }
      }
    }
    
    if (!var_name %in% names(pop_data)) {
      return(HTML("<p style='color:red;'>Variable not found</p>"))
    }
    
    forecast_data <- create_arima_forecast(pop_data, var_name, input$dem_pop_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(HTML(paste0("<p style='color:red;'>Error: ", forecast_data$error, "</p>")))
    }
    
    if (!is.null(forecast_data$used_auto) && forecast_data$used_auto) {
      model_display <- paste("ARIMA", paste(forecast_data$model$arma[c(1,6,2)], collapse=","), sep="")
    } else {
      model_display <- if(input$dem_pop_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    }
    var_display <- if(input$dem_pop_forecast_variable == "population_millions") "population" else "population growth rate"
    
    change_desc <- if(forecast_data$change >= 0) "increase" else "decrease"
    trend_desc <- if(abs(forecast_data$change_pct) < 1) "near-term stabilization" else if(forecast_data$change_pct > 0) "positive growth trend" else "moderation or decline"
    
    forecast_val <- sprintf("%.2f", forecast_data$forecast_value)
    lower_val <- sprintf("%.2f", forecast_data$f_lower[1])
    upper_val <- sprintf("%.2f", forecast_data$f_upper[1])
    change_val <- sprintf("%.2f", forecast_data$change)
    current_val <- sprintf("%.2f", forecast_data$current_value)
    change_pct_val <- sprintf("%.1f%%", forecast_data$change_pct)
    
    interpretation_text <- paste0(
      "<div style='font-size:12px; line-height:1.8; color:#475569;'>",
      "Based on the ", model_display, " model, Rwanda's ", var_display, " is projected at ",
      forecast_val, " (95% CI: ", lower_val, " to ", upper_val, "). ",
      "This is a ", change_val, " change from the current ", current_val, 
      " (", change_pct_val, "). This suggests ", trend_desc, ".",
      "</div>"
    )
    
    return(HTML(interpretation_text))
  })
  
  # Labor Force Forecast Variable UI
  output$dem_labor_forecast_variable_ui <- renderUI({
    labor_data <- load_labor_force_data()
    if (is.null(labor_data) || !is.data.frame(labor_data) || nrow(labor_data) == 0) {
      return(selectInput('dem_labor_forecast_variable', 'Select Labor Force Variable:', choices = list(), width = '100%'))
    }
    
    if ("Year" %in% names(labor_data)) names(labor_data)[names(labor_data) == "Year"] <- "year"
    
    labor_cols <- names(labor_data)[sapply(labor_data, is.numeric) & names(labor_data) != "year"]
    
    if (length(labor_cols) == 0) {
      return(selectInput('dem_labor_forecast_variable', 'Select Labor Force Variable:', choices = list(), width = '100%'))
    }
    
    display_names <- gsub('_', ' ', labor_cols)
    display_names <- tools::toTitleCase(display_names)
    choices_list <- setNames(labor_cols, display_names)
    
    selectInput(
      'dem_labor_forecast_variable',
      'Select Labor Force Variable:',
      choices = choices_list,
      selected = labor_cols[1],
      width = '100%'
    )
  })
  
  # Labor Force Forecast Chart
  output$dem_labor_forecast_chart <- renderPlotly({
    req(input$dem_labor_forecast_variable, input$dem_labor_forecast_model)
    
    labor_data <- load_labor_force_data()
    if (is.null(labor_data) || !is.data.frame(labor_data) || nrow(labor_data) == 0) {
      return(plotly_empty() %>% layout(title = "No data available"))
    }
    
    if ("Year" %in% names(labor_data)) names(labor_data)[names(labor_data) == "Year"] <- "year"
    
    forecast_data <- create_arima_forecast(labor_data, input$dem_labor_forecast_variable, input$dem_labor_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(plotly_empty() %>% layout(title = paste("Error:", forecast_data$error)))
    }
    
    var_display <- gsub('_', ' ', input$dem_labor_forecast_variable)
    var_display <- tools::toTitleCase(var_display)
    model_display <- if(input$dem_labor_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    
    p <- plot_ly() %>%
      add_bars(
        x = forecast_data$hist_years,
        y = forecast_data$hist_values,
        name = 'Historical',
        marker = list(color = '#1e40af', opacity = 0.8)
      ) %>%
      add_bars(
        x = forecast_data$f_years,
        y = forecast_data$f_mean,
        name = 'Forecast (mean)',
        marker = list(color = '#157A4A', opacity = 0.8)
      ) %>%
      add_ribbons(
        x = forecast_data$f_years,
        ymin = forecast_data$f_lower,
        ymax = forecast_data$f_upper,
        name = '95% CI',
        fillcolor = 'rgba(21, 122, 74, 0.2)',
        line = list(color = 'transparent')
      ) %>%
      layout(
        title = list(
          text = paste(var_display, '- Historical & Forecast -', model_display),
          font = list(size = 18, color = '#1e40af')
        ),
        xaxis = list(title = 'Year', tickmode = 'linear', dtick = 1),
        yaxis = list(title = var_display, rangemode = 'tozero'),
        barmode = 'group',
        hovermode = 'x unified',
        showlegend = TRUE,
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff'
      )
    
    return(p)
  })
  
  # Labor Force Forecast Metrics
  output$dem_labor_model_metrics <- renderUI({
    req(input$dem_labor_forecast_variable, input$dem_labor_forecast_model)
    
    labor_data <- load_labor_force_data()
    if (is.null(labor_data)) return(HTML("No data available"))
    
    if ("Year" %in% names(labor_data)) names(labor_data)[names(labor_data) == "Year"] <- "year"
    
    forecast_data <- create_arima_forecast(labor_data, input$dem_labor_forecast_variable, input$dem_labor_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(HTML(paste0("<p style='color:red;'>Error: ", forecast_data$error, "</p>")))
    }
    
    m <- forecast_data$metrics
    metrics_text <- paste0(
      "<div style='font-size:12px; line-height:1.8;'>",
      "<strong>Model Performance Metrics:</strong><br>",
      "AIC: ", sprintf("%.2f", m$aic), "<br>",
      "BIC: ", sprintf("%.2f", m$bic), "<br>",
      "RMSE: ", sprintf("%.2f", m$rmse), "<br>",
      "MAE: ", sprintf("%.2f", m$mae), "<br><br>",
      "<strong>Model Diagnostics:</strong><br>",
      "Variance: ", sprintf("%.2f", m$variance), "<br>",
      "Std Dev: ", sprintf("%.2f", m$std_dev),
      "</div>"
    )
    return(HTML(metrics_text))
  })
  
  # Labor Force Forecast Interpretation
  output$dem_labor_interpretation <- renderUI({
    req(input$dem_labor_forecast_variable, input$dem_labor_forecast_model)
    
    labor_data <- load_labor_force_data()
    if (is.null(labor_data)) return(HTML("No data available"))
    
    if ("Year" %in% names(labor_data)) names(labor_data)[names(labor_data) == "Year"] <- "year"
    
    forecast_data <- create_arima_forecast(labor_data, input$dem_labor_forecast_variable, input$dem_labor_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(HTML(paste0("<p style='color:red;'>Error: ", forecast_data$error, "</p>")))
    }
    
    model_display <- if(input$dem_labor_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    var_display <- gsub('_', ' ', input$dem_labor_forecast_variable)
    var_display <- tools::toTitleCase(var_display)
    
    trend_desc <- if(abs(forecast_data$change_pct) < 1) "near-term stabilization" else if(forecast_data$change_pct > 0) "positive growth trend" else "moderation or decline"
    
    forecast_val <- sprintf("%.2f", forecast_data$forecast_value)
    lower_val <- sprintf("%.2f", forecast_data$f_lower[1])
    upper_val <- sprintf("%.2f", forecast_data$f_upper[1])
    change_val <- sprintf("%.2f", forecast_data$change)
    current_val <- sprintf("%.2f", forecast_data$current_value)
    change_pct_val <- sprintf("%.1f%%", forecast_data$change_pct)
    
    interpretation_text <- paste0(
      "<div style='font-size:12px; line-height:1.8; color:#475569;'>",
      "Based on the ", model_display, " model, Rwanda's ", var_display, " is projected at ",
      forecast_val, " (95% CI: ", lower_val, " to ", upper_val, "). ",
      "This is a ", change_val, " change from the current ", current_val, 
      " (", change_pct_val, "). This suggests ", trend_desc, ".",
      "</div>"
    )
    
    return(HTML(interpretation_text))
  })
  
  # Agriculture GDP Forecast Chart
  output$dem_agri_gdp_forecast_chart <- renderPlotly({
    req(input$dem_agri_gdp_forecast_model)
    
    agri_gdp_data <- load_agriculture_gdp_data()
    if (is.null(agri_gdp_data) || !is.data.frame(agri_gdp_data) || nrow(agri_gdp_data) == 0) {
      return(plotly_empty() %>% layout(title = "No data available"))
    }
    
    if ("Year" %in% names(agri_gdp_data)) names(agri_gdp_data)[names(agri_gdp_data) == "Year"] <- "year"
    
    # Find percentage column
    pct_cols <- names(agri_gdp_data)[grepl('percent|%|pct|agriculture|gdp', names(agri_gdp_data), ignore.case = TRUE) & sapply(agri_gdp_data, is.numeric)]
    if (length(pct_cols) == 0) {
      numeric_cols <- names(agri_gdp_data)[sapply(agri_gdp_data, is.numeric) & names(agri_gdp_data) != "year"]
      if (length(numeric_cols) > 0) pct_col <- numeric_cols[1] else return(plotly_empty() %>% layout(title = "No percentage data found"))
    } else {
      pct_col <- pct_cols[1]
    }
    
    forecast_data <- create_arima_forecast(agri_gdp_data, pct_col, input$dem_agri_gdp_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(plotly_empty() %>% layout(title = paste("Error:", forecast_data$error)))
    }
    
    model_display <- if(input$dem_agri_gdp_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    
    p <- plot_ly() %>%
      add_bars(
        x = forecast_data$hist_years,
        y = forecast_data$hist_values,
        name = 'Historical',
        marker = list(color = '#1e40af', opacity = 0.8)
      ) %>%
      add_bars(
        x = forecast_data$f_years,
        y = forecast_data$f_mean,
        name = 'Forecast (mean)',
        marker = list(color = '#157A4A', opacity = 0.8)
      ) %>%
      add_ribbons(
        x = forecast_data$f_years,
        ymin = forecast_data$f_lower,
        ymax = forecast_data$f_upper,
        name = '95% CI',
        fillcolor = 'rgba(21, 122, 74, 0.2)',
        line = list(color = 'transparent')
      ) %>%
      layout(
        title = list(
          text = paste('Agriculture % to GDP - Historical & Forecast -', model_display),
          font = list(size = 18, color = '#1e40af')
        ),
        xaxis = list(title = 'Year', tickmode = 'linear', dtick = 1),
        yaxis = list(title = 'Percentage (%)', rangemode = 'tozero', ticksuffix = '%'),
        barmode = 'group',
        hovermode = 'x unified',
        showlegend = TRUE,
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff'
      )
    
    return(p)
  })
  
  # Agriculture GDP Forecast Metrics
  output$dem_agri_gdp_model_metrics <- renderUI({
    req(input$dem_agri_gdp_forecast_model)
    
    agri_gdp_data <- load_agriculture_gdp_data()
    if (is.null(agri_gdp_data)) return(HTML("No data available"))
    
    if ("Year" %in% names(agri_gdp_data)) names(agri_gdp_data)[names(agri_gdp_data) == "Year"] <- "year"
    
    pct_cols <- names(agri_gdp_data)[grepl('percent|%|pct|agriculture|gdp', names(agri_gdp_data), ignore.case = TRUE) & sapply(agri_gdp_data, is.numeric)]
    if (length(pct_cols) == 0) {
      numeric_cols <- names(agri_gdp_data)[sapply(agri_gdp_data, is.numeric) & names(agri_gdp_data) != "year"]
      if (length(numeric_cols) > 0) pct_col <- numeric_cols[1] else return(HTML("No percentage data found"))
    } else {
      pct_col <- pct_cols[1]
    }
    
    forecast_data <- create_arima_forecast(agri_gdp_data, pct_col, input$dem_agri_gdp_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(HTML(paste0("<p style='color:red;'>Error: ", forecast_data$error, "</p>")))
    }
    
    m <- forecast_data$metrics
    metrics_text <- paste0(
      "<div style='font-size:12px; line-height:1.8;'>",
      "<strong>Model Performance Metrics:</strong><br>",
      "AIC: ", sprintf("%.2f", m$aic), "<br>",
      "BIC: ", sprintf("%.2f", m$bic), "<br>",
      "RMSE: ", sprintf("%.2f", m$rmse), "<br>",
      "MAE: ", sprintf("%.2f", m$mae), "<br><br>",
      "<strong>Model Diagnostics:</strong><br>",
      "Variance: ", sprintf("%.2f", m$variance), "<br>",
      "Std Dev: ", sprintf("%.2f", m$std_dev),
      "</div>"
    )
    return(HTML(metrics_text))
  })
  
  # Agriculture GDP Forecast Interpretation
  output$dem_agri_gdp_interpretation <- renderUI({
    req(input$dem_agri_gdp_forecast_model)
    
    agri_gdp_data <- load_agriculture_gdp_data()
    if (is.null(agri_gdp_data)) return(HTML("No data available"))
    
    if ("Year" %in% names(agri_gdp_data)) names(agri_gdp_data)[names(agri_gdp_data) == "Year"] <- "year"
    
    pct_cols <- names(agri_gdp_data)[grepl('percent|%|pct|agriculture|gdp', names(agri_gdp_data), ignore.case = TRUE) & sapply(agri_gdp_data, is.numeric)]
    if (length(pct_cols) == 0) {
      numeric_cols <- names(agri_gdp_data)[sapply(agri_gdp_data, is.numeric) & names(agri_gdp_data) != "year"]
      if (length(numeric_cols) > 0) pct_col <- numeric_cols[1] else return(HTML("No percentage data found"))
    } else {
      pct_col <- pct_cols[1]
    }
    
    forecast_data <- create_arima_forecast(agri_gdp_data, pct_col, input$dem_agri_gdp_forecast_model)
    
    if (!is.null(forecast_data$error)) {
      return(HTML(paste0("<p style='color:red;'>Error: ", forecast_data$error, "</p>")))
    }
    
    model_display <- if(input$dem_agri_gdp_forecast_model == "arima111") "ARIMA(1,1,1)" else "ARIMA(2,1,2)"
    
    trend_desc <- if(abs(forecast_data$change_pct) < 1) "near-term stabilization" else if(forecast_data$change_pct > 0) "positive growth trend" else "moderation or decline"
    
    forecast_val <- sprintf("%.2f%%", forecast_data$forecast_value)
    lower_val <- sprintf("%.2f%%", forecast_data$f_lower[1])
    upper_val <- sprintf("%.2f%%", forecast_data$f_upper[1])
    change_val <- sprintf("%.2f%%", forecast_data$change)
    current_val <- sprintf("%.2f%%", forecast_data$current_value)
    change_pct_val <- sprintf("%.1f%%", forecast_data$change_pct)
    
    interpretation_text <- paste0(
      "<div style='font-size:12px; line-height:1.8; color:#475569;'>",
      "Based on the ", model_display, " model, Rwanda's agriculture contribution to GDP is projected at ",
      forecast_val, " (95% CI: ", lower_val, " to ", upper_val, "). ",
      "This is a ", change_val, " change from the current ", current_val, 
      " (", change_pct_val, "). This suggests ", trend_desc, ".",
      "</div>"
    )
    
    return(HTML(interpretation_text))
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
      # allow user to pick the variable via the new overview_production_variable selectInput
      var_col <- if(!is.null(input$overview_production_variable)) input$overview_production_variable else names(df)[2]
      # fall back if chosen column not present
      if(! (var_col %in% names(df)) ) var_col <- names(df)[2]

      df2 <- df %>%
        mutate(Year = as.integer(get(year_col)),
               Value = as.numeric(.data[[var_col]])) %>%
        arrange(Year)

      y_title <- switch(var_col,
                        'Agricultural_Yield_Billion_USD' = 'Agricultural Yield (Billion USD)',
                        'Industrial_Output_Billion_USD' = 'Industrial Output (Billion USD)',
                        'Service_Output_Billion_USD' = 'Service Output (Billion USD)',
                        var_col)

      plot_ly(df2, x = ~Year, y = ~Value, type = 'bar', marker = list(color = '#0B78A0'),
              hovertemplate = paste('<b>Year</b>: %{x}<br><b>', y_title, '</b>: %{y}<extra></extra>')) %>%
        layout(title = paste('Rwanda Production Output —', y_title), xaxis = list(title = year_col, tickmode = 'linear', dtick = 1), yaxis = list(title = y_title))
    } else plotly_empty()
  })

  # Helper function to find the correct schema name for rwanda_trade table
  find_trade_table_schema <- function(conn) {
    tryCatch({
      # Query information_schema to find the table
      schemas <- dbGetQuery(conn, "
        SELECT table_schema 
        FROM information_schema.tables 
        WHERE table_name = 'rwanda_trade'
        ORDER BY table_schema
      ")
      
      if (nrow(schemas) > 0) {
        schema_name <- schemas$table_schema[1]
        # Quote if it contains spaces or special characters
        if (grepl("[^a-zA-Z0-9_]", schema_name)) {
          return(sprintf('"%s"', schema_name))
        }
        return(schema_name)
      }
      return(NULL)
    }, error = function(e) {
      message(sprintf("[TRADE CHART] Error finding schema: %s", e$message))
      return(NULL)
    })
  }
  
  # Rwanda Balance of Trade Chart
  output$rwanda_trade_plot <- renderPlotly({
    trade_data <- NULL
    
    # Try to load from database first
    tryCatch({
      conn <- get_neon_connection()
      on.exit({
        if (!is.null(conn) && dbIsValid(conn)) {
          dbDisconnect(conn)
        }
      }, add = TRUE)
      
      message("[TRADE CHART] 🔌 Connected to database, querying trade data...")
      
      # First, try to find the correct schema automatically
      schema_name <- find_trade_table_schema(conn)
      
      if (!is.null(schema_name)) {
        tryCatch({
          query <- sprintf('
            SELECT 
              year,
              exports_usd_billions,
              imports_usd_billions,
              trade_balance_usd_billions
            FROM %s.rwanda_trade
            ORDER BY year ASC
          ', schema_name)
          
          message(sprintf("[TRADE CHART] Found schema: %s, querying...", schema_name))
          trade_data <- dbGetQuery(conn, query)
          
          if (!is.null(trade_data) && nrow(trade_data) > 0) {
            message(sprintf("[TRADE CHART] ✅ Data loaded from database using schema: %s (%d rows)", schema_name, nrow(trade_data)))
          }
        }, error = function(e) {
          message(sprintf("[TRADE CHART] Query with detected schema failed: %s", e$message))
        })
      }
      
      # If auto-detection failed, try different schema name variations
      if (is.null(trade_data) || nrow(trade_data) == 0) {
        schema_variations <- c('"economic data"', 'economic_data', 'economic')
        
        for (schema_var in schema_variations) {
          tryCatch({
            query <- sprintf('
              SELECT 
                year,
                exports_usd_billions,
                imports_usd_billions,
                trade_balance_usd_billions
              FROM %s.rwanda_trade
              ORDER BY year ASC
            ', schema_var)
            
            message(sprintf("[TRADE CHART] Trying schema: %s", schema_var))
            trade_data <- dbGetQuery(conn, query)
            
            if (!is.null(trade_data) && nrow(trade_data) > 0) {
              message(sprintf("[TRADE CHART] ✅ Data loaded from database using schema: %s (%d rows)", schema_var, nrow(trade_data)))
              break
            }
          }, error = function(e) {
            message(sprintf("[TRADE CHART] Schema %s failed: %s", schema_var, e$message))
          })
        }
      }
      
      # If still no data, try without schema prefix
      if (is.null(trade_data) || nrow(trade_data) == 0) {
        tryCatch({
          message("[TRADE CHART] Trying without schema prefix...")
          trade_data <- dbGetQuery(conn, "
            SELECT 
              year,
              exports_usd_billions,
              imports_usd_billions,
              trade_balance_usd_billions
            FROM rwanda_trade
            ORDER BY year ASC
          ")
          if (!is.null(trade_data) && nrow(trade_data) > 0) {
            message(sprintf("[TRADE CHART] ✅ Data loaded without schema prefix (%d rows)", nrow(trade_data)))
          }
        }, error = function(e) {
          message(sprintf("[TRADE CHART] Query without schema failed: %s", e$message))
        })
      }
      
    }, error = function(e) {
      message(sprintf("[TRADE CHART] ⚠️ Database connection failed: %s. Using CSV data.", e$message))
      
      # Fallback to CSV data if database table doesn't exist
      if (exists('Rwanda_trade') && !is.null(Rwanda_trade)) {
        df <- as.data.frame(Rwanda_trade)
        
        # Map CSV column names to expected names
        year_col <- names(df)[1]  # Usually "Year"
        exports_col <- names(df)[grep("Export", names(df), ignore.case = TRUE)[1]]
        imports_col <- names(df)[grep("Import", names(df), ignore.case = TRUE)[1]]
        balance_col <- names(df)[grep("Balance|Trade", names(df), ignore.case = TRUE)[1]]
        
        if (!is.na(exports_col) && !is.na(imports_col) && !is.na(balance_col)) {
          trade_data <- data.frame(
            year = as.numeric(df[[year_col]]),
            exports_usd_billions = as.numeric(df[[exports_col]]),
            imports_usd_billions = as.numeric(df[[imports_col]]),
            trade_balance_usd_billions = as.numeric(df[[balance_col]])
          )
          trade_data <- trade_data[order(trade_data$year), ]
          message("[TRADE CHART] ✅ Data loaded from CSV file")
        }
      }
    })
    
    # If still no data, return empty plot
    if (is.null(trade_data) || nrow(trade_data) == 0) {
      return(plotly_empty() %>% 
             layout(title = "No trade data available",
                   annotations = list(text = "No trade data found in economic_data.rwanda_trade",
                                     xref = "paper", yref = "paper",
                                     x = 0.5, y = 0.5, showarrow = FALSE)))
    }
    
    # Ensure numeric columns
    trade_data$year <- as.numeric(trade_data$year)
    trade_data$exports_usd_billions <- as.numeric(trade_data$exports_usd_billions)
    trade_data$imports_usd_billions <- as.numeric(trade_data$imports_usd_billions)
    trade_data$trade_balance_usd_billions <- as.numeric(trade_data$trade_balance_usd_billions)
    
    # Create professional statistical chart with multiple series
    p <- plot_ly(trade_data, x = ~year) %>%
      add_trace(
        y = ~exports_usd_billions,
        name = 'Exports',
        type = 'scatter',
        mode = 'lines+markers',
        line = list(color = '#0B78A0', width = 3),
        marker = list(color = '#0B78A0', size = 8, symbol = 'circle'),
        hovertemplate = '<b>Year</b>: %{x}<br><b>Exports</b>: $%{y:.2f} Billion<extra></extra>'
      ) %>%
      add_trace(
        y = ~imports_usd_billions,
        name = 'Imports',
        type = 'scatter',
        mode = 'lines+markers',
        line = list(color = '#dc2626', width = 3),
        marker = list(color = '#dc2626', size = 8, symbol = 'square'),
        hovertemplate = '<b>Year</b>: %{x}<br><b>Imports</b>: $%{y:.2f} Billion<extra></extra>'
      ) %>%
      add_trace(
        y = ~trade_balance_usd_billions,
        name = 'Trade Balance',
        type = 'scatter',
        mode = 'lines+markers',
        line = list(color = '#059669', width = 3, dash = 'dash'),
        marker = list(color = '#059669', size = 8, symbol = 'diamond'),
        hovertemplate = '<b>Year</b>: %{x}<br><b>Trade Balance</b>: $%{y:.2f} Billion<extra></extra>'
      ) %>%
      layout(
        title = list(
          text = 'Rwanda Balance of Trade Analysis',
          font = list(size = 20, color = '#0B78A0', family = 'Arial, sans-serif')
        ),
        xaxis = list(
          title = list(text = 'Year', font = list(size = 14, color = '#374151')),
          tickmode = 'linear',
          dtick = 1,
          gridcolor = '#e5e7eb',
          showgrid = TRUE
        ),
        yaxis = list(
          title = list(text = 'Value (USD Billions)', font = list(size = 14, color = '#374151')),
          gridcolor = '#e5e7eb',
          showgrid = TRUE,
          zeroline = TRUE,
          zerolinecolor = '#9ca3af',
          zerolinewidth = 1
        ),
        hovermode = 'x unified',
        legend = list(
          orientation = 'h',
          xanchor = 'center',
          x = 0.5,
          y = -0.15,
          font = list(size = 12)
        ),
        margin = list(l = 60, r = 40, t = 80, b = 80),
        plot_bgcolor = '#ffffff',
        paper_bgcolor = '#ffffff',
        font = list(family = 'Arial, sans-serif', size = 12)
      )
    
    return(p)
  })
  
  # Trade Statistics Summary Outputs
  output$trade_avg_exports <- renderText({
    trade_data <- NULL
    
    # Try database first
    tryCatch({
      conn <- get_neon_connection()
      on.exit({
        if (!is.null(conn) && dbIsValid(conn)) {
          dbDisconnect(conn)
        }
      }, add = TRUE)
      
      # Try different schema variations
      schema_variations <- c('"economic data"', 'economic_data', 'economic')
      for (schema_name in schema_variations) {
        tryCatch({
          query <- sprintf('SELECT exports_usd_billions FROM %s.rwanda_trade', schema_name)
          trade_data <- dbGetQuery(conn, query)
          if (!is.null(trade_data) && nrow(trade_data) > 0) break
        }, error = function(e) {})
      }
      
      # Try without schema
      if (is.null(trade_data) || nrow(trade_data) == 0) {
        tryCatch({
          trade_data <- dbGetQuery(conn, "SELECT exports_usd_billions FROM rwanda_trade")
        }, error = function(e) {})
      }
    }, error = function(e) {
      # Fallback to CSV
      if (exists('Rwanda_trade') && !is.null(Rwanda_trade)) {
        df <- as.data.frame(Rwanda_trade)
        exports_col <- names(df)[grep("Export", names(df), ignore.case = TRUE)[1]]
        if (!is.na(exports_col)) {
          trade_data <- data.frame(exports_usd_billions = as.numeric(df[[exports_col]]))
        }
      }
    })
    
    if (is.null(trade_data) || nrow(trade_data) == 0) return("N/A")
    avg <- mean(trade_data$exports_usd_billions, na.rm = TRUE)
    if (is.na(avg)) return("N/A")
    sprintf("$%.2f B", avg)
  })
  
  output$trade_avg_imports <- renderText({
    trade_data <- NULL
    
    # Try database first
    tryCatch({
      conn <- get_neon_connection()
      on.exit({
        if (!is.null(conn) && dbIsValid(conn)) {
          dbDisconnect(conn)
        }
      }, add = TRUE)
      
      # Try different schema variations
      schema_variations <- c('"economic data"', 'economic_data', 'economic')
      for (schema_name in schema_variations) {
        tryCatch({
          query <- sprintf('SELECT imports_usd_billions FROM %s.rwanda_trade', schema_name)
          trade_data <- dbGetQuery(conn, query)
          if (!is.null(trade_data) && nrow(trade_data) > 0) break
        }, error = function(e) {})
      }
      
      # Try without schema
      if (is.null(trade_data) || nrow(trade_data) == 0) {
        tryCatch({
          trade_data <- dbGetQuery(conn, "SELECT imports_usd_billions FROM rwanda_trade")
        }, error = function(e) {})
      }
    }, error = function(e) {
      # Fallback to CSV
      if (exists('Rwanda_trade') && !is.null(Rwanda_trade)) {
        df <- as.data.frame(Rwanda_trade)
        imports_col <- names(df)[grep("Import", names(df), ignore.case = TRUE)[1]]
        if (!is.na(imports_col)) {
          trade_data <- data.frame(imports_usd_billions = as.numeric(df[[imports_col]]))
        }
      }
    })
    
    if (is.null(trade_data) || nrow(trade_data) == 0) return("N/A")
    avg <- mean(trade_data$imports_usd_billions, na.rm = TRUE)
    if (is.na(avg)) return("N/A")
    sprintf("$%.2f B", avg)
  })
  
  output$trade_avg_balance <- renderText({
    trade_data <- NULL
    
    # Try database first
    tryCatch({
      conn <- get_neon_connection()
      on.exit({
        if (!is.null(conn) && dbIsValid(conn)) {
          dbDisconnect(conn)
        }
      }, add = TRUE)
      
      # Try different schema variations
      schema_variations <- c('"economic data"', 'economic_data', 'economic')
      for (schema_name in schema_variations) {
        tryCatch({
          query <- sprintf('SELECT trade_balance_usd_billions FROM %s.rwanda_trade', schema_name)
          trade_data <- dbGetQuery(conn, query)
          if (!is.null(trade_data) && nrow(trade_data) > 0) break
        }, error = function(e) {})
      }
      
      # Try without schema
      if (is.null(trade_data) || nrow(trade_data) == 0) {
        tryCatch({
          trade_data <- dbGetQuery(conn, "SELECT trade_balance_usd_billions FROM rwanda_trade")
        }, error = function(e) {})
      }
    }, error = function(e) {
      # Fallback to CSV
      if (exists('Rwanda_trade') && !is.null(Rwanda_trade)) {
        df <- as.data.frame(Rwanda_trade)
        balance_col <- names(df)[grep("Balance|Trade", names(df), ignore.case = TRUE)[1]]
        if (!is.na(balance_col)) {
          trade_data <- data.frame(trade_balance_usd_billions = as.numeric(df[[balance_col]]))
        }
      }
    })
    
    if (is.null(trade_data) || nrow(trade_data) == 0) return("N/A")
    avg <- mean(trade_data$trade_balance_usd_billions, na.rm = TRUE)
    if (is.na(avg)) return("N/A")
    sprintf("$%.2f B", avg)
  })

  # Overview small text outputs (show latest values)
  # Economic Overview - Split into label and value for animations
  output$overview_gdp_label <- renderText({
    if(exists('Rwanda_GDP')){
      df <- as.data.frame(Rwanda_GDP)
      names(df)[2]
    } else 'No GDP data available'
  })
  
  output$overview_gdp_value <- renderText({
    if(exists('Rwanda_GDP')){
      df <- as.data.frame(Rwanda_GDP)
      last_row <- tail(df, 1)
      val <- last_row[[2]]
      # Format the value appropriately
      if(is.numeric(val)) {
        if(val >= 1000) {
          formatC(val, format = "f", big.mark = ",", digits = 1)
        } else {
          sprintf('%.2f', val)
        }
      } else {
        as.character(val)
      }
    } else 'N/A'
  })

  output$overview_inflation_label <- renderText({
    if(exists('Rwanda_inflation')){
      df <- as.data.frame(Rwanda_inflation)
      names(df)[2]
    } else 'No inflation data available'
  })
  
  output$overview_inflation_value <- renderText({
    if(exists('Rwanda_inflation')){
      df <- as.data.frame(Rwanda_inflation)
      last_row <- tail(df, 1)
      val <- last_row[[2]]
      # Format the value appropriately
      if(is.numeric(val)) {
        sprintf('%.2f%%', val)
      } else {
        as.character(val)
      }
    } else 'N/A'
  })

  output$overview_production_label <- renderText({
    if(exists('Rwanda_production_output')){
      df <- as.data.frame(Rwanda_production_output)
      names(df)[2]
    } else 'No production data available'
  })
  
  output$overview_production_value <- renderText({
    if(exists('Rwanda_production_output')){
      df <- as.data.frame(Rwanda_production_output)
      last_row <- tail(df, 1)
      val <- last_row[[2]]
      # Format the value appropriately
      if(is.numeric(val)) {
        if(val >= 1000) {
          formatC(val, format = "f", big.mark = ",", digits = 1)
        } else {
          sprintf('%.2f', val)
        }
      } else {
        as.character(val)
      }
    } else 'N/A'
  })
  
  # Keep old outputs for backward compatibility (if needed elsewhere)
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
      "homepage_main.jpg",
      "homepage_2.jpg",
      "homepage_3.jpg",
      "homepage_4.jpg",
      "homepage_5.jpg"
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
  Population = c(14104969, 6875000, 7229969),
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
  # Adjusted so displayed GDP change matches requested ~8.2%
  gdp_current <- 13.96 # in billion USD (example)
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
  life_exp <- c('2024' = 69.5, '2025' = 70.7) # example years (updated to 70.7)
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
  poverty <- c('2024' = 38.2, '2025' = 27.4) # example percentage (updated to 27.4)
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
  
  # Rwanda Geography & Administration data
  output$geography_box <- renderUI({
    txt <- paste0(
      '<div style="display:flex; flex-direction:column; gap:16px; width:100%;">',
        '<div style="display:flex; gap:12px; align-items:center; margin-bottom:8px;">',
          '<div class="infobox-icon"><i class="fas fa-map-marked-alt"></i></div>',
          '<div style="font-weight:700; font-size:1.22em; color:#000; text-align:left;">Rwanda Geography</div>',
        '</div>',
        '<div style="display:grid; grid-template-columns:1fr 1fr; gap:16px; margin-top:8px;">',
          '<div style="display:flex; flex-direction:column; gap:4px;">',
            '<div style="font-size:0.85em; color:#64748b; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Land Size</div>',
            '<div style="font-size:1.8em; font-weight:700; color:#0B78A0; line-height:1.2;">26,338</div>',
            '<div style="font-size:0.9em; color:#64748b;">km²</div>',
          '</div>',
          '<div style="display:flex; flex-direction:column; gap:4px;">',
            '<div style="font-size:0.85em; color:#64748b; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Provinces</div>',
            '<div style="font-size:1.8em; font-weight:700; color:#157A4A; line-height:1.2;">5</div>',
            '<div style="font-size:0.9em; color:#64748b;">Regions</div>',
          '</div>',
          '<div style="display:flex; flex-direction:column; gap:4px;">',
            '<div style="font-size:0.85em; color:#64748b; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Districts</div>',
            '<div style="font-size:1.8em; font-weight:700; color:#0B78A0; line-height:1.2;">30</div>',
            '<div style="font-size:0.9em; color:#64748b;">Administrative</div>',
          '</div>',
          '<div style="display:flex; flex-direction:column; gap:4px;">',
            '<div style="font-size:0.85em; color:#64748b; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Sectors</div>',
            '<div style="font-size:1.8em; font-weight:700; color:#157A4A; line-height:1.2;">416</div>',
            '<div style="font-size:0.9em; color:#64748b;">Local Units</div>',
          '</div>',
        '</div>',
        '<div style="margin-top:8px; padding-top:12px; border-top:1px solid rgba(11,120,160,0.1);">',
          '<div style="font-size:0.85em; color:#64748b; font-style:italic;">Administrative structure as of 2024</div>',
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


  # All dashboard server logic is now handled by modules
  
  # Initialize login system
  user_session <- login_server(input, output, session)
  
  # Initialize role-specific dashboards
  admin_dashboard_server("admin_dashboard_module", user_session)
  reviewer_dashboard_server("reviewer_dashboard_module", user_session)
  institution_dashboard_server("institution_dashboard_module", user_session)
  
}

shinyApp(ui, server)



