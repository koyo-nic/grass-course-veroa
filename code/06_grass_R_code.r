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
