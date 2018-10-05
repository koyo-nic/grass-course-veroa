#!/bin/bash

########################################################################
# Exercises for raster data processing in GRASS GIS
# GRASS GIS postgraduate course in Rio Cuarto
# Author: Veronica Andreo
# October, 2018
########################################################################


#
# Landscape analysis and forest fragmentation
#


# install addons
g.extension r.diversity
g.extension r.forestfrag

# compute richness (number of unique classes)
g.region raster=landuse96
r.neighbors input=landuse96 output=richness method=diversity size=15

# compute diversity indices with various window sizes
r.diversity input=landuse96 prefix=index alpha=0.8 size=9-21 method=simpson,shannon,renyi

# change color tables to make them comparable
r.colors map=index_shannon_size_21,index_shannon_size_15,index_shannon_size_9 color=viridis
r.colors map=index_renyi_size_21_alpha_0.8,index_renyi_size_15_alpha_0.8,index_renyi_size_15_alpha_0.8 color=viridis
# we use grey1.0 color ramp because simpson is from 0 to 1
r.colors map=index_simpson_size_21,index_simpson_size_15,index_simpson_size_9 color=grey1.0


#
# Forest fragmentation
#


# first set region
g.region raster=landclass96

# list classes:
r.category map=landclass96

# select forests only
r.mapcalc "forest = if(landclass96 == 5, 1, 0)"

# compute the forest fragmentation index with window size 15
r.forestfrag input=forest output=fragmentation window=15

# report the distribution of the fragmentation categories
r.report map=fragmentation units=k,p


#
# Distance from forest edge
#


# select forests only
r.mapcalc "forest = if(landclass96 == 5, 1, null())"

# get distance to the edge of the forest
# -n is to obtain distance to the edge from within the forest itself
r.grow.distance -n input=forest distance=distance


#
# Patch analysis
#


# Create the config file in the g.gui.rlisetup config window

1. Create
2. Name the config file `forest_whole`
3. Select the raster map forest
4. Define the sampling region --> whole map layer
5. Define sample area --> whole map layer

1. Create
2. Name the config file `forest_mov_win`
3. Select the raster map forest
4. Define the sampling region --> whole map layer
5. Define sample area --> moving window 
6. Select shape of mov window --> rectangle --> width=10, height=10

# Compute the landscape metrics using both config files

# edge density
r.li.edgedensity input=forest config=forest_whole output=forest_edge_full
# shape
r.li.shape input=forest config=forest_whole output=forest_shape_full
# patch number
r.li.patchnum input=forest config=forest_whole output=forest_patchnum_full
# mean patch size
r.li.mps input=forest config=forest_whole output=forest_mps_full

# edge density
r.li.edgedensity input=forest config=forest_mov_win output=forest_edge_mw
# shape index
r.li.shape input=forest config=forest_mov_win output=forest_shape_mw
# patch number
r.li.patchnum input=forest config=forest_mov_win output=forest_patchnum_mw
# mean patch size
r.li.mps input=forest config=forest_mov_win output=forest_mps_mw


#
# Hydrology: Estimating inundation extent using HAND methodology
#


# install r.stream.distance and r.lake.series
g.extension r.stream.distance
g.extension r.lake.series

# compute the flow accumulation, drainage and streams (with threshold value of 100000)
r.watershed elevation=elevation accumulation=flowacc \
 drainage=drainage stream=streams threshold=100000

# convert the streams to vector for better visualization
r.to.vect input=streams output=streams type=line

# compute new raster with elevation difference between
# the cell and the the cell on the stream where the cell drains
r.stream.distance stream_rast=streams direction=drainage \
 elevation=elevation method=downstream difference=above_stream

# compute a lake from specified coordinates and water level
r.lake elevation=elevation water_level=90 lake=lake coordinates=637877,218475

#display raster lake
d.mon wx0
d.rast elevation
d.rast lake

# simulate 5m inundation with HAND, specify stream as seed
r.lake elevation=above_stream water_level=5 lake=flood seed=streams

# create a series of inundation maps with rising water levels
r.lake.series elevation=above_stream \
 start_water_level=0 end_water_level=5 \
 water_level_step=0.5 output=inundation \
 seed_raster=streams

# compute the volume and extent of flood water using t.rast.univar
t.rast.univar input=inundation separator=comma

# Visualize the inundation using the Animation Tool.
g.gui.animation strds=inundation


#
# Terrain analysis
#


# set region
g.region raster=elevation

# get geomorphons
r.geomorphon elevation=elevation forms=elevation_geomorph

# display output map
d.mon wx0
d.rast map=elevation_geomorph

# extraction of summits
r.mapcalc expression="elevation_summits = if(elevation_geomorph == 2, 1, null())"
r.thin input=elevation_summits output=summits_thinned
r.to.vect input=summits_thinned output=summits type=point
v.info input=summits
