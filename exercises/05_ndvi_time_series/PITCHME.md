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

## NDVI time series

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
- Phenology
- NDWI
- Regression
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
@ol[](false)
- Download mapset *modis_ndvi*
- Unzip it within NC location
- Ready
@olend
@snapend

+++

![NDVI global](assets/img/mod13c2_global_ndvi.png)

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
> - Display EVI, NIR and QA maps and get info about min and max values
> - What do you notice?

---

Use of reliability band

> **Task**: 
>
> - Read about this reliability band at the MOD13 [User guide](https://lpdaac.usgs.gov/sites/default/files/public/product_documentation/mod13_user_guide.pdf) (pag 27).
> - Display one of the pixel reliability bands along with NDVI band of the same date.
> - Select only pixels with value 0 (Good quality) in the pixel reliability band. What do you notice?

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Use of reliability band

@[102-104](Set computational region)
@[106-111](Keep only best quality pixels)
@[113-127](Keep only best quality pixels - all maps)

+++

> **Task*: Compare stats among original and filtered NDVI maps for the same date

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Create time series

@[135-139](Create the STRDS)
@[141-142](Check STRDS was created)
@[144-145](Create file with list of maps)
@[147-150](Register maps)
@[152-153](Print time series info)
@[155-156](Print list of maps in STRDS)

+++

> **Task**: Visually explore the values of the time series in different points. 
> Use [g.gui.tplot](https://grass.osgeo.org/grass74/manuals/g.gui.tplot.html) 
> and select different points interactively.

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Missing data

@[164-165](Set mask)
@[167-168](Get time series stats)
@[170-172](Count valid data)
@[174-176](Estimate percentage of missing data)

+++

> **Task**: 
> - Display the map representing percentage of missing data and explore values. 
> - Get univariate statistics of map.

---

Temporal gap-filling: HANTS

- Harmonic Analysis of Time Series (HANTS)
- Implemented in [r.hants](https://grass.osgeo.org/grass7/manuals/addons/r.hants.html) addon

+++?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Temporal gap-filling: HANTS

@[184-185](Install extension)
@[187-188](List maps)
@[190-191](Gap-fill: r.hants)

+++

> **Task**: Test different parameter settings

+++?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Temporal gap-filling: HANTS

@[193-198](Patch original and gapfilled map)
@[200-212](Patch original and gapfilled maps)
@[214-218](Create time series with patched data)
@[220-226](Register maps in time series)
@[228-229](Print time series info)

+++

> **Task**: Graphically asses the results of reconstruction in pixels with higher percentage of missing data and obtain univariate stats for the new time series.

---

### Aggregation with granularity

> **Task**: 
> - Obtain bimonthly average NDVI 
> - Visualize with [g.gui.animation](https://grass.osgeo.org/grass74/manuals/g.gui.animation.html)

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Phenology

@[237-239](Month of maximum and month of minimum)
@[241-248](Replace STRDS values with 1 if they match overall min or max)
@[250-252](Get the earliest month in which the maximum and minimum appeared)
@[254-255](Remove intermediate time series)

+++

> **Task**: Display resulting maps with [g.gui.mapswipe](https://grass.osgeo.org/grass74/manuals/g.gui.mapswipe.html)

+++?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Phenology

@[257-260](Get time series of slopes among consequtive maps)
@[262-265](Get maximum slope per year)

+++

> **Task**: Determine the highest growing rate in the period 2015-2017 and display it

+++?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Phenology

@[267-268](Install extension)
@[270-273](Determine start, end and length of growing season)

+++

> **Task**: Plot resulting maps

+++?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Phenology

@[275-276](Create a threshold map to use in r.seasons)

+++

> **Task**: Use threshold map in r.seasons and compare output maps

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Water index time series

@[284-293](Create time series of NIR and MIR)
@[295-297](List NIR and MIR files)
@[299-306](Register maps)
@[308-310](Print time series info)
@[312-314](Estimate NDWI time series)

+++

> **Task**: Get max and min values for each NDWI map and explore the time series plot in different points interactively.

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Frequency of flooding

@[322-324](Reclassify maps according to threshold)
@[326-327](Get flooding frequency)

+++

> **Task**: Which are the areas that have flooded most frequently?

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Regression analysis

@[335-339](Perform regression between NDVI and NDWI time series)

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
[Interface GRASS and R](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/06_R_grass&grs=gitlab#/)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend
