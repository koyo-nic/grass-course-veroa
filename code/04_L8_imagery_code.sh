#!/bin/bash

########################################################################
# Worflow for Landsat 8 data processing in GRASS GIS
# GRASS GIS postgraduate course in Rio Cuarto
# Author: Veronica Andreo
# October, 2018
########################################################################

# Register and download Landsat 8 scenes for NC
https://earthexplorer.usgs.gov/


#
# First settings
#


# launch GRASS GIS, -c creates new mapset landsat8
grass74 $HOME/grassdata/nc_spm_08_grass7/landsat8/ -c
# check the projection of the location
g.proj -p
# list all the mapsets in the search path
g.mapsets -p
# add the mapset landsat to the search path
g.mapsets mapset=landsat operation=add
# list all the mapsets in the search path
g.mapsets -p
# list all the raster maps in all the mapsets in the search path
g.list type=raster
# set the computational region 
g.region rast=lsat7_2002_20 res=30 -a    


# change directory to the input Landsat 8 data
cd $HOME/gisdata/LC80150352016168LGN00
# define a variable
BASE="LC80150352016168LGN00"


#
# Import L8 data
#


# loop to import all the bands
for i in "1" "2" "3" "4" "5" "6" "7" "9" "QA" "10" "11"; do
  r.import input=${BASE}_B${i}.TIF output=${BASE}_B${i} \
   resolution=value resolution_value=30 \
   extent=region
done

# PAN band 8 imported separately because of different spatial resolution
r.import input=${BASE}_B8.TIF output=${BASE}_B8 \
 resolution=value resolution_value=15 \
 extent=region


# 
# DN to surface reflectance and Temperature (Atmospheric correction through DOS)
#


# convert from DN to surface reflectance and temperature
i.landsat.toar input=${BASE}_B output=${BASE}_toar \
 metfile=${BASE}_MTL.txt sensor=oli8 method=dos1

# list output maps
g.list rast map=. pattern=${BASE}_toar*
# check info before and after for one band
r.info map=LC80150352016168LGN00_B4
r.info map=LC80150352016168LGN00_toar4


# 
# Image fusion
#


# Install the reqquired addon
g.extension extension=i.fusion.hpf

# Set the region
g.region rast=lsat7_2002_20 res=15 -a

# Apply the fusion based on high pass filter
i.fusion.hpf -l -c pan=${BASE}_toar8 \
 msx=`g.list type=raster mapset=. pattern=${BASE}_toar[1-7] separator=,` \
 center=high \
 modulation=max \
 trim=0.0

# list the fused maps
g.list type=raster mapset=. pattern=${BASE}_toar*.hpf

# display original and fused maps
g.gui.mapswipe first=LC80150352016168LGN00_toar5 \
 second=LC80150352016168LGN00_toar5.hpf


#
# Image Composites
#


# enhance the colors
i.colors.enhance red="${BASE}_toar4.hpf" \
 green="${BASE}_toar3.hpf" \
 blue="${BASE}_toar2.hpf" \
 strength=95

# display RGB
d.mon wx0
d.rgb red="${BASE}_toar4.hpf" \
 green="${BASE}_toar3.hpf" \
 blue="${BASE}_toar2.hpf"

# create RGB composites
r.composite red="${BASE}_toar4.hpf" \
 green="${BASE}_toar3.hpf" \
 blue="${BASE}_toar2.hpf" \
 output="${BASE}_toar.hpf_comp_432"

# enhance the colors
i.colors.enhance red="${BASE}_toar5.hpf" \
 green="${BASE}_toar4.hpf" \
 blue="${BASE}_toar3.hpf" \
 strength=95

# create RGB composites
r.composite red="${BASE}_toar5.hpf" \
 green="${BASE}_toar4.hpf" \
 blue="${BASE}_toar3.hpf" \
 output="${BASE}_toar.hpf_comp_543"  

# display false color composite
d.mon wx0
d.rast ${BASE}_toar.hpf_comp_543


#
# Cloud mask from the QA layer
#


# install the extension
g.extension extension=i.landsat8.qc

# create a rule set
i.landsat8.qc cloud="Maybe,Yes" output=Cloud_Mask_rules.txt

# reclass the BQA band based on the rule set created 
r.reclass input=${BASE}_BQA output=${BASE}_Cloud_Mask rules=Cloud_Mask_rules.txt

# report the area covered by cloud
r.report -e map=${BASE}_Cloud_Mask units=k -n

# display reclassified map
d.mon wx0
d.rast ${BASE}_Cloud_Mask


#
# Vegetation and Water Indices
#


# Set the cloud mask to avoid computing over clouds
r.mask raster=${BASE}_Cloud_Mask

# Compute NDVI
r.mapcalc expression="${BASE}_NDVI = (${BASE}_toar5.hpf - ${BASE}_toar4.hpf) / (${BASE}_toar5.hpf + ${BASE}_toar4.hpf) * 1.0"
# Set the color palette
r.colors map=${BASE}_NDVI color=ndvi

# Compute NDWI
r.mapcalc expression="${BASE}_NDWI = (${BASE}_toar5.hpf - ${BASE}_toar6.hpf) / (${BASE}_toar5.hpf + ${BASE}_toar6.hpf) * 1.0"
# Set the color palette
r.colors map=${BASE}_NDWI color=ndwi

# Remove the mask
r.mask -r

# display maps
d.mon wx0
d.rast map=${BASE}_NDVI
d.rast map=${BASE}_NDWI


#
# Unsupervised Classification
#


# list the bands needed for classification
g.list type=raster mapset=. pattern=${BASE}_toar*.hpf

# add maps to an imagery group for easier management
i.group group=${BASE}_hpf subgroup=${BASE}_hpf \
 input=`g.list type=raster mapset=. pattern=${BASE}_toar*.hpf sep=","`

# statistics for unsupervised classification
i.cluster group=${BASE}_hpf subgroup=${BASE}_hpf \
 sig=${BASE}_hpf \
 classes=5 \
 separation=0.6

# Maximum Likelihood unsupervised classification
i.maxlik group=${BASE}_hpf subgroup=${BASE}_hpf \
 sig=${BASE}_hpf \
 output=${BASE}_hpf.class \
 rej=${BASE}_hpf.rej

# display results
d.mon wx0
d.rast map=${BASE}_hpf.class
