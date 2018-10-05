#!/bin/bash

########################################################################
# Worflow for Sentinel 2 data processing in GRASS GIS
# GRASS GIS postgraduate course in Rio Cuarto
# Author: Veronica Andreo
# October, 2018
########################################################################

# Create an account in copernicus-hub

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
      
# Get AOD        
Another required input is the visibility map. Since we do not have this
kind of data, we will replace it with an estimated Aerosol Optical Depth
(AOD) value. It is possible to obtain AOD from [http://aeronet.gsfc.nasa.gov](https://aeronet.gsfc.nasa.gov). 
In this case, we will use the
[EPA-Res_Triangle_Pk](https://aeronet.gsfc.nasa.gov/cgi-bin/webtool_opera_v2_inv?stage=3&region=United_States_East&state=North_Carolina&site=EPA-Res_Triangle_Pk&place_code=10&if_polarized=0)
station, select `01-07-2017` as start date and `30-08-2017` as end date, tick the box labelled as 'Combined file (all products without phase functions)' near the bottom, choose 'All Points' under Data
Format, and download and unzip the file into `$HOME/gisdata/` folder (the final file has a .dubovik extension).

# DEM - elevation map
The last input data required is the elevation map. Inside the `North Carolina basic location` there is an elevation map called `elevation`. The extent of the `elevation` map is smaller than our
Sentinel-2 image extent, so if you will use this elevation map only a subset of the Sentinel image will be atmospherically corrected; to get an elevation map for the entire area please read the [next
session](#srtm). 

# run i.sentinel.preproc          
i.sentinel.preproc -atr \
input_dir=$HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.SAFE \
elevation=elevation aeronet_file=$HOME/gisdata/170701_170831_EPA-Res_Triangle_Pk.dubovik \
suffix=corr text_file=$HOME/gisdata/sentinel_mask

# display corrected image
d.mon wx0
d.rgb -n red=B04_corr green=B03_corr blue=B02_corr
d.barscale length=50 units=kilometers segment=4 fontsize=14
d.text -b text="Sentinel pre-processed scene" color=black align=cc font=sans size=8

# Identify and mask clouds and clouds shadows: i.sentinel.mask
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

# Replace elevation map by SRTM DEM: r.in.srtm.region
[Shuttle Radar Topography Mission (SRTM)](https://www2.jpl.nasa.gov/srtm/) is a worldwide Digital Elevation Model with a resolution of 30 or 90 meters. GRASS GIS has two
modules to work with SRTM data, [r.in.srtm](https://grass.osgeo.org/grass74/manuals/r.in.srtm.html) to import already downloaded SRTM data and, the add-on
[r.in.srtm.region](https://grass.osgeo.org/grass74/manuals/addons/r.in.srtm.region.html) which is able to download and import SRTM data for the current GRASS GIS
computational region. However, [r.in.srtm.region](https://grass.osgeo.org/grass74/manuals/addons/r.in.srtm.region.html) is working only in a Longitude-Latitude location.

First, we need to obtain the bounding box, in Longitude and Latitude on WGS84, of the Sentinel data we want to process

# get bb in the current location            
g.region raster=T17SQV_20170730T154909_B04,T17SPV_20170730T154909_B04 -b
    
# change to a lat-long location

# Set the region using the values obtained in NC location
g.region n=36:08:35N s=35:06:24N e=77:33:33W w=79:54:47W -p
            
# install r.in.srtm.region
g.extension r.in.srtm.region

# run r.in.srtm.region downloading SRTM data and import them as srtm raster map
r.in.srtm.region output=srtm user=your_NASA_user pass=your_NASA_password

# change back to NC location and sentinel2 mapset

# reproject the SRTM map
r.proj location=longlat mapset=PERMANENT input=srtm resolution=30

# use `srtm` map as input of `elevation` option in i.sentinel.preproc

#
# estimate vegetation and water indices
#

i.vi

i.wi

#
# Image segmentation
#

# install add-on
g.extension i.superpixels.slic

# list maps and create groups and subgroups
g.list type=raster pattern="lsat*" sep=comma mapset=PERMANENT
i.group group=lsat subgroup=lsat input=lsat7_2002_10,lsat7_2002_20,lsat7_2002_30,lsat7_2002_40,lsat7_2002_50,lsat7_2002_61,lsat7_2002_62,lsat7_2002_70,lsat7_2002_80

# run i.superpixels.slic and convert the resulting raster to vector
i.superpixels.slic group=lsat output=superpixels num_pixels=2000
r.to.vect input=superpixels output=superpixels type=area

# run i.segment and convert the resulting raster to vector
i.segment group=lsat output=segments threshold=0.5 minsize=50
r.to.vect input=segments output=segments type=area

# display NDVI along with the 2 segmentation outputs
d.rast map=ndvi
d.vect map=superpixels fill_color=none
d.vect map=segments fill_color=none




