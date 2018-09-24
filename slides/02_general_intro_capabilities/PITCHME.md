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

## GRASS GIS: Overview of general capabilities

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Interoperability

+++

<img src="assets/img/grass_database_vs_geodata.png" width="90%">

+++
@title[Import/Export]

@snap[north span-100]
Modules for import/export of vector and raster maps
@snapend

@snap[west span-50]
<img src="assets/img/File_raster_import.png">
@snapend

@snap[east span-50]
<img src="assets/img/File_raster_export.png">
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Raster data processing

+++

#### Raster menu

<img src="assets/img/Raster_menu.png" width="60%">

[Raster processing](https://grass.osgeo.org/grass74/manuals/rasterintro.html) manual

+++

Resampling

<img src="assets/img/Raster_resample_options.png" width="60%">

+++

Raster overlay

<img src="assets/img/Raster_overlay_options.png" width="60%">

+++

Hydrological modeling

<img src="assets/img/Raster_hydro.png" width="60%">

+++

@snap[north span-100]
Landscape and patch analysis
@snapend

@snap[west span-40]
<img src="assets/img/Raster_landscape.png">
@snapend

@snap[east span-60]
<img src="assets/img/Raster_r_pi_addons.png">
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Satellite imagery processing

+++

Imagery menu

<img src="assets/img/Imagery_menu.png" width="60%">

[Image processing](https://grass.osgeo.org/grass74/manuals/imageryintro.html) manual

+++

Manage colors

<img src="assets/img/Imagery_colors.png" width="60%">

+++

Transform

<img src="assets/img/Imagery_transform.png" width="60%">

+++

Classification and Segmentation

<img src="assets/img/Imagery_classification.png" width="60%">

... plus many add-ons: r.learn.ml, i.segment.\*, i.superpixels.slic, i.ann.\*

+++

Generic tools and tools for specific sensors

<img src="assets/img/Imagery_satellite_especif_tools.png" width="60%">

... plus add-ons for MODIS, Sentinel2, Landsat, SRTM, GPM, etc.

+++

Products

<img src="assets/img/Imagery_products.png" width="60%">

Add-ons: [i.wi](https://grass.osgeo.org/grass74/manuals/addons/i.wi.html), i.lswt, etc.

+++

Evapotranspiration

<img src="assets/img/Imagery_ET.png" width="60%">

... and in add-ons

---?image=template/img/grass.png&position=bottom&size=100% 30%

### 3D raster processing

+++

<img src="assets/img/3D_raster_menu.png" width="60%">

[3D raster processing](https://grass.osgeo.org/grass74/manuals/raster3dintro.html) manual

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Vector data processing

+++

Vector menu

<img src="assets/img/Vector_menu.png" width="60%">

[Vector processing](https://grass.osgeo.org/grass74/manuals/vectorintro.html) manual

+++

Topology maintenance

<img src="assets/img/Vector_topology_maint.png" width="60%">

+++

Selection and overlaying

<img src="assets/img/Vector_select.png" width="60%">

<img src="assets/img/Vector_overlay.png" width="60%">

+++

Network analysis

<img src="assets/img/Vector_network_analysis.png" width="60%">

+++

Report and stats

<img src="assets/img/Vector_report_stats.png" width="60%">

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Database management

+++

<img src="assets/img/DB_menu.png" width="60%">

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Temporal data processing

+++

<img src="assets/img/Temporal_menu.png" width="60%">

We'll see this in more detail on Thursday @fa[smile-o fa-spin text-green]

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
<img src="assets/img/graphical_modeller_python.png" width="50%">
@snapend

@snap[south span-100]
See [g.gui.gmodeler](https://grass.osgeo.org/grass74/manuals/wxGUI.gmodeler.html) manual page for further details.
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Visualization tools

+++

Map display: console tab

<img src="assets/img/map_display_and_gui_console.png" width="80%">

+++

Map display: data tab

<img src="assets/img/map_display_and_data_tab.png" width="80%">

+++

Map display: 3D view

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
<img src="assets/img/wx_monitor.png" width="60%">
@snapend

@snap[south span-100]
@size[24px](wx-monitors have the same "buttons" than the main Map Display in the GUI)
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

<img src="assets/img/cartographic_comp_draft.png" width="60%">

+++

Export as .ps .eps or .pdf

<img src="assets/img/elevation.png" width="60%">

+++?code=code/elevation.psmap

@[19](raster map)
@[21-29](vector of areas)
@[30-40](vector of lines)
@[41-49](color table, i.e., raster legend)
@[50-57](vector legend)
@[58-67](scale bar)

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Add-ons

---

Some cool add-ons we'll use:

@ul
- [i.modis](https://grass.osgeo.org/grass74/manuals/addons/i.modis.html)
- [i.sentinel](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.html)
- [r.learn.ml](https://grass.osgeo.org/grass74/manuals/addons/r.learn.ml.html)
- [r.hants](https://grass.osgeo.org/grass74/manuals/addons/r.hants.html)
- [r.series.lwr](https://grass.osgeo.org/grass74/manuals/addons/r.series.lwr.html)
- [r.seasons](https://grass.osgeo.org/grass74/manuals/addons/r.seasons.html)
- [r.bioclim](https://grass.osgeo.org/grass74/manuals/addons/r.bioclim.html)
@ulend

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