#!/usr/bin/bash

########################################################################
# Commands for the TGRASS lecture at GEOSTAT Summer School in Prague
# Author: Veronica Andreo
# Date: July - August, 2018
########################################################################


########### Before the workshop (done for you in advance) ##############

# Install i.modis add-on (requires pymodis library - www.pymodis.org)
g.extension extension=i.modis

# Download and import MODIS LST data 
# Note: User needs to be registered at Earthdata: 
# https://urs.earthdata.nasa.gov/users/new
i.modis.download settings=$HOME/.grass7/i.modis/SETTING \
  product=lst_terra_monthly_5600 \
  tile=h11v05 \
  startday=2015-01-01 endday=2017-12-31 \
  folder=/tmp

# Import LST Day 
# optionally also LST Night: spectral="( 1 1 0 0 0 1 0 0 0 0 0 0 0 )"
i.modis.import files=/tmp/listfileMOD11B3.006.txt \
  spectral="( 1 0 0 0 0 0 0 0 0 0 0 0 )"


############## For the workshop (what you have to do) ##################

## Download the ready to use mapset 'modis_lst' from:
## https://gitlab.com/veroandreo/grass-gis-geostat-2018
## and unzip it into North Carolina full LOCATION 'nc_spm_08_grass7'

# Get list of raster maps in the 'modis_lst' mapset
g.list type=raster

# Get info from one of the raster maps
r.info map=MOD11B3.A2015060.h11v05.single_LST_Day_6km


## Region settings and MASK

# Set region to NC state with LST maps' resolution
g.region -p vector=nc_state \
  align=MOD11B3.A2015060.h11v05.single_LST_Day_6km

#~ projection: 99 (Lambert Conformal Conic)
#~ zone:       0
#~ datum:      nad83
#~ ellipsoid:  a=6378137 es=0.006694380022900787
#~ north:      323380.12411493
#~ south:      9780.12411493
#~ west:       122934.46411531
#~ east:       934934.46411531
#~ nsres:      5600
#~ ewres:      5600
#~ rows:       56
#~ cols:       145
#~ cells:      8120

# Set a MASK to nc_state boundary
r.mask vector=nc_state

# you should see this statement in the terminal from now on
#~ [Raster MASK present]


## Time series

# Create the STRDS
t.create type=strds temporaltype=absolute output=LST_Day_monthly \
  title="Monthly LST Day 5.6 km" \
  description="Monthly LST Day 5.6 km MOD11B3.006, 2015-2017"

# Check if the STRDS is created
t.list type=strds

# Get info about the STRDS
t.info input=LST_Day_monthly


## Add time stamps to maps (i.e., register maps)

# in Unix systems
t.register -i input=LST_Day_monthly \
 maps=`g.list type=raster pattern="MOD11B3*LST_Day*" separator=comma` \
 start="2015-01-01" increment="1 months"

# in MS Windows, first create the list of maps
g.list type=raster pattern="MOD11B3*LST_Day*" output=map_list.txt
t.register -i input=LST_Day_monthly \
 file=map_list.txt start="2015-01-01" increment="1 months"
               
# Check info again
t.info input=LST_Day_monthly

# Check the list of maps in the STRDS
t.rast.list input=LST_Day_monthly

# Check min and max per map
t.rast.list input=LST_Day_monthly columns=name,min,max

 
## Let's see a graphical representation of our STRDS
g.gui.timeline inputs=LST_Day_monthly


## Temporal calculations: K*50 to Celsius 
 
# Re-scale data to degrees Celsius
t.rast.algebra basename=LST_Day_monthly_celsius \
  expression="LST_Day_monthly_celsius = LST_Day_monthly * 0.02 - 273.15"

# Check info
t.info LST_Day_monthly_celsius

# some new features in upcoming grass76
t.rast.algebra basename=LST_Day_monthly_celsius suffix=gran \
 expression="LST_Day_monthly_celsius = LST_Day_monthly * 0.02 - 273.15"


## Time series plots

