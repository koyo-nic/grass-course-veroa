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

## GRASS GIS: An overview of general capabilities

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Interoperability

+++

<img src="assets/img/grass_database_vs_geodata.png" width="90%">

+++

Modules for import/export of vector and raster maps

<img src="assets/img/File_raster_import.png">

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Raster processing

+++

#### Raster menu

<img src="assets/img/Raster_menu.png" width="70%">

[Raster processing](https://grass.osgeo.org/grass74/manuals/rasterintro.html) manual

+++

Resampling

<img src="assets/img/Raster_resample_options.png">

+++

Raster overlay

<img src="assets/img/Raster_overlay_options.png">

+++

Hydrological modeling

<img src="assets/img/Raster_hydro.png">

+++

Landscape and patch analysis

<img src="assets/img/Raster_landscape.png">

<img src="assets/img/Raster_r_pi_addons.png">

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Satellite imagery processing

+++

Imagery menu

<img src="assets/img/Imagery_menu.png">

[Image processing](https://grass.osgeo.org/grass74/manuals/imageryintro.html) manual

+++

Manage colors

<img src="assets/img/Imagery_colors.png">

+++

Transform

<img src="assets/img/Imagery_transform.png">

+++

Classification and Segmentation

<img src="assets/img/Imagery_classification.png">

+ many add-ons: r.learn.ml, i.segment.\*, i.superpixels.slic, i.ann.\*

+++

Generic tools and tools for specific sensors

<img src="assets/img/Imagery_satellite_especif_tools.png">

Add-ons for MODIS, Sentinel2, Landsat, SRTM, GPM, etc.

+++

Products

<img src="assets/img/Imagery_products.png">

Add-ons: [i.wi](https://grass.osgeo.org/grass74/manuals/addons/i.wi.html), i.lswt, etc.

+++

Evapotranspiration

<img src="assets/img/Imagery_ET.png">

... and in add-ons

---?image=template/img/grass.png&position=bottom&size=100% 30%

### 3D raster processing

+++

<img src="assets/img/3D_raster_menu.png">

[3D raster processing](https://grass.osgeo.org/grass74/manuals/raster3dintro.html) manual

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Vector processing

+++

Vector menu

<img src="assets/img/Vector_menu.png" width="70%">

[Vector processing](https://grass.osgeo.org/grass74/manuals/vectorintro.html) manual

+++

Topology maintenance

<img src="assets/img/Vector_topology_maint.png">

+++

Selection and overlaying

<img src="assets/img/Vector_select.png">

<img src="assets/img/Vector_overlay.png">

+++

Network analysis

<img src="assets/img/Vector_network_analysis.png">

+++

Report and stats

<img src="assets/img/Vector_report_stats.png">

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Database

+++

<img src="assets/img/DB_menu.png">

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Time series

+++

<img src="assets/img/Temporal_menu.png">

We'll see this on thursday @fa[smile-o fa-spin text-green]

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Graphical modeler

+++

@snap[north span-100]
Flowchart view plus Python translation
@snapend

@snap[west span-50]
<img src="assets/img/graphical_modeller.png">
@snapend 

@snap[east span-50]
<img src="assets/img/graphical_modeller_python.png">
@snapend

@snap[south span-100]
See [g.gui.gmodeler](https://grass.osgeo.org/grass74/manuals/wxGUI.gmodeler.html) manual page for further details.
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Visualization tools

+++

Map display

<img src="assets/img/map_display_and_gui_console.png" width="80%">

+++

Map display

<img src="assets/img/map_display_and_data_tab.png" width="80%">

+++

3D view

<img src="assets/img/3d_view.png" width="80%">

+++

@snap[north span-100]
wx-monitor
@snapend

@snap[west span-30]
Run in the terminal:

```
d.mon wx0
d.rast map=elevation
d.vect map=roadsmajor
```
<br>
@snapend

@snap[east span-70]
<img src="assets/img/wx_monitor.png">
@snapend

+++

Map-swipe

<img src="assets/img/map_swipe.png" width="70%">

+++

Animation tool

<img src="assets/img/lsat5_animation.gif" width="80%">

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Cartographic composer

+++

<img src="assets/img/cartographic_comp_draft.png" width="80%">

+++

Export as .ps .eps or .pdf

<img src="assets/img/elevation.png">

+++?code=code/elevation.psmap

@[19](raster map)
@[21-29](vector of areas)
@[30-40](vector of lines)

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Add-ons

<!--- Introduce some other useful add-ons --->

---

**Thanks for your attention!!**

![GRASS GIS logo](assets/img/grass_logo_alphab.png)

---

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend

<!--- <p><span class="slide-title">Flowchart view plus Python translation</span></p> --->