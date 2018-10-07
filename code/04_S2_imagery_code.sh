#!/bin/bash

########################################################################
# Worflow for Sentinel 2 data processing in GRASS GIS
# GRASS GIS postgraduate course in Rio Cuarto
# Author: Veronica Andreo
# October, 2018
########################################################################

#
# Create an account in copernicus-hub
#


# Create a text file called SENTINEL_SETTING with
your_username
your_password

# install dependencies (as root user)
pip install sentinelsat
pip install pandas

# start grass and create a new mapset
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

# pick a scene to download
i.sentinel.download settings=$HOME/gisdata/SETTING_SENTINEL \
 uuid=a559365f-8fc4-4399-8d1c-9123f72cc7a2 output=$HOME/gisdata \
 footprints=sentinel_2018_08

# import the downloaded data
# -r flag is used to reproject the data during import
# -c flag allows to import the cloud mask
i.sentinel.import -rc input=$HOME/gisdata/

# display an RGB combination
d.mon wx0
d.rgb -n red=B04 green=B03 blue=B02
d.barscale length=50 units=kilometers segment=4 fontsize=14
d.text -b text="Sentinel original" color=black align=cc font=sans size=8

# perform color auto-balancing for RGB bands 
i.colors.enhance red=B04 green=B03 blue=B02

# display an RGB combination
d.mon wx0
d.rgb -n red=B04 green=B03 blue=B02
d.barscale length=50 units=kilometers segment=4 fontsize=14
d.text -b text="Sentinel original" color=black align=cc font=sans size=8

#~ [i.sentinel.preproc](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.preproc.html)
#~ requires some extra inputs since it also performs atmospheric
#~ correction. First, this module requires the image as an unzipped
#~ directory, so you have to unzip one of the previous downloaded files,
#~ for example:


#
# Pre-processing of Sentinel 2 data
#


# enter directory with Sentinel scene and unzip file
cd $HOME/gisdata/
unzip $HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.zip
      
# get AOD from http://aeronet.gsfc.nasa.gov
# https://aeronet.gsfc.nasa.gov/cgi-bin/webtool_opera_v2_inv?stage=3&region=United_States_East&state=North_Carolina&site=EPA-Res_Triangle_Pk&place_code=10&if_polarized=0
# select start and end date
# tick the box labelled as 'Combined file (all products without phase functions)'
# choose 'All Points' under Data Format
# download and unzip the file into `$HOME/gisdata/` folder (the final file has .dubovik extension).

# run i.sentinel.preproc using elevation map in NC location         
i.sentinel.preproc -atr \
 input_dir=$HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.SAFE \
 elevation=elevation \
 aeronet_file=$HOME/gisdata/170701_170831_EPA-Res_Triangle_Pk.dubovik \
 suffix=corr \
 text_file=$HOME/gisdata/sentinel_mask

# display corrected image
d.mon wx0
d.rgb -n red=B04_corr green=B03_corr blue=B02_corr
d.barscale length=50 units=kilometers segment=4 fontsize=14
d.text -b text="Sentinel pre-processed scene" color=black align=cc font=sans size=8

# identify and mask clouds and clouds shadows: i.sentinel.mask
i.sentinel.mask input_file=$HOME/gisdata/sentinel_mask \
 cloud_mask=T17SQV_20170730T160022_cloud \
 shadow_mask=T17SQV_20170730T160022_shadow \
 mtd=$HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.SAFE/MTD_MSIL1C.xml

# display output
d.mon wx0
d.rgb -n red=T17SQV_20170730T154909_B04_corr green=T17SQV_20170730T154909_B03_corr blue=T17SQV_20170730T154909_B02_corr
d.vect T17SQV_20170730T160022_cloud fill_color=red
d.barscale length=50 units=kilometers segment=4 fontsize=14
d.text -b text="Cloud mask in red" color=black bgcolor=229:229:229 align=cc font=sans size=8


#
# Replace elevation map by SRTM DEM: r.in.srtm.region addon
#


# in the NC location get the bounding box of the S2 scene
g.region raster=T17SQV_20170730T154909_B04,T17SPV_20170730T154909_B04 -b
    
# open a new grass session in a lat-long location

# In the lat-long location, set the region using the values obtained in NC location
g.region n=36:08:35N s=35:06:24N e=77:33:33W w=79:54:47W -p
            
# install r.in.srtm.region
g.extension r.in.srtm.region

# downloading and import SRTM data
r.in.srtm.region output=srtm user=your_NASA_user pass=your_NASA_password

# change back to NC location and sentinel2 mapset

# reproject the SRTM map
r.proj location=longlat mapset=PERMANENT input=srtm resolution=30

# use `srtm` map in i.sentinel.preproc
i.sentinel.preproc -atr \
 input_dir=$HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.SAFE \
 elevation=srtm \
 aeronet_file=$HOME/gisdata/170701_170831_EPA-Res_Triangle_Pk.dubovik \
 suffix=corr \
 text_file=$HOME/gisdata/sentinel_mask

# display corrected image
d.mon wx0
d.rgb -n red=B04_corr green=B03_corr blue=B02_corr
d.barscale length=50 units=kilometers segment=4 fontsize=14
d.text -b text="Sentinel pre-processed scene" color=black align=cc font=sans size=8

# identify and mask clouds and clouds shadows: i.sentinel.mask
i.sentinel.mask input_file=$HOME/gisdata/sentinel_mask \
 cloud_mask=T17SQV_20170730T160022_cloud \
 shadow_mask=T17SQV_20170730T160022_shadow \
 mtd=$HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.SAFE/MTD_MSIL1C.xml

# display output
d.mon wx0
d.rgb -n red=T17SQV_20170730T154909_B04_corr green=T17SQV_20170730T154909_B03_corr blue=T17SQV_20170730T154909_B02_corr
d.vect T17SQV_20170730T160022_cloud fill_color=red
d.barscale length=50 units=kilometers segment=4 fontsize=14
d.text -b text="Cloud mask in red" color=black bgcolor=229:229:229 align=cc font=sans size=8


#
# Estimate vegetation and water indices
#


# estimate vegetation indices
i.vi 

# estimate water indices
i.wi 


#
# Image segmentation
#


# install add-on
g.extension i.superpixels.slic

# list maps and create groups and subgroups
g.list type=raster pattern="lsat*" sep=comma mapset=sentinel2
i.group group= subgroup= input=

# run i.superpixels.slic and convert the resulting raster to vector
i.superpixels.slic group= output=superpixels num_pixels=2000
r.to.vect input=superpixels output=superpixels type=area

# run i.segment and convert the resulting raster to vector
i.segment group= output=segments threshold=0.5 minsize=50
r.to.vect input=segments output=segments type=area

# display NDVI along with the 2 segmentation outputs
d.rast map=ndvi
d.vect map=superpixels fill_color=none
d.vect map=segments fill_color=none

