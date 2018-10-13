#!/bin/bash

########################################################################
# Commands for NDVI time series exercise
# Author: Veronica Andreo
# Date: October, 2018
########################################################################


#
# Data download and preparation
#


### DO NOT RUN

# create a new mapset
modis_ndvi

# add modis_lst to path
g.mapsets -p
g.mapsets mapset=modis_lst operation=add
g.list type=raster mapset=modis_lst

# set region to a LST map
g.region -p raster=MOD11B3.A2015001.h11v05.single_LST_Day_6km@modis_lst

# download MOD13C2 (https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod13c2_v006)
i.modis.download settings=$HOME/gisdata/SETTING \
 product=ndvi_terra_monthly_5600 \
 startday="2015-01-01" \
 endday="2017-12-31" \
 folder=$HOME/gisdata/mod13

# move to the latlong location

# import into latlong location: NDVI, EVI, QA, NIR, SWIR, Pixel reliability
i.modis.import files=$HOME/gisdata/mod13/listfileMOD13C2.006.txt \
 spectral="( 1 1 1 0 1 0 1 0 0 0 0 1 )"

# set region to bb

# subset to region and remove global maps

# move back to NC location

# reproject

### END OF DO NOT RUN


#
# 
#


# list files and get info and stats
g.list type=raster
r.info
r.univar

# visualize pixel reliability band (https://lpdaac.usgs.gov/sites/default/files/public/product_documentation/mod13_user_guide.pdf)

# use only most reliable pixels

# create time series

# check it was created

# register maps

# print time series info

# print list of maps in time series

# visual inspection

# is there missing data?

# gapfill: r.hants

# assess results visually

# patch original with filled

# create new time series with filled data

# start, end and length of growing season

# get average and standard deviation ndvi

# percentils: identify changes

# estimate NDWI
