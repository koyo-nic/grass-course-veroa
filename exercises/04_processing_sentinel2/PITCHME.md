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

## Processing Copernicus Sentinel 2 data in GRASS GIS

---

@snap[north-west span-60]
<h3>Overview</h3>
@snapend

@snap[west span-100]
<br><br>
@ol[list-content-verbose]
- List available scenes and download
- Import Sentinel 2 data
- Color autobalance
- Pre-processing
- Cloud and cloud shadow masking
- Vegetation and water indices
- Image segmentation
@olend
@snapend

---

@snap[north span-100]
<h3>Sentinel 2 data</h3>
@snapend

@snap[west span-40]
![Sentinel 2 satellite](assets/img/sentinel2.jpg)
@snapend

@snap[east span-60]
<br><br>
@ul[list-content-verbose](false)
- Sentinel-2A in spring 2015, Sentinel-2B in 2017
- Five days revisit time
- Systematic coverage of land and coastal areas between 84°N and 56°S
- 13 spectral bands with spatial resolutions of 10 m (4 VIS and NIR bands), 20 m (6 red-edge/SWIR bands) and 60 m
@ulend
@snapend

---

Set of GRASS GIS extensions to manage Sentinel 2 data:

- [i.sentinel.download](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.download.html): downloads Copernicus Sentinel products from Copernicus Open Access Hub
- [i.sentinel.import](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.import.html): imports Sentinel satellite data downloaded from Copernicus Open Access Hub
- [i.sentinel.preproc](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.preproc.html): imports and performs atmospheric correction of Sentinel-2 images
- [i.sentinel.mask](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.mask.html): creates clouds and shadows masks for Sentinel-2 images

@size[24px](See <a href="https://grasswiki.osgeo.org/wiki/SENTINEL">Sentinel wiki</a> for further info)

+++