# LST time series plot for the city center of Raleigh
g.gui.tplot strds=LST_Day_monthly_celsius \
  coordinates=641428.783478,229901.400746

# some new features in upcoming grass76
g.gui.tplot strds=LST_Day_monthly_celsius \
  coordinates=641428.783478,229901.400746 \
  title="Monthly LST. City center of Raleigh, NC " \
  xlabel="Time" ylabel="LST" \
  csv=raleigh_monthly_LST.csv


## Get specific lists of maps

# Maps with minimum value lower than or equal to 5
t.rast.list input=LST_Day_monthly_celsius order=min \
 columns=name,start_time,min where="min <= '5.0'"

#~ name|start_time|min
#~ LST_Day_monthly_celsius_2015_02|2015-02-01 00:00:00|-1.31
#~ LST_Day_monthly_celsius_2017_01|2017-01-01 00:00:00|-0.89
#~ LST_Day_monthly_celsius_2015_01|2015-01-01 00:00:00|-0.25
#~ LST_Day_monthly_celsius_2016_01|2016-01-01 00:00:00|-0.17
#~ LST_Day_monthly_celsius_2016_02|2016-02-01 00:00:00|0.73
#~ LST_Day_monthly_celsius_2017_12|2017-12-01 00:00:00|1.69
#~ LST_Day_monthly_celsius_2016_12|2016-12-01 00:00:00|3.45

# Maps with maximum value higher than 30
t.rast.list input=LST_Day_monthly_celsius order=max \
 columns=name,start_time,max where="max > '30.0'"

#~ name|start_time|max
#~ LST_Day_monthly_celsius_2017_04|2017-04-01 00:00:00|30.85
#~ LST_Day_monthly_celsius_2017_09|2017-09-01 00:00:00|32.45
#~ LST_Day_monthly_celsius_2016_05|2016-05-01 00:00:00|32.97
#~ LST_Day_monthly_celsius_2015_09|2015-09-01 00:00:00|33.49
#~ LST_Day_monthly_celsius_2017_05|2017-05-01 00:00:00|34.35
#~ LST_Day_monthly_celsius_2015_05|2015-05-01 00:00:00|34.53
#~ LST_Day_monthly_celsius_2017_08|2017-08-01 00:00:00|35.81
#~ LST_Day_monthly_celsius_2016_09|2016-09-01 00:00:00|36.33
#~ LST_Day_monthly_celsius_2016_08|2016-08-01 00:00:00|36.43

# Maps between two given dates
t.rast.list input=LST_Day_monthly_celsius columns=name,start_time \
 where="start_time >= '2015-05' and start_time <= '2015-08-01 00:00:00'"

#~ name|start_time
#~ LST_Day_monthly_celsius_2015_05|2015-05-01 00:00:00
#~ LST_Day_monthly_celsius_2015_06|2015-06-01 00:00:00
#~ LST_Day_monthly_celsius_2015_07|2015-07-01 00:00:00
#~ LST_Day_monthly_celsius_2015_08|2015-08-01 00:00:00

# Maps from January
t.rast.list input=LST_Day_monthly_celsius columns=name,start_time \
 where="strftime('%m', start_time)='01'"

#~ name|start_time
#~ LST_Day_monthly_celsius_2015_01|2015-01-01 00:00:00
#~ LST_Day_monthly_celsius_2016_01|2016-01-01 00:00:00
#~ LST_Day_monthly_celsius_2017_01|2017-01-01 00:00:00


## Descriptive statistics for STRDS

# Print univariate stats for maps within STRDS
t.rast.univar input=LST_Day_monthly_celsius

