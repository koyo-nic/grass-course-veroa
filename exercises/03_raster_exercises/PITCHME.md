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

## Raster data in GRASS GIS

---

@snap[north-west span-60]
<h3>Overview</h3>
@snapend

@snap[west span-100]
@ol[list-content-verbose](false)
- Basics about raster maps in GRASS GIS
- NULL values
- MASK
- Computational region
- Map algebra
- Reports and Stats
- Exercises: 
  - Landscape patch analysis
  - Terrain analysis
  - Hydrology analysis
@olend
@snapend

---

### Landscape structure analysis

For the following examples we will use raster `landuse96_28m` from our North Carolina dataset, where patches represent different land cover. We will use module and addons and . Install the addon first:
```
g.extension r.diversity
g.extension r.forestfrag
```
---

**Richness**

First, we compute richness (number of unique classes) using r.neighbors. By using moving window analysis, we create a raster representing spatially variable richness. The window size is in cells.

```
g.region raster=landuse96_28m
r.neighbors input=landuse96_28m output=richness method=diversity size=15
```

---

**Landscape indices**

Addon computes landscape indices using moving window. It is based on modules for landscape structure analysis. In this example, we compute Simpson, Shannon, and Renyi diversity indices with a range of window sizes:

`r.diversity input=landuse96_28m prefix=index alpha=0.8 size=9-21 method=simpson,shannon,renyi`

This generates 9 rasters with names like `index_simpson_size_9`. We can add them to Map Display using *Add multiple raster or vector layers* in Layer manager toolbar (top).

---

For viewing, we should set the same color table for rasters maps of the same index.

```
r.colors map=index_shannon_size_21,index_shannon_size_15,index_shannon_size_9 color=viridis
r.colors map=index_renyi_size_21_alpha_0.8,index_renyi_size_15_alpha_0.8,index_renyi_size_15_alpha_0.8 color=viridis`
# we use grey1.0 color ramp because simpson is from 0-1
r.colors map=index_simpson_size_21,index_simpson_size_15,index_simpson_size_9 color=grey1.0
```

---

**Forest fragmentation** 

Module computes the forest fragmentation following the methodology proposed by [Riitters et al.
(2000)](https://www.ecologyandsociety.org/vol4/iss2/art3/).

First mark all cells which are forest as 1 and everything else as zero:

```
# first set region
g.region raster=landclass96
# list classes:
r.category map=landclass96
# select classes
r.mapcalc "forest = if(landclass96 == 5, 1, 0)"
```

---

Use the new forest presence raster map to compute the forest fragmentation index with window size 15:

```
r.forestfrag input=forest output=fragmentation window=15
```

Report the distribution of the fragmentation categories:

```
r.report map=fragmentation units=k,p
```
---

Distance from forest edge

Use raster map algebra to extract just the given forest class (here 5) from the land classification raster:

r.mapcalc "forest = if(landclass96 == 5, 1, null())"

The if() function we used has three parameters with the following syntax:

if(condition, value used when it is true, value used when it is false)

Then we used operator == which evaluates as true when both sides are equal. Finally we used null() function which represents NULL (no data) value.

Now we can get distance to the edge of the forest using r.grow.distance module which computes distances to areas with values in areas without values (with NULLs) or the other way around. By default it would give us distance to the edge of the forest from outside of the forest, but we are now using the -n flag to obtain distance to the edge from within the forest itself:

r.grow.distance -n input=forest distance=distance

---

### Patch analysis

```
# Set the config file in the g.gui.rlisetup config window

1. Create
2. Name the config file `forest_whole`
3. Select the raster map forest
4. Define the sampling region --> whole map layer
5. Define sample area --> whole map layer

1. Create
2. Name the config file `forest_mov_win`
3. Select the raster map forest
4. Define the sampling region --> whole map layer
5. Define sample area --> moving window 
6. Select shape of mov window --> rectangle --> width=10, height=10

# Compute the landscape metrics using both config files

r.li.edgedensity input=forest config=forest_whole output=forest_edge_full
r.li.shape input=forest config=forest_whole output=forest_shape_full
r.li.patchnum input=forest config=forest_whole output=forest_patchnum_full
r.li.mps input=forest config=forest_whole output=forest_mps_full

