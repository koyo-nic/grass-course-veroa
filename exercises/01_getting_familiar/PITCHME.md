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
grass74

# power users
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
- Select the GRASS database folder
- Select the location `nc_spm_08_grass7`
- Select `user1` mapset
- Start
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

![GRASS GUI]()

---

... and the Terminal

![]()

---

## Displaying raster and vector maps

---

Calling GRASS GIS commands

- From the GUI: main menu, console tab, module tab
- From the terminal: first letter or some letters + <tab><tab>

---

Note *Copy* button in commands interface and Log in GUI console

---

## Query raster and vector maps


---

## 3D visualization


---

## Displaying base maps

---

Add decorations

---

## Plots

---

**Thanks for your attention!!**

![GRASS GIS logo](assets/img/grass_logo_alphab.png)

---

@snap[north span-90]
<br><br><br>
Move on to: 
<br>
[your house]()
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend

