########################################################################
# Commands for GRASS - R interface presentation and demo (R part)
# Author: Veronica Andreo
# Date: July - August, 2018
########################################################################

# Install packages
install.packages("rgrass7")
library("rgrass7")

# print grass session info
gmeta()

# set region
execGRASS("g.region", raster="LST_mean", flags="p")

# generate random points and sample the datasets
execGRASS("v.random", output="samples", npoints=1000)

# this will restrict sampling to the boundaries NC
# we are overwriting vector samples, so we need to use overwrite flag
execGRASS("v.random", output="samples", npoints=1000, restrict="boundaries", flags=c("overwrite"))

# create attribute table
execGRASS("v.db.addtable", map="samples", columns=c("elevation double precision", "NDVI double precision", "LST double precision"))

# sample individual rasters
execGRASS("v.what.rast", map="samples", raster="LST_mean", column="LST")
execGRASS("v.what.rast", map="samples", raster="NDVI_mean", column="NDVI")
execGRASS("v.what.rast", map="samples", raster="elevation", column="elevation")

# explore the dataset in R:
samples <- readVECT("samples")
str(samples)
summary(samples)
plot(samples@data)

# compute multivariate linear model:
linmodel <- lm(temp ~ elevation + NDVI_mean, samples)
summary(linmodel)

# predict LST using this model:
maps <- readRAST(c("elevation", "NDVI_mean"))
maps$temp_model <- predict(linmodel, newdata=maps)
spplot(maps, "temp_model")

# write modeled LST to GRASS raster and set color ramp
writeRAST(maps, "temp_model", zcol="temp_model")
execGRASS("r.colors", map="temp_model", color="celsius")

# compare simple linear model to real data:
execGRASS("r.mapcalc", expression="diff = temp_mean - temp_model")
execGRASS("r.colors", map="diff", color="differences")



#
# Start GRASS from R
#


# list available vector maps:
execGRASS("g.list", parameters = list(type = "vector"))

# list selected vector maps (wildcard):
execGRASS("g.list", parameters = list(type = "vector", pattern = "precip*"))

# save selected vector maps into R vector:
my_vmaps <- execGRASS("g.list", parameters = list(type = "vector", pattern = "precip*"))
attributes(my_vmaps)
attributes(my_vmaps)$resOut

# list available raster maps:
execGRASS("g.list", parameters = list(type = "raster"))

# list selected raster maps (wildcard):
execGRASS("g.list", parameters = list(type = "raster", pattern = "lsat7_2002*"))


In the first place, find out the path to the GRASS GIS library. This can
be easily done with the following command (still outside of R; or
through a system() call inside of R):

# OSGeo4W users: nothing to do
 
# Linux, Mac OSX users:
grass70 --config path

To call GRASS GIS 7 functionality from R, start R and use the
initGRASS() function to define the GRASS settings:

## MS-Windows users:
library(rgrass7)
# initialisation and the use of North Carolina sample dataset
initGRASS(gisBase = "C:/OSGeo4W/apps/grass/grass-7.1.svn",
         gisDbase = "C:/Users/marissa/GRASSdata/",
         location = "nc_spm_08_grass7", mapset = "user1", SG="elevation")

## Linux, Mac OSX users:
library(rgrass7)
# initialisation and the use of North Carolina sample dataset
initGRASS(gisBase = "/usr/local/grass-7.0.1", home = tempdir(), 
          gisDbase = "/home/veroandreo/grassdata/",
          location = "nc_spm_08_grass7", mapset = "user1", SG="elevation")

Note: the optional SG parameter is a 'SpatialGrid' object to define
the 'DEFAULT_WIND' of the temporary location.

# set computational region to default (optional)
system("g.region -dp")
# verify metadata
gmeta()

# get two raster maps into R space
ncdata <- readRAST(c("geology_30m", "elevation"), cat=c(TRUE, FALSE))

# calculate object summaries
summary(ncdata$geology_30m)


### Reading in data from GRASS

# the cat parameter indicates which raster values to be returned as factors
# - geology_30m is a categorical map (i.e., it comes with classes)
# - elevation is a continuous surface
ncdata <- readRAST(c("geology_30m", "elevation"), cat=c(TRUE, FALSE))

# verify the new R object:
str(ncdata)
str(ncdata@data)

# plot
image(ncdata, "elevation", col = terrain.colors(20))

execGRASS("g.region", raster = "elevation", flags = "p")
ncdata <- readRAST("elevation", cat=FALSE)
summary(ncdata)
spplot(ncdata, col = terrain.colors(20))
boxplot(ncdata$elevation ~ ncdata$geology_30m, medlwd = 1)

### Querying maps

# set the computational region first to the raster map:
execGRASS("g.region", raster = "elev_state_500m", flags = "p")

# query raster map at vector points, transfer result into R
goutput <- execGRASS("r.what", map="elev_state_500m", points="geodetic_pts", separator=",", intern=TRUE)
str(goutput)
chr [1:29939] "571530.81289275,265739.968425953,,187.8082200648" ...

# parse it
con <- textConnection(goutput)
go1 <- read.csv(con, header=FALSE)
str(go1)

### Exporting data back to GRASS

Finally, a SpatialGridDataFrame object is written back to a GRASS raster
map:

# square root of elevation)
ncdata$sqdem <- sqrt(ncdata$elevation)

# export data from *R* back into a GRASS raster map:
writeRAST(ncdata, "sqdemNC", zcol="sqdem", ignore.stderr=TRUE)

# check that it imported into GRASS ok:
execGRASS("r.info", parameters=list(map="sqdemNC"))



#
# GRASS within R in batch mode
#

# load library
library(rgrass7)
# initialisation and the use of north carolina dataset
initGRASS(gisBase = "/home/veroandreo/software/grass-7.0.svn/dist.x86_64-unknown-linux-gnu", 
          home = tempdir(), 
          gisDbase = "/home/veroandreo/grassdata/",
          location = "nc_spm_08_grass7", mapset = "user1", SG="elevation",
          override = TRUE)
# set region to default
system("g.region -dp")
# verify
gmeta()
# read data into R
ncdata <- readRAST(c("geology_30m", "elevation"), cat=c(TRUE, FALSE))
# summary of geology map
summary(ncdata$geology_30m)
proc.time()
