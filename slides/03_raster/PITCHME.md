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

## Raster data processing in GRASS GIS

---

@snap[north-west span-60]
<h3>Overview</h3>
@snapend

@snap[west span-100]
<br>
@ol[list-content-verbose]
- Basics about raster maps in GRASS GIS
- NULL values
- MASK
- Computational region
- Resampling and interpolation methods
- Reports and Statistics
- Regresion analysis
- Map algebra
@olend
@snapend

---

### Basic raster concepts in GRASS GIS

> A "raster map" is a gridded array of cells. It has rows and columns, with a data point (or null value indicator) in each cell. They may exist as 2D grids or 3D cubes.

- Boundaries are described by the north, south, east, and west fields. 
- Extent is described by the outer bounds of all cells within the map.

@size[20px](Further info: <a href="https://grass.osgeo.org/grass70/manuals/rasterintro.html">Raster Intro</a> manual page)

+++

### Raster data precision

- **CELL DATA TYPE:** a raster map of INTEGER type (whole numbers only)
- **FCELL DATA TYPE:** a raster map of FLOAT type (4 bytes, 7-9 digits precision)
- **DCELL DATA TYPE:** a raster map of DOUBLE type (8 bytes, 15-17 digits precision) 

@size[22px](Further info: <a href="https://grasswiki.osgeo.org/wiki/GRASS_raster_semantics">Raster semantics</a> wiki)

+++

### General raster rules in GRASS GIS

