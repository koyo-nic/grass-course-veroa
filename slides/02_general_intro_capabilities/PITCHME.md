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

@snap[north span-100]
Raster menu
@snapend

@snap[west span-60]
<img src="assets/img/Raster_menu.png" width="40%">
@snapend

@snap[east span-40]
Most of these modules will work with:
- Raster data: DEMs, land cover, climatic maps...
- Imagery data: Landsat, MODIS, SPOT, QuickBird...
@snapend

@snap[south span-100]
[Raster processing](https://grass.osgeo.org/grass74/manuals/rasterintro.html) manual
@snapend

+++

@snap[north span-100]
Resampling
@snapend

@snap[west span-50]
<img src="assets/img/Raster_resample_options.png" width="60%">
@snapend

@snap[east span-50]
Examples:
- [r.resamp.interp](https://grass.osgeo.org/grass74/manuals/r.resamp.interp.html): Resamples raster map to a finer grid using interpolation (nearest, bilinear, bicubic)
- [r.resamp.stats](https://grass.osgeo.org/grass74/manuals/r.resamp.stats.html): Resamples raster map layers to a coarser grid using aggregation
@snapend

+++

@snap[north span-100]
Raster overlay
@snapend

@snap[west span-50]
<img src="assets/img/Raster_overlay_options.png" width="60%">
<br>
<img src="assets/img/r_patch.png">
@snapend

@snap[east span-50]
Examples:
- [r.series](https://grass.osgeo.org/grass74/manuals/r.series.html): Allows to aggregate a list of maps with different methods, i.e., average, minimum, maximum, etc.
- [r.patch](https://grass.osgeo.org/grass74/manuals/r.patch.html): Creates a composite raster map using known category values from one (or more) map(s) to fill in areas of "no data" in another map
@snapend

+++

@snap[north span-100]
Hydrological modeling
@snapend

@snap[west span-50]
<img src="assets/img/Raster_hydro.png" width="60%">
@snapend

@snap[east span-50]
... plus several other add-ons, including

<img src="assets/img/r_stream_addons.jpg">

<a href="https://doi.org/10.1016/j.cageo.2011.03.003">Jasiewics and Metz, 2011</a>
@snapend

+++

@snap[north span-100]
Landscape and patch analysis
@snapend

@snap[west span-40]
<img src="assets/img/Raster_landscape.png">
@snapend

@snap[east span-60]
... plus several add-ons for "patch analysis"

<img src="assets/img/Raster_r_pi_addons.png">
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Satellite imagery processing

+++

Imagery menu

<img src="assets/img/Imagery_menu.png" width="60%">

[Image processing](https://grass.osgeo.org/grass74/manuals/imageryintro.html) manual

+++

@snap[north span-100]
Manage colors
@snapend

@snap[west span-50]
<img src="assets/img/Imagery_colors.png" width="60%">
@snapend

@snap[east span-50]
[i.colors.enhance](https://grass.osgeo.org/grass74/manuals/i.colors.enhance.html)

<img src="assets/img/i.colors.enhance.jpg">
@snapend

+++

@snap[north span-100]
Transform
@snapend

@snap[west span-50]
<img src="assets/img/Imagery_transform.png" width="60%">
@snapend

@snap[east span-50]
Examples:
- [i.pca](https://grass.osgeo.org/grass74/manuals/i.pca.html): Principal components analysis (PCA) for image processing
- [i.fft](https://grass.osgeo.org/grass74/manuals/i.fft.html): Fast Fourier Transform (FFT) for image processing
- [i.pansharpen](https://grass.osgeo.org/grass74/manuals/i.pansharpen.html): Image fusion algorithms to sharpen multispectral with high-res panchromatic channels 
@snapend

+++

@snap[north span-100]
Classification and Segmentation
@snapend

@snap[west span-50]
<img src="assets/img/Imagery_classification.png" width="60%">

@ul
- Supervised (maxlik, smap)
- Unsupervised
- Segmentation
@ulend
@snapend

@snap[east span-50]
... plus many add-ons: 
- r.learn.ml 
- i.segment.\*
- i.superpixels.slic
- i.ann.\*
- and more...
@snapend

@snap[south span-100]
cite M. Lennert papers
@snapend

+++

@snap[north span-100]
Generic RS tools and tools for specific sensors
@snapend

@snap[west span-60]
<img src="assets/img/Imagery_satellite_especif_tools.png" width="60%">

... plus add-ons for MODIS, Sentinel2, Landsat, SRTM, GPM, etc.
@snapend

@snap
<img src="assets/img/i_atcor_B02_atcorr.png">

@size[18px](Sentinel-2A Band 02 with applied atmospheric correction)
@snapend

+++

@snap[north span-100]
RS derived products
@snapend

@snap[west span-50]
<img src="assets/img/Imagery_products.png" width="60%">
@snapend

@snap[east span-50]
Add-ons: 
- [i.wi](https://grass.osgeo.org/grass74/manuals/addons/i.wi.html)
- [i.lswt](https://grass.osgeo.org/grass74/manuals/addons/i.lswt.html)
- [i.landsat8.swlst](https://grass.osgeo.org/grass74/manuals/addons/i.landsat8.swlst.html)
- [i.rh](https://grass.osgeo.org/grass74/manuals/addons/i.rh.html)
- [i.water](https://grass.osgeo.org/grass74/manuals/addons/i.water.html)
@snapend

+++

@snap[north span-100]
Evapotranspiration
@snapend

@snap[west span-50]
<img src="assets/img/Imagery_ET.png" width="60%">
@snapend

@snap[east span-50]
... and in add-ons
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### 3D raster processing

+++

@snap[west span-50]
<img src="assets/img/3D_raster_menu.png" width="50%">
@snapend

@snap[east span-50]
<img src="assets/img/raster3d_layout.png">
<br>
@size[18px](3D raster map coordinate system and internal tile layout)
@snapend

@snap[south span-100]
[3D raster processing](https://grass.osgeo.org/grass74/manuals/raster3dintro.html) manual
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Vector data processing

+++

@snap[north span-100]
Vector menu
@snapend

@snap[west span-50]
<img src="assets/img/Vector_menu.png" width="40%">
@snapend

@snap[east span-50]
<img src="assets/img/vector_types.png">

Topological vector formats in GRASS GIS
@snapend

@snap[south span-100]
[Vector processing](https://grass.osgeo.org/grass74/manuals/vectorintro.html) manual
@snapend

+++

@snap[north span-100]
Topology maintenance
@snapend

@snap[west span-50]
<img src="assets/img/Vector_topology_maint.png">
@snapend

@snap[east span-50]
<img src="assets/img/v_clean.png"><br>
<img src="assets/img/v_generalize_smooth.png"><br>
See also: [v.generalize](https://grasswiki.osgeo.org/wiki/V.generalize_tutorial) tutorial
@snapend

+++

@snap[north span-100]
Selection and overlaying
@snapend

@snap[west span-50]
<img src="assets/img/Vector_select.png" width="60%">
<br>
<img src="assets/img/Vector_overlay.png" width="60%">
@snapend

@snap[east span-50]
<img src="assets/img/v_select_op_touches.png">
<br>
<img src="assets/img/v_overlay_op_not.png">
@spanend

+++
@snap[north span-100]
Network analysis
@snapend

@snap[west span-50]
<img src="assets/img/Vector_network_analysis.png">
@spanend

@snap[east span-50]
<img src="assets/img/v_net_distance.png">
@snapend

+++

@snap[west span-50]
Report and stats

<img src="assets/img/Vector_report_stats.png">

<img src="assets/img/v_univar.png">
@snapend

@snap[east span-50]
Update attributes

<img src="assets/img/Vector_update_attr.png">

<img src="assets/img/v_rast_stats.png">
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Database management

+++

@snap[nort-west span-50]
<img src="assets/img/DB_menu.png" width="50%">
@snapend

@snap[south-west span-50]
<img src="assets/img/db_execute.png">
@snapend

@snap[east span-50]
<img src="assets/img/vector_db_connections.png">
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Temporal data processing

+++

<img src="assets/img/Temporal_menu.png" width="50%">

We'll see this in more detail on Thursday @fa[smile-o fa-spin text-green]

+++

<img src="assets/img/tgrass_flowchart.png" width=80%>

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
<img src="assets/img/graphical_modeller_python.png" width="80%">
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
Wx-monitors
@snapend

@snap[west span-35]
Run in the terminal:
<br>
```
d.mon wx0
d.rast map=elevation
d.vect map=roadsmajor
```
<br>
@snapend

@snap[east span-65]
<img src="assets/img/wx_monitor.png" width="80%">
@snapend

@snap[south span-100]
@size[24px](The wx-monitors have the same "buttons" than the main Map Display in the GUI)
@snapend

+++

Map-swipe

<img src="assets/img/map_swipe.png" width="70%">

[g.gui.mapswipe](https://grass.osgeo.org/grass74/manuals/g.gui.mapswipe.html)

+++

Animation tool

<img src="assets/img/lsat5_animation.gif" width="80%">

[g.gui.animation](https://grass.osgeo.org/grass74/manuals/g.gui.animation.html)

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Cartographic composer

+++

<img src="assets/img/cartographic_comp_draft.png" width="60%">

[g.gui.psmap](https://grass.osgeo.org/grass77/manuals/g.gui.psmap.html)

+++

Export as .ps .eps or .pdf

<img src="assets/img/elevation.png" width="60%">

+++?code=code/elevation.psmap

@snap[north-east template-note text-gray]
Example of a .psmap file to automatize cartographic composition
@snapend

@[19](raster map)
@[21-29](vector of areas)
@[30-40](vector of lines)
@[41-49](color table, i.e., raster legend)
@[50-57](vector legend)
@[58-67](scale bar)

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Add-ons

---

Some other cool add-ons we'll use:

@ul
- [i.modis](https://grass.osgeo.org/grass74/manuals/addons/i.modis.html)
- [i.sentinel](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.html)
- [r.learn.ml](https://grass.osgeo.org/grass74/manuals/addons/r.learn.ml.html)
- [r.hants](https://grass.osgeo.org/grass74/manuals/addons/r.hants.html)
- [r.seasons](https://grass.osgeo.org/grass74/manuals/addons/r.seasons.html)
- [r.bioclim](https://grass.osgeo.org/grass74/manuals/addons/r.bioclim.html)
@ulend

Just don't forget to check <br>
https://grass.osgeo.org/grass74/manuals/addons/ <br>
from time to time @fa[grin-alt text-green]

--- 

**Thanks for your attention!!**

![GRASS GIS logo](assets/img/grass_logo_alphab.png)

---

@snap[north span-90]
<br><br><br>
Move on to: 
<br>
[Raster data processing](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/03_raster&grs=gitlab#/)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend

<!--- <p><span class="slide-title">Flowchart view plus Python translation</span></p> --->