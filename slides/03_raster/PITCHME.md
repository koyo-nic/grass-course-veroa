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

## Raster processing in GRASS GIS

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
- Reports and Statistics
@olend
@snapend

---

### Basic raster concepts in GRASS GIS

> A "raster map" is a gridded array of cells. It has a certain number of rows and columns, with a data point (or null value indicator) in each cell. They may exist as a 2D grid or as a 3D cube.

- Boundaries are described by the north, south, east, and west fields. 
- Extent is described by the outer bounds of all cells within the map.

<br>
@size[24px](Further info: <a href="https://grass.osgeo.org/grass70/manuals/rasterintro.html">Raster Intro</a> manual page)

---

### Raster data precision

- **CELL DATA TYPE:** a raster map of INTEGER type (whole numbers only)
- **FCELL DATA TYPE:** a raster map of FLOAT type (4 bytes, 7-9 digits precision)
- **DCELL DATA TYPE:** a raster map of DOUBLE type (8 bytes, 15-17 digits precision) 

<br>
@size[24px](Further info: <a href="https://grasswiki.osgeo.org/wiki/GRASS_raster_semantics">Raster semantics</a> wiki)

---

### General raster rules in GRASS GIS

- **Output** raster maps have their *bounds and resolution equal to those of the computational region*
- **Input** raster maps are automatically *cropped/padded and rescaled to the computational region*
- **Input** raster maps are automatically masked if a raster map named MASK exists.

