#!/bin/bash

########################################################################
# Commands for NDVI time series exercise
# Author: Veronica Andreo
# Date: October, 2018
########################################################################


#
# Data download and preparation
#


### DO NOT RUN ###

# start GRASS GIS in NC location and create a new mapset
grass74 -c $HOME/grassdata/nc_spm_08_grass7/modis_ndvi

# add modis_lst to path
g.mapsets -p
g.mapsets mapset=modis_lst operation=add
g.list type=raster mapset=modis_lst

# set region to a LST map
g.region -p raster=MOD11B3.A2015001.h11v05.single_LST_Day_6km@modis_lst

# get bounding box in ll
g.region -bg
#~ ll_n=40.59247652
#~ ll_s=29.48543350
#~ ll_w=-91.37851025
#~ ll_e=-67.97322249
#~ ll_clon=-79.67586637
#~ ll_clat=35.03895501

# download MOD13C2 (https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod13c2_v006)
i.modis.download settings=$HOME/gisdata/SETTING \
 product=ndvi_terra_monthly_5600 \
 startday="2015-01-01" \
 endday="2017-12-31" \
 folder=$HOME/gisdata/mod13

# move to the latlong location

# import into latlong location: NDVI, EVI, QA, NIR, SWIR, Pixel reliability
i.modis.import files=$HOME/gisdata/mod13/listfileMOD13C2.006.txt \
 spectral="( 1 1 1 0 1 0 1 0 0 0 0 0 1 )"

# set region to bb
g.region -p n=40.59247652 s=29.48543350 w=-91.37851025 e=-67.97322249 align=MOD13C2.A2017335.006.single_CMG_0.05_Deg_Monthly_NDVI

# subset to region and remove global maps
for map in `g.list type=raster pattern="MOD13C2*"` ; do
 r.mapcalc expression="$map = $map" --o
done

# get list of maps to reprojects
g.list type=raster pattern="MOD13C2*" output=list_proj.txt

# move back to NC location

# reproject
for map in `cat list_proj.txt` ; do
 r.proj input=$map location=latlong_wgs84 mapset=testing resolution=5600
done

### END OF DO NOT RUN ###


#
# 
#


# download data

# add modis_lst to path
g.mapsets -p
g.mapsets mapset=modis_lst operation=add
g.list type=raster mapset=modis_lst

# list files and get info and stats
g.list type=raster
r.info 
r.univar

# visualize pixel reliability band (https://lpdaac.usgs.gov/sites/default/files/public/product_documentation/mod13_user_guide.pdf)

# use only NDVI most reliable pixels
r.mapcalc

# create NDVI time series
t.create


# check it was created
t.list 

# register maps
t.register

# print time series info
t.info

# print list of maps in time series
t.rast.list

# visual inspection
g.gui.tplot


#
# Gap-filling: HANTS
#


# is there any missing data after filtering for pixel reliability?
t.rast.univar

# gapfill: r.hants
r.hants 

# test different parameter settings and compare results

# assess results visually
g.gui.tplot

# patch original with filled
r.patch

# create new time series with filled data
t.create
t.register


#
# Derive aggregated values
#


# get average and standard deviation ndvi
t.rast.series

# percentils: identify changes



#
# Obtain phenological information
#


# install extension
g.extension extension=r.seasons

# start, end and length of growing season
r.seasons 

# get max slope


# get month of maximum and month of minimum



#
# Estimate NDWI
#


# create time series of NIR and MIR
t.create
t.register

# estimate NDWI time series
t.rast.algebra 

# frequency of inundation



#
# Regression between NDWI and NDVI
#

r.regression.series xseries= yseries=
