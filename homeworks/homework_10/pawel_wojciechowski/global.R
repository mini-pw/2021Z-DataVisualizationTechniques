library(shiny)
library(bslib)
library(rsconnect)
library(shinyWidgets)
library(plotly)
#library(rsconnect)


source("eda/loadData.R")

my_theme <- bs_theme(
  base_font = font_google("Montserrat"),
  bootswatch = "minty",
  primary = "#63C6D9",
  secondary = "#63C6D9",
  info = "#88EBFF"
)
