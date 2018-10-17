#!/bin/bash

########################################################################
# Worflow for Sentinel 2 data processing in GRASS GIS
# GRASS GIS postgraduate course in Rio Cuarto
# Author: Veronica Andreo
# October, 2018
########################################################################


# Create an account in copernicus-hub
https://scihub.copernicus.eu/dhus/#/self-registration

# Create a text file in $HOME/gisdata called SENTINEL_SETTING with
your_username
your_password

# install dependencies (as root user)
pip install sentinelsat
pip install pandas

# start grass and create a new mapset in NC location
grass74 -c $HOME/grassdata/nc_spm_08_grass7/sentinel2

# install i.sentinel extension
g.extension extension=i.sentinel

# set region to elevation map
g.region -p raster=elevation

# explore list of scenes for a certain date range
i.sentinel.download -l settings=$HOME/gisdata/SETTING_SENTINEL \
 start="2018-08-19" end="2018-08-26"
#~ 5 Sentinel product(s) found
#~ a559365f-8fc4-4399-8d1c-9123f72cc7a2 2018-08-24T15:48:09Z  1% S2MSI1C
#~ 780697f6-0071-4675-b7eb-662d1747776b 2018-08-24T15:48:09Z  5% S2MSI1C
#~ f188af8c-c7f6-47a6-aca2-4925e2cb2404 2018-08-22T15:59:01Z  6% S2MSI1C
#~ c326f43f-5b1f-46e0-8ecc-c37e819425fc 2018-08-22T15:59:01Z  9% S2MSI1C
#~ 74f27482-145d-42ea-a628-57a2bd9ca095 2018-08-19T15:49:01Z 16% S2MSI1C

# explore list of scenes for a certain date range
i.sentinel.download -l settings=$HOME/gisdata/SETTING_SENTINEL \
 start="2018-08-19" end="2018-08-26" area_relation=Contains
#~ 1 Sentinel product(s) found
#~ c326f43f-5b1f-46e0-8ecc-c37e819425fc 2018-08-22T15:59:01Z  9% S2MSI1C

# download the scene that fully contains our region
i.sentinel.download settings=$HOME/gisdata/SETTING_SENTINEL \
 uuid=c326f43f-5b1f-46e0-8ecc-c37e819425fc output=$HOME/gisdata \
 footprints=sentinel_2018_08

# print bands info before importing (1 -proj match, 0- no proj match)
i.sentinel.import -p input=$HOME/gisdata/
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B11.jp2 0 (EPSG: 32617)
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B02.jp2 0 (EPSG: 32617)
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B12.jp2 0 (EPSG: 32617)
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B04.jp2 0 (EPSG: 32617)
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B03.jp2 0 (EPSG: 32617)
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B01.jp2 0 (EPSG: 32617)
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B09.jp2 0 (EPSG: 32617)
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B08.jp2 0 (EPSG: 32617)
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B05.jp2 0 (EPSG: 32617)
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B06.jp2 0 (EPSG: 32617)
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B07.jp2 0 (EPSG: 32617)
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B8A.jp2 0 (EPSG: 32617)
#~ /home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/IMG_DATA/T17SQV_20180822T155901_B10.jp2 0 (EPSG: 32617)

# import the downloaded data
# -r flag is used to reproject the data during import
# -c flag allows to import also the cloud mask
i.sentinel.import -rc input=$HOME/gisdata/

# display an RGB combination
d.mon wx0
d.rgb -n red=T17SQV_20180822T155901_B04 \
 green=T17SQV_20180822T155901_B03 \
 blue=T17SQV_20180822T155901_B02

# perform color auto-balancing for RGB bands 
i.colors.enhance red=T17SQV_20180822T155901_B04 \
 green=T17SQV_20180822T155901_B03 \
 blue=T17SQV_20180822T155901_B02

# display the enhanced RGB combination
d.mon wx0
d.rgb -n red=T17SQV_20180822T155901_B04 \
 green=T17SQV_20180822T155901_B03 \
 blue=T17SQV_20180822T155901_B02


#
# Pre-processing of Sentinel 2 data
#


# enter directory with Sentinel scene and unzip file
cd $HOME/gisdata/
unzip $HOME/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.zip
      
# get AOD from http://aeronet.gsfc.nasa.gov
# https://aeronet.gsfc.nasa.gov/cgi-bin/webtool_opera_v2_inv?stage=3&region=United_States_East&state=North_Carolina&site=EPA-Res_Triangle_Pk&place_code=10&if_polarized=0
# select start and end date
# tick the box labelled as 'Combined file (all products without phase functions)'
# choose 'All Points' under Data Format
# download and unzip the file into `$HOME/gisdata/` folder (the final file has .dubovik extension).

# run i.sentinel.preproc using elevation map in NC location         
i.sentinel.preproc -atr \
 input_dir=$HOME/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE \
 elevation=elevation \
 aeronet_file=$HOME/gisdata/180819_180825_EPA-Res_Triangle_Pk.dubovik \
 suffix=corr \
 text_file=$HOME/gisdata/sentinel_mask --o

# perform color auto-balancing for RGB bands 
i.colors.enhance red=T17SQV_20180822T155901_B04_corr \
 green=T17SQV_20180822T155901_B03_corr \
 blue=T17SQV_20180822T155901_B02_corr

# display RBG combination of atmospherically corrected image
d.mon wx0
d.rgb -n red=T17SQV_20180822T155901_B04_corr \
 green=T17SQV_20180822T155901_B03_corr \
 blue=T17SQV_20180822T155901_B02_corr


