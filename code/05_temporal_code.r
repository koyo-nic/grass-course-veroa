########################################################################
# Commands for the TGRASS lecture at GEOSTAT Summer School in Prague
# Author: Veronica Andreo
# Date: July - August, 2018 - Edited October, 2018
########################################################################

## Plot `raleigh_aggr_lst` vector in rstudio

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

# sp
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

# ggplot
ggplot() + geom_sf(data = raleigh_gather, aes(fill = LST)) + 
		   facet_wrap(~season, ncol=2)

# mapview
mapview(raleigh_sf[,6:17])