<br>
**Exception:** All @color[#8EA33B](r.in.*) programs read the data cell-by-cell, with no resampling

---

### NULL values 

- **NULL**: represents "no data" in raster maps (e.g. gaps in DEM or RS products), different from 0 (zero) data value.
- Important: operations on NULL cells lead to NULL cells. 
- NULL values are handled by [r.null](https://grass.osgeo.org/grass74/manuals/r.null.html). 

<br>
```bash
# set the nodata value
r.nulls map=mapname setnull=-9999

# replace NULL by a number 
r.nulls map=mapname null=256
```

---
			
### MASK

A raster map named MASK can be created to mask out areas: all cells that
are NULL in the MASK map will be ignored (also all areas outside the 
computation region).

<br>
Masks are set with [r.mask](https://grass.osgeo.org/grass74/manuals/r.mask.html) or creating a raster map called *MASK*. 

+++

Vector maps can be also used as masks

![MASK](assets/img/masks.png)
<br>
@size[22px](Examples of masking: b- Only the raster data inside the masked area are used for further analysis. c- Inverse mask.)

+++

#### MASK examples

```bash
# use vector as mask
r.mask vector=lakes

# use vector as mask, set inverse mask
r.mask -i vector=lakes

# mask categories of a raster map
r.mask raster=landclass96 maskcats="5 thru 7"

# create a raster named MASK
r.mapcalc expression="MASK = if(elevation < 100, 1, null())"

# remove mask
r.mask -r
```

<br>
@size[22px](**Note**: A mask is only actually applied when reading a GRASS raster map, i.e., when used as input in a module.)

---

### Computational region

![Show computational region](assets/img/region.png)

<br>
@size[22px](It can be set and changed by means of <a href="https://grass.osgeo.org/grass74/manuals/g.region.html">g.region</a> to the extent of a vector map, a raster map or manually to some area of interest.)

+++

- @color[#8EA33B](**Computational region**) is defined by actual region extent and raster resolution. *It applies to raster operations.* 
- @color[#8EA33B](**Raster map region**) is defined by map extents and map resolution. Each raster map has its own values. Computational region overrides raster region.
- @color[#8EA33B](**Display region**) is the extent of the current map display independent of the current computational region and the raster region. 


*User can set the current computational region from display region*

---

### Import/export, MASK and computational region

**IMPORT**

@color[#8EA33B](r.in.\* modules + r.import): 
The full map is always imported (unless cropping to region is set). Importantly, we can set the region to align with raster resolution (and extent).

**EXPORT**

@color[#8EA33B](r.out.\* modules): 
Raster export adheres to computational region (extent and resolution) and respects MASK if present. Nearest neighbour interpolation is applied by default. 

**Note:** *In import and export, vector maps are always considered completely.*

---

### Resampling and interpolation methods

If nearest neighbor resampling is not desired, the input map(s) has/have to be resampled beforehand with one of the dedicated modules.

+++

@snap[west span-100]
@ul[]()
- Downscaling:
@ul[list-content-verbose](false)
- [r.resample](https://grass.osgeo.org/grass74/manuals/r.resample.html): nearest neighbour resampling for discrete data
- [r.resamp.interp](https://grass.osgeo.org/grass74/manuals/r.resamp.interp.html): nearest neighbor, bilinear, and bicubic resampling methods for continuous data
- [r.resamp.rst](https://grass.osgeo.org/grass74/manuals/r.resamp.rst.html): Regularized Spline with Tension (RST) interpolation 2D
@ulend
- Upscaling:
@ul[list-content-verbose](false)
- [r.resamp.stats](https://grass.osgeo.org/grass74/manuals/r.resamp.stats.html): Resamples raster map layers to a coarser grid using aggregation
- [r.resamp.rst](https://grass.osgeo.org/grass74/manuals/r.resamp.rst.html): Regularized Spline with Tension (RST) interpolation 2D
@ulend
- Gap-filling 2D:
@ul[list-content-verbose](false)
- [r.fillnulls](https://grass.osgeo.org/grass74/manuals/r.fillnulls.html): Regularized Spline with Tension (RST) interpolation 2D for gap-filling (e.g., SRTM DEM)
- [r.resamp.bspline](https://grass.osgeo.org/grass74/manuals/r.resamp.bspline.html): Bicubic or bilinear spline interpolation with Tykhonov regularization
- [r.resamp.tps](https://grass.osgeo.org/grass7/manuals/addons/r.resamp.tps.html): thin plate spline interpolation with regularization and covariables
@ulend
@ulend
@snapend

---

### Raster map reports and statistics

A couple of commands are available to calculate local statistics (r.neighbors), and global statistics (r.statistics, r.surf.area). 
Univariate statistics (r.univar) and reports are also available (r.report, r.stats, r.volume).

r.coin

<!--- add example --->

---

### Regression analysis

Both linear (r.regression.line) and multiple regression (r.regression.multi) are supported.

<!--- add example --->

---

### Raster map algebra

[r.mapcalc](https://grass.osgeo.org/grass74/manuals/r.mapcalc.html)

![r.mapcalc GUI](assets/img/r_mapcalc_gui.png)

+++

Operators

![Operators](assets/img/r_mapcalc_operators.png)

+++

#### Neighborhood operator **[ , ]**

Apply low pass filter (smoothing) on a Landsat image

```bash
r.mapcalc expression="lsat7_2002_10_smooth = (lsat7_2002_10[-1,-1] + lsat7_2002_10[-1,0] + lsat7_2002_10[1,1] + lsat7_2002_10[0,-1] + lsat7_2002_10[0,0] + lsat7_2002_10[0,1] + lsat7_2002_10[1,-1] + lsat7_2002_10[1,0] + lsat7_2002_10[1,1]) / 9"
```

Set the same color table as the original raster map has: 

```
r.colors map=lsat7_2002_10_smooth raster=lsat7_2002_10
```

+++

![Neighbourhood operator](assets/img/neighbour_operator_mapswipe.png)

<br>
```bash
g.gui.mapswipe first=lsat7_2002_10 second=lsat7_2002_10_smooth
```

+++

Functions

![Functions](assets/img/r_mapcalc_functions.png)

+++

#### if statement

Let\'s determine forested areas which are higher then certain elevation.

```bash
# set region
g.region rast=landclass96

# report of land classes
r.report map=landclass96 units=p

# univariate statistics for elevation
r.univar map=elevation

# select areas higher than chosen elevation and with forest land class:
r.mapcalc "forest_high = if(elevation > 120 && landclass96 == 5, 1, null())"
```
<!---

### Advanced raster algebra

#### `eval` function

If the output of the computation should be only one map but the expression is so complex that it is better to split it to several expressions, the eval function can be used: 

```bash
r.mapcalc "eval(elev_200 = elevation - 200, 
				elev_5 = 5 * elevation, 
				elev_p = pow(elev_5, 2)); 
				elevation_result = (0.5 * elev_200) + 0.8 * elev_p"
```
--->

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
[Raster exercises](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=exercises/03_raster_exercises&grs=gitlab#/)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend

<!---

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
