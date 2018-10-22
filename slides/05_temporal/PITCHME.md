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

## Spatio-temporal data processing & visualization in GRASS GIS

---

@color[#8EA33B](GRASS GIS) is **the first Open Source GIS** that incorporated
capabilities to **manage, analyze, process and visualize spatio-temporal
data**, as well as the temporal relationships among time series.

+++

## The TGRASS framework

@ul
- TGRASS is the temporal enabled GRASS GIS designed to easily handle time series data
- TGRASS is fully @color[#8EA33B](based on metadata) and does not duplicate any dataset
- @color[#8EA33B](Snapshot) approach, i.e., adds time stamps to maps
- A collection of time stamped maps (snapshots) of the same variable are called @color[#8EA33B](space-time datasets or STDS)
- Maps in a STDS can have different spatial and temporal extents
@ulend

<!---
TGRASS uses an SQL database to store the temporal and spatial extension
of STDS, as well as the topological relationships among maps and among
STDS in each mapset.
--->

+++

## Space-time datasets

- Space time raster datasets (**ST@color[#8EA33B](R)DS**)
- Space time 3D raster datasets (**ST@color[#8EA33B](R3)DS**)
- Space time vector datasets (**ST@color[#8EA33B](V)DS**)

+++

## Other TGRASS notions

@ul
- Time can be defined as @color[#8EA33B](intervals) (start and end time) or @color[#8EA33B](instances) (only start time)
- Time can be @color[#8EA33B](absolute) (e.g., 2017-04-06 22:39:49) or @color[#8EA33B](relative) (e.g., 4 years, 90 days)
- @color[#8EA33B](Granularity) is the greatest common divisor of the temporal extents (and possible gaps) of all maps in the space-time cube
@ulend

+++

### Other TGRASS notions

- @color[#8EA33B](Topology) refers to temporal relations between time intervals in a STDS.

<img src="assets/img/temp_relation.png">

+++

### Other TGRASS notions

- @color[#8EA33B](Temporal sampling) is used to determine the state of one process during a second process.

<img src="assets/img/temp_samplings.png" width="55%">

+++

## Spatio-temporal modules

- @color[#8EA33B](**t.\***): General modules to handle STDS of all types
- @color[#8EA33B](**t.rast.\***): Modules that deal with STRDS
- @color[#8EA33B](**t.rast3d.\***): Modules that deal with STR3DS
- @color[#8EA33B](**t.vect.\***): Modules that deal with STVDS

+++

## TGRASS framework and workflow

+++?image=assets/img/tgrass_flowchart.png&position=center&size=auto 93%

---

## Hands-on to raster time series in GRASS GIS

---

### Let's first get the data and the code to follow this session
<br>
- [modis_lst mapset (2Mb)](https://gitlab.com/veroandreo/grass-gis-geostat-2018/blob/master/data/modis_lst.zip): download and unzip within the North Carolina location in 
`$HOME/grassdata/nc_spm_08_grass7`
- [GRASS code](https://gitlab.com/veroandreo/curso-grass-gis-rioiv/raw/master/code/05_temporal_code.sh?inline=false)
- [R code](https://gitlab.com/veroandreo/curso-grass-gis-rioiv/raw/master/code/05_temporal_code.r?inline=false)

... and start GRASS GIS

```bash
grass74 $HOME/grassdata/nc_spm_08_grass7/modis_lst --gui
```

---?code=code/05_temporal_code.sh&lang=bash&title=Set computational region and apply MASK

@[32-40](List raster maps and get info)
@[43-61](Set region)
@[63-67](Set MASK)

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

@[70-75](Create the STRDS)
@[77-78](Check if the STRDS is created)
@[80-81](Get info about the STRDS)

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

@[84-89](Add time stamps to maps, i.e., register maps)
@[91-94](Add time stamps to maps, i.e., register maps)
@[96-97](Check info again)
@[99-100](Check the list of maps in the STRDS)
@[102-103](Check min and max per map)

@size[20px](For more options, check the <a href="https://grass.osgeo.org/grass74/manuals/t.register.html">t.register</a> manual and related <a href="https://grasswiki.osgeo.org/wiki/Temporal_data_processing/maps_registration">map registration wiki</a> page.)

+++?code=code/05_temporal_code.sh&lang=bash&title=Graphical Representation of the STRDS

@[106-107](Graphical representation of the time series)

+++

<img src="assets/img/g_gui_timeline_monthly.png" width="70%">

@size[24px](See <a href="https://grass.osgeo.org/grass74/manuals/g.gui.timeline.html">g.gui.timeline</a> manual page)

---

@snap[north span-100]
<h3>Operations with temporal algebra</h3>
@snapend

@snap[south list-content-verbose span-100]
**[t.rast.algebra](https://grass.osgeo.org/grass74/manuals/t.rast.algebra.html)**
<br><br>
@ul[](false)
- Performs a wide range of temporal and spatial map algebra operations based on map's temporal topology 
@ul[](false)
  - Temporal operators: union, intersection, etc.
  - Temporal functions: *start_time()*, *start_doy()*, etc.
  - Spatial operators (subset of [r.mapcalc](https://grass.osgeo.org/grass74/manuals/r.mapcalc.html))
  - Temporal neighbourhood modifier: *[x,y,t]*
  - Other temporal functions like *tsnap()*, *buff_t()* or *tshift()*
@ulend
@ulend
**@size[30px](they can be combined in complex expressions!!)**
@snapend

+++?code=code/05_temporal_code.sh&lang=bash&title=From K*50 to Celsius using the temporal calculator

@[110-114](Re-scale data to degrees Celsius)
@[116-117](Check info)

+++?code=code/05_temporal_code.sh&lang=bash&title=Time series plot

@[126-128](LST time series plot for the city center of Raleigh)
@[130-135](New features in upcoming grass76)

@size[20px](For a single point, see <a href="https://grass.osgeo.org/grass74/manuals/g.gui.tplot.html">g.gui.tplot</a>. For a vector of points, see <a href="https://grass.osgeo.org/grass74/manuals/t.rast.what.html">t.rast.what</a>.)

+++

<img src="assets/img/g_gui_tplot_final.png" width="80%">

@size[24px](Point coordinates can be typed directly, copied from the map display and pasted or directly chosen from the main map display.)

---

#### Lists and selections

- **[t.list](https://grass.osgeo.org/grass74/manuals/t.list.html)** for listing STDS and maps registered in the temporal database,
- **[t.rast.list](https://grass.osgeo.org/grass74/manuals/t.rast.list.html)** for maps in raster time series, and
- **[t.vect.list](https://grass.osgeo.org/grass74/manuals/t.vect.list.html)** for maps in vector time series.

<!--- list of variables to use for query 
id, name, creator, mapset, temporal_type, creation_time, start_time, end_time, north, south, west, east, nsres, ewres, cols, rows, number_of_cells, min, max
id, name, layer, creator, mapset, temporal_type, creation_time, start_time, end_time, north, south, west, east, points, lines, boundaries, centroids, faces, kernels, primitives, nodes, areas, islands, holes, volumes
--->

+++?code=code/05_temporal_code.sh&lang=bash&title=Listing examples

@[140-151](Maps with minimum value lower than or equal to 5)
@[153-166](Maps with maximum value higher than 30)
@[168-176](Maps between two given dates)
@[178-185](Maps from January)

---?code=code/05_temporal_code.sh&lang=bash&title=Descriptive statistics of LST time series

@[188-198](Print univariate stats for maps within STRDS)
@[200-201](Get extended statistics)
@[203-205](Write the univariate stats output to a csv file)

---

### Temporal aggregation 1: Using the full time series

**[t.rast.series](https://grass.osgeo.org/grass74/manuals/t.rast.series.html)**
<br>
- Aggregates full STRDS or parts of it using the *where* option
- Different methods available: average, minimum, maximum, median, mode, etc.

+++?code=code/05_temporal_code.sh&lang=bash&title=Maximum and minimum LST in the past 3 years

@[208-212](Get maximum LST in the STRDS)
@[214-216](Get minimum LST in the STRDS)
@[218-219](Change color pallete to celsius)

+++?code=code/05_temporal_code.sh&lang=bash&title=Compare maps with the Mapswipe tool

@[222-228](Display the new maps with mapswipe and compare them to elevation)

+++

![mapswipe and lst max](assets/img/g_gui_mapswipe_lstmax.png)

+++

![mapswipe and lst min](assets/img/g_gui_mapswipe_lstmin.png)

---

### Temporal operations using time variables

**[t.rast.mapcalc](https://grass.osgeo.org/grass74/manuals/t.rast.mapcalc.html)**
<br>
- Performs spatio-temporal mapcalc expressions
- It allows for *spatial and temporal operators*, as well as *internal variables* in the expression string
- The temporal variables include: *start_time(), end_time(), start_month(), start_doy()*, etc. 

+++

The supported internal variables for the STRDS:

- td(), start_time(), end_time()

The supported internal variables for the current sample interval or instance:

- start_doy(), start_dow(), start_year(), start_month(), start_week(),
 start_day(), start_hour(), start_minute(), start_second()

... and the same for *end_**

+++?code=code/05_temporal_code.sh&lang=bash&title=Which is the month of the maximum LST?

@[231-236](Get month of maximum LST)
@[238-239](Get basic info)
@[241-242](Get the earliest month in which the maximum appeared)
@[244-249](Remove month_max_lst strds)

@size[24px](We could do this year-wise to know when the annual max LST occurs and assess trends)

+++?code=code/05_temporal_code.sh&lang=bash&title=Display the resulting map from the CLI

@[252-255](Open a monitor)
@[257-258](Display raster map)
@[260-261](Display only boundary of vector map)
@[263-265](Add raster legend)
@[267-268](Add scale bar)
@[270-271](Add North arrow)
@[273-275](Add title text)

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

@[278-284](3-month mean LST)
@[286-287](Check info)
@[289-304](Check map list)

+++

> **Task**: Compare the monthly and sesonal timelines with [g.gui.timeline](https://grass.osgeo.org/grass74/manuals/g.gui.timeline.html)

<!---
```bash
g.gui.timeline inputs=LST_Day_monthly_celsius,LST_Day_mean_3month
```
--->

+++?code=code/05_temporal_code.sh&lang=bash&title=Display seasonal LST using frames in wx monitor

@[307-310](Set STRDS color table to celsius degrees)
@[312-314](Start a new cairo monitor)
@[316-320](Create first frame)
@[322-326](Create second frame)
@[328-332](Create third frame)
@[334-338](Create fourth frame)
@[340-341](Release monitor)

+++

![Sesonal LST by frames](assets/img/frames.png)

@size[24px](3-month average LST in 2015)

---

> **Task**: Now that you know [t.rast.aggregate](https://grass.osgeo.org/grass74/manuals/t.rast.aggregate.html), 
> extract the month of maximum LST per year and then test if there's any positive or 
> negative trend, i.e., if maximum LST values are observed later or earlier with time (years)

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

@[344-347](Animation of seasonal LST)

@size[20px](See <a href="https://grass.osgeo.org/grass74/manuals/g.gui.animation.html">g.gui.animation</a> manual for further options and tweaks)

---

@snap[north span-100]
<h3>Aggregation vs Climatology</h3>
@snapend

@snap[west span-45]
<img src="assets/img/aggregation.png">
<br>
Granularity aggregation
@snapend

@snap[east span-55]
<img src="assets/img/climatology.png">
<br>
Climatology aggregation
@snapend

+++?code=code/05_temporal_code.sh&lang=bash&title=Monthly climatologies

@[352-355](January average LST)
@[357-362](Climatology for all months)

+++

> **Task**: Compare monthly means with "climatological" means

---

### Annual anomalies
<br>

`\[
Std_Anomaly_i = \frac{Average_i - Average}{SD}
\]`

<br>
- We need overall average and standard deviation
- We need yearly averages

+++?code=code/05_temporal_code.sh&lang=bash&title=Annual anomalies

@[367-369](Get general average)
@[371-373](Get general SD)
@[375-378](Get annual averages)
@[380-382](Estimate annual anomalies)
@[384-385](Set color table)
@[387-388](Animation)

+++

![Anomalies animation](assets/img/LST_anomalies.gif)

---

### Zonal statistics in raster time series

**[v.strds.stats](https://grass.osgeo.org/grass7/manuals/addons/v.strds.stats.html)**
<br>
- Allows to obtain spatially aggregated time series data for polygons in a vector map

+++?code=code/05_temporal_code.sh&lang=bash&title=Extract mean LST for Raleigh (NC) urban area

@[393-394](Install v.strds.stats add-on)
@[396-399](Extract seasonal average LST for Raleigh urban area)
@[401-402](Save the attribute table of the new vector into a csv file)

+++?code=code/05_temporal_code.r&lang=r&title=Read and plot Raleigh vector in RStudio 

@[9-10](Call RStudio)
@[12-17](Load libraries)
@[19-20](Read vector raleigh_aggr_lst)
@[22-23](Use sp tools to plot vector map)

+++

![spplot output](assets/img/spplot_output.png)

+++?code=code/05_temporal_code.r&lang=r&title=Read and plot Raleigh vector in RStudio

@[25-26](Convert from sp to sf)
@[28-34](Gather the table into season and mean LST (we do only 2015))
@[36-38](Plot sf object with ggplot)

+++

![sf + ggplot output](assets/img/ggplot_output.png)

+++?code=code/05_temporal_code.r&lang=r&title=Read and plot Raleigh vector in RStudio

@[40-41](Plot vector over basemap with mapview)

+++

![mapview output](assets/img/mapview.png)

---

## QUESTIONS?

<img src="assets/img/gummy-question.png" width="45%">

---

## Other (very) useful resources

- [Temporal data processing wiki](https://grasswiki.osgeo.org/wiki/Temporal_data_processing)
- [GRASS GIS and R for time series processing wiki](https://grasswiki.osgeo.org/wiki/Temporal_data_processing/GRASS_R_raster_time_series_processing)
- [GRASS GIS temporal workshop at NCSU](http://ncsu-geoforall-lab.github.io/grass-temporal-workshop/)
- [TGRASS workshop at FOSS4G Europe 2017](https://gitlab.com/veroandreo/tgrass_workshop_foss4g_eu)
- [GRASS GIS workshop held in Jena 2018](http://training.gismentors.eu/grass-gis-workshop-jena-2018/index.html)
- [GRASS GIS course IRSAE 2018](http://training.gismentors.eu/grass-gis-irsae-winter-course-2018/index.html)

---

## References

- Gebbert, S., Pebesma, E. (2014). *A temporal GIS for field based environmental modeling*. Environmental Modelling & Software, 53, 1-12. [DOI](https://doi.org/10.1016/j.envsoft.2013.11.001)
- Gebbert, S., Pebesma, E. (2017). *The GRASS GIS temporal framework*. International Journal of Geographical Information Science 31, 1273-1292. [DOI](http://dx.doi.org/10.1080/13658816.2017.1306862)

---

**Thanks for your attention!!**

![GRASS GIS logo](assets/img/grass_logo_alphab.png)

---

@snap[north span-90]
<br><br><br>
Move on to: 
<br>
[Exercise: Hands-on to NDVI time series](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=exercises/05_ndvi_time_series&grs=gitlab#/)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend
