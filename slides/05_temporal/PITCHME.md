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

## Spatio-temporal data processing & visualization in GRASS GIS

---

## The TGRASS framework

<!---
GRASS GIS is **the first Open Source GIS** that incorporated
capabilities to **manage, analyze, process and visualize spatio-temporal
data**, as well as the temporal relationships among time series.
--->

@ul
- TGRASS is the temporal enabled GRASS GIS designed to easily handle time series data
- TGRASS is fully @color[green](based on metadata) and does not duplicate any dataset
- @color[green](Snapshot) approach, i.e., adds time stamps to maps
- A collection of time stamped maps (snapshots) of the same variable are called @color[green](space-time datasets or STDS)
- Maps in a STDS can have different spatial and temporal extents
@ulend

<!---
TGRASS uses an SQL database to store the temporal and spatial extension
of STDS, as well as the topological relationships among maps and among
STDS in each mapset.
--->

+++

## Space-time datasets

- Space time raster datasets (**ST@color[green](R)DS**)
- Space time 3D raster datasets (**ST@color[green](R3)DS**)
- Space time vector datasets (**ST@color[green](V)DS**)

+++

## Other TGRASS notions

@ul
- Time can be defined as @color[green](intervals) (start and end time) or @color[green](instances) (only start time)
- Time can be @color[green](absolute) (e.g., 2017-04-06 22:39:49) or @color[green](relative) (e.g., 4 years, 90 days)
- @color[green](Granularity) is the greatest common divisor of the temporal extents (and possible gaps) of all maps in the space-time cube
@ulend

+++

### Other TGRASS notions

- @color[green](Topology) refers to temporal relations between time intervals in a STDS.

<img class="plain" src="img/temp_relation.png">

+++

### Other TGRASS notions

- @color[green](Temporal sampling) is used to determine the state of one process during a second process.

<img class="plain" src="img/temp_samplings.png">

+++

## Spatio-temporal modules

- @color[green](**t.\***): General modules to handle STDS of all types
- @color[green](**t.rast.\***): Modules that deal with STRDS
- @color[green](**t.rast3d.\***): Modules that deal with STR3DS
- @color[green](**t.vect.\***): Modules that deal with STVDS

+++

## TGRASS framework and workflow

+++?image=assets/img/tgrass_flowchart.png&position=center&size=auto 93%

---

## Hands-on to raster time series in GRASS GIS

---

