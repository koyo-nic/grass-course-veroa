---?image=template/img/grass.png&position=bottom&size=100% 30%
@title[Front page]

@snap[north span-100]
<br>
<h2>Procesamiento de series de tiempo en @color[green](GRASS GIS)</h2>
<h3>Aplicaciones en Ecologia y Ambiente</h3>
@snapend

@snap[south message-box-white]
<br>Dra. Veronica Andreo<br>CONICET - INMeT<br><br>Rio Cuarto, 2018<br>
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Interface GRASS - R: Bridging GIS and statistics

---

GRASS GIS and R can be used together in two ways:
<br><br>
- Using [R within a GRASS GIS session](https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7#R_within_GRASS),
- Using [GRASS GIS within an R session](https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7#GRASS_within_R),
<br><br>

@size[22px](Details and examples at the [GRASS and R wiki](https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7))

+++

![Calling R from within GRASS](assets/img/RwithinGRASS_and_Rstudio_from_grass.png)

---

- Using *R within GRASS GIS session*, i.e. starting R (or RStudio) from the GRASS GIS command line.
  - we work with data already in GRASS GIS Spatial Database using GRASS GIS but from R by means of `execGRASS()`
  - we do not need to initialize GRASS with `initGRASS()` because GRASS GIS is already running
  - we use `readVECT()`, `readRAST()` only if we want to read data from GRASS DB to do some analysis or plot and write data back to GRASS with `writeVECT()` and `writeRAST()`

---

- Using *GRASS GIS within a R session*, i.e. we connect to GRASS GIS Spatial Database from within R (or RStudio).
  - we need to initialize GRASS GIS with `initGRASS()` function to start GRASS GIS
  - we write data into GRASS GIS Spatial Database with `writeVECT()` and `writeRAST()` and use GRASS GIS funtionalities with `execGRASS()`
  - we use `readVECT()`, `readRAST()` to read data from GRASS DB to do some analysis or plot

---

The link is provided by the [rgrass7](https://cran.r-project.org/web/packages/rgrass7/index.html) package
<br><br>
(kudos to Roger Bivand @fa[smile-o])
 
---

We will run R within GRASS GIS session, we launch R inside GRASS GIS

---

We will analyze the .

+++?code=code/06_grass_R_code.r&lang=rsplus&title=Relationship between LST and elevation and NDVI

@[7-9](Install and load rgrass7)
@[11-12](Read grass session metadata)
@[14-15](Set the computational region)
@[17-18](Generate random points)
@[20-22](Generate random points restricting to NC area)
@[24-25](Add table to vector of random points)
@[27-30](Sample rasters with random points)
@[32-36](Explore the dataset)

+++

Add plot here

+++?code=code/06_grass_R_code.r&lang=rsplus&title=Relationship between LST and elevation and NDVI

@[38-40](Compute linear model)
@[42-45](Predict LST using the model)
@[47-49](Write modeled LST to GRASS raster)
@[51-53](Compare model to real data)

---

### Reading in data from GRASS

# the cat parameter indicates which raster values to be returned as factors
# - geology_30m is a categorical map (i.e., it comes with classes)
# - elevation is a continuous surface
ncdata <- readRAST(c("geology_30m", "elevation"), cat=c(TRUE, FALSE))

# verify the new R object:
str(ncdata)
str(ncdata@data)

# plot
image(ncdata, "elevation", col = terrain.colors(20))

execGRASS("g.region", raster = "elevation", flags = "p")
ncdata <- readRAST("elevation", cat=FALSE)
summary(ncdata)
spplot(ncdata, col = terrain.colors(20))
boxplot(ncdata$elevation ~ ncdata$geology_30m, medlwd = 1)

### Querying maps

# set the computational region first to the raster map:
execGRASS("g.region", raster = "elev_state_500m", flags = "p")

# query raster map at vector points, transfer result into R
goutput <- execGRASS("r.what", map="elev_state_500m", points="geodetic_pts", separator=",", intern=TRUE)
str(goutput)
chr [1:29939] "571530.81289275,265739.968425953,,187.8082200648" ...

# parse it
con <- textConnection(goutput)
go1 <- read.csv(con, header=FALSE)
str(go1)

### Exporting data back to GRASS

Finally, a SpatialGridDataFrame object is written back to a GRASS raster
map:

# square root of elevation)
ncdata$sqdem <- sqrt(ncdata$elevation)

# export data from *R* back into a GRASS raster map:
writeRAST(ncdata, "sqdemNC", zcol="sqdem", ignore.stderr=TRUE)

# check that it imported into GRASS ok:
execGRASS("r.info", parameters=list(map="sqdemNC"))


### Using RStudio in a GRASS GIS session

If you are most used to run R through RStudio, but still want to have
all GRASS data available for performing any analyses without loosing the
possibility of still using GRASS command line, you can run:

``` {.bash}
GRASS> rstudio &
```

or, if you already are working on a certain RStudio project:

``` {.bash}
GRASS> rstudio /path/to/project/folder/ &
```

---

GRASS within R

Using **GRASS GIS within a R session**, i.e. you connect to a GRASS GIS
location/mapset from within R (or RStudio).

### Startup

In the first place, find out the path to the GRASS GIS library. This can
be easily done with the following command (still outside of R; or
through a system() call inside of R):

# OSGeo4W users: nothing to do
 
# Linux, Mac OSX users:
grass70 --config path

To call GRASS GIS 7 functionality from R, start R and use the
initGRASS() function to define the GRASS settings:

## MS-Windows users:
library(rgrass7)
# initialisation and the use of North Carolina sample dataset
initGRASS(gisBase = "C:/OSGeo4W/apps/grass/grass-7.1.svn",
         gisDbase = "C:/Users/marissa/GRASSdata/",
         location = "nc_spm_08_grass7", mapset = "user1", SG="elevation")

## Linux, Mac OSX users:
library(rgrass7)
# initialisation and the use of North Carolina sample dataset
initGRASS(gisBase = "/usr/local/grass-7.0.1", home = tempdir(), 
          gisDbase = "/home/veroandreo/grassdata/",
          location = "nc_spm_08_grass7", mapset = "user1", SG="elevation")

Note: the optional SG parameter is a 'SpatialGrid' object to define
the 'DEFAULT_WIND' of the temporary location.

# set computational region to default (optional)
system("g.region -dp")
# verify metadata
gmeta()

# get two raster maps into R space
ncdata <- readRAST(c("geology_30m", "elevation"), cat=c(TRUE, FALSE))

# calculate object summaries
summary(ncdata$geology_30m)


---

R in GRASS in batch mode

Run the following script with

```bash
R CMD BATCH batch.R
```

```rsplus
library(rgrass7)
# initialisation and the use of north carolina dataset
initGRASS(gisBase = "/home/veroandreo/software/grass-7.0.svn/dist.x86_64-unknown-linux-gnu", 
          home = tempdir(), 
          gisDbase = "/home/veroandreo/grassdata/",
          location = "nc_spm_08_grass7", mapset = "user1", SG="elevation",
          override = TRUE)
# set region to default
system("g.region -dp")
# verify
gmeta()
# read data into R
ncdata <- readRAST(c("geology_30m", "elevation"), cat=c(TRUE, FALSE))
# summary of geology map
summary(ncdata$geology_30m)
proc.time()
```

---

Note: include link2GI way as well (see tom's and Chris' github)

(Tom's example)

library(rgrass7)
rname <- "./data/Boulder_mDLSM_30m.tif"
# Set GRASS environment and database location 
loc <- initGRASS("/usr/lib/grass74", home="/data/tmp/", 
                 gisDbase="GRASS_TEMP", override=TRUE)
execGRASS("r.in.gdal", flags="o", parameters=list(input=rname, output="mDLSM"))
execGRASS("g.region", parameters=list(raster="mDLSM"))
execGRASS("r.geomorphon", parameters=list(elevation="mDLSM", forms="mDLSMg"))
#plot(readRAST("mDLSMg"))
execGRASS("r.out.gdal", parameters=list(input="mDLSMg",
          output="./data/Boulder_mDLSMg_30m.tif", 
          type="Byte", createopt="COMPRESS=DEFLATE"))
## clean-up
unlink("./GRASS_TEMP", recursive = TRUE)
unset.GIS_LOCK()
unlink_.gislock()
remove_GISRC()


(Chris example)

#' Adapting parts of the tutorial
#' https://neteler.gitlab.io/grass-gis-analysis/02_grass-gis_ecad_analysis/
#' of Marcus Neteler and Veronica Andreo
#' 
#' This usecase is just giving you an idea how quick and dirty you may 
#' integrate GRASS shell commandline code to a R script
#' Most of the comments and command lines are just copy and paste
#' from Markus Netelers tutorial script 
#' 
#' I just tried to "streamline" the code and dropped 
#' out unix specific stuff like calling displays


cat("setting arguments loading libs and data\n")
require(link2GI)
require(raster)
require(rgrass7)

### define arguments


# define root folder
if (Sys.info()["sysname"] == "Windows"){
  projRootDir<-"C:/Users/User/Documents/link2gi2018-master/grassreload"
} else {
  projRootDir<-"~/link2gi2018-master/grassreload"
}



##--link2GI-- create project folder structure, NOTE the tailing slash is obligate
link2GI::initProj(projRootDir = projRootDir, 
                  projFolders =  c("run/","src/","grassdata/","geodata/","grassdata/user1/"),
                  global = TRUE,
                  path_prefix ="path_gr_" )

## download the tutorial data set 
download <- curl::curl_download("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_countries.zip",
                                paste0(path_gr_run,"ne_10m_admin_0_countries.zip"))
utils::unzip(zipfile = download, exdir = path_gr_geodata)

### 
##--link2GI-- linking GRASS project structure using the information from the DEM raster
link2GI::linkGRASS7(gisdbase = path_gr_grassdata,
                    location = "ecad17_ll",
                    gisdbase_exist = TRUE) 

#-- create mapset user1 ecad17
system("g.mapset -c  mapset=user1")


# Add the mapset "ecad17" and "user1" to the search path
## please note the difference between mapset and mapsets
system("g.mapsets  mapset=user1 operation=add")
system("g.mapsets  mapset=ecad17 operation=add")
system("g.list type=rast")

# import and check/fix topology
system(paste0("v.import --overwrite input=",
              paste0(path_gr_geodata,"ne_10m_admin_0_countries.shp"),
              " output=country_boundaries"))

# add some metadata
system('v.support country_boundaries comment="Source: http://www.naturalearthdata.com/downloads/110m-cultural-vectors/"')
system('v.support country_boundaries map_name="Admin0 boundaries from NaturalEarthData.com"')

# show attibute table colums
system("v.info -c country_boundaries")

##--rgrass7-- import DEM to GRASS
rgrass7::execGRASS('r.in.gdal',
                   flags=c('o',"overwrite","quiet"),
                   input=path.expand(paste0(path_gr_geodata,"ecad_v17/elev_v17.tif")), 
                   output='elev_v17',
                   band=1
)
# color it (works even if you are not looking at it)
system("r.colors map=elev_v17 color=elevation")



### finish with the basic execise

### start the anaysis

##--rgrass7-- Set the computational region to the full raster map (bbox and spatial resolution)  
# resulting in the same using a system call system("g.region raster=precip.1951_1980.01.sum@ecad17")
rgrass7::execGRASS(cmd = "g.region", raster="precip.1951_1980.01.sum")

# Now use the r.series command to create annual precip map for the period 1951 to 1980
system('r.series --overwrite input=`g.list rast pattern="precip.1981_2010.*.sum" sep="comma"` output=precip.1981_2010.annual.sum method=sum
')
# Aggregate the temperature maps average annual temperature
system('r.series --overwrite input=`g.list rast pattern="tmean.1981_2010.*.avg" sep="comma"` output=tmean.1981_2010.annual.avg method=average
')
# read results to R
a_p_sum_1981_2010<-raster::raster(rgrass7::readRAST("precip.1981_2010.annual.sum"))
a_t_mean_1981_2010<-raster::raster(rgrass7::readRAST("tmean.1981_2010.annual.avg"))

# use mapview for visualisation
mapview::mapview(a_p_sum_1981_2010) + a_t_mean_1981_2010

# Compute extended univariate statistics
stat<-system2(command = "r.univar", args = 'tmean.1981_2010.annual.avg -e -g',stdout = TRUE,stderr = TRUE)




### lets do some timeseries


########################################################################
# Commands for the TGRASS lecture at GEOSTAT Summer School in Prague
# Author: Veronica Andreo
# Date: July - August, 2018
########################################################################


########### Before the workshop (done for you in advance) ##############

# Install i.modis add-on (requires pymodis library - www.pymodis.org)
system("g.extension extension=i.modis")

############## For the workshop (what you have to do) ##################

## Download the ready to use mapset 'modis_lst' from:
## https://gitlab.com/veroandreo/grass-gis-geostat-2018
## and unzip it into North Carolina full LOCATION 'nc_spm_08_grass7'
link2GI::linkGRASS7(gisdbase = path_gr_grassdata,
                    location = "nc_spm_08_grass7",
                    gisdbase_exist = TRUE) 

system("g.mapsets  mapset=modis_lst operation=add")
# Get list of raster maps in the 'modis_lst' mapset
system("g.mapsets  -p")
system("g.mapset  mapset=modis_lst")
# Get info from one of the raster maps
system('r.info map=MOD11B3.A2015060.h11v05.single_LST_Day_6km')


## Region settings and MASK

# Set region to NC state with LST maps' resolution
system("g.region -p vector=nc_state align=MOD11B3.A2015060.h11v05.single_LST_Day_6km")

# Set a MASK to nc_state boundary
system("r.mask --overwrite vector=nc_state")

# you should see this statement in the terminal from now on
#~ [Raster MASK present]


## Time series

# Create the STRDS

system('t.create --overwrite type=strds temporaltype=absolute output=LST_Day_monthly@modis_lst title="Monthly LST Day 5.6 km" description="Monthly LST Day 5.6 km MOD11B3.006, 2015-2017"')

# Check if the STRDS is created
system("t.list type=strds")

# Get info about the STRDS
system("t.info input=LST_Day_monthly")


## Add time stamps to maps (i.e., register maps)

# in Unix systems
system('t.register -i input=LST_Day_monthly maps=`g.list type=raster pattern="MOD11B3*LST_Day*" separator=comma` start="2015-01-01" increment="1 months"')


# Check info again
system('t.info input=LST_Day_monthly')


# Check min and max per map
system('t.rast.list input=LST_Day_monthly columns=name,min,max')


## Let's see a graphical representation of our STRDS
system('g.gui.timeline inputs=LST_Day_monthly')


## Temporal calculations: K*50 to Celsius 

# Re-scale data to degrees Celsius
# https://www.mail-archive.com/grass-user@lists.osgeo.org/msg35180.html
## Apparently the data got zstd compressed in 7.5.svn which isn't supported in
## 7.4.x. You need to switch the compression in 7.5 with r.compress.
system('t.rast.algebra --overwrite basename=LST_Day_monthly_celsius expression="LST_Day_monthly_celsius = LST_Day_monthly * 0.02 - 273.15"')

# Check info
system('t.info LST_Day_monthly_celsius')

![vignette on how to set GRASS database with link2GI](https://github.com/gisma/link2gi2018/tree/master/R/vignette)






See here for an exercise: https://tutorials.ecodiv.earth/toc/spatial_interpolation.html, https://tutorials.ecodiv.earth/toc/import-bioclim-data.html

https://www.grassbook.org/wp-content/uploads/neteler/shortcourse_grass2003/notes7.html

# Fetch Aedes albopictus presence from GBIF
# https://grass.osgeo.org/grass74/manuals/addons/v.in.pygbif.html

g.extension v.in.pygbif
v.in.pygbif taxa="Aedes albopictus" rank=species output=gbif -i
v.db.select Aedes_albopictus_gbif






---

## QUESTIONS?

<img src="assets/img/gummy-question.png" width="45%">

---

**Thanks for your attention!!**

![GRASS GIS logo](assets/img/grass_logo_alphab.png)

---

@snap[north span-90]
<br><br><br>
Move on to: 
<br>
[Think about the evaluation]()
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend
