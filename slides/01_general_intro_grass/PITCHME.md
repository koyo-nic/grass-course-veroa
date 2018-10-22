---?image=template/img/grass.png&position=bottom&size=100% 30%
@title[Front page]

@snap[north span-100]
<br>
<h2>Procesamiento de series de tiempo en @color[green](GRASS GIS)</h2>
<h3>Aplicaciones en Ecología y Ambiente</h3>
@snapend

@snap[south message-box-white]
<br>Dra. Veronica Andreo<br>CONICET - INMeT<br><br>Rio Cuarto, 2018<br>
@snapend

---
@title[About the trainer]

@snap[west]
@css[bio-about](Lic. y Dra. Cs. Biológicas<br>Mgter. en Aplicaciones Espaciales de Alerta y<br>Respuesta Temprana a Emergencias<br>Aplicaciones de RS & GIS en Ecología<br><br><i>Keywords:</i> RS, GIS, Time series, SDM,<br>Disease Ecology, Rodents, Hantavirus)
<br><br>
@css[bio-about](<a href="https://grass.osgeo.org/">GRASS GIS</a> Dev Team<br><a href="https://www.osgeo.org/">OSGeo</a> Charter member<br>FOSS4G enthusiast and advocate)
@snapend

@snap[east]
@css[bio-headline](About me)
<br><br>
![myphoto](assets/img/vero_round_small.png)
<br><br>
@css[bio-byline](@fa[gitlab pad-fa] veroandreo @fa[twitter pad-fa] @VeronicaAndreo<br>@fa[envelope pad-fa] veroandreo@gmail.com)
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

# Introduction to GRASS GIS

---
@title[Intro FOSS]

@snap[north span-100]
<h2>Brief intro to FOSS</h2>
<br><br>
@snapend

@snap[east split-screen-text]
Free and Open Source Software (FOSS) means that anyone is freely licensed to use, copy, study, and change the software. The source code is openly shared so that people are encouraged to voluntarily improve it.
@snapend

@snap[west split-screen-img]
<img src="assets/img/foss.png">
@snapend

<!--- This is in contrast to proprietary software, where the software is under restrictive copyright and the source code is usually hidden. --->

---
@title[Intro OSGeo 1]

@snap[north span-100]
<h2>Brief intro to OSGeo</h2>
<br><br>
@snapend

