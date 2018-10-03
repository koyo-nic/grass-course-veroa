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

# Raster data processing in GRASS GIS

---

### Overview

- Basic raster concepts in GRASS GIS
- Types of raster data
- NULL values
- MASK
- Computational region
- Map calculator
- Reports and Stats
- Landscape analysis

---

### Raster data: Basic concepts in GRASS GIS

> A "raster map" is a data layer consisting of a gridded array of cells. It has a certain number of rows and columns, with a data point (or null value indicator) in each cell. They may exist as a 2D grid or as a 3D cube.

- The geographic boundaries of the raster map are described by the north, south, east, and west fields. 
- The geographic extent of the map is described by the outer bounds of all cells within the map.

[[https://grass.osgeo.org/grass70/manuals/rasterintro.html](https://grass.osgeo.org/grass70/manuals/rasterintro.html)

---

### Raster data precision

- **CELL DATA TYPE:** a raster map of INTEGER type (whole numbers only)
- **FCELL DATA TYPE:** a raster map of FLOAT type (4 bytes, 7-9 digits precision)
- **DCELL DATA TYPE:** a raster map of DOUBLE type (8 bytes, 15-17 digits precision) 

[https://grasswiki.osgeo.org/wiki/GRASS_raster_semantics](https://grasswiki.osgeo.org/wiki/GRASS_raster_semantics)

---

#### General raster rules in GRASS GIS:

- Raster output maps have their bounds and resolution equal to those of the current computational region.
- Raster input maps are automatically cropped/padded and rescaled (using nearest-neighbour resampling) to match the current region.
- Raster input maps are automatically masked if a raster map named MASK exists. The MASK is only applied when reading maps from the disk. 

All r.in.\* programs read the data cell-by-cell, with no resampling

---

### NULL values 

- **NULL:** represents "no data" in raster maps (e.g. gaps in DEM or RS L3 products), to be distinguished from 0 (zero) data value.
- Important: operations on NULL cells lead to NULL cells. 
- NULL values are handled by [r.null](https://grass.osgeo.org/grass74/manuals/r.null.html). 

```bash
# set the nodata value
r.nulls setnull=-9999

# replace nodata by a number 
r.nulls null=256
```

---
			
### Mask

A raster map named MASK can be created to mask out areas: all cells that are NULL in the MASK map will be ignored (also all areas outside the computation region).
	
Masks are set with [r.mask](https://grass.osgeo.org/grass74/manuals/r.mask.html) or creating a raster map called `MASK`. Vector maps can be also used as masks. 

![MASK](assets/img/masks.png)
<br>
@size[18px](Examples of masking: b- Only the raster data inside the masked area are used for further analysis. c- Inverse mask.)

---

#### MASK examples

```bash
# use vector as mask
r.mask vector=lakes
# use vector as mask, set inverse mask
r.mask -i vector=lakes
# mask categories of a raster map
r.mask raster=landclass96 maskcats="5 thru 7"
# remove mask
r.mask -r
```

The mask is only applied when reading an existing GRASS raster map, for example when used in a module as an input map. 

---

### Computational region

![Show computational region](assets/img/region.png)

+++

@color[#8EA33B](**Computational region**) is defined by actual region extent and raster resolution. *It applies to raster operations.* It can be set and changed by means of [g.region](https://grass.osgeo.org/grass74/manuals/g.region.html) to the extent of a vector map, a raster map or manually to some area of interest. 

@color[#8EA33B](**Raster map region**) is defined by map extents and map resolution. Each raster map has its own values. Computational region overrides raster region.

@color[#8EA33B](**Display region**) is the extent of the current map display independent of the current computational region and the raster region. The user can set the current computational region from display region.

---

### Import/export, MASK and computational region

**IMPORT**

r.in.\* modules + r.import: 
The full map is always imported (unless cropping to region is set). Importantly, we can set the region to align with raster resolution (and extent).

**EXPORT**

r.out.\* modules: 
Raster export adheres to computational region (extent and resolution) and respects MASK if present. Nearest neighbour interpolation is applied by default. 

If you want some other form of resampling, first change the region, then explicitly resample the map with e.g. r.resamp.interp or r.resamp.stats, then export the resampled map. 

**Note:** *In import and export, vector maps are always considered completely.*

---

Resampling methods and interpolation methods
GRASS raster map processing is always performed in the current region settings (see g.region), i.e. the current region extent and current raster resolution is used. If the resolution differs from that of the input raster map(s), on-the-fly resampling is performed (nearest neighbor resampling). If this is not desired, the input map(s) has/have to be resampled beforehand with one of the dedicated modules.

---

The following modules are available for re-interpolation of "filled" raster maps (continuous data) to a different resolution:

- r.resample uses the built-in resampling, so it should produce identical results as the on-the-fly resampling done via the raster import modules.
- r.resamp.interp Resampling with nearest neighbor, bilinear, and bicubic method: method=nearest uses the same algorithm as r.resample, but not the same code, so it may not produce identical results in cases which are decided by the rounding of floating-point numbers.
- r.resamp.rst Regularized Spline with Tension (RST) interpolation 2D: Behaves similarly, i.e. it computes a surface assuming that the values are samples at each raster cell's centre, and samples the surface at each region cell's centre.
- r.resamp.bspline Bicubic or bilinear spline interpolation with Tykhonov regularization.
- For r.resamp.stats without -w, the value of each region cell is the chosen aggregate of the values from all of the raster cells whose centres fall within the bounds of the region cell. With -w, the samples are weighted according to the proportion of the raster cell which falls within the bounds of the region cell, so the result is normally unaffected by rounding error.
- r.fillnulls for Regularized Spline with Tension (RST) interpolation 2D for hole filling (e.g., SRTM DEM)

Furthermore, there are modules available for re-interpolation of "sparse" (scattered points or lines) maps:

- Inverse distance weighted average (IDW) interpolation (r.surf.idw)
- Interpolating from contour lines (r.contour)
- Various vector modules for interpolation

---

Raster map statistics

A couple of commands are available to calculate local statistics (r.neighbors), and global statistics (r.statistics, r.surf.area). Univariate statistics (r.univar) and reports are also available (r.report, r.stats, r.volume).

The r.resamp.stats command resamples raster map layers using various aggregation methods, the r.statistics command aggregates one map based on a second map. r.resamp.interp resamples raster map layers using interpolation.

<!--- add example --->

---

Regression analysis
Both linear (r.regression.line) and multiple regression (r.regression.multi) are supported.

<!--- add example --->

---

### Raster algebra

*Raster algebra* (or *raster map algebra*) is probably the most general way of manipulating rasters which is accessible to the user.

<!--- Add screenshot here --->

https://grass.osgeo.org/grass74/manuals/r.mapcalc.html

---

Operators

![Operators](assets/img/r_mapcalc_operators.png)

---

#### neighborhood operator `[ , ]`

Apply low pass filter (smoothing) on a Landsat image using *r.mapcalc*:

```
r.mapcalc "lsat7_2002_10_smooth = (lsat7_2002_10[-1,-1] + lsat7_2002_10[-1,0] + lsat7_2002_10[1,1] + lsat7_2002_10[0,-1] + lsat7_2002_10[0,0] + lsat7_2002_10[0,1] + lsat7_2002_10[1,-1] + lsat7_2002_10[1,0] + lsat7_2002_10[1,1]) / 9"
```

Set the same color table as the original raster map has: 

```
r.colors map=lsat7_2002_10_smooth raster=lsat7_2002_10
```

---

Use Map Swipe to compare original and resulting map. Map Swipe is
available from File menu or using: ``

    g.gui.mapswipe first=lsat7_2002_10 second=lsat7_2002_10_smooth

Note that in this case the same operation which was done using *r.mapcalc* could be done using *r.neighbors* module.

---

Raster map layer values from the category file

Sometimes it is desirable to use a value associated with a category's label instead of the category value itself. If a raster map layer name is preceded by the @ operator, then the labels in the category file for the raster map layer are used in the expression instead of the category value. 

---

Functions

---

NULL handling


---

Raster MASK handling

r.mapcalc follows the common GRASS behavior of raster MASK handling, so the MASK is only applied when reading an existing GRASS raster map. This implies that, for example, the command:

r.mapcalc "elevation_exaggerated = elevation * 3"

create a map respecting the masked pixels if MASK is active.

However, when creating a map which is not based on any map, e.g. a map from a constant:

r.mapcalc "base_height = 200.0"

the created raster map is limited only by a computation region but it is not affected by an active MASK. This is expected because, as mentioned above, MASK is only applied when reading, not when writing a raster map.

If also in this case the MASK should be applied, an if() statement including the MASK should be used, e.g.:

r.mapcalc "base_height = if(MASK, 200.0, null())"

When testing MASK related expressions keep in mind that when MASK is active you don't see data in masked areas even if they are not NULL. See r.mask for details. 

---

EXAMPLES

To compute the average of two raster map layers a and b:

ave = (a + b)/2

To produce a binary representation of the raster map layer a so that category 0 remains 0 and all other categories become 1:

mapmask = a != 0

To mask raster map layer b by raster map layer a:

result = if(a,b)

To change all values below 5 to NULL:

newmap = if(map<5, null(), 5)

---

#### if statement


Let\'s determine forested areas which are higher then certain elevation.
Set computational region (both extent and resolution) to the landclass
raster: 

g.region rast=landclass96

See what are the land classes (raster categories) in the raster: 

r.report map=landclass96 units=p

See also univariate statistics for the elevation raster: 

r.univar map=elevation

Use raster algebra to select areas higher than chosen elevation and with
forest land class: ``

r.mapcalc "forest_high = if(elevation > 120 && landclass96 == 5, 1, null())"

---

### Advanced raster algebra

---

#### `eval` function

If the output of the computation should be only one map but the expression is so complex that it is better to split it to several expressions, the eval function can be used: 
```
r.mapcalc "eval(elev_200 = elevation - 200, elev_5 = 5 * elevation, elev_p = pow(elev_5, 2)); elevation_result = (0.5 * elev_200) + 0.8 * elev_p"
```

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

FOR ANALYSIS ON A MOVING WINDOW

```
# Select the window and create a mask

r.mask vector=Cluster1@garzonc
r.mapcalc expression="Cluster4_withP1 = FragmentsAO_withP1" --o

# Set the config file in the g.gui.rlisetup config window

<!--- screenshot --->

#Compute the landscape metrics

r.li.edgedensity input=FragmentsAO_withP1 config=cluster4 output=cluster4edgeDP1
r.li.shape input=FragmentsAO_withP1 config=cluster4 output=cluster4indexP1
r.li.patchnum input=FragmentsAO_withP1 config=cluster4 output=cluster4fragNumP1
r.li.mps input=FragmentsAO_withP1 config=cluster4 output=cluster4mpsP1

# Remove the mask

r.mask -r

#The results can be found at .grass7/r.li/output
```

---

Hydrology

<!--- add links --->

---

Terrain analysis

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

<!---

Ejercicios (1)

Cargar el raster "zipcodes"
Setear la region a dicho mapa
g.region raster=zipcodes -p
Vamos a elegir una categoria para usar de mascara
r.category zipcodes (O las vemos con la herramienta interactiva)
Seteamos la MASK
r.mask raster=zipcodes maskcats=27605
Mostrar el mapa de nuevo → icono "Render map"
Lo exportamos (r.out.gdal)
Removemos la mascara: r.mask -r

---

Ejercicios

Usamos como valor nulo, la categoria que enmascaramos previamente r.nulls
Aplicamos una mascara vectorial en esta ocasión Vector: lakes
Recargamos el mapa
Lo exportamos
Vemos los dos mapas en QGIS

---

Exercise: Raster rescaling
Changing the range of cell values
GRASS GIS modules:
r.rescale
r.recode
Input elevation: elev_state_500m
Output elevation: elev_state_100m.rescaled
Command:
r.rescale input=elev_state_500m output=elev_state_100m.cubic to=0,100

Exercise: Reclassification
Raster data representing classes or categories
Reclassification by combining classes
Example: land cover / land use

r.category map=landuse96
0 not classified
1 Developed / cultivated
2 Herbaceous
3 Shrubland
4 Forest
5 Water Bodies
6 Unconsolidated Sediment
7 Evergreen Shrubland
8 Deciduous Shrubland
9 Mixed Shrubland
10 Mixed Hardwoods
11 Bottomland Hardwoods/Hardwood Swamps
15 Southern Yellow Pine
18 Mixed Hardwoods/Conifers
20 Water Bodies
21 Unconsolidated Sediment

Reclassify to
0 → 0  not classified
1,2,3  → 1  Developed / cultivated
4,6 → 2  Herbaceous
7,8,9 → 3  Shrubland
10,11,15,18  → 4  Forest
20  →  5  Water Bodies
21  → 6  Unconsolidated Sediment

--->