#~ id|start|end|mean|min|max|mean_of_abs|stddev|variance|coeff_var|sum|null_cells|cells
#~ LST_Day_monthly_celsius_2015_01@modis_lst|2015-01-01 00:00:00|2015-02-01 00:00:00|7.76419671326958|-0.25|11.89|7.76431935246506|1.77839501064634|3.1626888138918|22.905074102604|31654.6300000001|4043|8120
#~ LST_Day_monthly_celsius_2015_02@modis_lst|2015-02-01 00:00:00|2015-03-01 00:00:00|7.23198184939909|-1.30999999999995|12.37|7.23262447878345|2.05409396877013|4.21930203253782|28.4029193040744|29484.7900000001|4043|8120
#~ LST_Day_monthly_celsius_2015_03@modis_lst|2015-03-01 00:00:00|2015-04-01 00:00:00|16.0847706647044|8.27000000000004|22.0700000000001|16.0847706647044|2.22005586700676|4.92864805263112|13.8022226942802|65577.61|4043|8120
#~ LST_Day_monthly_celsius_2015_04@modis_lst|2015-04-01 00:00:00|2015-05-01 00:00:00|22.2349889624724|10.05|28.21|22.2349889624724|2.14784334478279|4.6132310337277|9.65974549574931|90652.05|4043|8120
#~ LST_Day_monthly_celsius_2015_05@modis_lst|2015-05-01 00:00:00|2015-06-01 00:00:00|26.7973632572971|16.89|34.53|26.7973632572971|2.43267997291578|5.91793185062553|9.07805723107235|109252.85|4043|8120

# Get extended statistics
t.rast.univar -e input=LST_Day_monthly_celsius

# Write the univariate stats output to a csv file
t.rast.univar input=LST_Day_monthly_celsius separator=comma \
  output=stats_LST_Day_monthly_celsius.csv


## Temporal aggregations (full series)

# Get maximum LST in the STRDS
t.rast.series input=LST_Day_monthly_celsius \
  output=LST_Day_max method=maximum

# Get minimum LST in the STRDS
t.rast.series input=LST_Day_monthly_celsius \
  output=LST_Day_min method=minimum

# Change color pallete to celsius
r.colors map=LST_Day_min,LST_Day_max color=celsius


## Display the new maps with mapswipe and compare them to elevation

# LST_Day_max & elevation
g.gui.mapswipe first=LST_Day_max second=elev_state_500m

# LST_Day_min & elevation
g.gui.mapswipe first=LST_Day_min second=elev_state_500m


## Temporal operations with time variables

# Get month of maximum LST
t.rast.mapcalc -n inputs=LST_Day_monthly_celsius output=month_max_lst \
  expression="if(LST_Day_monthly_celsius == LST_Day_max, start_month(), null())" \
  basename=month_max_lst
 
# Get basic info
t.info month_max_lst

# Get the earliest month in which the maximum appeared (method minimum)
t.rast.series input=month_max_lst method=minimum output=max_lst_date

# Remove month_max_lst strds 
# we were only interested in the resulting aggregated map
t.remove -rf inputs=month_max_lst

# Note that the flags "-rf" force (immediate) removal of both 
# the STRDS and the maps registered in it.


## Display maps in a wx monitor

# Open a monitor
d.mon wx0

# Display the raster map
d.rast map=max_lst_date

# Display boundary vector map
d.vect map=nc_state type=boundary color=#4D4D4D width=2

# Add raster legend
d.legend -t raster=max_lst_date title="Month" \
  label_num=6 title_fontsize=20 font=sans fontsize=18

# Add scale bar
d.barscale length=200 units=kilometers segment=4 fontsize=14

# Add North arrow
d.northarrow style=1b text_color=black

# Add text
d.text -b text="Month of maximum LST 2015-2017" \
  color=black align=cc font=sans size=12


## Temporal aggregation (granularity of three months)
 
# 3-month mean LST
t.rast.aggregate input=LST_Day_monthly_celsius \
  output=LST_Day_mean_3month \
  basename=LST_Day_mean_3month suffix=gran \
  method=average granularity="3 months"

# Check info
t.info input=LST_Day_mean_3month

# Check map list
t.rast.list input=LST_Day_mean_3month

