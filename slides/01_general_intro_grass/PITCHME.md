# Introduction to GRASS GIS

### Conceptos Basicos

**Rio Cuarto, Octubre 2018**

---

<iframe width="560" height="315" scrolling="no" src="//av.tib.eu/player/12963" frameborder="0" allowfullscreen></iframe>

---

@size[56px](Working with GRASS GIS is not much different than any other GIS...)

---

Well, except for this...

<img class="plain" src="img/start_screen1.png">

---

## NOTIONS: GRASS DATABASE, LOCATION and MAPSET

@ul

- The @color[green](**GRASS DATABASE**) (or "GISDBASE") is an existing directory containing all GRASS GIS LOCATIONs. 
- A @color[green](**LOCATION**) is defined by its coordinate system, map projection and geographical boundaries.
- @color[green](**MAPSET**) is a subdirectory within Locations. In a **MAPSET** you can organize GIS maps thematically, geographically, by project or however you prefer.

@ulend

+++

When GRASS GIS is started, it connects to a Database, Location and Mapset specified by the user.

![GRASS DATABASE, LOCATIONs, and MAPSETs](img/grass_database.png)

[GRASS database](https://grass.osgeo.org/grass74/manuals/grass_database.html) 

+++

- **Why this structure?**

 - GRASS GIS has a @color[green](*native format*) for raster and vector data, therefore
   they must be imported or linked into a GRASS Location/Mapset.

- **What are the advantages?**

 - GRASS DATABASE, LOCATIONs and MAPSETs are folders that @color[green](*can be easily shared with other users*).
 - The GRASS DATABASE can be @color[green](*local or remote*), and @color[green](*special permissions*) can be set to specific mapsets in a LOCATION.
 - All data in a LOCATION have necessarily the @color[green](same CRS).

---

## Data types in GRASS GIS

- [Raster](https://grass.osgeo.org/grass74/manuals/rasterintro.html)
  (including [satellite imagery](https://grass.osgeo.org/grass74/manuals/imageryintro.html))
- [3D raster or voxel](https://grass.osgeo.org/grass74/manuals/raster3dintro.html)
- [Vector](https://grass.osgeo.org/grass74/manuals/vectorintro.html): point, line, boundary, area, face
- [Space-time datasets](https://grass.osgeo.org/grass74/manuals/temporalintro.html):
  collections of raster (**STRDS**), raster 3D (**STR3DS**) or vector (**STVDS**) maps

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
| [ps.\*](https://grass.osgeo.org/grass74/manuals/full_index.html#ps)  | postscript       | map creation in PostScript format   | [ps.map](https://grass.osgeo.org/grass74/manuals/ps.map.html): PostScript map creation
| [t.\*](https://grass.osgeo.org/grass74/manuals/full_index.html#t)    | temporal         | space-time datasets                 | [t.rast.aggregate](https://grass.osgeo.org/grass74/manuals/t.rast.aggregate.html): raster time series aggregation

+++

<img class="wide" src="img/module_tree_and_search.png">
<br>
Module tree and module search engine

---

## Add-ons

Plugins or **Add-ons** can be installed from
a centralized [OSGeo repository](https://grass.osgeo.org/grass7/manuals/addons/) 
or from github (or similar repositories) using the command
[g.extension](https://grass.osgeo.org/grass74/manuals/g.extension.html).

```bash
 # install extension from GRASS GIS Add-on repository
 g.extension extension=r.hants
 
 # install extension from github repository
 g.extension extension=r.in.sos \
   url=https://github.com/pesekon2/GRASS-GIS-SOS-tools/tree/master/sos/r.in.sos
``` 

---

## Computational region

![Show computational region](img/region.png)

+++

## Computational region

The @color[green](**computational region**) is the *actual setting of the region 
boundaries and the actual raster resolution*.
<br><br>
The @color[green](**computational region**) can be set and changed by means of
[g.region](https://grass.osgeo.org/grass74/manuals/g.region.html) to the
extent of a vector map, a raster map or manually to some area of interest. 
<br><br>
Output raster maps will have their extent and resolution equal to
those of the current computational region, while vector maps are 
always considered in their original extent.

+++

## Computational region

- **Which are the advantages?**

  - Keep your results consistent
  - Avoid clipping maps prior to subarea analysis
  - Test an algorithm or computationally demanding process in small areas
  - Fine-tune the settings of a certain module
  - Run different processes in different areas

@size[16px](More details at the [Computational region wiki](https://grasswiki.osgeo.org/wiki/Computational_region))

---

## Mask

If a mask is set, raster modules will operate only on data falling inside
the masked area(s). Masks are set with 
[r.mask](https://grass.osgeo.org/grass74/manuals/r.mask.html) 
or creating a raster map called `MASK`.

![MASK](img/masks.png)
<br>
@size[16px](Examples of masking: b- Only the raster data inside the masked area are used for further analysis. c- Inverse mask.)

---

## Interfaces

GRASS GIS offers different interfaces for the interaction between user and software. 

#### Let's see them!

+++

### Graphical User Interface (GUI)

![GRASS GIS GUI](img/GUI_description.png)

+++

### Command line

The most powerful way to use GRASS GIS!!

<img class="plain" src="img/grass_command_line.png">

+++

**Advantages of the command line**

@ul
- Run "history" to see all your previous commands
- History is stored individually per MAPSET
- Search in history with CTRL-R
- Save the commands to a file: `history > my_protocol.sh`, polish/annotate the protocol and re-run with: `sh my_protocol.sh`
- Call module's GUI and "Copy" the command for further replication
@ulend

+++

The GUI's simplified command line offers a *Command prompt* button to save the history to a file

<img class="plain" src="img/command_prompt_gui.png">

+++

### Python

The simplest way to execute a Python script is through the "Simple Python editor"

![Python console and simple python editor](img/simple_python_editor.png)

+++

... or write your Python script in your favorite editor and run it:

```python
 !/usr/bin/env python

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

+++?code=intro/grass_session_vector_import.py&lang=python&title=Using GRASS GIS through **grass-session** Python library

<br>
Credits: Pietro Zambelli. See [grass-session GitHub](https://github.com/zarch/grass-session) for further details.

+++

### QGIS

There are two ways to use GRASS GIS functionalities within QGIS:
<br>
- [GRASS GIS plugin](https://docs.qgis.org/2.18/en/docs/user_manual/grass_integration/grass_integration.html)
- [Processing toolbox](https://docs.qgis.org/2.18/en/docs/user_manual/processing/toolbox.html)

+++

![GRASS modules through GRASS Plugin](img/qgis_grass_plugin.png)
<br>
@size[16px](Using GRASS GIS modules through the GRASS Plugin in QGIS)

+++

![GRASS modules through Processing Toolbox](img/qgis_processing.png)
<br>
@size[16px](Using GRASS GIS modules through the Processing Toolbox)

+++

### R + rgrass7

GRASS GIS and R can be used together in two ways:
<br>
- Using [R within a GRASS GIS session](https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7#R_within_GRASS),
- Using [GRASS GIS within an R session](https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7#GRASS_within_R),

+++

![Calling R from within GRASS](img/RwithinGRASS_and_Rstudio_from_grass.png)

@size[16px](Details and examples at the [GRASS and R wiki](https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7))

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
 
 # import SHAPE file, clip to region extent and reproject to current location projection
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
  
  **IMPORTANT**: Always perform these tasks from within a GRASS session.

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

<!--- example of saving the region? ---> 

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

# HELP!!!

+++

## KEEP CALM and GRASS GIS

- [g.manual](https://grass.osgeo.org/grass74/manuals/g.manual.html):
  in the main GUI under Help or just pressing *F1*
- --help or --h flag after the module name
- [GRASS wiki](https://grasswiki.osgeo.org/wiki/GRASS-Wiki): examples,
  explanations and help on particular modules or tasks,
  [tutorials](https://grasswiki.osgeo.org/wiki/Category:Tutorial),
  applications, news, etc.
- [Jupyter/IPhyton notebooks](https://grasswiki.osgeo.org/wiki/GRASS_GIS_Jupyter_notebooks)
  with example workflows for different applications
- GRASS user mailing list: Just [subscribe](https://lists.osgeo.org/mailman/listinfo/grass-user) and
  post to or check the [archives](https://lists.osgeo.org/pipermail/grass-user/).

+++

## Other (very) useful links

- [GRASS intro workshop held at NCSU](https://ncsu-osgeorel.github.io/grass-intro-workshop/)
- [Unleash the power of GRASS GIS at US-IALE 2017](https://grasswiki.osgeo.org/wiki/Unleash_the_power_of_GRASS_GIS_at_US-IALE_2017)
- [GRASS GIS workshop in Jena 2018](http://training.gismentors.eu/grass-gis-workshop-jena-2018/index.html)
- [Raster data processing in GRASS GIS](https://grass.osgeo.org/grass74/manuals/rasterintro.html)
- [Vector data processing in GRASS GIS](https://grass.osgeo.org/grass74/manuals/vectorintro.html)

---

## References

- Neteler, M., Mitasova, H. (2008): *Open Source GIS: A GRASS GIS
  Approach*. Third edition. ed. Springer, New York. [Book site](https://grassbook.org/)
- Neteler, M., Bowman, M.H., Landa, M. and Metz, M. (2012): *GRASS
  GIS: a multi-purpose Open Source GIS*. Environmental Modelling &
  Software, 31: 124-130 [DOI](http://dx.doi.org/10.1016/j.envsoft.2011.11.014)

---

# QUESTIONS

<img class="plain" src="img/gummy-question.png">

---

**Thanks for your attention!!**

![GRASS GIS logo](img/grass_logo_alphab.png)

@snap[south]
@css[bio-byline](@fa[gitlab  pad-fa] veroandreo @fa[twitter pad-fa] @VeronicaAndreo)
@snapend

<!--- ?include=tgrass/PITCHME.md --->
