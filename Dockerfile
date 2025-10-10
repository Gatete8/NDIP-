FROM rocker/shiny:4.3.2

# Install system dependencies commonly needed by R packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy app into the container
COPY . /srv/shiny-server/ndip-app

WORKDIR /srv/shiny-server/ndip-app

# Install R packages required by the app (install_packages.R should exist in the project)
COPY install_packages.R /tmp/install_packages.R
RUN Rscript /tmp/install_packages.R

# Ensure files are readable by the shiny user
RUN chown -R shiny:shiny /srv/shiny-server && \
    chmod -R 755 /srv/shiny-server

EXPOSE 3838

USER shiny

# Start shiny-server (the base image exposes the server on 3838)
CMD ["/usr/bin/shiny-server"]
