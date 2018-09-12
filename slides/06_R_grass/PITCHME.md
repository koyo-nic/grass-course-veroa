Scripting with R
----------------

Using R and GRASS GIS together can be done in two ways:

-   Using *R within GRASS GIS session*, i.e. you start R (or RStudio)
    from the GRASS GIS command line.
    -   You work with data in GRASS GIS Spatial Database using GRASS GIS
    -   Do not use the `initGRASS()` function (GRASS GIS is running
        already).
-   Using *GRASS GIS within a R session*, i.e. you connect to a GRASS
    GIS Spatial Database from within R (or RStudio).
    -   You put data into GRASS GIS Spatial Database just to perform the
        GRASS GIS computations.
    -   Use the `initGRASS()` function to start GRASS GIS inside R.

We will run R within GRASS GIS session (the first way). Launch R inside
GRASS GIS and install *rgrass7* and *rgdal* package

``` {.r}
install.packages("rgrass7")
install.packages("rgdal")
library("rgrass7")
library("rgdal")
```

We can execute GRASS modules using `execGRASS` function:

``` {.r}
execGRASS("g.region", raster="temp_mean", flags="p")
```

We will analyze the relationship between temperature and elevation and
latitude.

First we will generate raster of latitude values:

``` {.r}
execGRASS("r.mapcalc", expression="latitude = y()")
```

Note: in projected coordinate systems you can use .

Then, we will generate random points and sample the datasets.

``` {.r}
execGRASS("v.random", output="samples", npoints=1000)
# this will restrict sampling to the boundaries of USA
# we are overwriting vector samples, so we need to use overwrite flag
execGRASS("v.random", output="samples", npoints=1000, restrict="boundaries", flags=c("overwrite"))
# create attribute table
execGRASS("v.db.addtable", map="samples", columns=c("elevation double precision", "latitude double precision", "temp double precision"))
# sample individual rasters
execGRASS("v.what.rast", map="samples", raster="temp_mean", column="temp")
execGRASS("v.what.rast", map="samples", raster="latitude", column="latitude")
execGRASS("v.what.rast", map="samples", raster="elevation", column="elevation")
```

Note: there is an addon module which simplifies this process by sampling
multiple rasters.

Now open GRASS GIS attribute table manager to inspect the sampled values
or use to list the values. Explore the dataset in R:

```R
samples <- readVECT("samples")
summary(samples)
plot(samples@data)
```

Compute multivariate linear model:

```R
linmodel <- lm(temp ~ elevation + latitude, samples)
summary(linmodel)
```

Predict temperature using this model:

```R
maps <- readRAST(c("elevation", "latitude"))
maps$temp_model <- predict(linmodel, newdata=maps)
spplot(maps, "temp_model")
# write modeled temperature to GRASS raster and set color ramp
writeRAST(maps, "temp_model", zcol="temp_model")
execGRASS("r.colors", map="temp_model", color="celsius")
```

Compare simple linear model to real data:

```R
execGRASS("r.mapcalc", expression="diff = temp_mean - temp_model")
execGRASS("r.colors", map="diff", color="differences")
```

In GRASS GUI, add layers *temp_mean* and *temp_model*, select them and
go to *File* - *Map Swipe* to compare visually the modeled and real
temperatures.

Image:US_temp_model_comparison.png|Comparison of PRISM annual mean
temperature and modeled temperature based on latitude and elevation.
Left: Difference between modeled and real temperature in degree Celsius.
Right: Using Map Swipe to visually assess the model (modeled temperature
on the right side).


---

from wiki

Installation
------------

See [R\_statistics/Installation](R_statistics/Installation "wikilink")

R within GRASS
--------------

Using **R within GRASS GIS session**, i.e. you start R (or RStudio) from
the GRASS GIS command line.

### Startup

