---?image=template/img/grass.png&position=bottom&size=100% 30%
@title[Front page]

@snap[north span-100]
<br>
<h2>Procesamiento de series de tiempo en @color[green](GRASS GIS)</h2>
<h3>Aplicaciones en Ecología y Ambiente</h3>
@snapend

@snap[south message-box-white]
<br>Dra. Verónica Andreo<br>CONICET - INMeT<br><br>Río Cuarto, 2018<br>
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Interface GRASS - R: Bridging GIS and statistics

---

GRASS GIS and R can be used together in two ways:
<br><br>
- Using [R within a GRASS GIS session](https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7#R_within_GRASS),
- Using [GRASS GIS within an R session](https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7#GRASS_within_R),
<br><br>

@size[22px](Details and examples at the <a href="https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7">GRASS and R wiki</a>)

+++

![Calling R from within GRASS](assets/img/RwithinGRASS_and_Rstudio_from_grass.png)

+++

- Using @color[#8EA33B](**R within GRASS GIS session**), i.e. starting R (or RStudio) from the GRASS GIS command line.
  - we do not need to initialize GRASS with `initGRASS()`
  - we work with data already in GRASS GIS database using GRASS GIS but from R by means of `execGRASS()`
  - we use `readVECT()`, `readRAST()` to read data from GRASS DB to do analysis or plot
  - we write data back to GRASS with `writeVECT()` and `writeRAST()`

+++

- Using @color[#8EA33B](**GRASS GIS within a R session**), i.e. we connect to GRASS GIS database from within R (or RStudio).
  - we need to initialize GRASS GIS with `initGRASS()`
  - we use GRASS GIS funtionalities with `execGRASS()`
  - we use `readVECT()`, `readRAST()` to read data from GRASS DB to do analysis or plot
  - we write data back to GRASS with `writeVECT()` and `writeRAST()`

+++

The link between GRASS GIS and R is provided by the [**rgrass7**](https://cran.r-project.org/web/packages/rgrass7/index.html) package
<br><br><br>
(kudos to Roger Bivand @fa[smile-o fa-spin])

---

Download the file with [code](https://gitlab.com/veroandreo/curso-grass-gis-rioiv/raw/master/code/06_grass_R_code.r?inline=false) to follow this session
 
---

We will first @color[#8EA33B](run R within a GRASS GIS session)

<br>

Open GRASS GIS in North Carolina Location and mapset user1

```
g.mapsets mapset=modis_lst,modis_ndvi operation=add
g.region -p vector=nc_state  align=MOD13C2.A2015001.006.single_CMG_0.05_Deg_Monthly_NDVI
t.rast.series input=LST_Day_monthly_celsius@modis_lst output=lst method=average
t.rast.series input=ndvi_monthly@modis_ndvi output=ndvi method=average
```

+++

Now, launch R or RStudio from inside GRASS GIS

```r
GRASS> rstudio &
GRASS> rstudio /path/to/project/folder/ &
```

+++?code=code/06_grass_R_code.r&lang=r&title=Relationship between LST and elevation and NDVI

@[13-15](Install and load rgrass7)
@[17-18](Read grass session metadata)
@[20-21](Set the computational region)
@[23-24](Generate random points)
@[26-31](Generate random points restricting to NC area)
@[33-37](Add table to vector of random points)
@[39-42](Sample rasters with random points)
@[44-48](Explore the dataset)

+++

![corr plot](assets/img/corr_plot.png)

+++?code=code/06_grass_R_code.r&lang=r&title=Relationship between LST and elevation and NDVI

@[50-52](Compute linear model)
@[54-57](Predict LST using the model)
@[59-62](Set color palette, read raster and plot)

+++

![lst pred](assets/img/lst_pred.png)

+++?code=code/06_grass_R_code.r&lang=r&title=Relationship between LST and elevation and NDVI

@[64-66](Compare model to real data)
@[68-70](Read raster and plot)

+++

![lst diff](assets/img/lst_diff.png)

---

We'll now learn how to @color[#8EA33B](start GRASS from within R or Rstudio)

<br>

Open @fa[r-project] or RStudio

<br>

Attention! Windows users need to **start R or RStudio from the OSGeo4W Shell**

+++?code=code/06_grass_R_code.r&lang=r

@[78-81](Find out the path to the GRASS GIS library)
@[86-93](Define the GRASS settings: Windows)
@[95-103](Define the GRASS settings: Linux)
@[108-111](Set computational region)
@[113-114](Verify metadata)
@[116-121](List vector maps)
@[123-127](Save list of vector maps)
@[129-134](List raster maps)
@[136-137](Get raster maps into R)
@[139-142](Summaries)
@[144-146](Verify the object)
@[148-149](Plot)

+++?code=code/06_grass_R_code.r&lang=r

@[151-153](Boxplot and histogram)

+++

![boxplot](assets/img/boxplot.png)

+++?code=code/06_grass_R_code.r&lang=r

@[155-159](Query a raster map)
@[161-164](Parse the output)

+++?code=code/06_grass_R_code.r&lang=r

@[166-167](Do something with a raster map)
@[169-170](Write it into GRASS)
@[172-173](Check metadata of exported map)

---

GRASS within R in @color[#8EA33B](batch mode)

+++

Run the script from the terminal with:

<br>

```bash
R CMD BATCH batch.R
```

+++?code=code/06_grass_R_code.r&lang=r

@[181-199](The script might look like this)

---

Learn more: 

[Example of GRASS - R for raster time series](https://grasswiki.osgeo.org/wiki/Temporal_data_processing/GRASS_R_raster_time_series_processing)

![DINEOF for gap-filling](https://grasswiki.osgeo.org/w/images/Time_series.png)

---

There is another R package that provides link to GRASS and other GIS:
<br>

**link2GI**

<br>
See the [vignette on how to set GRASS database with link2GI](https://github.com/gisma/link2gi2018/tree/master/R/vignette) for further details

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
[GRASS and R: Predicting species distribution](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=exercises/06_predicting_species_distribution&grs=gitlab#/)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend

<!---

See here for an exercise: 
https://tutorials.ecodiv.earth/toc/spatial_interpolation.html
https://tutorials.ecodiv.earth/toc/import-bioclim-data.html
https://www.grassbook.org/wp-content/uploads/neteler/shortcourse_grass2003/notes7.html


If GRASS GIS is started from R (or RStudio) session a initGRASS() function must be called in order to define GRASS GIS environment settings. First get the full path to GRASS GIS installation and run the initGRASS() function with specified parameters pointing to GRASS location and mapset to be used.

# Get GRASS library path
grasslib <- try(system('grass --config', intern=TRUE))[4]

initGRASS(gisBase=grasslib, gisDbase='/home/user/grassdata/',
          location='oslo-region', mapset='PERMANENT', override=TRUE)

At this point GRASS GIS modules are available inside R by execGRASS() function. In example below are listed available vector maps from the current location and mapset using g.list. Vector map of administrative regions (Fylke) is converted to raster format by v.to.rast.

execGRASS("g.list", parameters = list(type = "vector"))
execGRASS("g.region", parameters = list(vector="Fylke", align="modis_avg@modis"))
execGRASS("v.to.rast", parameters = list(input = "Fylke",
          output="fylke", use="cat", label_column="navn"))

GRASS raster map can be read as an R object by readRAST() function. The cat parameter indicates which raster values to be returned as factors.

ncdata <- readRAST(c("fylke", "modis_avg@modis"), cat=c(TRUE, FALSE))
summary(ncdata)

Object of class SpatialGridDataFrame
Coordinates:
      min     max
[1,] -572752 1039248
[2,] 5539179 7836179
Is projected: TRUE
proj4string :
[+proj=utm +no_defs +zone=33 +a=6378137 +rf=298.257222101
 +towgs84=0,0,0,0,0,0,0 +to_meter=1]
Grid attributes:
   cellcentre.offset cellsize cells.dim
1           -572252     1000      1612
2           5539679     1000      2297
Data attributes:
                     fylke           modis_avg
  (1:Nordland)          :  80964   Min.   :-11.1
  (1:Trøndelag)         :  58662   1st Qu.: -1.7
  (2:Troms,Romsa)       :  40760   Median :  4.2
  (2:Finnmark,Finnmárku):  31257   Mean   :  3.4
  (1:Hedmark)           :  27403   3rd Qu.:  8.7
  (Other)               : 187401   Max.   : 16.1
  NA's                  :3276317   NA's   :2450449

In example below a boxplot of Norwegian regions with the 2017 annual mean values of MODIS LST is ploted, see Fig. 135.

boxplot(ncdata$modis_avg ~ ncdata$fylke, medlwd = 1)

--->
