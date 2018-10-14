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
- MODIS product: <a href="https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod13c2_v006">MOD13C2 Collection 6</a>
- Global monthly composites
- Spatial resolution: 5600m 
@snapend

@snap[east span-50]
- Download mapset *modis_ndvi*
- Unzip it within NC location
- Ready
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

@[85-86](Start GRASS GIS in `modis_ndvi` mapset)
@[88-90](Add `modis_lst` to accessible mapsets path)
@[92-95](List files and get info and stats)

+++

> **Task**: 
> - Display EVI, NIR and QA maps
> - Get info about min and max values
> - What do you notice?

---

Use of reliability band

> **Task**: 
> - Read about this band at the MOD13 [User guide](https://lpdaac.usgs.gov/sites/default/files/public/product_documentation/mod13_user_guide.pdf)
> - Display one of the pixel reliability bands

---?code=code/05_ndvi_time_series_code.sh&lang=bash&title=Use of reliability band









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
[Temporal data processing](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/05_temporal&grs=gitlab)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend
