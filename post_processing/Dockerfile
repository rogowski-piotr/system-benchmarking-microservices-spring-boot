## Base image https://hub.docker.com/u/rocker/
FROM rocker/r-base:latest

## create directories
RUN mkdir -p /01_data
RUN mkdir -p /02_code
RUN mkdir -p /03_output

## copy files
COPY install_dependencies.R ./02_code/install_packages.R

## install R-packages
RUN Rscript /02_code/install_packages.R