#~ name|mapset|start_time|end_time
#~ LST_Day_mean_3month_2015_01|modis_lst|2015-01-01 00:00:00|2015-04-01 00:00:00
#~ LST_Day_mean_3month_2015_04|modis_lst|2015-04-01 00:00:00|2015-07-01 00:00:00
#~ LST_Day_mean_3month_2015_07|modis_lst|2015-07-01 00:00:00|2015-10-01 00:00:00
#~ LST_Day_mean_3month_2015_10|modis_lst|2015-10-01 00:00:00|2016-01-01 00:00:00
#~ LST_Day_mean_3month_2016_01|modis_lst|2016-01-01 00:00:00|2016-04-01 00:00:00
#~ LST_Day_mean_3month_2016_04|modis_lst|2016-04-01 00:00:00|2016-07-01 00:00:00
#~ LST_Day_mean_3month_2016_07|modis_lst|2016-07-01 00:00:00|2016-10-01 00:00:00
#~ LST_Day_mean_3month_2016_10|modis_lst|2016-10-01 00:00:00|2017-01-01 00:00:00
#~ LST_Day_mean_3month_2017_01|modis_lst|2017-01-01 00:00:00|2017-04-01 00:00:00
#~ LST_Day_mean_3month_2017_04|modis_lst|2017-04-01 00:00:00|2017-07-01 00:00:00
#~ LST_Day_mean_3month_2017_07|modis_lst|2017-07-01 00:00:00|2017-10-01 00:00:00
#~ LST_Day_mean_3month_2017_10|modis_lst|2017-10-01 00:00:00|2018-01-01 00:00:00


## Display seasonal LST using frames

# Set STRDS color table to celsius degrees
t.rast.colors input=LST_Day_mean_3month color=celsius

# Start a new graphics monitor, the data will be rendered to
# /tmp/map.png image output file of size 640x360px
d.mon cairo out=frames.png width=640 height=360 resolution=4

# create a first frame
d.frame -c frame=first at=0,50,0,50
d.rast map=LST_Day_mean_3month_2015_07
d.vect map=nc_state type=boundary color=#4D4D4D width=2
d.text text='Jul-Sep 2015' color=black font=sans size=10

# create a second frame
d.frame -c frame=second at=0,50,50,100
d.rast map=LST_Day_mean_3month_2015_10
d.vect map=nc_state type=boundary color=#4D4D4D width=2
d.text text='Oct-Dec 2015' color=black font=sans size=10

# create a third frame
d.frame -c frame=third at=50,100,0,50
d.rast map=LST_Day_mean_3month_2015_01
d.vect map=nc_state type=boundary color=#4D4D4D width=2
d.text text='Jan-Mar 2015' color=black font=sans size=10

# create a fourth frame
d.frame -c frame=fourth at=50,100,50,100
d.rast map=LST_Day_mean_3month_2015_04
d.vect map=nc_state type=boundary color=#4D4D4D width=2 
d.text text='Apr-Jun 2015' color=black font=sans size=10

# release monitor
d.mon -r


## Time series animation

# Animation of monthly LST
g.gui.animation strds=LST_Day_mean_3month


## Extract zonal statistics for areas

# Install v.strds.stats add-on
g.extension extension=v.strds.stats

# Extract seasonal average LST for Raleigh urban area
v.strds.stats input=urbanarea strds=LST_Day_mean_3month \
  where="NAME == 'Raleigh'" \
  output=raleigh_aggr_lst method=average

# Save the attribute table of the new vector into a csv file
v.db.select map=raleigh_aggr_lst file=lst_raleigh

