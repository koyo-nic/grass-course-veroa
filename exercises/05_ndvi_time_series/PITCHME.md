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

## Hands-on to NDVI time series

---

@snap[north-west span-60]
<h3>Overview</h3>
@snapend

@snap[west span-100]
<br><br>
@ol[list-content-verbose]
- Data for the exercise
- Get familiar with the data
- Use reliability band
- Create NDVI time series
- Gap-filling: HANTS
- Aggregation
- Phenology indices
- NDWI and flooding frequency
- Regression between NDVI and NDWI
@olend
@snapend

---

@snap[north span-100]
<h3>Data for the exercise</h3>
@snapend

@snap[west span-50]
@ul[](false)
- MODIS product: <a href="https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod13c2_v006">MOD13C2 Collection 6</a>
- Global monthly composites
- Spatial resolution: 5600m 
@ulend
@snapend

@snap[east span-50]
![NDVI global](assets/img/mod13c2_global_ndvi.png)
@snapend

+++

@snap[north span-100]
<h3>Data for the exercise</h3>
@snapend

@snap[midpoint span-100]
@ol[](false)
- Download [*modis_ndvi*](https://gitlab.com/veroandreo/curso-grass-gis-rioiv/raw/master/data/modis_ndvi.zip?inline=false) mapset
- Unzip it within North Carolina location
- Ready
@olend
@snapend

@snap[south span-100]
Download the [code](https://gitlab.com/veroandreo/curso-grass-gis-rioiv/raw/master/code/05_ndvi_time_series_code.sh?inline=false) to follow this exercise
<br><br>
@snapend

+++?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Preparation of the dataset

@[17-18](Start GRASS GIS in NC location and create a new mapset)
@[20-22](Add modis_lst mapset to path)
@[24-26](Set region to an LST map)
@[28-35](Get bounding box in ll)
@[37-42](Download MOD13C2)
@[46-48](Move into latlong_wgs84 location and import)
@[50-52](Set region to bb obtained from NC)
@[54-57](Subset to region)
@[59-60](List of maps that will be reprojected)
@[64-70](Reprojection - in target location)
@[72-73](Check projected data)

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Get familiar with NDVI data

@[85-86](Start GRASS GIS in modis_ndvi mapset)
@[88-90](Add modis_lst to accessible mapsets path)
@[92-95](List files and get info and stats)

+++

> **Task**: 
>
> - Display EVI, NIR and QA maps and get information about minimum and maximum values
> - What do you notice?

---

Use of reliability band
<br>

> **Task**: 
>
> - Read about this reliability band at the MOD13 [User guide](https://lpdaac.usgs.gov/sites/default/files/public/product_documentation/mod13_user_guide.pdf) (pag 27).
> - Display one of the pixel reliability bands along with NDVI band of the same date.
> - Select only pixels with value 0 (Good quality) in the pixel reliability band. What do you notice?

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Use of reliability band

@[102-104](Set computational region)
@[106-111](Keep only best quality pixels - UNIX)
@[113-117](Keep only best quality pixels - Windows)
@[119-133](Keep only best quality pixels - all maps)

+++

> **Task**: Compare stats among original and filtered NDVI maps for the same date

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Create time series

@[141-145](Create the STRDS)
@[147-148](Check STRDS was created)
@[150-151](Create file with list of maps)
@[153-156](Register maps)
@[158-159](Print time series info)
@[161-162](Print list of maps in STRDS)

+++

> **Task**: Visually explore the values of the time series in different points. 
> Use [g.gui.tplot](https://grass.osgeo.org/grass74/manuals/g.gui.tplot.html) 
> and select different points interactively.

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Missing data

@[170-171](Set mask)
@[173-174](Get time series stats)
@[176-178](Count valid data)
@[180-182](Estimate percentage of missing data)

+++

> **Task**: 
> - Display the map representing the percentage of missing data and explore values. 
> - Get univariate statistics of this map.

---

### Temporal gap-filling: HANTS

- Harmonic Analysis of Time Series (HANTS)
- Implemented in [r.hants](https://grass.osgeo.org/grass7/manuals/addons/r.hants.html) addon

+++?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Temporal gap-filling: HANTS

@[190-191](Install extension)
@[193-195](List maps)
@[197-198](Gap-fill: r.hants)

+++

> **Task**: Test different parameter settings in r.hants and compare results

+++?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Temporal gap-filling: HANTS

@[200-205](Patch original and gapfilled map)
@[207-218](Gap-fill and patch maps in Windows)
@[220-232](Patch original and gapfilled maps)
@[234-238](Create time series with patched data)
@[240-246](Register maps in time series)
@[248-249](Print time series info)

+++

> **Task**: Graphically assess the results of HANTS reconstruction in pixels with higher percentage of missing data and obtain univariate statistics for the new time series

---

### Aggregation with granularity

<br>

> **Task**: 
> - Obtain average NDVI every two months
> - Visualize the resulting time series with [g.gui.animation](https://grass.osgeo.org/grass74/manuals/g.gui.animation.html)

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Phenology

@[257-259](Month of maximum and month of minimum)
@[261-268](Replace STRDS values with start_month if they match overall min or max)
@[270-272](Get the earliest month in which the maximum and minimum appeared)
@[274-275](Remove intermediate time series)

+++

> **Task**: Display the resulting maps with [g.gui.mapswipe](https://grass.osgeo.org/grass74/manuals/g.gui.mapswipe.html)

+++?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Phenology

@[278-281](Get time series of slopes among consequtive maps)
@[283-286](Get maximum slope per year)

+++

> **Task**: Obtain a map with the highest growing rate per pixel in the period 2015-2017 and display it

+++?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Phenology

@[288-289](Install extension)
@[291-294](Determine start, end and length of growing season)
@[296-299](Determine start, end and length of growing season - Windows)

+++

> **Task**: Plot the resulting maps

+++?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Phenology

@[301-302](Create a threshold map to use in r.seasons)

+++

> **Task**: Use threshold map in r.seasons and compare output maps with the outputs of using a threshold value only

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Water index time series

@[310-319](Create time series of NIR and MIR)
@[321-323](List NIR and MIR files)
@[325-332](Register maps)
@[334-336](Print time series info)
@[338-340](Estimate NDWI time series)

+++

> **Task**: Get maximum and minimum values for each NDWI map and explore the time series plot in different points interactively

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Frequency of flooding

@[348-350](Reclassify maps according to threshold)
@[352-353](Get flooding frequency)

+++

> **Task**: Which are the areas that have been flooded most frequently?

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Regression analysis

@[361-362](Install extension)
@[364-369](Perform regression between NDVI and NDWI time series)
@[371-376](Perform regression between NDVI and NDWI time series - Windows)

+++

> **Task**: Where is the highest correlation among NDVI and NDWI?

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
[GRASS and R interface](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/06_R_grass&grs=gitlab#/)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend
