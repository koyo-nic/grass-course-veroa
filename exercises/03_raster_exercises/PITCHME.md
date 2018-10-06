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

## Exercises with raster data

---

@snap[north-west span-60]
<h3>Overview</h3>
@snapend

@snap[west span-100]
@ol[](false)
- Landscape structure and forest fragmentation
- Hydrology analysis
- Terrain analysis
@olend
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Landscape structure analysis and forest fragmentation

+++?code=code/03_raster_code.sh&lang=bash&title=Landscape structure and forest fragmentation

@[16-18](Install addons)

+++?code=code/03_raster_code.sh&lang=bash&title=Richness and Diversity

@[20-22](Estimate richness - The window size is in cells)
@[24-25](Compute Simpson, Shannon, and Renyi diversity indices)
@[27-31](Make colors comparable)

+++

> **Task**: Add all maps to Map Display using *Add multiple raster or vector layers* in Layer manager toolbar (top).

<br>
- How do different indices compare to each other?
- How does changing window size affect diversity measure?

+++

Forest fragmentation
<br><br>
We'll use the addon [r.forestfrag](https://grass.osgeo.org/grass7/manuals/addons/r.forestfrag.html) 
that computes the forest fragmentation following the methodology proposed by [Riitters et al.
(2000)](https://www.ecologyandsociety.org/vol4/iss2/art3/).

+++?code=code/03_raster_code.sh&lang=bash&title=Forest fragmentation

@[39-40](Set the computational region)
@[42-43](List the classes in LULC map)
@[45-46](Create new map with forest class only)
@[48-49](Compute the forest fragmentation index)
@[51-52](Report the distribution of fragmentation categories)

+++

> **Task**: Explore the effect of different window sizes over fragmentation categories.

<br>
Further details: [blog about r.forestfrag](https://pvanb.wordpress.com/2016/03/25/update-of-r-forestfrag-addon/)

+++?code=code/03_raster_code.sh&lang=bash&title=Distance from forest edge

@[60-61](Create new map with forest class only - note null function)
@[63-65](Get distance from center to forest edge - note -n flag )

+++

> **Task**: Display raster map obtained and get univariate statistics

+++

@snap[north span-100]
Landscape patch analysis
<br>
Set the config file in the [g.gui.rlisetup](https://grass.osgeo.org/grass74/manuals/g.gui.rlisetup.html) config window
@snapend

@snap[west span-45]
<br>
@ol[list-content-verbose](false)
- Hit "Create" and name the config file *forest_whole*
- Select the raster map forest
- Define the sampling region --> whole map layer
- Define sample area --> whole map layer
@olend
@snapend

@snap[east span-55]
<br><br>
@ol[list-content-verbose](false)
- Hit Create and name the config file *forest_mov_win*
- Select the raster map forest
- Define the sampling region --> whole map layer
- Define sample area --> moving window 
- Select shape of mov window --> rectangle --> width=10, height=10
@olend
@snapend

+++?code=code/03_raster_code.sh&lang=bash&title=Landscape patch analysis

@[90-91](Compute edge density for the whole area)
@[92-93](Compute shape index for the whole area)
@[94-95](Compute patch number for the whole area)
@[96-97](Compute mean patch size for the whole area)

+++

> **Task**: Now, do the same for the moving window case and compare outputs and results.

<br>
For an overview of r.li.* modules see: [r.li](https://grass.osgeo.org/grass74/manuals/r.li.html) manual

+++

**Notes**: 
<br><br>
If the "moving window" method was selected in g.gui.rlisetup, 
the output will be a raster map, otherwise an ASCII file will be 
generated in the folder C:\Users\userxy\AppData\Roaming\GRASS7\r.li\output\ (MS-Windows)
or $HOME/.grass7/r.li/output/ (GNU/Linux). 

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Hydrology: Estimating inundation extent using HAND methodology

+++

- [r.watershed](https://grass.osgeo.org/grass74/manuals/r.watershed.html): for computing flow accumulation, drainage direction, the location of streams and watershed basins
- [r.lake](https://grass.osgeo.org/grass74/manuals/r.lake.html): fills a lake to a target water level from a given start point or seed raster
- [r.lake.series](https://grass.osgeo.org/grass7/manuals/addons/r.lake.series.html): addon which runs r.lake for different water levels
- [r.stream.distance](https://grass.osgeo.org/grass7/manuals/addons/r.stream.distance.html): for computing the distance to streams or outlet, the relative elevation above streams

<!---
We will estimate inundation extent using Height Above Nearest Drainage methodology (A.D. Nobre, 2011). 
We will compute HAND terrain model representing the differences in elevation between each grid cell 
and the elevations of the flowpath-connected downslope grid cell where the flow enters the channel.
--->

+++?code=code/03_raster_code.sh&lang=bash&title=Inundation extent using HAND methodology

@[114-116](Install required addons)
@[118-120](Compute the flow accumulation, drainage and streams)
@[122-123](Convert the streams to vector for better visualization)
@[125-128](Compute height difference between cell and cell on the stream)

+++?code=code/03_raster_code.sh&lang=bash&title=How does r.lake works?

@[130-131](Compute a lake from specified coordinates and water level)

+++

> **Task**: Display lake map over elevation map

+++?code=code/03_raster_code.sh&lang=bash&title=Inundation extent using HAND methodology

@[138-139](Simulate 5-meter inundation from the streams)
@[141-145](Create a series of inundation maps with rising water level)
@[147-148](Get volume and extent of flood for each time step)
@[150-151](Create an animation with the output of r.lake.series)

+++

@snap[north span-100]
Create animation from GUI
@snapend

@snap[west span-100]
@ol[list-content-verbose](false)
- Launch it from menu File --> Animation tool
- *Add new animation* and click on *Add space-time dataset or series of map layers*
- Select *Space time raster dataset* and below select **inundation**
- Use *Add raster map layer* and select raster **elevation_shade** from PERMANENT
- Use *Add vector map layer* and select **streets_wake** from PERMANENT
- Select **inundation** layer and move it above elevation_shade
- Press OK and wait till the animation is rendered 
- Press Play button
@olend
@snapend

+++

<!--- add animation here --->

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Terrain analysis: [r.geomorphon](https://grass.osgeo.org/grass74/manuals/addons/r.geomorphon.html)

+++?code=code/03_raster_code.sh&lang=bash&title=Terrain analysis

@[159-160](Set computational region)
@[162-163](Compute geo forms)
@[165-166](Extract summits with r.mapcalc)
@[168-170](Thin summits raster and convert to points)
@[172-174](Get summits' height)

+++

> **Task**: Get summits height univariate statistics and display geomorphon map plus summits vector

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
[Remote sensing in GRASS GIS](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/04_imagery&grs=gitlab)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend
