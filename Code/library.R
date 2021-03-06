#### R LIBRARIES ####

## Data manipulation
library(data.table)
library(jsonlite)
library(ndjson)
library(tidyverse)

## Mapping
library(leaflet)
library(sf)
library(USAboundaries)

#### CUSTOM FUNCTIONS ####
fread_to_tbl <- function(filepath) {
  require(data.table)
  require(dplyr)
  
  data <- data.table::fread(filepath) %>%
    as.data.frame() %>%
    as.tbl()
  
  return(data)
}