#
# Replace elevation map by SRTM DEM: r.in.srtm.region addon
#


# in the NC location get the bounding box of the full S2 scene
g.region raster=T17SQV_20180822T155901_B04 -b
#~ north latitude:   36:07:27.469949N
#~ south latitude:   35:06:24.823887N
#~ west longitude:   78:48:18.996088W
#~ east longitude:   77:33:33.210097W

# open a new grass session in a lat-long location
grass74 -c $HOME/grassdata/latlong_wgs84/testing

# In the lat-long location, set the region using the values obtained in NC location
g.region -p n=36:07:27.469949N s=35:06:24.823887N e=77:33:33.210097W w=78:48:18.996088W            

# install r.in.srtm.region extension
g.extension extension=r.in.srtm.region

# downloading and import SRTM data
r.in.srtm.region output=srtm user=your_NASA_user pass=your_NASA_password
#~ Importing 4 SRTM tiles...
  #~ 25%

# display srtm map and get info
d.mon wx0
d.rast srtm
r.info srtm

# change back to NC location and sentinel2 mapset
# reproject the SRTM map
r.proj location=latlong_wgs84 mapset=testing input=srtm resolution=30

# use `srtm` map in i.sentinel.preproc
i.sentinel.preproc -atr \
 input_dir=$HOME/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE \
 elevation=srtm \
 aeronet_file=$HOME/gisdata/180819_180825_EPA-Res_Triangle_Pk.dubovik \
 suffix=corr_full \
 text_file=$HOME/gisdata/sentinel_mask_full

# enhance colors
i.colors.enhance red=T17SQV_20180822T155901_B04_corr_full \
 green=T17SQV_20180822T155901_B03_corr_full \
 blue=T17SQV_20180822T155901_B02_corr_full

# display corrected image
d.mon wx0
d.rgb -n red=T17SQV_20180822T155901_B04_corr_full \
 green=T17SQV_20180822T155901_B03_corr_full \
 blue=T17SQV_20180822T155901_B02_corr_full


#
# Identify and mask clouds
#


# identify and mask clouds and clouds shadows: i.sentinel.mask
i.sentinel.mask --o input_file=$HOME/gisdata/sentinel_mask_full \
 cloud_mask=T17SQV_20180822T15590_cloud \
 shadow_mask=T17SQV_20180822T15590_shadow \
 mtd=/home/veroandreo/gisdata/S2A_MSIL1C_20180822T155901_N0206_R097_T17SQV_20180822T212023.SAFE/GRANULE/L1C_T17SQV_A016539_20180822T160456/MTD_TL.xml

# display output
d.mon wx0
d.rgb -n red=T17SQV_20180822T155901_B04_corr_full \
 green=T17SQV_20180822T155901_B03_corr_full \
 blue=T17SQV_20180822T155901_B02_corr_full
d.vect T17SQV_20180822T15590_cloud fill_color=red
d.vect T17SQV_20180822T15590_shadow fill_color=blue


#
# Estimate vegetation and water indices
#


# set region
g.region -p raster=elevation align=T17SQV_20180822T155901_B04_corr_full
#~ projection: 99 (Lambert Conformal Conic)
#~ zone:       0
#~ datum:      nad83
#~ ellipsoid:  a=6378137 es=0.006694380022900787
#~ north:      228500
#~ south:      215000
#~ west:       630000
#~ east:       645000
#~ nsres:      10
#~ ewres:      10
#~ rows:       1350
#~ cols:       1500
#~ cells:      2025000

# set clouds mask
v.patch input=T17SQV_20180822T15590_cloud,T17SQV_20180822T15590_shadow \
 output=cloud_shadow_mask
v.to.rast input=cloud_shadow_mask output=cloud_shadow_mask use=val value=1
r.mask -i raster=cloud_shadow_mask

# estimate vegetation indices
i.vi red=T17SQV_20180822T155901_B04_corr_full \
 nir=T17SQV_20180822T155901_B08_corr_full \
 output=T17SQV_20180822T155901_NDVI viname=ndvi
 
i.vi red=T17SQV_20180822T155901_B04_corr_full \
 nir=T17SQV_20180822T155901_B08_corr_full \
 blue=T17SQV_20180822T155901_B02_corr_full \
 output=T17SQV_20180822T155901_EVI viname=evi

# install extension
g.extension extension=i.wi

# estimate water indices
i.wi green=T17SQV_20180822T155901_B03_corr_full \
 nir=T17SQV_20180822T155901_B08_corr_full \
 output=T17SQV_20180822T155901_NDWI winame=ndwi_mf 


#
# Image segmentation
#


# install extension
g.extension extension=i.superpixels.slic

# list maps and create groups and subgroups
g.list type=raster pattern="*corr_full" \
 mapset=sentinel2 output=list
i.group group=sentinel subgroup=sentinel file=list

# run i.superpixels.slic and convert the resulting raster to vector
i.superpixels.slic input=sentinel \
 output=superpixels num_pixels=2000
r.to.vect input=superpixels output=superpixels type=area

# run i.segment and convert the resulting raster to vector
i.segment group= output=segments \
 threshold=0.5 minsize=100 memory=500
r.to.vect input=segments output=segments type=area

# display NDVI along with the 2 segmentation outputs
d.mon wx0
d.rast map=T17SQV_20180822T155901_NDVI
d.vect map=superpixels fill_color=none
d.vect map=segments fill_color=none