#~ cat|OBJECTID|UA|NAME|UA_TYPE|LST_Day_monthly_celsius_2015_01_01_average|LST_Day_monthly_celsius_2015_02_01_average|LST_Day_monthly_celsius_2015_03_01_average|LST_Day_monthly_celsius_2015_04_01_average|LST_Day_monthly_celsius_2015_05_01_average|LST_Day_monthly_celsius_2015_06_01_average|LST_Day_monthly_celsius_2015_07_01_average|LST_Day_monthly_celsius_2015_08_01_average|LST_Day_monthly_celsius_2015_09_01_average|LST_Day_monthly_celsius_2015_10_01_average|LST_Day_monthly_celsius_2015_11_01_average|LST_Day_monthly_celsius_2015_12_01_average|LST_Day_monthly_celsius_2016_01_01_average|LST_Day_monthly_celsius_2016_02_01_average|LST_Day_monthly_celsius_2016_03_01_average|LST_Day_monthly_celsius_2016_04_01_average|LST_Day_monthly_celsius_2016_05_01_average|LST_Day_monthly_celsius_2016_06_01_average|LST_Day_monthly_celsius_2016_07_01_average|LST_Day_monthly_celsius_2016_08_01_average|LST_Day_monthly_celsius_2016_09_01_average|LST_Day_monthly_celsius_2016_10_01_average|LST_Day_monthly_celsius_2016_11_01_average|LST_Day_monthly_celsius_2016_12_01_average|LST_Day_monthly_celsius_2017_01_01_average|LST_Day_monthly_celsius_2017_02_01_average|LST_Day_monthly_celsius_2017_03_01_average|LST_Day_monthly_celsius_2017_04_01_average|LST_Day_monthly_celsius_2017_05_01_average|LST_Day_monthly_celsius_2017_06_01_average|LST_Day_monthly_celsius_2017_07_01_average|LST_Day_monthly_celsius_2017_08_01_average|LST_Day_monthly_celsius_2017_09_01_average|LST_Day_monthly_celsius_2017_10_01_average|LST_Day_monthly_celsius_2017_11_01_average|LST_Day_monthly_celsius_2017_12_01_average
#~ 55|55|73261|Raleigh|UA|8.41692307692311|7.81769230769234|15.1792307692308|24.2661538461539|28.6676923076923|34.4|32.3146153846154|31.7415384615385|28.6076923076923|21.8938461538462|15.5084615384616|14.8515384615385|8.37615384615388|10.8084615384616|22.3984615384616|23.6061538461539|28.4638461538462|31.3746153846154|32.6684615384616|32.1061538461539|30.7476923076923|22.6569230769231|17.1615384615385|11.3415384615385|13.2807692307693|17.3823076923077|18.5507692307693|26.4038461538462|29.0292307692308|31.4423076923077|33.7869230769231|31.8584615384616|29.1169230769231|23.3869230769231|15.7769230769231|9.7792307692308


## Plot the resulting vector in rstudio

# Call rstudio
rstudio &

# Load libraries
library(rgrass7)
library(sf)
library(dplyr)
library(ggplot2)
library(mapview)

# read vector
raleigh <- readVECT("raleigh_aggr_lst")

# with spplot
spplot(raleigh[,6:17])

# sf + ggplot
raleigh_sf <- st_as_sf(raleigh)

# gather the table into season and mean LST (we do only 2015)
raleigh_gather <- raleigh_sf %>% 
				  gather(LST_Day_mean_3month_2015_01_01_average,
						 LST_Day_mean_3month_2015_04_01_average,
						 LST_Day_mean_3month_2015_07_01_average,
						 LST_Day_mean_3month_2015_10_01_average, 
						 key="season", value="LST")

# with ggplot
ggplot() + geom_sf(data = raleigh_gather, aes(fill = LST)) + 
		   facet_wrap(~season, ncol=2)

# with mapview
mapview(raleigh_sf[,6:17])


############################## THE END #################################

### Some extra examples if you are still interested ###

## Example of t.rast.accumulate and t.rast.accdetect application

# Accumulation
t.rast.accumulate input=LST_Day_monthly output=lst_acc limits=15,32 \
start="2015-03-01" cycle="7 months" offset="5 months" basename=lst_acc \
suffix=gran scale=0.02 shift=-273.15 method=mean granularity="1 month"

# First cycle at 100°C - 190°C GDD
t.rast.accdetect input=lst_acc occ=insect_occ_c1 start="2015-03-01" \
cycle="7 months" range=100,200 basename=insect_c1 indicator=insect_ind_c1