@snap[south span-100]
The [OSGeo Foundation](https://www.osgeo.org/) was created in 2006, to support the collaborative development of open source geospatial software, and promote its widespread use.
<br><br>
<img src="assets/img/osgeo-logo.png" width="50%">
<br><br>
@snapend

+++
@title[Intro OSGeo 2]

@snap[north span-100]
<h2>Brief intro to OSGeo</h2>
<br><br>
@snapend

@snap[south-west list-content-verbose span-100]
@ol[](false)
- Projects should manage themselves, striving for consensus and encouraging participation from all contributors.
- Contributors are the scarce resource and successful projects court and encourage them.
- Projects are encouraged to adopt open standards and collaborate with other OSGeo projects.
- Projects are responsible for reviewing and controlling their code bases to assure integrity.
@olend
<br><br>
@snapend

---
@title[GRASS GIS history 1]

@snap[north span-100]
<h2>GRASS GIS: Brief history</h2>
<br><br>
@snapend

@snap[south-west list-content-verbose span-100]
@ul[](false)
- @color[#8EA33B](**GRASS GIS**) (Geographic Resources Analysis Support System), is a FOSS GIS software suite used for geospatial data management and analysis, image processing, graphics and maps production, spatial modeling, and visualization. 
- Used in academic and commercial settings around the world, as well as by many governmental agencies and consulting companies.
- Originally developed by the U.S. Army Construction Engineering Research Laboratories as a tool for land management and environmental planning by the military (USA-CERL, 1982-1995).
@ulend
<br>
@snapend

+++?image=template/img/grass.png&position=bottom&size=100% 30%
@title[GRASS GIS history 2]

@snap[north span-90]
<br>
A bit of (geek) GRASS GIS history...
@snapend

<iframe width="560" height="315" scrolling="no" src="//av.tib.eu/player/12963" frameborder="0" allowfullscreen></iframe>

+++?image=template/img/bg/green.jpg&position=left&size=50% 100%
@title[Advantages and Disadvantages]

@snap[west text-white span-50]
Advantages
<br><br>
@ul[split-screen-list](false)
- open source, you can use, modify, improve, share
- strong user community, commercial support
- large amount of tools for 2D/3D raster/vector, topology, imagery, spatio-temporal data
- both GUI and CLI (easy for scripting) interface
- Python API and libraries
@ulend
@snapend

@snap[east text-green span-50]
Disadvantages
<br><br>
@ul[split-screen-list](false)
- complicated startup for newcomers
- native format (requires importing data, be aware of the possibility of linking external formats)
- vector topology (confusing for GIS beginners, sometimes tricky to import broken GIS data)
@ulend
@snapend

+++?image=template/img/bg/green.jpg&position=left&size=50% 100%
@title[When to use and not to use GRASS]

@snap[west text-white span-50]
When to use GRASS GIS?
<br><br>
@ul[split-screen-list](false)
- doing (heavy) geospatial data analysis
- working with topological vector data
- analysing space-time datasets
- doing Python scripting
- deploying server-side applications (e.g. as WPS process)
@ulend
@snapend

@snap[east text-green span-50]
When to use rather something else?
<br><br>
@ul[split-screen-list](false)
- want to vizualize geodata in easy and quick way (use QGIS instead)
- scared of location and mapsets ;-)
@ulend
@snapend

---

@size[56px](Working with GRASS GIS is not much different than any other GIS...)

---

Well, except for this...

<img src="assets/img/start_screen1.png" width="50%">

---

## Basic notions

@ul
- The @color[#8EA33B](**GRASS DATABASE**) (or "GISDBASE") is an existing directory containing all GRASS GIS LOCATIONs. 
- A @color[#8EA33B](**LOCATION**) is defined by its coordinate system, map projection and geographical boundaries.
- @color[#8EA33B](**MAPSET**) is a subdirectory within Locations. In a **MAPSET** you can organize GIS maps thematically, geographically, by project or however you prefer.
@ulend

+++
@title[GRASS DB, Location and Mapsets]

When GRASS GIS is started, it connects to the Database, Location and Mapset specified by the user

<img src="assets/img/grass_database.png" width="65%">

@size[24px](<a href="https://grass.osgeo.org/grass74/manuals/grass_database.html">GRASS database</a>)
<br><br>

+++

- **Why this structure?**

 - GRASS GIS has a @color[#8EA33B](*native format*) for raster and vector data, therefore
   they must be *imported* or *linked* into a GRASS Location/Mapset (see [r.external](https://grass.osgeo.org/grass74/manuals/r.external.html) for example).

+++

- **What are the advantages?**

 - GRASS DATABASE, LOCATIONs and MAPSETs are folders that @color[#8EA33B](*can be easily shared with other users*).
 - The GRASS DATABASE can be @color[#8EA33B](*local or remote*), and @color[#8EA33B](*special permissions*) can be set to specific mapsets in a LOCATION.
 - All data in a LOCATION have necessarily the @color[#8EA33B](same CRS).

+++?image=template/img/bg/green.jpg&position=left&size=46% 100%
@title[Data types in GRASS GIS]

@snap[west split-screen-heading text-white span-45]
Data types in GRASS GIS
@snapend

@snap[east text-green span-55]
@ul[split-screen-list](false)
- [Raster](https://grass.osgeo.org/grass74/manuals/rasterintro.html) (including [satellite imagery](https://grass.osgeo.org/grass74/manuals/imageryintro.html))
- [3D raster or voxel](https://grass.osgeo.org/grass74/manuals/raster3dintro.html)
- [Vector](https://grass.osgeo.org/grass74/manuals/vectorintro.html): point, line, boundary, area, face
- [Space-time datasets](https://grass.osgeo.org/grass74/manuals/temporalintro.html): collections of raster (**STRDS**), raster 3D (**STR3DS**) or vector (**STVDS**) maps
@ulend
@snapend

---

## Modules

More than [500 modules](https://grass.osgeo.org/grass74/manuals/full_index.html) but well structured:

| Prefix                                                               | Function class   | Type of command                     | Example
|--------------------------------------------------------------------- |:---------------- |:----------------------------------- |:-------------------------------------------------------------------------------------------------------------------
| [g.\*](https://grass.osgeo.org/grass74/manuals/full_index.html#g)    | general          | general data management             | [g.rename](https://grass.osgeo.org/grass74/manuals/g.rename.html): renames map
| [d.\*](https://grass.osgeo.org/grass74/manuals/full_index.html#d)    | display          | graphical output                    | [d.rast](https://grass.osgeo.org/grass74/manuals/d.rast.html): display raster map 
| [r.\*](https://grass.osgeo.org/grass74/manuals/full_index.html#r)    | raster           | raster processing                   | [r.mapcalc](https://grass.osgeo.org/grass74/manuals/r.mapcalc.html): map algebra
| [v.\*](https://grass.osgeo.org/grass74/manuals/full_index.html#r)    | vector           | vector processing                   | [v.clean](https://grass.osgeo.org/grass74/manuals/v.clean.html): topological cleaning
| [i.\*](https://grass.osgeo.org/grass74/manuals/full_index.html#i)    | imagery          | imagery processing                  | [i.pca](https://grass.osgeo.org/grass74/manuals/i.pca.html): Principal Components Analysis on imagery group
| [r3.\*](https://grass.osgeo.org/grass74/manuals/full_index.html#r3)  | voxel            | 3D raster processing                | [r3.stats](https://grass.osgeo.org/grass74/manuals/r3.stats.html): voxel statistics
| [db.\*](https://grass.osgeo.org/grass74/manuals/full_index.html#db)  | database         | database management                 | [db.select](https://grass.osgeo.org/grass74/manuals/db.select.html): select value(s) from table
| [ps.\*](https://grass.osgeo.org/grass74/manuals/full_index.html#ps)  | postscript       | PostScript map creation   | [ps.map](https://grass.osgeo.org/grass74/manuals/ps.map.html): PostScript map creation
| [t.\*](https://grass.osgeo.org/grass74/manuals/full_index.html#t)    | temporal         | space-time datasets                 | [t.rast.aggregate](https://grass.osgeo.org/grass74/manuals/t.rast.aggregate.html): raster time series aggregation

+++

<img src="assets/img/module_tree_and_search.png" width="70%">
<br>
Module tree and module search engine

---

## Add-ons

Plugins or **Add-ons** can be installed from
a centralized [OSGeo repository](https://grass.osgeo.org/grass7/manuals/addons/) 
or from github (or similar repositories) using 
[g.extension](https://grass.osgeo.org/grass74/manuals/g.extension.html) command.

```bash
 # install extension from GRASS GIS Add-on repository
 g.extension extension=r.hants
 
 # install extension from github repository
 g.extension extension=r.in.sos \
   url=https://github.com/pesekon2/GRASS-GIS-SOS-tools/tree/master/sos/r.in.sos
``` 

---

## Computational region

![Show computational region](assets/img/region.png)

+++

@snap[west]
The @color[#8EA33B](**computational region**) is the *actual setting of the region 
boundaries and the actual raster resolution*.
<br><br>
The @color[#8EA33B](**computational region**) can be set and changed by means of
[g.region](https://grass.osgeo.org/grass74/manuals/g.region.html) to the
extent of a vector map, a raster map or manually to some area of interest. 
<br><br>
Output raster maps will have their extent and resolution equal to
those of the current computational region, while vector maps are 
always considered in their original extent.
@snapend

+++

## Computational region

- **Which are the advantages?**

  - Keep your results consistent
  - Avoid clipping maps prior to subarea analysis
  - Test an algorithm or computationally demanding process in small areas
  - Fine-tune the settings of a certain module
  - Run different processes in different areas

@size[18px](More details at the [Computational region wiki](https://grasswiki.osgeo.org/wiki/Computational_region))

<!---
## Mask

If a mask is set, raster modules will operate only on data falling inside
the masked area(s). Masks are set with 
[r.mask](https://grass.osgeo.org/grass74/manuals/r.mask.html) 
or creating a raster map called `MASK`.

![MASK](assets/img/masks.png)
<br>
@size[18px](Examples of masking: b- Only the raster data inside the masked area are used for further analysis. c- Inverse mask.)
--->

---

## Interfaces

GRASS GIS offers different interfaces for the interaction between user and software. 

#### Let's see them!

+++

### Graphical User Interface (GUI)

![GRASS GIS GUI](assets/img/GUI_description.png)

+++

### Command line

The most powerful way to use GRASS GIS!!

<img src="assets/img/grass_command_line.png" width="70%">

+++

### Advantages of the command line

@ul
- Run `history` to see all your previous commands
- History is stored individually per MAPSET
- Search in history with `CTRL-R`
- Save the commands to a file: `history > my_protocol.sh`, polish/annotate the protocol and re-run with: `sh my_protocol.sh`
- Call module's GUI and "Copy" the command for further replication
@ulend

+++

The GUI's simplified command line offers a *Log file* button to save the history to a file

<img src="assets/img/command_prompt_gui.png" width="43%">

+++

### Python

The simplest way to execute a Python script is through the *Simple Python editor*

<img src="assets/img/simple_python_editor.png" width="80%">

+++

... or write your Python script in your favorite editor and run it:

```python
 #!/usr/bin/env python

 # simple example for pyGRASS usage: raster processing via modules approach
 from grass.pygrass.modules.shortcuts import general as g
 from grass.pygrass.modules.shortcuts import raster as r
 g.message("Filter elevation map by a threshold...")
 
 # set computational region
 input = 'elevation'
 g.region(raster=input)
 output = 'elev_100m'
 thresh = 100.0

 r.mapcalc("%s = if(%s > %d, %s, null())" % (output, input, thresh, input), overwrite = True)
 r.colors(map=output, color="elevation")
``` 

+++?code=code/01_intro_grass_session_vector_import.py&lang=python

@snap[north-east template-note text-gray]
Using GRASS GIS through **grass-session** Python library
@snapend

@[17-28](Import libraries)
@[36-48](Create Location and Mapset)
@[50-66](Run modules)
@[68-69](Clean and close)

@size[18px](Credits: Pietro Zambelli. See <a href="https://github.com/zarch/grass-session">grass-session GitHub</a> for further details.)

+++

### QGIS

There are two ways to use GRASS GIS functionalities within QGIS:
<br>
- [GRASS GIS plugin](https://docs.qgis.org/2.18/en/docs/user_manual/grass_integration/grass_integration.html)
- [Processing toolbox](https://docs.qgis.org/2.18/en/docs/user_manual/processing/toolbox.html)

+++

![GRASS GIS modules through GRASS Plugin](assets/img/qgis_grass_plugin.png)
<br>
@size[18px](Using GRASS GIS modules through the GRASS Plugin in QGIS)

+++

![GRASS modules through Processing Toolbox](assets/img/qgis_processing.png)
<br>
@size[18px](Using GRASS GIS modules through the Processing Toolbox)

+++

### R + rgrass7

GRASS GIS and R can be used together in two ways:
<br><br>
- Using [R within a GRASS GIS session](https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7#R_within_GRASS),
- Using [GRASS GIS within an R session](https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7#GRASS_within_R),
<br><br>

@size[22px](Details and examples at the <a href="https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7">GRASS and R wiki</a>)

+++

![Calling R from within GRASS](assets/img/RwithinGRASS_and_Rstudio_from_grass.png)

@snap[south-east]
@size[24px](We'll study this on Friday morning. Stay tuned!) @fa[smile-o fa-spin text-green]
@snapend

+++

### WPS - OGC Web Processing Service

- [Web Processing Service](https://en.wikipedia.org/wiki/Web_Processing_Service) is an [OGC](https://en.wikipedia.org/wiki/Open_Geospatial_Consortium) standard. 
- [ZOO-Project](http://zoo-project.org/) and [PyWPS](http://pywps.org/) allow the user to run GRASS GIS commands in a simple way through the web.

---

## Some useful commands and cool stuff

+++

- [r.import](https://grass.osgeo.org/grass74/manuals/r.import.html) and
  [v.import](https://grass.osgeo.org/grass74/manuals/v.import.html):
  import of raster and vector maps with reprojection, subsetting and
  resampling on the fly.

```bash 
 ## IMPORT RASTER DATA: SRTM V3 data for NC
 
 # set computational region to e.g. 10m elevation model:
 g.region raster=elevation -p
 
 # Import with reprojection on the fly
 r.import input=n35_w079_1arc_v3.tif output=srtmv3_resamp10m \
  resample=bilinear extent=region resolution=region \
  title="SRTM V3 resampled to 10m resolution"

 ## IMPORT VECTOR DATA
 
 # import SHAPE file, clip to region extent and reproject to 
 # current location projection
 v.import input=research_area.shp output=research_area extent=region
``` 

+++

- [g.list](https://grass.osgeo.org/grass74/manuals/g.list.html): Lists
  available GRASS data base files of the user-specified data type
  (i.e., raster, vector, 3D raster, region, label) optionally using
  the search pattern.

```bash 
 g.list type=vector pattern="r*"
 g.list type=vector pattern="[ra]*"
 g.list type=raster pattern="{soil,landuse}*"
``` 
                
+++

- [g.remove](https://grass.osgeo.org/grass74/manuals/g.remove.html),
  [g.rename](https://grass.osgeo.org/grass74/manuals/g.rename.html)
  and [g.copy](https://grass.osgeo.org/grass74/manuals/g.copy.html):

  These modules remove maps from the GRASSDBASE, rename maps and copy
  maps either in the same mapset or from other mapset. 
  
@css[message-box](Always perform these tasks from within GRASS)

+++

- [g.region](https://grass.osgeo.org/grass74/manuals/g.region.html):
  Manages the boundary definitions and resolution for the computational region.

```bash 
 ## Subset a raster map
 # 1. Check region settings
 g.region -p
 # 2. Change region (here: relative to current N and W values, expanding values in map units)
 g.region n=n-3000 w=w+4000
 # 3. Subset map
 r.mapcalc "new_elev = elevation"
 r.colors new_elev color=viridis
 # 4. Display maps
 d.mon wx0
 d.rast elevation
 d.rast new_elev
``` 

+++

- [g.mapset](https://grass.osgeo.org/grass74/manuals/g.mapset.html)
  and [g.mapsets](https://grass.osgeo.org/grass74/manuals/g.mapsets.html):
  These modules allow to change mapset and add/remove mapsets from the
  accessible mapsets list.

```bash
 # print current mapset
 g.mapset -p
 # change to a different mapset
 g.mapset mapset=modis_lst
 # print mapsets in the search path
 g.mapsets -p
 # list available mapsets in the location
 g.mapsets -l
 # add mapset to the search path
 g.mapsets mapset=modis_lst operation=add
``` 
                
+++

- [r.info](https://grass.osgeo.org/grass74/manuals/r.info.html) and
  [v.info](https://grass.osgeo.org/grass74/manuals/v.info.html):
  useful to get basic info about maps as well as their history.

```bash
 # info for raster map
 r.info elevation
 # info for vector map
 v.info nc_state
 # history of vector map
 v.info nc_state -h
```
               
+++

- [--exec in the grass74 startup command](https://grass.osgeo.org/grass74/manuals/grass7.html): 
  This flag allows to run modules or complete workflows written in Bash
  shell or Python without starting GRASS GIS.

```bash
 # running a module
 grass74 /path/to/grassdata/nc_spm_08_grass7/PERMANENT/ --exec r.univar map=elevation
 
 # running a script
 grass74 /path/to/grassdata/nc_spm_08_grass7/PERMANENT/ --exec sh test.sh

 ## test.sh might be as simple as:
 
 #!/bin/bash

 g.region -p
 g.list type=raster
 r.info elevation
``` 
                
---

# **HELP!!!**

+++

### KEEP CALM and GRASS GIS

- [g.manual](https://grass.osgeo.org/grass74/manuals/g.manual.html):
  in the main GUI under Help or just pressing *F1*
- `--help` or `--h` flag after the module name
- [GRASS wiki](https://grasswiki.osgeo.org/wiki/GRASS-Wiki): examples,
  explanations and help on particular modules or tasks,
  [tutorials](https://grasswiki.osgeo.org/wiki/Category:Tutorial),
  applications, news, etc.
- [Jupyter/IPhyton notebooks](https://grasswiki.osgeo.org/wiki/GRASS_GIS_Jupyter_notebooks)
  with example workflows for different applications
- GRASS user mailing list: Just [subscribe](https://lists.osgeo.org/mailman/listinfo/grass-user) and
  post or check the [archives](https://lists.osgeo.org/pipermail/grass-user/).

+++

## Other (very) useful links

- [GRASS intro workshop held at NCSU](https://ncsu-osgeorel.github.io/grass-intro-workshop/)
- [Unleash the power of GRASS GIS at US-IALE 2017](https://grasswiki.osgeo.org/wiki/Unleash_the_power_of_GRASS_GIS_at_US-IALE_2017)
- [GRASS GIS workshop in Jena 2018](http://training.gismentors.eu/grass-gis-workshop-jena-2018/index.html)
- [Raster data processing in GRASS GIS](https://grass.osgeo.org/grass74/manuals/rasterintro.html)
- [Vector data processing in GRASS GIS](https://grass.osgeo.org/grass74/manuals/vectorintro.html)

---

## References

- Neteler, M., Mitasova, H. (2008): *Open Source GIS: A GRASS GIS Approach*. Third edition. ed. Springer, New York. [Book site](https://grassbook.org/)
- Neteler, M., Bowman, M.H., Landa, M. and Metz, M. (2012): *GRASS GIS: a multi-purpose Open Source GIS*. Environmental Modelling & Software, 31: 124-130 [DOI](http://dx.doi.org/10.1016/j.envsoft.2011.11.014)

---

## QUESTIONS?

<img src="assets/img/gummy-question.png" width="45%">

---

**Thanks for your attention!!**

![GRASS GIS logo](assets/img/grass_logo_alphab.png)

---?image=assets/img/grass_sprint2018_bonn_fotowall_medium.jpg&size=cover

@transition[zoom]

<p style="color:white">Join and enjoy GRASS GIS!!</p>

<!--- ?include=tgrass/PITCHME.md --->

---

@snap[north span-90]
<br><br><br>
Move on to: 
<br>
[GRASS GIS Installation party](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/00_installation&grs=gitlab#/)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend
