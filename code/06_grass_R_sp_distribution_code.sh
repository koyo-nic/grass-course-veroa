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


# install extension (requires pygbif: pip install pygbif)
g.extension extension=v.in.pygbif

# set region and mask
g.region vector=nc_state align=MOD11B3.A2015001.h11v05.single_LST_Day_6km@modis_lst
r.mask vector=nc_state

# import data from gbif
v.in.pygbif output=aedes_albopictus taxa="Aedes albopictus" \
 date_from="2015-01-01" date_to="2018-09-30"
 
# create absences
v.buffer input=aedes_albopictus output=aedes_buffer distance=3000
r.mask -i vector=aedes_buffer
v.random output=background_points npoints=100
r.mask -r


#
# Generate environmental variables
#

# Average LST

# Minimum LST

# Average LST of summer

# Average LST of winter

# Average NDVI

# Average NDWI
