#!/bin/bash

########################################################################
# Commands for GRASS - R interface exercise: 
# Modelling Aedes albopictus potential distribution in NC
# Author: Veronica Andreo
# Date: October, 2018
########################################################################


#
# Download data from GBIF for Aedes albopictus
#


# install extension (requires pygbif: pip install pygbif)
g.extension extension=v.in.pygbif

# set region and mask
g.region vector=nc_state align=MOD11B3.A2015001.h11v05.single_LST_Day_6km@modis_lst
r.mask vector=nc_state

# import data from gbif
v.in.pygbif output=aedes_albopictus taxa="Aedes albopictus" \
 date_from="2015-01-01" date_to="2018-09-30"


# 
# Create background points
#


# create buffer around Aedes albopictus records
v.buffer input=aedes_albopictus output=aedes_buffer distance=2800

# generate random points
v.random output=background_points npoints=200

# remove points falling in buffers
v.select ainput=background_points binput=aedes_buffer \
 output=aedes_background operator=disjoint


#
# Generate environmental variables
#


# Average LST
t.rast.series 


# Minimum LST
t.rast.series


# Average LST of summer
t.rast.series where=



# Average LST of winter
t.rast.series where=



# Average NDVI
t.rast.series input=ndvi_monthly_patch method=average output=ndvi_average


# Average NDWI
t.rast.series

