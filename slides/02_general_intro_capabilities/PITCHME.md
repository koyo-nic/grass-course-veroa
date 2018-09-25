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

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%
@title[Raster Import/Export]

@snap[north text-white span-100]
Modules for import/export of raster maps
@snapend

@snap[west span-50]
<img src="assets/img/File_raster_import.png">
@snapend

@snap[east span-50]
<img src="assets/img/File_raster_export.png">
@snapend

@snap[south span-100]
GRASS relies on [GDAL](https://www.gdal.org/) to import and export raster data
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%
@title[Vector Import/Export]

@snap[north text-white span-100]
Modules for import/export of vector maps
@snapend

@snap[west span-50]
<img src="assets/img/File_vector_import.png">
@snapend

@snap[east span-50]
<img src="assets/img/File_vector_export.png">
@snapend

@snap[south span-100]
GRASS relies on [OGR](https://www.gdal.org/ogr_arch.html) to import and export vector data
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Raster data processing

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Raster menu
@snapend

@snap[west span-50]
<br>
<img src="assets/img/Raster_menu.png" width="90%">
@snapend

@snap[east span-50]
@ul[header-footer-list-shrink](false)
- Raster data: DEM, land cover, climatic maps, etc.
- Imagery data: Landsat, Sentinel, MODIS, SPOT, QuickBird, etc.
@ulend
@snapend

@snap[south span-100]
[Raster processing](https://grass.osgeo.org/grass74/manuals/rasterintro.html) manual
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Resampling
@snapend

@snap[west span-50]
@ul[header-footer-list-shrink](false)
- [r.resamp.interp](https://grass.osgeo.org/grass74/manuals/r.resamp.interp.html): Resamples raster map to a finer grid using different interpolation methods: nearest, bilinear, bicubic (downscaling)
- [r.resamp.stats](https://grass.osgeo.org/grass74/manuals/r.resamp.stats.html): Resamples raster map layers to a coarser grid using aggregation (i.e., upscaling)
@ulend
<br>
@snapend

@snap[east span-50]
<img src="assets/img/Raster_resample_options.png">
<br>
@snapend

@snap[south span-60]
<img src="assets/img/r_resamp_stats_6m_20m.png" width="60%">
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Raster overlay
@snapend

@snap[west span-50]
<img src="assets/img/Raster_overlay_options.png">
<br><br>
@snapend

@snap[south span-60]
<img src="assets/img/r_patch.png" width="70%">
@snapend

@snap[east span-50]
@ul[header-footer-list-shrink](false)
- [r.series](https://grass.osgeo.org/grass74/manuals/r.series.html): Allows to aggregate a list of maps with different methods, i.e., average, min, max, etc.
- [r.patch](https://grass.osgeo.org/grass74/manuals/r.patch.html): Creates a composite raster map using category values from one (or more) map(s) to fill in areas of "no data" in another map
@ulend
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Hydrological modeling
@snapend

@snap[west span-50]
<img src="assets/img/Raster_hydro.png">
@snapend

@snap[east span-50]
@size[20px](... plus several other add-ons, for example:)

<img src="assets/img/r_stream_addons.jpg">

@size[20px](<a href="https://doi.org/10.1016/j.cageo.2011.03.003">Jasiewics and Metz, 2011</a>)
@snapend

@snap[south span-70]
<img src="assets/img/r_stream_collage.png" width="80%">
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Landscape analysis
@snapend

@snap[west span-40]
<img src="assets/img/Raster_landscape.png">
@snapend

@snap[east span-60]
@size[20px](... plus several add-ons for "patch analysis")

<img src="assets/img/Raster_r_pi_addons.png">
@snapend

@snap[south span-80]
<img src="assets/img/r_pi_searchtime.png" width="45%">
@size[20px](<a href="https://doi.org/10.1111/2041-210X.12827">Wegman et al., 2017</a>)
@snapend


---?image=template/img/grass.png&position=bottom&size=100% 30%

### Satellite imagery processing

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Imagery menu
@snapend

@snap[west span-40]
<img src="assets/img/Imagery_menu.png">
@snapend

@snap[east span-60]
<img src="assets/img/Imaging-Spectroscopy-Concept.png" width="90%">
@snapend

@snap[south span-100]
[Image processing](https://grass.osgeo.org/grass74/manuals/imageryintro.html) manual
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Manage colors
@snapend

@snap[west span-50]
<br>
<img src="assets/img/Imagery_colors.png">
<br><br><br>
@snapend

@snap[east span-50]
<br>
<img src="assets/img/i_colors_enhance.jpg" width="85%">
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Transformations
@snapend

@snap[west span-40]
<img src="assets/img/Imagery_transform.png">
@snapend

@snap[east span-60]
@ul[header-footer-list-shrink](false)
- [i.pca](https://grass.osgeo.org/grass74/manuals/i.pca.html): Principal components analysis
- [i.fft](https://grass.osgeo.org/grass74/manuals/i.fft.html): Fast Fourier Transform
- [i.pansharpen](https://grass.osgeo.org/grass74/manuals/i.pansharpen.html): Image fusion algorithms to sharpen multispectral with high-res panchromatic channels
@ulend
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Classification
@snapend

@snap[west span-50]
<img src="assets/img/Imagery_classification.png">
@snapend

@snap[east span-50]
<br>
@ul[header-footer-list-shrink](false)
- [r.learn.ml](https://grass.osgeo.org/grass74/manuals/addons/r.learn.ml.html): Supervised classification and regression with Machine Learning
- [r.fuzzy.system](https://grass.osgeo.org/grass74/manuals/addons/r.fuzzy.system.html): Full fuzzy logic standalone classification system
- [i.ann.maskrcnn](https://grass.osgeo.org/grass74/manuals/addons/i.ann.maskrcnn.html): Supervised classification using convolutional neural networks
- [i.object.activelearning](https://grass.osgeo.org/grass74/manuals/addons/r.object.activelearning.html): Active learning for classifying raster objects
@ulend
@snapend

@snap[south span-100]
@size[20px](Supervised and Unsupervised methods available. See <a href="https://grasswiki.osgeo.org/wiki/Image_classification">Image classification</a> wiki for details and mini tutorial)
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Segmentation and OBIA
@snapend

@snap[west span-40]
<br>
@size[20px](OBIA-automated classification)
<img src="assets/img/remotesensing_grass_obia.png" width="85%">
@snapend

@snap[east span-60]
<br>
@ul[header-footer-list-shrink](false)
- [i.segment](https://grass.osgeo.org/grass77/manuals/i.segment.html): Identifies segments (objects) from imagery data
- [i.segment.hierarchical](https://grass.osgeo.org/grass74/manuals/addons/i.segment.hierarchical.html): Hierarchical segmentation
- [i.segment.stats](https://grass.osgeo.org/grass74/manuals/addons/i.segment.stats.html): Calculates statistics describing raster areas
- [i.segment.uspo](https://grass.osgeo.org/grass74/manuals/addons/i.segment.uspo.html): Unsupervised segmentation parameter optimization
- [i.superpixels.slic](https://grass.osgeo.org/grass74/manuals/addons/i.superpixels.slic.html): Performs image segmentation using SLIC method
@ulend
@snapend

@snap[south span-100]
@size[26](<a href="https://github.com/tgrippa/Opensource_OBIA_processing_chain">OBIA processing chain</a>)
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Generic RS tools and tools for specific sensors
@snapend

@snap[west span-60]
<br>
<img src="assets/img/Imagery_satellite_especif_tools.png">
<br>
@size[20px](... plus add-ons for MODIS, Sentinel2, Landsat, SRTM, GPM, etc.)
@snapend

@snap[east span-40]
<br>
<img src="assets/img/i_atcorr_B02_atcorr.png" width="85%">

@size[16px](Sentinel-2A Band 02 after *i.atcorr*)
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
RS derived products
@snapend

@snap[west span-40]
<br>
<img src="assets/img/Imagery_products.png">
<br>
<img src="assets/img/ndvi.png" width="80%">
@snapend

@snap[east span-60]
<br>
@ul[header-footer-list-shrink](false)
- [i.wi](https://grass.osgeo.org/grass74/manuals/addons/i.wi.html): Calculates different types of water indices
- [i.lswt](https://grass.osgeo.org/grass74/manuals/addons/i.lswt.html): Computes Lake Surface Water Temperatures from TOA Brightness Temperatures
- [i.landsat8.swlst](https://grass.osgeo.org/grass74/manuals/addons/i.landsat8.swlst.html): Split-window algorithm estimating LST from Landsat 8 OLI/TIRS
- [i.rh](https://grass.osgeo.org/grass74/manuals/addons/i.rh.html): Water in atmosphere: relative humidity, water vapour
- [i.water](https://grass.osgeo.org/grass74/manuals/addons/i.water.html): Water detection from satellite data derived indices
@ulend
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### 3D raster processing

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
3D raster menu
@snapend

@snap[west span-50]
<br>
<img src="assets/img/3D_raster_menu.png">
<br><br>
@snapend

@snap[east span-50]
<br>
<img src="assets/img/raster3d_layout.png" width="80%">
<br>
@size[18px](3D raster coordinate system and internal tile layout)
@snapend

@snap[south span-100]
[3D raster processing](https://grass.osgeo.org/grass74/manuals/raster3dintro.html) manual
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Vector data processing

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Vector menu
@snapend

@snap[west span-50]
<img src="assets/img/Vector_menu.png">
@snapend

@snap[east span-50]
<img src="assets/img/vector_types.png">

@size[18px](Topological vector formats in GRASS GIS)
@snapend

@snap[south span-100]
[Vector processing](https://grass.osgeo.org/grass74/manuals/vectorintro.html) manual
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Topology maintenance
@snapend

@snap[midpoint span-90]
<img src="assets/img/Vector_topology_maint.png" width="80%">
<br><br><br><br>
@snapend

@snap[south-west span-65]
<img src="assets/img/v_clean.png" width="60%"><br>
@size[16px](Cleaning topological errors in vector map)
@snapend

@snap[south-east span-65]
<img src="assets/img/v_generalize_smooth.png" width="60%"><br>
@size[16px](Smoothing. See also the <a href="https://grasswiki.osgeo.org/wiki/V.generalize_tutorial">v.generalize</a> wiki)
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Selection and overlaying
@snapend

@snap[west span-50]
<img src="assets/img/Vector_select.png">
<br><br><br><br>
<img src="assets/img/Vector_overlay.png">
@snapend

@snap[east span-50]
<br>
<img src="assets/img/v_select_op_touches.png" width="60%">
@size[15px](v.select operator *TOUCHES*)
<br><br><br>
<img src="assets/img/v_overlay_op_not.png" width="50%">
@size[15px](v.overlay operator *NOT*)
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Network analysis
@snapend

@snap[west span-50]
<img src="assets/img/Vector_network_analysis.png">
@snapend

@snap[east span-50]
<img src="assets/img/v_net_distance.png">
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Reporting, stats and update of attributes
@snapend

@snap[west span-50]
<br>
<img src="assets/img/Vector_report_stats.png">

<img src="assets/img/v_univar.png">
@snapend

@snap[east span-50]
<br><br>
<img src="assets/img/Vector_update_attr.png">

<img src="assets/img/v_rast_stats.png" width="90%">
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Database management

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Database management menu
@snapend

@snap[west span-50]
<img src="assets/img/DB_menu.png" width="95%">
<br><br><br><br>
@snapend

@snap[east span-50]
<img src="assets/img/vector_db_connections.png">
<br><br><br>
@snapend

@snap[south span-60]
<img src="assets/img/db_execute.png" width="55%">
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Temporal data processing

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Temporal menu
@snapend

@snap[west span-50]
<img src="assets/img/Temporal_menu.png">
@snapend

@snap[east span-50]
@ul[header-footer-list-shrink](false)
- import/export
- temporal topology
- aggregation
- accumulation
- temporal algebra
- temporal interpolation
@ulend
@snapend

@snap[south span-100]
We'll see this in more detail on Thursday @fa[smile-o fa-spin text-green]
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Graphical modeler

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Graphic model and Python translation
@snapend

@snap[west span-50]
<img src="assets/img/graphical_modeller.png">
@snapend 

@snap[east span-50]
<img src="assets/img/graphical_modeller_python.png" width="90%">
@snapend

@snap[south span-100]
See [g.gui.gmodeler](https://grass.osgeo.org/grass74/manuals/wxGUI.gmodeler.html) manual page for further details.
@snapend

---?image=template/img/grass.png&position=bottom&size=100% 30%

### Visualization tools

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Map display: console tab
@snapend

@snap[south span-100]
<img src="assets/img/map_display_and_gui_console.png" width="85%">
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Map display: data tab
@snapend

@snap[south span-100]
<img src="assets/img/map_display_and_data_tab.png" width="85%">
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Map display: 3D view
@snapend

@snap[south span-100]
<img src="assets/img/3d_view.png" width="85%">
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Wx-monitors
@snapend

@snap[west span-40]
From the terminal:
<img src="assets/img/terminal_wx0_call.png">
@snapend

@snap[east span-60]
<img src="assets/img/wx_monitor.png" width="90%">
@snapend

@snap[south span-100]
@size[26px](The wx-monitors have the same **buttons** than the main Map Display in the GUI)
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Map-swipe
@snapend

@snap[midpoint span-100]
<br>
<img src="assets/img/map_swipe.png" width="60%">
@snapend

@snap[south span-100]
[g.gui.mapswipe](https://grass.osgeo.org/grass74/manuals/g.gui.mapswipe.html)
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Animation tool
@snapend

@snap[midpoint span-100]
<br>
<img src="assets/img/lsat5_animation.gif" width="70%">
@snapend

@snap[south span-100]
[g.gui.animation](https://grass.osgeo.org/grass74/manuals/g.gui.animation.html)
@snapend

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Cartographic composer
@snapend

@snap[midpoint span-100]
<br>
<img src="assets/img/cartographic_comp_draft.png" width="50%">
@snapend

@snap[south span-100]
[g.gui.psmap](https://grass.osgeo.org/grass77/manuals/g.gui.psmap.html)
@snapend

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

+++?image=template/img/bg/green.jpg&position=top&size=100% 15%

@snap[north text-white span-100]
Some (other) cool add-ons
@snapend

@snap[midpoint span-100]
@ul[header-footer-list-shrink](false)
- [i.modis](https://grass.osgeo.org/grass74/manuals/addons/i.modis.html): Toolset for download and processing of MODIS products using pyModis
- [i.sentinel](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.html): Toolset for download and processing of Copernicus Sentinel products
- [r.hants](https://grass.osgeo.org/grass74/manuals/addons/r.hants.html): Approximates a periodic time series with harmonics
- [r.seasons](https://grass.osgeo.org/grass74/manuals/addons/r.seasons.html): Extracts seasons from a time series
- [r.bioclim](https://grass.osgeo.org/grass74/manuals/addons/r.bioclim.html): Calcuates bioclimatic indices
- ... and **other 300+ more in the official repo!!**
@ulend
@snapend

@snap[south span-100]
@fa[grin #8EA33B]
@size[24px](Don't forget to check <a href="https://grass.osgeo.org/grass74/manuals/addons/">https://grass.osgeo.org/grass74/manuals/addons/</a> from time to time)
@snapend

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