#### Let's first get the data
<br><br>
- [North Carolina location (full dataset, 150Mb)](https://grass.osgeo.org/sampledata/north_carolina/nc_spm_08_grass7.zip): download and unzip within `$HOME/grassdata`. 
- [modis_lst mapset (2Mb)](https://gitlab.com/veroandreo/grass-gis-geostat-2018/blob/master/data/modis_lst.zip): download and unzip within the North Carolina location in `$HOME/grassdata/nc_spm_08_grass7`.
<br><br><br>
... and start GRASS GIS in `$HOME/grassdata/nc_spm_08_grass7/modis_lst`

---?code=code/05_temporal_code.sh&lang=bash&title=Set computational region and apply MASK

@[32-40]
@[43-61]
@[63-67]

---

### Create a temporal dataset (STDS)

**[t.create](https://grass.osgeo.org/grass74/manuals/t.create.html)**
<br>
- Creates an SQLite container table in the temporal database 
- Handles even huge amounts of maps by using the STDS as input 
- We need to specify:
  - *type of maps* (raster, raster3d or vector)
  - *type of time* (absolute or relative)

+++?code=code/05_temporal_code.sh&lang=bash&title=Create a raster time series (STRDS)

@[70-75]
@[77-78]
@[80-81]

---  

### Register maps into the STRDS

**[t.register](https://grass.osgeo.org/grass74/manuals/t.register.html)**
<br>
- Assigns time stamps to maps
- We need: 
  - the *empty STDS* as input, i.e., the container table, 
  - the *list of maps* to be registered, 
  - the *start date*,
  - *increment* option along with the *-i* flag for interval creation 

+++?code=code/05_temporal_code.sh&lang=bash&title=Register maps in STRDS (assign time stamps)

@[84-89]
@[91-94]
@[96-97]
@[99-100]
@[102-103]

<br>
For more options, check the
[t.register](https://grass.osgeo.org/grass74/manuals/t.register.html)
manual and related 
[map registration wiki](https://grasswiki.osgeo.org/wiki/Temporal_data_processing/maps_registration)
page.

+++?code=code/05_temporal_code.sh&lang=bash&title=Graphical Representation of the STRDS

@[106-107]

+++

![g.gui.timeline example](assets/img/g_gui_timeline_monthly.png)

<br>
See [g.gui.timeline](https://grass.osgeo.org/grass74/manuals/g.gui.timeline.html) manual page

---

### Operations with temporal algebra

**[t.rast.algebra](https://grass.osgeo.org/grass74/manuals/t.rast.algebra.html)**
<br>
- Performs a wide range of temporal and spatial map algebra operations based on map's temporal topology 
- Provides:
  - Temporal operators: union, intersection, etc.
  - Temporal functions: *start_time()*, *start_doy()*, etc.
  - Spatial operators (subset of [r.mapcalc](https://grass.osgeo.org/grass74/manuals/r.mapcalc.html))
  - Temporal neighbourhood modifier: *[x,y,t]*
  - Other temporal functions like *tsnap()*, *buff_t()* or *tshift()*
<br><br>
**they can be combined in complex expressions!!**

+++?code=code/05_temporal_code.sh&lang=bash&title=From K*50 to Celsius using the temporal calculator

@[110-114]
@[116-117]
@[119-121]

+++?code=code/05_temporal_code.sh&lang=bash&title=Time series plot

@[126-128]
@[130-135]

For a single point, see [g.gui.tplot](https://grass.osgeo.org/grass74/manuals/g.gui.tplot.html). For a vector of points, see [t.rast.what](https://grass.osgeo.org/grass74/manuals/t.rast.what.html).

+++

![g.gui.tplot: LST time series for Raleigh](assets/img/g_gui_tplot_final.png)

@size[20px](Point coordinates can be typed directly, copied from the map display and pasted or directly chosen from the main map display.)

---

#### Lists and selections

- **[t.list](https://grass.osgeo.org/grass74/manuals/t.list.html)** for listing STDS and maps registered in the temporal database,
- **[t.rast.list](https://grass.osgeo.org/grass74/manuals/t.rast.list.html)** for maps in raster time series, and
- **[t.vect.list](https://grass.osgeo.org/grass74/manuals/t.vect.list.html)** for maps in vector time series.

+++?code=code/05_temporal_code.sh&lang=bash&title=Listing examples

@[140-151]
@[153-166]
@[168-176]
@[178-185]

---?code=code/05_temporal_code.sh&lang=bash&title=Descriptive statistics of LST time series

@[188-198]
@[200-201]
@[203-205]

---

### Temporal aggregation 1: Using the full time series

**[t.rast.series](https://grass.osgeo.org/grass74/manuals/t.rast.series.html)**
<br>
- Aggregates full STRDS or parts of it using the *where* option
- Different methods available: average, minimum, maximum, median, mode, etc.

+++?code=code/05_temporal_code.sh&lang=bash&title=Maximum and minimum LST in the past 3 years

@[208-212]
@[214-216]
@[218-219]

+++?code=code/05_temporal_code.sh&lang=bash&title=Compare maps with the Mapswipe tool

@[222-228]

+++

![mapswipe and lst max](assets/img/g_gui_mapswipe_lstmax.png)

+++

![mapswipe and lst min](img/g_gui_mapswipe_lstmin.png)

---

### Temporal operations using time variables

**[t.rast.mapcalc](https://grass.osgeo.org/grass74/manuals/t.rast.mapcalc.html)**
<br>
- Performs spatio-temporal mapcalc expressions
- It allows for *spatial and temporal operators*, as well as *internal variables* in the expression string
- The temporal variables include: *start_time(), end_time(), start_month(), start_doy()*, etc. 

+++?code=code/05_temporal_code.sh&lang=bash&title=Which is the month of the maximum LST?

@[231-236]
@[238-239]
@[241-242]
@[244-249]

@size[20px](**Note**: We could do this year-wise in order to know when the annual max LST occurs and then e.g. assess trends)

+++?code=code/05_temporal_code.sh&lang=bash&title=Display the resulting map from the CLI

@[252-255]
@[257-258]
@[260-261]
@[263-265]
@[267-268]
@[270-271]
@[273-275]

+++

![Month of maximum LST](assets/img/month_max_lst.png)

---

### Temporal aggregation 2: using granularity

**[t.rast.aggregate](https://grass.osgeo.org/grass74/manuals/t.rast.aggregate.html)**
<br>
- Aggregates raster maps in STRDS with different **granularities** 
- *where* option allows to set specific dates for the aggregation
- Different methods available: average, minimum, maximum, median, mode, etc.

+++?code=code/05_temporal_code.sh&lang=bash&title=From monthly to seasonal LST

@[278-284]
@[286-287]
@[289-304]

+++

@size[38px](***Exercise***)
<br><br>
Compare the monthly and sesonal timelines with 
![g.gui.timeline](https://grass.osgeo.org/grass74/manuals/g.gui.timeline.html)
<br>
```bash
g.gui.timeline inputs=LST_Day_monthly_celsius,LST_Day_mean_3month
```

+++?code=code/05_temporal_code.sh&lang=bash&title=Display seasonal LST using frames in wx monitor

@[307-310]
@[312-314]
@[316-320]
@[322-326]
@[328-332]
@[334-338]
@[340-341]

+++

![Sesonal LST by frames](assets/img/frames.png)

@size[26px](3-month average LST in 2015)

---

@size[38px](***Exercise***)
<br><br>
Now that you know [t.rast.aggregate](https://grass.osgeo.org/grass74/manuals/t.rast.aggregate.html), 
extract the month of maximum LST per year and then test if there's any positive or 
negative trend, i.e., if maximum LST values are observed later or earlier with 
time (years)

+++

One solution could be...
<br>
```bash
t.rast.aggregate input=LST_Day_monthly_celsius output=month_maxLST_per_year \
  basename=month_maxLST suffix=gran \
  method=max_raster granularity="1 year" 

t.rast.series input=month_maxLST_per_year output=slope_month_maxLST \
  method=slope
```

---

### Animations

![Animation 3month LST](assets/img/3month_lst_anim_small.gif)

+++?code=code/05_temporal_code.sh&lang=bash&title=Animation of seasonal LST time series

@[344-347]

See [g.gui.animation](https://grass.osgeo.org/grass74/manuals/g.gui.animation.html) manual for further options and tweaks 

---

### Zonal statistics in raster time series

**[v.strds.stats](https://grass.osgeo.org/grass74/manuals/addons/v.strds.stats.html)**
<br>
- Allows to obtain spatially aggregated time series data for polygons in a vector map

+++?code=code/05_temporal_code.sh&lang=bash&title=Extract mean LST for Raleigh (NC) urban area

@[350-353]
@[355-358]
@[360-364]

<!---
@size[20px](This vector map can be read-in in R and plotted with sf and ggplot, for example.)
--->

+++?code=code/05_temporal_code.sh&lang=R&title=Read and plot Raleigh vector in RStudio 

@[367-377]
@[379-380]
@[382-383]

+++

![spplot output](assets/img/spplot_output.png)

+++?code=code/05_temporal_code.sh&lang=R&title=Read and plot Raleigh vector in RStudio

@[385-386]
@[388-394]
@[396-398]

+++

![sf + ggplot output](assets/img/ggplot_output.png)

+++

```R
# with mapview
mapview(raleigh_sf[,6:17])
```

![mapview output](assets/img/mapview.png)

---

## QUESTIONS?

<img src="assets/img/gummy-question.png" width="45%">

---

## Other (very) useful links/resources

- [Temporal data processing wiki](https://grasswiki.osgeo.org/wiki/Temporal_data_processing)
- [GRASS GIS and R for time series processing wiki](https://grasswiki.osgeo.org/wiki/Temporal_data_processing/GRASS_R_raster_time_series_processing)
- [GRASS GIS temporal workshop at NCSU](http://ncsu-geoforall-lab.github.io/grass-temporal-workshop/)
- [TGRASS workshop at FOSS4G Europe 2017](https://gitlab.com/veroandreo/tgrass_workshop_foss4g_eu)
- [GRASS GIS workshop held in Jena 2018](http://training.gismentors.eu/grass-gis-workshop-jena-2018/index.html)

---

## References

- Gebbert, S., Pebesma, E. (2014). *A temporal GIS for field based environmental modeling*. Environmental Modelling & Software, 53, 1-12. [DOI](https://doi.org/10.1016/j.envsoft.2013.11.001)
- Gebbert, S., Pebesma, E. (2017). *The GRASS GIS temporal framework*. International Journal of Geographical Information Science 31, 1273-1292. [DOI](http://dx.doi.org/10.1080/13658816.2017.1306862)

---

**Thanks for your attention!!**

![GRASS GIS logo](assets/img/grass_logo_alphab.png)

<br><br><br><br>

@size[20px](Presentation powered by)

<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>

