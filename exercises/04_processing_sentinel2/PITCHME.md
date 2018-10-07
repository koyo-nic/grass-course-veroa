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
@ul[]()
- Sentinel-2A in spring 2015, Sentinel-2B in 2017
- Five days revisit time
- Systematic coverage of land and coastal areas between 84°N and 56°S
- 13 spectral bands with spatial resolutions of 10 m (4 VIS and NIR bands), 20 m (6 red-edge/SWIR bands) and 60 m (3 atmospheric correction bands)
- Data access: <sentinels.copernicus.eu>
@ulend
@snapend

---

Set of GRASS GIS extensions to manage Sentinel 2 data:

- [i.sentinel.download](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.download.html): downloads Copernicus Sentinel products from Copernicus Open Access Hub
- [i.sentinel.import](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.import.html): imports Sentinel satellite data downloaded from Copernicus Open Access Hub
- [i.sentinel.preproc](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.preproc.html): imports and performs atmospheric correction of Sentinel-2 images
- [i.sentinel.mask](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.mask.html): creates clouds and shadows masks for Sentinel-2 images

See [Sentinel wiki](https://grasswiki.osgeo.org/wiki/SENTINEL) for further info

---

[i.sentinel.download](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.download.html)
allows downloading Sentinel-2 products from [Copernicus Open Access Hub](https://scihub.copernicus.eu/).

To connect to Copernicus Open Access Hub a user name and password are required, 
see [Register new account](https://scihub.copernicus.eu/dhus/#/self-registration)
page for signing up.

Create the *SETTING_SENTINEL* file with the following content, e.g. in the
directory `$HOME/gisdata/`:

myusername
mypassword
    
---?code=code/04_S2_imagery_code.sh&lang=bash&title=Download Sentinel 2 data

@[](Start GRASS GIS and create a new mapset)            
@[](Install i.sentinel extension)
@[](Set computational region)
@[](List available scenes intersecting computational region)
@[](List available scenes containing computational region)
@[](Download the data)

+++

Since downloading takes a while, take a pre-downloaded scene from:

<!--- add link --->

move it to `$HOME/gisdata`

+++?code=code/04_S2_imagery_code.sh&lang=bash&title=Import Sentinel 2 data

@[](Print info about bands before importing)
@[](Import the data)
@[](Display an RGB combination)
   
+++

> **Task**: Display an RGB 432 combination of the original data and zoom to computational region only

---?code=code/04_S2_imagery_code.sh&lang=bash&title=Color enhancement

@[](Color enhancement)
@[](Display an RGB combination of the enhanced bands)

+++

![Auto-balanced Sentinel scene RGB](assets/img/S2_color_enhance_uncorr.png)

Auto-balanced Sentinel scene RGB

---

@snap[north span-100]
Import with Atmospheric correction: [i.sentinel.preproc](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.preproc.html)
@snapend

@snap[west span-50]
https://grass.osgeo.org/grass74/manuals/addons/i_sentinel_preproc_GWF.png
@snapend

@snap[east span-50]
We need:

@ol
- unzip file
- visibility map or AOD
- elevation map
@olend
@snapend

+++

@snap[north span-100]
Obtain AOD from [http://aeronet.gsfc.nasa.gov](https://aeronet.gsfc.nasa.gov)
@snapend

@snap[west span-50]
<img src="assets/img/aeronet_download.png">
@snapend

@snap[east span-50]
Download and unzip in $HOME/gisdata (the final file has a .dubovik extension)
@snapend

+++

Elevation map

For now, we'll use the `elevation` map present in NC location
<br>
... but only the region covered by `elevation` map will be atmospherically corrected

+++?code=code/04_S2_imagery_code.sh&lang=bash&title=Import plus Atmospheric correction with i.sentinel.preproc

@[](Enter directory with Sentinel scene and unzip file)
@[](Run i.sentinel.preproc using elevation map in NC location)
@[](Display atmospherically corrected map)

+++
        
![Pre-processed Sentinel scene RGB with elevation]()

---

Let's now use a different elevation map: SRTM

- [Shuttle Radar Topography Mission (SRTM)](https://www2.jpl.nasa.gov/srtm/) 
is a worldwide Digital Elevation Model with a resolution of 30 or 90 meters.
- [r.in.srtm.region](https://grass.osgeo.org/grass7/manuals/addons/r.in.srtm.region.html)
downloads and imports SRTM data for the current computational region.

+++?code=code/04_S2_imagery_code.sh&lang=bash&title=Obtain SRTM digital elevation model

@[]()
@[]()
@[]()

+++

![Pre-processed Sentinel scene RGB with SRTM](figures/sentinel_preproc_srtm.png "Pre-processed Sentinel scene RGB with SRTM")
On the left the Sentinel-2 scene processed with `elevation` map, on the
right the same scene processed with `SRTM` map
        
    d.mon wx0
    d.rgb -n red=T17SQV_20170730T154909_B04_corr green=T17SQV_20170730T154909_B03_corr blue=T17SQV_20170730T154909_B02_corr
    d.barscale length=50 units=kilometers segment=4 fontsize=14
    d.text -b text="Sentinel pre-processed scene" color=black bgcolor=229:229:229 align=cc font=sans size=8

---?code=code/04_S2_imagery_code.sh&lang=bash&title=Clouds and clouds' shadows masks
    
+++
            
![Auto-balanced Sentinel scene RGB](figures/sentinel_cloud.png "Auto-balanced Sentinel scene RGB")

---?code=code/04_S2_imagery_code.sh&lang=bash&title=Vegetation and water indices

@[]()
@[]()
@[]()

+++

screenshot

---?code=code/04_S2_imagery_code.sh&lang=bash&title=Segmentation

@[]()
@[]()
@[]()

+++

screenshot

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
