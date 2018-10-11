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

+++

- Using @color[#8EA33B](**R within GRASS GIS session**), i.e. starting R (or RStudio) from the GRASS GIS command line.
  - we do not need to initialize GRASS with `initGRASS()` because GRASS GIS is already running
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
(kudos to Roger Bivand @fa[smile-o])
 
---

We will first @color[#8EA33B](run R within GRASS GIS session)

<br>

Open GRASS GIS and launch R or RStudio from inside GRASS GIS


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

Add plot here

+++?code=code/06_grass_R_code.r&lang=r&title=Relationship between LST and elevation and NDVI

@[50-52](Compute linear model)
@[54-57](Predict LST using the model)

+++?code=code/06_grass_R_code.r&lang=r&title=Relationship between LST and elevation and NDVI

@[59-61](Write modelled LST to a GRASS raster)
@[63-65](Compare model to real data)

+++?code=code/06_grass_R_code.r&lang=r&title=Relationship between LST and elevation and NDVI

Add maps here

---

We'll now learn how to @color[#8EA33B](start GRASS within R or Rstudio)

<br>

Open RStudio

+++?code=code/06_grass_R_code.r&lang=r

@[73-76](Find out the path to the GRASS GIS library)
@[78-88](Define the GRASS settings: Windows)
@[90-98](Define the GRASS settings: Linux)
@[103-106](Set computational region)
@[108-109](Verify metadata)
@[111-116](List vector maps)
@[118-122](Save list of vector maps)
@[124-129](List raster maps)
@[131-132](Get raster maps into R)
@[134-137](Summaries)
@[139-141](Verify the object)
@[143-145](Plot)

+++

Add plot here

+++?code=code/06_grass_R_code.r&lang=r

@[147-149](Boxplot and histogram)

+++

Add plot here

+++?code=code/06_grass_R_code.r&lang=r

@[151-155](Query a raster map)
@[157-160](Parse the output)

+++?code=code/06_grass_R_code.r&lang=r

@[162-163](Do something with a raster map)
@[165-166](Write it into GRASS)
@[168-169](Check metadata of exported map)

---

GRASS within R in @color[#8EA33B](batch mode)

+++

Run the script from the termnal with:

<br>

```bash
R CMD BATCH batch.R
```

+++?code=code/06_grass_R_code.r&lang=r

@[177-193](The script might look like this)

---

[Example of GRASS - R for raster time series](https://grasswiki.osgeo.org/wiki/Temporal_data_processing/GRASS_R_raster_time_series_processing)

---

There is another R package that provides link to GRASS and other GIS:

**link2GI**

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
[Think about the evaluation]()
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

# Fetch Aedes albopictus presence from GBIF
# https://grass.osgeo.org/grass74/manuals/addons/v.in.pygbif.html

g.extension v.in.pygbif
v.in.pygbif taxa="Aedes albopictus" rank=species output=gbif -i
v.db.select Aedes_albopictus_gbif

--->