- [i.sentinel.download](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.download.html)
allows downloading Sentinel-2 products from [Copernicus Open Access Hub](https://scihub.copernicus.eu/)
- To connect to Copernicus Open Access Hub, you need to be [registered](https://scihub.copernicus.eu/dhus/#/self-registration)
- Create the *SETTING_SENTINEL* file with the following content in the `$HOME/gisdata/` directory:

```
myusername
mypassword
```
    
---?code=code/04_S2_imagery_code.sh&lang=bash&title=Download Sentinel 2 data

@[22-23](Start GRASS GIS and create a new mapset)            
@[25-26](Install i.sentinel extension)
@[28-29](Set computational region)
@[31-39](List available scenes intersecting computational region)
@[41-45](List available scenes containing computational region)
@[47-50](Download selected scene)

+++

Since downloading takes a while, we'll skip it. Take a pre-downloaded scene from:

< add link >

and move it to `$HOME/gisdata`

---?code=code/04_S2_imagery_code.sh&lang=bash&title=Import Sentinel 2 data

@[52-66](Print info about bands before importing)
@[68-71](Import the data)
   
+++

> **Task**: Display an RGB 432 combination of the original data and zoom to computational region. How does it look like?

---?code=code/04_S2_imagery_code.sh&lang=bash&title=Color enhancement

@[79-82](Color enhancement)
@[84-88](Display an RGB combination of the enhanced bands)

+++

![Auto-balanced Sentinel scene RGB](assets/img/S2_color_enhance_uncorr.png)

@size[24px](Auto-balanced Sentinel scene RGB)

---

@snap[north span-100]
Import with Atmospheric correction: <a href="https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.preproc.html">i.sentinel.preproc</a>
@snapend

@snap[west span-50]
<br>
![](https://grass.osgeo.org/grass74/manuals/addons/i_sentinel_preproc_GWF.png)
@snapend

@snap[east span-50]
We need:
@ol[list-content-verbose](false)
- unzip S2 file
- visibility map or AOD (Aerosol Optic Depth)
- elevation map
@olend
@snapend

+++

@snap[north span-100]
Obtain AOD from [http://aeronet.gsfc.nasa.gov](https://aeronet.gsfc.nasa.gov)
@snapend

@snap[west span-40]
<img src="assets/img/aeronet_download.png" width="55%">
@snapend

@snap[east span-60]
@ul[list-content-verbose](false)
- EPA-Res_Triangle_Pk station
- Select start and end date
- Choose Combined file and All points
- Download and unzip in `$HOME/gisdata` (the final file has a .dubovik extension)
@ulend
@snapend

+++

Elevation map
<br>

For now, we'll use the `elevation` map present in NC location
<br>
... but only the region covered by `elevation` map will be atmospherically corrected

+++?code=code/04_S2_imagery_code.sh&lang=bash&title=Import plus Atmospheric correction with i.sentinel.preproc

@[96-98](Enter directory with Sentinel scene and unzip file)
@[107-113](Run i.sentinel.preproc using elevation map in NC location)
@[115-118](Color enhancement)
@[120-124](Display atmospherically corrected map)

---

Let's now use a different elevation map: SRTM

- [Shuttle Radar Topography Mission (SRTM)](https://www2.jpl.nasa.gov/srtm/) 
is a worldwide Digital Elevation Model with a resolution of 30 or 90 meters.
- [r.in.srtm.region](https://grass.osgeo.org/grass7/manuals/addons/r.in.srtm.region.html)
downloads and imports SRTM data for the current computational region.

+++?code=code/04_S2_imagery_code.sh&lang=bash&title=Obtain SRTM digital elevation model

@[132-137](Get bounding box of the full S2 scene)
@[139-140](Open a new grass session in a lat-long location)
@[142-143](Set the region using the values obtained in NC location)
@[145-146](Install r.in.srtm.region extension)
@[148-151](Download and import SRTM data for the region)

+++

> **Task**: Display the imported SRTM map and get basic info

+++?code=code/04_S2_imagery_code.sh&lang=bash&title=Reproject and run i.sentinel.preproc again

@[158-160](Change back to NC location and reproject the SRTM map)
@[162-168](Use `srtm` map in i.sentinel.preproc)

+++

> **Task**: Enhance colors and display an RGB combination of the S2 full scene

+++

![RGB corrected S2 image - elevation region](assets/img/S2_color_enhance_corr_full_elev_region.png)


---?code=code/04_S2_imagery_code.sh&lang=bash&title=Clouds and clouds' shadows masks

@[187-191](Identify and mask clouds and clouds shadows)
@[193-199](Display output)

+++
            
![Clouds and cloud shadows](assets/img/S2_clouds_and_shadows.png)

@size[24px](Clouds and cloud shadows identified by *i.sentinel.mask*)

---?code=code/04_S2_imagery_code.sh&lang=bash&title=Vegetation and water indices

@[207-221](Set computational region)
@[223-227](Set clouds mask)
@[229-237](Estimate vegetation indices)
@[239-240](Install i.wi extension)
@[242-245](Estimate water indices)

+++

![Sentinel 2 - NDVI and EVI](assets/img/S2_ndvi_evi.png)

@size[24px](NDVI and EVI from Sentinel 2)

+++

<img src="assets/img/S2_ndwi.png" width="60%">

@size[24px](NDWI from Sentinel 2)

---?code=code/04_S2_imagery_code.sh&lang=bash&title=Segmentation

@[253-254](Install extension)
@[256-259](List maps and create groups and subgroups)
@[261-264](Run i.superpixels.slic)
@[266-269](Run i.segment)
@[271-275](Display NDVI along with the 2 segmentation outputs)

+++

<img src="assets/img/S2_segment_results.png" width="70%">

@size[24px](Segmentation results)

---

## QUESTIONS?

<img src="assets/img/gummy-question.png" width="45%">

---

**Thanks for your attention!!**

![GRASS GIS logo](assets/img/grass_logo_alphab.png)

---

@snap[north span-90]
<br><br><br>
Move on to: 
<br>
[Temporal data processing](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/05_temporal&grs=gitlab)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend
