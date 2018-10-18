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

## Exercise 1: Getting familiar with GRASS GIS

---

@snap[north-west span-60]
<h3>Overview</h3>
@snapend

@snap[west span-100]
<br><br>
@ol[list-content-verbose]
- Revise GRASS GIS database structure
- Sample dataset "North Carolina"
- Start GRASS GIS and explore GUI
- Display raster and vector maps
- Query raster and vector maps
- 3D visualization
- Display base maps (WMS servers)
- Add map decorations
- Scatterplots and histograms
@olend
@snapend
---

Now I will ask you some questions? @fa[smile-o fa-spin]

<br>

> - Location ?
> - Mapset ? 
> - Computational region ?

<br>

You can have a sneak peek at the [GRASS Intro](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/01_general_intro_grass&grs=gitlab#/8) presentation

---

@snap[north span-100]
<h3>Sample dataset: North Carolina</h3>
@snapend

@snap[west span-60]
<br>
@ul[list-content-verbose](false)
- Download the [**North Carolina full dataset**](https://grass.osgeo.org/sampledata/north_carolina/nc_spm_08_grass7.zip)
- Create a folder in your `$HOME` directory (or Documents) and name it `grassdata`
- Unzip the file `nc_spm_08_grass7.zip` within `grassdata`
@ulend
@snapend

@snap[east span-40]
<br><br>
<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://www.openstreetmap.org/export/embed.html?bbox=-127.70507812500001%2C20.797201434307%2C-69.69726562500001%2C50.261253827584724&amp;layer=mapnik" style="border: 1px solid black"></iframe><br/><small><a href="https://www.openstreetmap.org/#map=5/36.932/-98.701">View Larger Map</a></small>
@snapend

---

## Let's start GRASS GIS

<br>

- Click over the GRASS GIS icon (*MS Windows: Start --> OSGeo4W --> GRASS GIS*)
- Open a terminal or the *OSGeo4W Shell* and type:

<br>

```bash
# open grass with GUI Location wizard
grass74

# open text mode only
grass74 --text $HOME/grassdata/nc_spm_08_grass7/user1/
```

---

@snap[north span-100]
... and now what?
<br>
@snapend

@snap[west span-55]
<img src="assets/img/start_screen3.png" width="90%">
@snapend

@snap[east span-45]
@ol[list-content-verbose]
- Select the GRASS database folder
- Select the `nc_spm_08_grass7` location 
- Select `user1` mapset
- Hit `Start GRASS session`
@olend
@snapend

---

@snap[north span-100]
If you haven't downloaded NC location yet... No problem!
@snapend

@snap[west span-50]
<br><br>
![Startup-download location](assets/img/download_location_button.png)
@snapend

@snap[east span-50]
![Download location](assets/img/download_location.png)
@snapend

---
@snap[north-west]
Here we are :)
@snapend

<img src="assets/img/empty_gui_explained.png" width="88%">

---

... and the Terminal

<img src="assets/img/empty_terminal.png" width="80%">

---

### Get information about the CRS

<img src="assets/img/projection_info.png" width="65%">
<br>
or just type in the terminal

```bash
g.proj -p
```

---

<h3>Display raster and vector maps</h3>

Many different options:
- Go to File --> Map display --> Add raster|vector
- Toolbar icons in the Layer Manager
- Type the commands in the Console tab
- Double-click over a map in the Data tab 
- From command line in the black terminal

+++

<h3>Display raster and vector maps</h3>

> **Task:** Give a look to the [General Capabilities](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/02_general_intro_capabilities&grs=gitlab#/10) presentation and practice different ways of displaying raster & vector maps

---

### Calling GRASS GIS commands

- From the GUI: 
  - Main menu in GRASS GIS Layer Manager, 
  - Console tab, 
  - Modules tab
  
- From the terminal: 
  - type first letter or some letters + `<tab><tab>`

---

### Calling GRASS GIS commands
<br>
> **Task:**
> - Run `r.univar map=elevation` from the main GUI (Raster --> Reports and statistics)
> - Run `r.univar map=elevation` from the Console tab
> - Type `r.un` in the black terminal and hit `<tab>` twice. Then hit `<Enter>`
> - Run `r.univar map=elevation` in the black terminal

---

@snap[north span-80]
2 things to note in the GUI:
@snapend

@snap[west span-50]
<br>
<img src="assets/img/log_file_button.png" width="85%">
<br>
@size[26px](*Log file* and *Save* in the GUI console)
@snapend

@snap[east span-50]
![Copy button](assets/img/copy_button.png)
<br>
@size[26px](*Copy* button in commands' GUI)
@snapend

---

### Getting Help

- From the Main menu `Help`
- In the GUI of every command
- Typing `<command> --help` in the terminal
- Using `g.manual <command>` to see the online manual page

<br>

> **Task:** Now try yourself. Get help for `r.info` and `v.what.stats`.

---

### Query raster and vector maps

![Query raster map](assets/img/query_maps.png)

+++

### Query raster and vector maps

![Query vector map](assets/img/query_vector_maps.png)

---

### Vector's attribute table(s)

<img src="assets/img/vector_attr_table.png" width="85%">

+++

### Vector's attribute table(s)

<br>

> **Task:**
> 
> - Change color of areas
> - Display only boundaries with a different color
> - Show only cat 1-40
> - Build an SQL SELECTION query with at least 2 conditions 

---

### Exploring the sample dataset and region settings
<br>
```bash
# list of raster maps
g.list rast
# list of vector maps
g.list vect
# print region settings
g.region -p
```

+++

>**Tasks:**
>- Explore r.info and v.info help and get basic information about a raster and a vector map
>- Change the current region to a vector map and print the new settings
>- Align the region resolution to a raster map and print it to check

---

### 3D visualization

> **Task:**
> 
> - Display the `elevation` raster map
> - Change to 3D view in the Map Display window
> - Explore the options available in the new 3D tab that appears in the Layer Manager

<img src="assets/img/3d_view.png" width="40%">

---

@snap[north span-100]
<h3>Display base maps from WMS servers</h3>
@snapend

@snap[west span-50]
@size[26px](Step 1)
<img src="assets/img/add_wms_1.png" width="95%">
@snapend

@snap[east span-50]
<br>
@size[26px](Step 2)
<img src="assets/img/add_wms_2.png" width="85%">
@snapend

---

<h3>Display base maps from WMS servers</h3>

<img src="assets/img/add_wms_3.png" width="45%">

> **Task:**
> - Explore the area, zoom in, zoom out
> - Display a vector map over the WMS layer (*Hint: adjust opacity of the vector map*)

---

### Adding map decorations

> **Task:**
>  - Diplay `elevation` and `roadsmajor` maps
>  - Add grid over map
>  - Add roads labels (hint: right click over the map name in the Layer Manager)
>  - Add raster and vector legend
>  - Add scale bar
>  - Add North arrow
>  - Add a title

+++

<img src="assets/img/map_decorations_task.png" width="80%">

---

@snap[north span-70]
<h3>Bivariate Scatter Plots</h3>
@snapend

@snap[west span-50]
![Scatter plot](assets/img/bivariate_scatterplot.png)
@snapend

@snap[east span-50]
@ol[list-content-verbose](false)
- Click over *Analyze map*
- Select *Bivariate scatterplot*
- Select 2 raster maps
- Explore the relationship among map values
@olend
@snapend

---

## Histograms

> **Task:**
> Explore the histogram tools on your own

---

**Thanks for your attention!!**

![GRASS GIS logo](assets/img/grass_logo_alphab.png)

---

@snap[north span-90]
<br><br><br>
Now go to: 
<br>
[Exercise 2: Create a new location and mapset](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=exercises/02_create_new_location&grs=gitlab#/)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend

