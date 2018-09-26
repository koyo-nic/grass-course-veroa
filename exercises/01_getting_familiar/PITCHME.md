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

@snap[north-west span-60]
<h3>Overview</h3>
@snapend

@snap[west span-80]
@ol[list-content-concise]
- Revise GRASS GIS database structure
- Sample dataset "North Carolina"
- Start GRASS GIS
- GRASS GIS GUI
- Display raster and vector maps
- Query raster and vector maps
- 3D visualization
- Displaying base maps (WMS servers)
- Add map decorations: barscale, north arrow, text, grids, raster and vector legends
- Scatterplots and histograms
@olend
@snapend
---

### GRASS GIS database structure

Now I will ask you some questions? 

- Location ?
- Mapset ? 
- Computational region ?

You can have a sneak peek here: [GRASS Intro](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/01_general_intro_grass&grs=gitlab#/8) presentation

---

### Sample dataset: North Carolina 

- Download the **North Carolina full dataset** from: http://grass.osgeo.org/download/sample-data/
- Create a folder in your $HOME directory (or Documents) and name it `grassdata`
- Unzip the file `nc_spm_08_grass7.zip` within `grassdata` so you end up with: $HOME/grassdata/nc_spm_08_grass7

<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://www.openstreetmap.org/export/embed.html?bbox=-127.70507812500001%2C20.797201434307%2C-69.69726562500001%2C50.261253827584724&amp;layer=mapnik" style="border: 1px solid black"></iframe><br/><small><a href="https://www.openstreetmap.org/#map=5/36.932/-98.701">View Larger Map</a></small>

---

## Let's start GRASS GIS

- Click over the icon (Start --> OSGeo4W --> GRASS GIS)

or 

- Open a terminal or the OSGeo4W Shell and type:

```bash
# open grass with GUI Location wizard
grass74

# open text mode only
grass74 --text $HOME/grassdata/nc_spm_08_grass7/user1/
```

---

@snap[north span-100]
... and now what?
@snapend

@snap[west span-60]
![Startup](assets/img/start_screen3.png)
@snapend

@snap[east span-40]
@ol
- Select the GRASS database folder (previously created)
- Select the `nc_spm_08_grass7` location 
- Select `user1` mapset
- Hit `Start`
@olend
@snapend

---

@snap[north span-100]
If you haven't downloaded the sample data set yet... No problem!
@snapend

@snap[west span-50]
![Startup-download location](assets/img/download_location_button.png)
@snapend

@snap[east span-50]
![Download location](assets/img/download_location.png)
@snapend

---

Here we are :)

![GRASS GUI](assets/img/empty_gui_explained.png)

---

... and the Terminal

![GRASS Terminal](assets/img/empty_terminal.png)

---

## Displaying raster and vector maps

Different options:
- Toolbar in the Layer Manager
- Typing the commands in the Console tab
- Double-click over a map in the Data tab 
- From command line 

**Task:**

- Give a second look to the [General Capabilities](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/02_general_intro_capabilities&grs=gitlab#/10) presentation and practice different ways of displaying maps

---

## Calling GRASS GIS commands

- From the GUI: 
  - Main menu in GRASS GIS Layer Manager, 
  - Console tab, 
  - Modules tab
  
- From the terminal: 
  - type first letter or some letters + <tab><tab>

---

**Task:**

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
![Log and Save buttons](assets/img/log_file_button.png)
@snapend

@snap[east span-50]
*Copy* button in commands user interface
![Copy button](assets/img/copy_button.png)
@snapend

---

### Getting Help

- From the Main menu `Help`
- In the GUI of every command
- Typing <command> `--help` in the terminal
- Using `g.manual` <command> to see the online manual page
<br><br>
**Task:**

Now try yourself with `r.info` and `v.what.stats`. What do they do?

---

### Query raster and vector maps

![Query raster map](assets/img/query_maps.png)

---

### 3D visualization

**Task:**

- Display `elevation` map
- Change to 3D view in the Map Display window
- Explore the options

---

### Displaying base maps from WMS servers

@snap[west span-50]
![Step 1](assets/img/add_wms_1.png)
@snapend

@snap[east span-50]
![Step 2](assets/img/add_wms_2.png)
@snapend

---

@snap[north span-100]
### Displaying base maps from WMS servers
@snapend

@snap[west span-50]
![Step 3](assets/img/add_wms_3.png)
@snapend

@snap[east span-50]
**Task:**
 
- Explore the area, zoom in, zoom out
- Display a vector map over the WMS layer (hint: adjust opacity of the vector map)
@snapend

---

### Adding map decorations

**Task:**

- Diplay `elevation` raster map and `roadsmajor` vector map
- Add grid over map
- Add roads labels (hint: right click over the map name in the Layer Manager)
- Add raster and vector legend
- Add scale bar
- Ddd North arrow
- Add a title

+++

![All map decorations](assets/img/map_decorations_task.png)

---

@snap[north span-70]
<h3>Bivariate Scatter Plots</h3>
@snapend

@snap[west span-50]
![Scatter plot](assets/img/bivariate_scatterplot.png)
@snapend

@snap[east span-50]
**Task:**

1. Click over *Analyze map*
2. Select *Bivariate scatterplot*
3. Select 2 raster maps
4. Explore the relationship among map values
@snapend

---

## Histograms

**Task:**

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

