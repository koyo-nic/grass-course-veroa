#!/bin/bash

########################################################################
# Commands for GRASS - R interface presentation and demo (bash part)
# Author: Veronica Andreo
# Date: July - August, 2018
########################################################################


##### In GRASS GIS ######


#
# Download data from GBIF for Aedes albopictus
#


# install extension
g.extension extension=v.in.pygbif

# set region and mask
g.region raster=
r.mask vector=

# import data from gbif
v.in.pygbif 

# create absences
v.buffer 300
r.mask
v.random
r.mask -r