- @color[#8EA33B](**Output**) raster maps have their *bounds and resolution equal to those of the computational region*
- @color[#8EA33B](**Input**) raster maps are automatically *cropped/padded and rescaled to the computational region*
- @color[#8EA33B](**Input**) raster maps are automatically masked if a raster map named *MASK* exists.

**Exception:** All @color[#8EA33B](r.in.*) programs read the data cell-by-cell, with no resampling

---

### NULL values 

- **NULL**: represents "no data" in raster maps, different from 0 (zero) data value.
- Operations on NULL cells lead to NULL cells
- NULL values are handled by [r.null](https://grass.osgeo.org/grass74/manuals/r.null.html). 

<br>
```bash
# set the nodata value
r.null map=mapname setnull=-9999

# replace NULL by a number 
r.null map=mapname null=256
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
@size[22px](a- Elevation raster and lakes vector maps. b- Only the raster data inside the masked area are used for further analysis. c- Inverse mask.)

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

@size[22px](**Note**: A mask is only actually applied when reading a GRASS raster map, i.e., when used as input in a module.)

---

### Computational region

![Show computational region](assets/img/region.png)

@size[26px](It can be set and changed by means of <a href="https://grass.osgeo.org/grass74/manuals/g.region.html">g.region</a> to the extent of a vector map, a raster map or manually to some area of interest.)

+++

- @color[#8EA33B](**Computational region**) is defined by actual region extent and raster resolution. *It applies to raster operations.* 
- @color[#8EA33B](**Raster map region**) is defined by map extents and map resolution. Each raster map has its own values. Computational region overrides raster region.
- @color[#8EA33B](**Display region**) is the extent of the current map display independent of the current computational region and the raster region. 

@size[26px](*User can set the current computational region from display region*)

---

### Import/export, MASK and region

- @color[#8EA33B](r.in.\* modules + r.import): 
The full map is always imported (unless cropping to region is set). Importantly, we can set the region to align with raster resolution (and extent).
- @color[#8EA33B](r.out.\* modules): 
Raster export adheres to computational region (extent and resolution) and respects MASK if present. Nearest neighbour interpolation is applied by default. 

@size[26px](**Note:** *In import and export, vector maps are always considered completely.*)

---

### Resampling and interpolation methods

<br><br>

@size[26px](See <a href="https://grasswiki.osgeo.org/wiki/Interpolation">Interpolation</a> wiki page)

+++

@snap[west span-100]
@ul[]()
- Downscaling:
@ul[list-content-verbose](false)
- [r.resample](https://grass.osgeo.org/grass74/manuals/r.resample.html): nearest neighbour resampling for discrete data
- [r.resamp.interp](https://grass.osgeo.org/grass74/manuals/r.resamp.interp.html): nearest neighbor, bilinear, and bicubic resampling methods for continuous data
- [r.resamp.rst](https://grass.osgeo.org/grass74/manuals/r.resamp.rst.html): Regularized Spline with Tension (RST) interpolation 2D
@ulend
@ulend
@snapend

+++

@snap[west span-100]
@ul[]()
- Upscaling:
@ul[list-content-verbose](false)
- [r.resamp.stats](https://grass.osgeo.org/grass74/manuals/r.resamp.stats.html): Resamples raster map layers to a coarser grid using aggregation
- [r.resamp.rst](https://grass.osgeo.org/grass74/manuals/r.resamp.rst.html): Regularized Spline with Tension (RST) interpolation 2D
@ulend
@ulend
@snapend

+++

@snap[west span-100]
@ul[]()
- Gap-filling 2D:
@ul[list-content-verbose](false)
- [r.fillnulls](https://grass.osgeo.org/grass74/manuals/r.fillnulls.html): Regularized Spline with Tension (RST) interpolation 2D for gap-filling (e.g., SRTM DEM)
- [r.resamp.bspline](https://grass.osgeo.org/grass74/manuals/r.resamp.bspline.html): Bicubic or bilinear spline interpolation with Tykhonov regularization
- [r.resamp.tps](https://grass.osgeo.org/grass7/manuals/addons/r.resamp.tps.html): Thin Plate Spline interpolation with regularization and covariables
@ulend
@ulend
@snapend

+++

Note that there are also methods to interpolate sparse vector data and obtain continuous surfaces

---

### Raster map reports and statistics

+++

- [r.report](https://grass.osgeo.org/grass74/manuals/r.report.html): reports area and cell numbers
- [r.coin](https://grass.osgeo.org/grass74/manuals/r.coin.html): reports coincidence of two raster map layers
- [r.volume](https://grass.osgeo.org/grass74/manuals/r.volume.html): estimates volume for clumps
- [r.surf.area](https://grass.osgeo.org/grass74/manuals/r.surf.area.html): estimates area of a raster map

<br>
```bash
r.report map=zipcodes,landclass96 units=h,p
r.coin first=zipcodes second=landclass96 units=p

```

+++

- [r.univar](https://grass.osgeo.org/grass74/manuals/r.univar.html): calculates univariate statistics from the non-null cells of a raster map.
- [r.stats](https://grass.osgeo.org/grass74/manuals/r.stats.html): calculates the area present in each of the categories or intervals of a raster map
- [r.statistics](https://grass.osgeo.org/grass74/manuals/r.statistics.html) and [r.stats.zonal](https://grass.osgeo.org/grass74/manuals/r.stats.zonal.html): zonal statistics
- [r.neighbors](https://grass.osgeo.org/grass74/manuals/r.neighbors.html): local stats based in neighbors

<br>
```bash
# univar stats
r.univar map=elevation

# average elevation in zipcode areas
r.stats.zonal base=zipcodes cover=elevation method=average 
  output=zipcodes_elev_avg
```

---

### Regression analysis

Both linear ([r.regression.line](https://grass.osgeo.org/grass74/manuals/r.regression.line.html)) 
and multiple regression ([r.regression.multi](https://grass.osgeo.org/grass74/manuals/r.regression.multi.html))
are supported

<br>
```bash
# linear regression
g.region raster=elev_srtm_30m -p
r.regression.line mapx=elev_ned_30m mapy=elev_srtm_30m 

# multiple linear regression
g.region raster=soils_Kfactor -p
r.regression.multi mapx=elevation,aspect,slope mapy=soils_Kfactor \
  residuals=soils_Kfactor.resid estimates=soils_Kfactor.estim
```

---

### Raster map algebra

[r.mapcalc](https://grass.osgeo.org/grass74/manuals/r.mapcalc.html)

<img src="assets/img/r_mapcalc_gui.png" width="50%">

+++

Operators

![Operators](assets/img/r_mapcalc_operators.png)

+++

#### Neighborhood operator **[row,col]**


```bash
# example of a low pass filter
r.mapcalc \
expression="lsat7_2002_10_smooth = (lsat7_2002_10[-1,-1] + 
									lsat7_2002_10[-1,0] + 
									lsat7_2002_10[1,1] + 
									lsat7_2002_10[0,-1] + 
									lsat7_2002_10[0,0] + 
									lsat7_2002_10[0,1] + 
									lsat7_2002_10[1,-1] + 
									lsat7_2002_10[1,0] + 
									lsat7_2002_10[1,1]) / 9"
```

+++

<img src="assets/img/neighbour_operator_mapswipe.png" width="75%">


```bash
g.gui.mapswipe first=lsat7_2002_10 second=lsat7_2002_10_smooth
```

+++

Functions

<img src="assets/img/r_mapcalc_functions.png" width="50%">

+++

#### if statement

Determine the forested areas located above a certain elevation


```bash
# set region
g.region rast=landclass96

# report of land classes
r.report map=landclass96 units=p

# univariate statistics for elevation
r.univar map=elevation

# select areas higher 120m and with forest land class:
r.mapcalc expression="forest_high = \
  if(elevation > 120 && landclass96 == 5, 1, null())"
```

---

### Advanced raster algebra

#### `eval` function

When the output of the computation should be only one map but the expression is so complex that it is better to split it to several expressions: 

```bash
r.mapcalc expression= "eval(elev_200 = elevation - 200, 
							elev_5 = 5 * elevation, 
							elev_p = pow(elev_5, 2)); 
							elevation_result = (0.5 * elev_200) + 0.8 * elev_p"
```

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
[Exercise 3: Landscape, hydrology and terrain analysis](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=exercises/03_raster_exercises&grs=gitlab#/)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend
