#Dataset para ver aceite de palma
#K. Wiese 22 de mayo 2022

#definir directorio de trabajo
setwd("~/git/CanopyHeight/")

#Librerias
library(rgee)
library(sf)
library(cptcity)

#Inicializacion
ee_Initialize(email = "klauswiesengine@gmail.com", drive = TRUE)

#Límites área de estudio
Honduras <- "data/HNg.gpkg" %>%
  st_read(quiet = TRUE) %>% 
  sf_as_ee()

#dataset
#Import the dataset; a collection of composite granules from 2019.
Canopy <- ee$Image('users/nlang/ETH_GlobalCanopyHeight_2020_10m_v1')$clip(Honduras)
Canopy_sd <- ee$Image('users/nlang/ETH_GlobalCanopyHeightSD_2020_10m_v1')$clip(Honduras)

CanopyVis <- list(
  min = 0, 
  max = 50,
  palette = cpt("mpl_inferno")
)

CanopysdVis <- list(
  min = 0, 
  max = 15,
  palette = cpt("grass_bcyr")
)

#Mapa
Map$centerObject(Honduras,zoom=7)

heigth <-   Map$addLayer(
            eeObject = Canopy,
            visParams = CanopyVis,
            name = "Altura de Canopy") 

sd <- Map$addLayer(
      eeObject = Canopy_sd,
      visParams = CanopysdVis,
      name = "Desviación Típica de la Estimación sobre la Altura de Canopy")

heigth | sd



