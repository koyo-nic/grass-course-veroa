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

## Exercise 1: Getting familiar with GRASS GIS

---

## Overview

- Revise the database structure of GRASS GIS 
- Sample dataset "North Carolina"
- Starting GRASS GIS
- GRASS GIS GUI
- Displaying raster and vector maps
- Query raster and vector maps maps
- 3D visualization
- Displaying base maps (WMS servers)
- Add map decorations: barscale, north arrow, text, grids, raster and vector legend
- Profiles, histograms and scatterplots 


<!--- 
See: https://apps.mundialis.de/workshops/osgeo_ireland2017/presentations/

crear location y mapset, import vector y raster data, display a vector over a WMS
https://www.mundialis.de/en/ows-mundialis/
--->

---

Now I will ask you some questions? 
- Location
- Mapset
- Computational region

<!--- copy slides or link to presentation --->

---

## GRASS GIS database structure

---

## Sample dataset: North Carolina

---

## Let's start GRASS GIS

- Click over the icon (Start --> OSGeo4W --> GRASS GIS)
- Open a terminal or the OSGeo4W Shell and type

```bash
# open grass with Location wizard
grass74

# power users, call terminal only
grass77svn --text /home/veroandreo/grassdata/nc_spm_08_grass7/user1/
```

---

@snap[north span-100]
... now what?
@snapend

@snap[west span-65]
![Startup]("assets/img/start_screen3.png")
@snapend

@snap[east span-35]
@ol
- Select the GRASS database folder (previously created)
- Select the `nc_spm_08_grass7` location 
- Select `user1` mapset
- Hit `Start`
@olend
@snapend

---

@snap[north span-100]
If you haven't downloaded the sample data set... No problem!
@snapend

@snap[west span-50]
![Startup-download location]("assets/img/download_location_button.png")
@snapend

@snap[east span-50]
![Download location]("assets/img/download_location.png")
@snapend

---

Here we are :)

![GRASS GUI]("assets/img/empty_gui_explained.png")

---

... and the Terminal

![GRASS Terminal]("assets/img/empty_terminal.png")

---

## Displaying raster and vector maps

- Toolbar in the Layer Manager
- Typing the commands in the Console tab
- Double-click over a map in the Data tab 
- From command line 

Task:
- Review presentation and practice different ways of displaying maps

---

## Calling GRASS GIS commands

- From the GUI: 
  - Main menu in GRASS GIS Layer Manager, 
  - Console tab, 
  - Modules tab
  
- From the terminal: 
  - type first letter or some letters + <tab><tab>

---

Let's try...

1. Run `r.univar map=elevation` from the main GUI (Raster --> Reports and statistics)
2. Run `r.univar map=elevation` from the Console tab
3. Type `r.un` in the black terminal and hit <tab> twice. Then hit <Enter>
4. Run `r.univar map=elevation` in the black terminal

---

@snap[north span-80]
2 things to note in the GUI:
@snapend

@snap[west span-50]
*Log file* and *Save* in the GUI console
![Log and Save buttons]("assets/img/log_file_button.png")
@snapend

@snap[east span-50]
*Copy* button in commands interface
![Copy button]("assets/img/copy_button.png")
@snapend

---

## Getting Help

- From the Main menu
- In the GUI of every command
- Typing <command> `--help` in the terminal
- Using `g.manual` <command> to see the online manual page

Now try yourself with `r.info` and `v.what.stats`

---

## Query raster and vector maps

![Query raster map]("assets/img/query_maps.png")

---

## 3D visualization

- Display `elevation` map
- Change to 3D view in the Map Display window
- Explore the options

---

## Displaying base maps from WMS servers

@snap[west span-50]
![Step 1]("assets/img/add_wms_1.png")
@snapend

@snap[east span-50]
![Step 2]("assets/img/add_wms_2.png")
@snapend

---

## Displaying base maps from WMS servers

![Step 3]("assets/img/add_wms_3.png")

Tasks: 
- Explore the area, zoom in, zoom out
- Display a vector map over the WMS layer (adjust opacity of the vector map)

---

## Adding map decorations

Task:

- Diplay `elevation` raster map and `roadsmajor` vector map
- Add grid
- Add roads labels
- Add raster and vector legend
- Add scale bar
- Ddd north arrow
- Add a title

+++

![All map decorations added]("assets/img/map_decorations_task.png")

---

## Bivariate Scatter Plots

![Scatter plot]("assets/img/bivariate_scatterplot.png")

1. Click over *Analyze map*
2. Select *Bivariate scatterplot*
3. Select 2 raster maps
4. Explore the relationship among map values

---

## Histograms

Task: 

- Explore the histogram tools on your own

---

**Thanks for your attention!!**

![GRASS GIS logo](assets/img/grass_logo_alphab.png)

---

@snap[north span-90]
<br><br><br>
Go to: 
<br>
[your house]()
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend

