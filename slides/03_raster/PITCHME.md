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

# Raster processing in GRASS GIS

---

### Overview

-   Basic raster concepts in GRASS GIS
-   NULL values and MASK
-   Region
-   Computational region
-   Raster map import/export
-   FAQ

---

## Raster: conceptos básicos en GRASS
A "raster map" is a data layer consisting of a gridded array of cells. It has a certain number of rows and columns, with a data point (or null value indicator) in each cell. These may exist as a 2D grid or as a 3D cube.

The geographic boundaries of the raster map are described by the north, south, east, and west fields. The geographic extent of the map is described by the outer bounds of all cells within the map.

[Precision de datos raster]{.underline}

- **CELL DATA TYPE:** a raster map of INTEGER type (whole numbers only)
- **FCELL DATA TYPE:** a raster map of FLOAT type (4 bytes, 7-9 digits precision)
- **DCELL DATA TYPE:** a raster map of DOUBLE type (8 bytes, 15-17 digits precision) ●**NULL:** represents \"no data\" in raster maps, to be distinguished from 0 (zero) data value

[[https://grass.osgeo.org/grass70/manuals/rasterintro.html](https://grass.osgeo.org/grass70/manuals/rasterintro.html)

[https://grasswiki.osgeo.org/wiki/GRASS\_raster\_semantics](https://grasswiki.osgeo.org/wiki/GRASS_raster_semantics)

NULL values: 
	no value – no data – unknown raster cell value (e.g. gaps in DEM)
	r.nulls setnull=-9999

MASK (MASKing): 
			
A raster map named MASK can be created to mask out areas:
	all cells that are NULL in the MASK map will be ignored
	(also all areas outside the computation region)
		
Example: Land-ocean map + land map (MASK, land=1) → land-only map

Also possible to use vectors as masks
```
# we mask land and get an ocean map
r.mask -i vect=argentina
```

Computational region or current region
defined by actual region extent and raster resolution
applies to raster operations
it may also affect some vector operations

Raster map region
defined by map extents and map resolution
each raster map has its own values
computational region overrides raster region

Display region
extents of the current map display
independent of the current computational region and the raster region
user can set the current computational region from display region

Locations are defined by projection
transfer maps between locations = map re-projection

Raster map re-projection

User needs to set desired extent and resolution prior 
to re-projection in target location

Vector map re-projection
The whole vector map is re-projected by coordinate conversion

Mechanism:
Working in target location, maps are projected into it 
from the source location

Raster map import/export in GRASS GIS
-------------------------------------

> **IMPORT**
>
> Módulos r.in.\*
>
> r.import (también ofrece reproyección al vuelo)
>
> Siempre se importan los raster completos
>
> **EXPORT**
>
> Modulos r.out.\*
>
> Raster export adheres to computational region (extent and resolution)
> and respec
>
> [Note:]{.underline} In import and export, vector maps are always
> considered completely

Raster algebra
--------------

*Raster algebra* (or *raster map algebra*) is probably the most general
way of manipulating rasters which is accessible to the user.

### if statement

Let\'s determine forested areas which are higher then certain elevation.
Set computational region (both extent and resolution) to the landclass
raster: ``

    g.region rast=landclass96

See what are the land classes (raster categories) in the raster: ``

    r.report map=landclass96 units=p

See also univariate statistics for the elevation raster: ``

    r.univar map=elevation

Use raster algebra to select areas higher than chosen elevation and with
forest land class: ``

    r.mapcalc "forest_high = if(elevation > 120 && landclass96 == 5, 1, null())"

Advanced raster algebra
-----------------------

### `eval` function

If the output of the computation should be only one map but the
expression is so complex that it is better to split it to several
expressions, the eval function can be used: ``

    r.mapcalc "eval(elev_200 = elevation - 200, elev_5 = 5 * elevation, elev_p = pow(elev_5, 2)); elevation_result = (0.5 * elev_200) + 0.8 * elev_p"

### neighborhood operator `[ , ]`

Apply low pass filter (smoothing) on a Landsat image using *r.mapcalc*:
``

    r.mapcalc "lsat7_2002_10_smooth = (lsat7_2002_10[-1,-1] + lsat7_2002_10[-1,0] + lsat7_2002_10[1,1] + lsat7_2002_10[0,-1] + lsat7_2002_10[0,0] + lsat7_2002_10[0,1] + lsat7_2002_10[1,-1] + lsat7_2002_10[1,0] + lsat7_2002_10[1,1]) / 9"

Set the same color table as the original raster map has: ``

    r.colors map=lsat7_2002_10_smooth raster=lsat7_2002_10

Use Map Swipe to compare original and resulting map. Map Swipe is
available from File menu or using: ``

    g.gui.mapswipe first=lsat7_2002_10 second=lsat7_2002_10_smooth

Note that in this case the same operation which was done using
*r.mapcalc* could be done using *r.neighbors* module.

Learn more
----------

-   [Raster data processing in GRASS GIS](http://grass.osgeo.org/grass70/manuals/rasterintro.html) (intro in manual)


FAQ and problems with raster display
------------------------------------

> Q: I don\'t see anything!
>
> A: Typically the computational region is set to an area not covering
> the raster map of interest. U g.region rast=myrastermap -p
>
> Q: I want to subset a raster map!
>
> A: While this is done on the fly by setting the computational region
> properly, you can still creat r.mapcalc \"subset = original\_map\"

FAQ and problems with raster display
------------------------------------

> Q: The resolution of my region is not the one I asked for!
>
> A: Sometimes, the resolution of the computational region is not
> matching exactly the resolution g.region rast=myrastermap res=1 -p
>
> (\...)
>
> Nsres: 0.9993515
>
> ewres: 1.00025576
>
> (\...)
>
> To force the computational region to match the resolution entered, you
> need to use the -a flag: g.region rast=myrastermap res=1 -ap
>
> (\...) nsres: 1
>
> ewres: 1
>
> (\...)

Ejercicios
----------

Imprimimos y definimos la región de distintas maneras

Ejercicios (1)
--------------

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

Ejercicios (2)
--------------

Usamos como valor nulo, la categoria que enmascaramos previamente
r.nulls
Aplicamos una mascara vectorial en esta ocasión Vector: lakes
Recargamos el mapa
Lo exportamos
Vemos los dos mapas en QGIS

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