-   First start a GRASS GIS session. Then, at the GRASS command line
    start *R* (for a \'rstudio\' session, see below)

:   *In this example we will use the [North Carolina sample
    dataset](http://grass.osgeo.org/download/sample-data/).*

Reset the region settings to the defaults

``` {.bash}
GRASS 7.0.1svn (nc_spm_08_grass7):~ > g.region -d
```

Launch R from the GRASS prompt

``` {.bash}
GRASS 7.0.1svn (nc_spm_08_grass7):~ > R
```

Load the *rgrass7* library:

``` {.rsplus}
library(rgrass7)
```

If you plan to follow the example using the North Carolina sample
dataset, load the *rgdal* library:

``` {.rsplus}
library(rgdal)
```

Get the GRASS environment (mapset, region, map projection, etc.); you
can display the metadata for your location by printing G:

``` {.rsplus}
G <- gmeta()
gisdbase    /home/neteler/grassdata 
location    nc_spm_08_grass7 
mapset      user1 
rows        620 
columns     1630 
north       320000 
south       10000 
west        120000 
east        935000 
nsres       500 
ewres       500 
projection  +proj=lcc +lat_1=36.16666666666666 +lat_2=34.33333333333334
+lat_0=33.75 +lon_0=-79 +x_0=609601.22 +y_0=0 +no_defs +a=6378137
+rf=298.257222101 +towgs84=0.000,0.000,0.000 +to_meter=1 
```

### Listing of existing maps

List available vector maps:

``` {.rsplus}
execGRASS("g.list", parameters = list(type = "vector"))
```

List selected vector maps (wildcard):

``` {.rsplus}
execGRASS("g.list", parameters = list(type = "vector", pattern = "precip*"))
```

Save selected vector maps into R vector:

``` {.rsplus}
my_vmaps <- execGRASS("g.list", parameters = list(type = "vector", pattern = "precip*"))
attributes(my_vmaps)
attributes(my_vmaps)$resOut
```

List available raster maps:

``` {.rsplus}
execGRASS("g.list", parameters = list(type = "raster"))
```

List selected raster maps (wildcard):

``` {.rsplus}
execGRASS("g.list", parameters = list(type = "raster", pattern = "lsat7_2002*"))
```

### Reading in data from GRASS

#### Example 1

Read in two GRASS raster maps (the maps \"geology\_30m\" and
\"elevation\" from the North Carolina sample data location) into the R
current session as a new object \"ncdata\" (containing then two
SpatialGridDataFrames as well as metadata):

``` {.rsplus}
# the cat parameter indicates which raster values to be returned as factors
# - geology_30m is a categorical map (i.e., it comes with classes)
# - elevation is a continuous surface
ncdata <- readRAST(c("geology_30m", "elevation"), cat=c(TRUE, FALSE))
```

(A warning may appear since in the \"geology\_30m\" map two labels are
not unique - as found in the original data.)

We can verify the new R object:

``` {.rsplus}
str(ncdata)
Formal class 'SpatialGridDataFrame' [package "sp"] with 4 slots
 ..@ data       :'data.frame':  16616 obs. of  2 variables:
```

and also check the data structure in more detail:

``` {.rsplus}
str(ncdata@data)
'data.frame':   16616 obs. of  2 variables:
 $ geology_30m: Factor w/ 12 levels "CZfg_217","CZlg_262",..: NA NA NA NA NA NA NA NA NA NA ...
 $ elevation  : num  NA NA NA NA NA NA NA NA NA NA ...
```

The metadata are now accessed and available, but are not (yet) used to
structure the *sp* class objects, in this case a SpatialGridDataFrame
object filled with data from two North Carolina layers. Here is a plot
of the elevation data:

``` {.rsplus}
image(ncdata, "elevation", col = terrain.colors(20))
```

Add a title to the plot:

``` {.rsplus}
title("North Carolina elevation")
```

![](ncdata.png "ncdata.png")

In addition, we can show what is going on inside the objects read into
R:

``` {.rsplus}
str(G)
List of 26
 $ DEBUG        : chr "0"
 $ LOCATION_NAME: chr "nc_spm_08_grass7"
 $ GISDBASE     : chr "/home/veroandreo/grassdata"
 $ MAPSET       : chr "PERMANENT"
 $ GUI          : chr "wxpython"
 $ projection   : chr "99"
 $ zone         : chr "0"
 $ n            : num 228500
 $ s            : num 215000
 $ w            : num 630000
 $ e            : num 645000
 $ t            : num 1
 $ b            : num 0
 $ nsres        : num 27.5
 $ nsres3       : num 10
 $ ewres        : num 37.5
 $ ewres3       : num 10
 $ tbres        : num 1
 $ rows         : int 491
 $ rows3        : int 1350
 $ cols         : int 400
 $ cols3        : int 1500
 $ depths       : int 1
 $ cells        : chr "196400"
 $ cells3       : chr "2025000"
 $ proj4        : chr "+proj=lcc +lat_1=36.16666666666666 +lat_2=34.33333333333334 +lat_0=33.75 +lon_0=-79 +x_0=609601.22 +y_0=0 +no_defs +a=6378137 +"| __truncated__
 - attr(*, "class")= chr "gmeta"

summary(ncdata)
Object of class SpatialGridDataFrame
Coordinates:
        min    max
[1,] 630000 645000
[2,] 215000 228500
Is projected: TRUE 
proj4string :
[+proj=lcc +lat_1=36.16666666666666 +lat_2=34.33333333333334
+lat_0=33.75 +lon_0=-79 +x_0=609601.22 +y_0=0 +no_defs +a=6378137
+rf=298.257222101 +towgs84=0.000,0.000,0.000 +to_meter=1]
Grid attributes:
  cellcentre.offset cellsize cells.dim
1          630018.8 37.50000       400
2          215013.7 27.49491       491
Data attributes:
   geology_30m      elevation     
 CZfg_217:70381   Min.   : 55.92  
 CZig_270:66861   1st Qu.: 94.78  
 CZbg_405:24561   Median :108.88  
 CZlg_262:19287   Mean   :110.38  
 CZam_862: 6017   3rd Qu.:126.78  
 CZbg_910: 4351   Max.   :156.25  
 (Other) : 4942                   
```

#### Example 2

Here an example for a single map transfer from GRASS GIS to R:

``` {.rsplus}
library(rgrass7)
execGRASS("g.region", raster = "elevation", flags = "p")
ncdata <- readRAST("elevation", cat=FALSE)
summary(ncdata)
spplot(ncdata, col = terrain.colors(20))
```

### Summarizing data

We can create a table of cell counts:

``` {.rsplus}
table(ncdata$geology_30m)
```

  CZfg\_217   CZlg\_262   CZig\_270   CZbg\_405   CZve\_583   CZam\_720   CZg\_766   CZam\_862   CZbg\_910   Km\_921   CZbg\_945   CZam\_946   CZam\_948
  ----------- ----------- ----------- ----------- ----------- ----------- ---------- ----------- ----------- --------- ----------- ----------- -----------
  70381       19287       66861       24561       2089        467         691        6017        4351        1211      1           398         85

And compare with the equivalent GRASS module:

``` {.rsplus}
execGRASS("r.stats", flags=c("c", "l"), parameters=list(input="geology_30m"), ignore.stderr=TRUE)
```

    217 CZfg 70381
    262 CZlg 19287
    270 CZig 66861
    405 CZbg 24561
    583 CZve 2089
    720 CZam 467
    766 CZg 691
    862 CZam 6017
    910 CZbg 4351
    921 Km 1211
    945 CZbg 1
    946 CZam 398
    948 CZam 85

Create a box plot of geologic types at different elevations:

``` {.rsplus}
boxplot(ncdata$elevation ~ ncdata$geology_30m, medlwd = 1)
```

![](boxplot_geo.png "boxplot_geo.png")

### Querying maps

Sometimes you may want to query GRASS GIS maps from your R session.

As an example, here the transfer of raster pixel values at the position
of vector points:

``` {.rsplus}
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
'data.frame':   29939 obs. of  4 variables:
 $ V1: num  571531 571359 571976 572391 573011 ...
 $ V2: num  265740 265987 267049 267513 269615 ...
 $ V3: logi  NA NA NA NA NA NA ...
 $ V4: Factor w/ 22738 levels "-0.0048115728",..: 6859 6642 6749 6411 6356 6904 7506 7224 6908 7167 ...
summary(go1)
       V1               V2            V3                V4       
 Min.   :121862   Min.   :  7991   Mode:logical   0      :  723  
 1st Qu.:462706   1st Qu.:162508   NA's:29939     *      :  293  
 Median :610328   Median :204502                  0.3048 :   47  
 Mean   :588514   Mean   :200038                  0.6096 :   44  
 3rd Qu.:717610   3rd Qu.:247633                  1.524  :   42  
 Max.   :946743   Max.   :327186                  0.9144 :   23  
                                                  (Other):28767  
```

### Exporting data back to GRASS

Finally, a SpatialGridDataFrame object is written back to a GRASS raster
map:

First prepare some data: (square root of elevation)

``` {.rsplus}
ncdata$sqdem <- sqrt(ncdata$elevation)
```

Export data from *R* back into a GRASS raster map:

``` {.rsplus}
writeRAST(ncdata, "sqdemNC", zcol="sqdem", ignore.stderr=TRUE)
```

Check that it imported into GRASS ok:

``` {.rsplus}
execGRASS("r.info", parameters=list(map="sqdemNC"))
```

     +----------------------------------------------------------------------------+
     | Map:      sqdemNC                        Date: Sun Jul 19 13:06:34 2015    |
     | Mapset:   PERMANENT                      Login of Creator: veroandreo      |
     | Location: nc_spm_08_grass7                                                 |
     | DataBase: /home/veroandreo/grassdata                                       |
     | Title:     ( sqdemNC )                                                     |
     | Timestamp: none                                                            |
     |----------------------------------------------------------------------------|
     |                                                                            |
     |   Type of Map:  raster               Number of Categories: 0               |
     |   Data Type:    DCELL                                                      |
     |   Rows:         491                                                        |
     |   Columns:      400                                                        |
     |   Total Cells:  196400                                                     |
     |        Projection: Lambert Conformal Conic                                 |
     |            N:     228500    S: 215000.0002   Res: 27.49490794              |
     |            E:     645000    W:     630000   Res:  37.5                     |
     |   Range of data:    min = 7.47818253045085  max = 12.5000787351036         |
     |                                                                            |
     |   Data Description:                                                        |
     |    generated by r.in.bin                                                   |
     |                                                                            |
     |   Comments:                                                                |
     |                                                                            |
     +----------------------------------------------------------------------------+

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

Then, you load rgrass7 library in your RStudio project

``` {.rsplus}
library(rgrass7)
```

and you are ready to go.

![RStudio used in GRASS GIS 7
session](Grass7_rstudio.png "RStudio used in GRASS GIS 7 session"){width="500"}

GRASS within R
--------------

Using **GRASS GIS within a R session**, i.e. you connect to a GRASS GIS
location/mapset from within R (or RStudio).

### Startup

In the first place, find out the path to the GRASS GIS library. This can
be easily done with the following command (still outside of R; or
through a system() call inside of R):

``` {.bash}
# OSGeo4W users: nothing to do
 
# Linux, Mac OSX users:
grass70 --config path
```

It may report something like:

``` {.bash}
/usr/local/grass-7.0.1
```

To call GRASS GIS 7 functionality from R, start R and use the
initGRASS() function to define the GRASS settings:

``` {.rsplus}
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
```

Note: the optional SG parameter is a \'SpatialGrid\' object to define
the 'DEFAULT\_WIND' of the temporary location.

``` {.rsplus}
# set computational region to default (optional)
system("g.region -dp")
# verify metadata
gmeta()

# get two raster maps into R space
ncdata <- readRAST(c("geology_30m", "elevation"), cat=c(TRUE, FALSE))

# calculate object summaries
summary(ncdata$geology_30m)
 CZfg_217 CZlg_262 CZig_270 CZbg_405 CZve_583 CZam_720  CZg_766 CZam_862 
     292       78      277      102        8        1        2       25 
 CZbg_910   Km_921 CZam_946     NA's 
      18        5        2  1009790 
```

R in GRASS in batch mode
------------------------

Run the following script with

```bash
R CMD BATCH batch.R
```

```R
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

The result is (shorted here):

```bash
cat batch.Rout
```

```R
    R version 3.2.1 (2015-06-18) -- "World-Famous Astronaut"
    Copyright (C) 2015 The R Foundation for Statistical Computing
    Platform: x86_64-redhat-linux-gnu (64-bit)
    ...
    > library(rgrass7)
    Loading required package: sp
    Loading required package: XML
    GRASS GIS interface loaded with GRASS version: (GRASS not running)
    > # initialisation and the use of north carolina dataset
    > initGRASS(gisBase = "/home/veroandreo/software/grass-7.0.svn/dist.x86_64-unknown-linux-gnu", home = tempdir(), 
    +           gisDbase = "/home/veroandreo/grassdata/",
    +           location = "nc_spm_08_grass7", mapset = "user1", SG="elevation",
    +           override = TRUE)
    gisdbase    /home/veroandreo/grassdata/ 
    location    nc_spm_08_grass7 
    mapset      user1 
    rows        620 
    columns     1630 
    north       320000 
    south       10000 
    west        120000 
    east        935000 
    nsres       500 
    ewres       500 
    projection  +proj=lcc +lat_1=36.16666666666666 +lat_2=34.33333333333334
    +lat_0=33.75 +lon_0=-79 +x_0=609601.22 +y_0=0 +no_defs +a=6378137
    +rf=298.257222101 +towgs84=0.000,0.000,0.000 +to_meter=1 
    
    > system("g.region -dp")
    projection: 99 (Lambert Conformal Conic)
    zone:       0
    datum:      nad83
    ellipsoid:  a=6378137 es=0.006694380022900787
    north:      320000
    south:      10000
    west:       120000
    east:       935000
    nsres:      500
    ewres:      500
    rows:       620
    cols:       1630
    cells:      1010600
    > gmeta()
    gisdbase    /home/veroandreo/grassdata/ 
    location    nc_spm_08_grass7 
    mapset      user1 
    rows        620 
    columns     1630 
    north       320000 
    south       10000 
    ...
    > ncdata <- readRAST(c("geology_30m", "elevation"), cat=c(TRUE, FALSE))
    ...
    > summary(ncdata$geology_30m)
    CZfg_217 CZlg_262 CZig_270 CZbg_405 CZve_583 CZam_720  CZg_766 CZam_862 
         292       78      277      102        8        1        2       25 
    CZbg_910   Km_921 CZam_946     NA's 
          18        5        2  1009790 
    > proc.time()
       user  system elapsed 
      8.061   2.016  10.048
```

Troubleshooting
---------------

### Running out of disk space

Linux: A common issue is that /tmp/ is used for temporary files albeit
being often a small partition. To change that to a larger directory, you
may add to your `$HOME/.bashrc` the entry:

```bash
# change TMP directory of R (note: of course also another directory than suggested here is fine)
mkdir -p $HOME/tmp
export TMP=$HOME/tmp
```

The drawback is that on modern Linux systems the /tmp/ is a fast RAM
disk (based on tempfs) while HOME directories are often on slower
spinning disks (unless you have a SSD drive). At least you no longer run
out of disk space easily.

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

