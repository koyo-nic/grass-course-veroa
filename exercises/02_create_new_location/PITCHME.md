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

## Exercise 2: Create a new Location and Mapset

---

@snap[north-west span-60]
<h3>Overview</h3>
@snapend

@snap[west span-100]
<br><br>
@ol[list-content-verbose]
- Revise GRASS GIS database structure
- Data
- Create new locations and mapsets: different options
- Change mapsets / add mapsets to path
- Import raster and vector map
- Set, save and change computational region
- Reproject raster and vector maps
- Export raster and vector maps
@olend
@snapend

---

Now I will ask you some questions? 

<br>

> - Location ?
> - Mapset ? 
> - Computational region ?

<br>

You can have a sneak peek at the [GRASS Intro](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/01_general_intro_grass&grs=gitlab#/8) presentation

---

@snap[north span-100]
<h3>Data for this exercise</h3>
@snapend

@snap[west span-60]
@ul[](false)
- Download 
- Create a folder in your $HOME directory (or Documents) and name it `geodata`
- Unzip the files within `geodata`
@ulend
@snapend

@snap[east span-40]
<br><br>
<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://www.openstreetmap.org/export/embed.html?bbox=-127.70507812500001%2C20.797201434307%2C-69.69726562500001%2C50.261253827584724&amp;layer=mapnik" style="border: 1px solid black"></iframe><br/><small><a href="https://www.openstreetmap.org/#map=5/36.932/-98.701">View Larger Map</a></small>
@snapend

---

## Start GRASS GIS

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

### Creating a new Location

Different options:

- From the GUI
  - Button "New" in the Location wizard
  - After starting GRASS GIS, Settings --> GRASS working environment --> Create new location
  - We can use georeferenced maps, EPSG codes, prj files, WKT, etc.

- From command line
  - using `-c` flag in the grass74 script
  - we need to provide path to new location plus either a georeferenced map or an EPSG code

---

#### Creating a new Location from the GUI

<img src="assets/img/new_location_epsg.png" width="90%">

--- 

Create new Location from EPSG code

- EPSG: European Petroleum Survey Group (International Association of Oil & Gas Producers)

- EPSG codes are standardized numbers for national and international coordinate reference systems and coordinate transformations -- used by many GIS software packages.

- Also used in [PROJ](http://trac.osgeo.org/proj/) and [GDAL](http://www.gdal.org/)

- Codes available as SQL database from [http://www.epsg.org](http://www.epsg.org/) or found in
 the PROJ4 installation at /usr/share/proj/epsg

- Useful Web sites:
  - [http://www.epsg-registry.org](http://www.epsg-registry.org/)
  - [http://epsg.io/](http://epsg.io/)

---

#### Create a new mapset from the GUI

Using New button in Mapset wizard
Under Settings --> GRASS working environment --> Create new mapset

---

Create new location from command line

```bash
# Creates new location with EPSG code 4326
grass74 -c EPSG:4326 $HOME/grassdata/mylocation
#  Creates new with EPSG code 5514 with datum transformation parameters used in Czech Republic 
grass74 -c EPSG:5514:3 $HOME/grassdata/mylocation
# Creates new location based on georeferenced Shapefile 
grass74 -c myvector.shp $HOME/grassdata/mylocation
# Creates new location based on georeferenced GeoTIFF file 
grass74 -c myraster.tif $HOME/grassdata/mylocation
```

can also be done from a different location

---

Create new mapset from command line 

well, just add a folder at the end of the former commands.

```bash
# Creates new location with EPSG code 4326
grass74 -c EPSG:4326 $HOME/grassdata/mylocation/mymapset
```

or within a GRASS session:

```bash
# create a new mapset within location
g.mapset -c mapset=curso_rio4
```

---

### Remove Locations or Mapsets

Just remove the folder or use Location wizard

---

### Rename Locations and Mapsets

From Location wizard or from a GRASS GIS session

---

### Change to a different mapset

---

### Add mapsets path

---

### Get information about the CRS

<img src="assets/img/projection_info.png" width="65%">
<br>
or just type in the terminal

```bash
g.proj -p
```
---

**Thanks for your attention!!**

![GRASS GIS logo](assets/img/grass_logo_alphab.png)

---

@snap[north span-90]
<br><br><br>
Now go to: 
<br>
[Raster processing](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/03_raster&grs=gitlab#/) presentation
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend

