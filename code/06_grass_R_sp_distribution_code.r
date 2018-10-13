########################################################################
# Commands for GRASS - R interface presentation and demo (bash part)
# Author: Veronica Andreo
# Date: July - August, 2018
########################################################################


##### In R ######


#
# Install and load required packages
#


# install
install.packages("raster")
install.packages("mapview")
install.packages("biomod2")

# load libraries
library(raster)
library(virtualspecies)
library(rgrass7)
library(mapview)
library(biomod2)

# Set GRASS GIS variables for initialization
# Path to GRASS binaries
myGRASS <- "/home/veroandreo/software/grass-7.0.svn/dist.x86_64-unknown-linux-gnu"
# Path to GRASS database
myGISDbase <- "/home/veroandreo/grassdata/"
# Path to location
myLocation <- "nc_spm_08_grass7"
# Path to mapset
myMapset <- "user1"

# Start GRASS GIS from R
initGRASS(gisBase = myGRASS, 
		  home = tempdir(), 
		  gisDbase = myGISDbase, 
		  location = myLocation, 
          mapset = myMapset,
          SG="elevation",
          override = TRUE)

# Read raster layers
LST_mean <- readRAST("")                                                                                                                                       
LST_min <- readRAST("")
NDVI_mean <- readRAST("")
NDWI_mean <- readRAST("")

# Read vector layers
Aa_pres <- readVECT("Ae_albopictus_GBIF")
Aa_abs <- readVECT("background_points")

# visualize in mapview
mapview(LST_mean)
mapview(LST_mean) + pres


#
# Data preparation and formatting
#


n_pres <- length(Attalea@data[,1])
n_abs <- length(Ausencias@data[,1])
 
myRespName <- 'Aedes_albopictus'

pres <- rep(1, n_pres)
abs <- rep(0, n_abs)
myResp <- c(pres,abs)

myRespXY <- rbind(cbind(Attalea@coords[,1],Attalea@coords[,2]), 
				  cbind(Ausencias@coords[,1],Ausencias@coords[,2]))

myExpl <- stack(raster(LST_mean),raster(LST_min))

myBiomodData <- BIOMOD_FormatingData(resp.var = myResp,
                                     expl.var = myExpl,
                                     resp.xy = myRespXY,
                                     resp.name = myRespName)


#
# Run model
#


myBiomodOption <- BIOMOD_ModelingOptions()

myBiomodModelOut <- BIOMOD_Modeling(
  myBiomodData,
  models = c('RF'),  # algoritmos de analisis para hacer el modelo
  models.options = myBiomodOption,
  NbRunEval=2,     
  DataSplit=80,   # porcentaje de los datos para evaluación
  Prevalence=0.5,
  VarImport=3,
  models.eval.meth = c('TSS','ROC'), # metricas para evaluar el modelo
  SaveObj = TRUE,
  rescal.all.models = TRUE,
  do.full.models = FALSE,
  modeling.id = paste(myRespName,"FirstModeling",sep=""))

myBiomodModelOut


#
# Evaluación del modelo
#


# extract evaluation
myBiomodModelEval <- get_evaluations(myBiomodModelOut)

# TSS: True Skill Statistics
myBiomodModelEval["TSS","Testing.data","RF",,]

# ROC
myBiomodModelEval["ROC","Testing.data",,,]

# variable importance
get_variables_importance(myBiomodModelOut)

# predictions
myBiomodProj <- BIOMOD_Projection(
                modeling.output = myBiomodModelOut, 
                new.env = myExpl,                     
                proj.name = "current", 
                selected.models = "all", 
                compress = FALSE, 
                build.clamping.mask = FALSE)

mod_proj <- get_predictions(myBiomodProj)
mod_proj

# plot predicted potential distribution
plot(mod_proj, main = "Predicted potential distribution - RF")