r.li.edgedensity input=forest config=forest_mov_win output=forest_edge_mw
r.li.shape input=forest config=forest_mov_win output=forest_shape_mw
r.li.patchnum input=forest config=forest_mov_win output=forest_patchnum_mw
r.li.mps input=forest config=forest_mov_win output=forest_mps_mw

# Notes: 
Do not use absolute path names for the config and output file/map 
parameters. If the "moving window" method was selected in 
g.gui.rlisetup, then the output will be a raster map, otherwise an 
ASCII file will be generated in the folder 
C:\Users\userxy\AppData\Roaming\GRASS7\r.li\output\ (MS-Windows) or 
$HOME/.grass7/r.li/output/ (GNU/Linux). 
```

---

Hydrology: Estimating inundation extent using HAND methodology

In this example we will use some of GRASS GIS hydrology tools, namely:

- r.watershed: for computing flow accumulation, drainage direction, the location of streams and watershed basins; does not need sink filling because of using least-cost-path to route flow out of sinks
- r.lake: fills a lake to a target water level from a given start point or seed raster
- r.lake.series: addon which runs r.lake for different water levels
- r.stream.distance: for computing the distance to streams or outlet, the relative elevation above streams; the distance and the elevation are calculated along watercourses

r.stream.distance and r.lake.series are addons and we need to install them first:

g.extension r.stream.distance
g.extension r.lake.series

We will estimate inundation extent using Height Above Nearest Drainage methodology (A.D. Nobre, 2011). We will compute HAND terrain model representing the differences in elevation between each grid cell and the elevations of the flowpath-connected downslope grid cell where the flow enters the channel.

First we compute the flow accumulation, drainage and streams (with threshold value of 100000). We convert the streams to vector for better visualization.

r.watershed elevation=elevation accumulation=flowacc drainage=drainage stream=streams threshold=100000
r.to.vect input=streams output=streams type=line

Now we use r.stream.distance without output parameter difference to compute new raster where each cell is the elevation difference between the cell and the the cell on the stream where the cell drains.

r.stream.distance stream_rast=streams direction=drainage elevation=elevation method=downstream difference=above_stream

Before we compute the inundation, we will look at how r.lake works. We compute a lake from specified coordinate and water level:

r.lake elevation=elevation water_level=90 lake=lake coordinates=637877,218475

Now instead of elevation raster we use the HAND raster to simulate 5-meter inundation and as the seed we specify the entire stream.

r.lake elevation=above_stream water_level=5 lake=flood seed=streams

With addon r.lake.series we can create a series of inundation maps with rising water levels:

r.lake.series elevation=above_stream start_water_level=0 end_water_level=5 water_level_step=0.5 output=inundation seed_raster=streams

r.lake.series creates a space-time dataset. We can use temporal modules to further work with the data. for example, we could further compute the volume and extent of flood water using t.rast.univar:

t.rast.univar input=inundation separator=comma

Finally, we can visualize the inundation using the Animation Tool.

-    Launch it from menu File - Animation tool.
-    Start with Add new animation and click on Add space-time dataset or series of map layers.
-    In Input data type select Space time raster dataset and below select inundation and press OK.
-    Next we want to add shaded relief as base layer. Use Add raster map layer and select raster elevation_shade from mapset PERMANENT.
-    You can also overlay road network using Add vector map layer and selecting streets_wake from mapset PERMANENT.
-    Select inundation layer and move it above elevation_shade using the toolbar buttons above the layers.
-    Press OK and wait till the animation is rendered. Then press Play button.
-    Animation tool always renders based on the current computational region. If you want to zoom into a specific area, change the region interactively (see how to do it in the intro), or in command line (e.g. g.region n=224690 s=221320 w=640120 e=643520) in the Map Display and in Animation tool press Render map

<!--- add links --->

---

Terrain analysis

r.geomorphon

g.region raster=eu_dem_25m -p
r.geomorphon elevation=eu_dem_25m forms=eu_dem_25m_geomorph

Extraction of summits
Using the resulting terrestial landforms map, single landforms can be extracted, e.g. the summits, and converted into a vector point map:

r.mapcalc expression="eu_dem_25m_summits = if(eu_dem_25m_geomorph == 2, 1, null())"
r.thin input=eu_dem_25m_summits output=eu_dem_25m_summits_thinned
r.to.vect input=eu_dem_25m_summits_thinned output=eu_dem_25m_summits type=point
v.info input=eu_dem_25m_summits

<!--- add links --->

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
[Remote sensing]()
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend
