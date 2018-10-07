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

## Processing Copernicus Sentinel 2 in GRASS GIS

---

### Overview

- List available scenes and download
- Import all the bands
- Color autobalance
- Pre-processing
- Cloud and cloud shadow masking
- Data fusion/Pansharpening
- Vegetation and water indices
- Image segmentation

---

### Sentinel 2 satellite data

<!--- add info about Sentinel 2 --->

---

GRASS GIS has a new set of extensions to manage Sentinel 2 data:

- [i.sentinel.download](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.download.html): downloads Copernicus Sentinel products from Copernicus Open Access Hub
- [i.sentinel.import](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.import.html): downloads Copernicus Sentinel products from Copernicus Open Access Hub
- [i.sentinel.preproc](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.preproc.html): Imports and performs atmospheric correction of Sentinel-2 images
- [i.sentinel.mask](https://grass.osgeo.org/grass7/manuals/addons/i.sentinel.mask.html): Creates clouds and shadows masks for Sentinel-2 images

---
[i.sentinel.download](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.download.html)
allows downloading Sentinel-2 products from [Copernicus Open Access Hub](https://scihub.copernicus.eu/).

To connect to Copernicus Open Access Hub a user name and password are required, 
see [Register new account](https://scihub.copernicus.eu/dhus/#/self-registration)
page for signing up.

Create the *SETTING_SENTINEL* file with the following content, e.g. in the
directory `$HOME/gisdata/`:

myusername
mypassword
    
---?code=code/04_S2_imagery_code.sh&lang=bash&title=Download and Import Sentinel 2 data
            
@[](Install i.sentinel extension)
@[](List available scenes)
@[](Download the data)
@[](Import the data)
@[](Display an RGB combination)
   
+++

![Original Sentinel scene RGB](figures/sentinel_original.png "Original Sentinel scene RGB")

+++?code=code/04_S2_imagery_code.sh&lang=bash&title=Color enhancement

@[](Color enhancement)
@[](Display an RGB combination of the enhanced bands)

+++

![Auto-balanced Sentinel scene RGB](figures/sentinel_color_enhance.png "Auto-balanced Sentinel scene RGB")

+++?code=code/04_S2_imagery_code.sh&lang=bash&title=Import plus Atmospheric correction with i.sentinel.preproc

@[](Enter directory with Sentinel scene and unzip file)

+++
        
Another required input is the visibility map. Since we don't have this
kind of data, we will replace it with an estimated Aerosol Optical Depth
(AOD) value. It is possible to obtain AOD from
[http://aeronet.gsfc.nasa.gov](https://aeronet.gsfc.nasa.gov). In this
case, we will use the
[EPA-Res_Triangle_Pk](https://aeronet.gsfc.nasa.gov/cgi-bin/webtool_opera_v2_inv?stage=3&region=United_States_East&state=North_Carolina&site=EPA-Res_Triangle_Pk&place_code=10&if_polarized=0)
station, select `01-07-2017` as start date and `30-08-2017` as end
date, tick the box labelled as 'Combined file (all products without
phase functions)' near the bottom, choose 'All Points' under Data
Format, and download and unzip the file into `$HOME/gisdata/` folder
(the final file has a .dubovik extension).
The last input data required is the elevation map. Inside the
`North Carolina basic location` there is an elevation map called
`elevation`. The extent of the `elevation` map is smaller than our
Sentinel-2 image's extent, so if you will use this elevation map only a
subset of the Sentinel image will be atmospherically corrected; to get
an elevation map for the entire area please read the [next
session](#srtm). At this point you can run
[i.sentinel.preproc](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.preproc.html)
(please check which elevation map you want to use). The `text_file`
option creates a text file useful as input for
[i.sentinel.mask](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.mask.html),
the next step in the workflow.
            
    i.sentinel.preproc -atr input_dir=$HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.SAFE elevation=elevation aeronet_file=$HOME/gisdata/170701_170831_EPA-Res_Triangle_Pk.dubovik suffix=corr text_file=$HOME/gisdata/sentinel_mask
          
        
![Pre-processed Sentinel scene RGB with
elevation](figures/sentinel_preproc_ele.png "Pre-processed Sentinel scene RGB with elevation")
![Pre-processed Sentinel scene RGB with
SRTM](figures/sentinel_preproc_srtm.png "Pre-processed Sentinel scene RGB with SRTM")
On the left the Sentinel-2 scene processed with `elevation` map, on the
right the same scene processed with `SRTM` map
        
    d.mon wx0
    d.rgb -n red=T17SQV_20170730T154909_B04_corr green=T17SQV_20170730T154909_B03_corr blue=T17SQV_20170730T154909_B02_corr
    d.barscale length=50 units=kilometers segment=4 fontsize=14
    d.text -b text="Sentinel pre-processed scene" color=black bgcolor=229:229:229 align=cc font=sans size=8
            
Finally you can get the clouds and clouds' shadows masks for the
Sentinel-2 scene using
[i.sentinel.mask](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.mask.html).
            
    i.sentinel.mask input_file=$HOME/gisdata/sentinel_mask cloud_mask=T17SQV_20170730T160022_cloud shadow_mask=T17SQV_20170730T160022_shadow mtd=$HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.SAFE/MTD_MSIL1C.xml
            
At this point we can visualize the output of
[i.sentinel.mask](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.mask.html).
        
    d.mon wx0
    d.rgb -n red=T17SQV_20170730T154909_B04_corr green=T17SQV_20170730T154909_B03_corr blue=T17SQV_20170730T154909_B02_corr
    d.vect T17SQV_20170730T160022_cloud fill_color=red
    d.barscale length=50 units=kilometers segment=4 fontsize=14
    d.text -b text="Cloud mask in red" color=black bgcolor=229:229:229 align=cc font=sans size=8
            
![Auto-balanced Sentinel scene RGB](figures/sentinel_cloud.png "Auto-balanced Sentinel scene RGB")


#### How to obtain SRTM digital elevation model

[Shuttle Radar Topography Mission (SRTM)](https://www2.jpl.nasa.gov/srtm/) is a worldwide Digital
Elevation Model with a resolution of 30 or 90 meters. GRASS GIS has two
modules to work with SRTM data,
[r.in.srtm](https://grass.osgeo.org/grass74/manuals/r.in.srtm.html) to
import already downloaded SRTM data and, the add-on
[r.in.srtm.region](https://grass.osgeo.org/grass74/manuals/addons/r.in.srtm.region.html)
which is able to download and import SRTM data for the current GRASS GIS
computational region. However,
[r.in.srtm.region](https://grass.osgeo.org/grass74/manuals/addons/r.in.srtm.region.html)
is working only in a Longitude-Latitude location.

First, we need to obtain the bounding box, in Longitude and Latitude on
WGS84, of the Sentinel data we want to process
           
    g.region raster=T17SQV_20170730T154909_B04,T17SPV_20170730T154909_B04 -b
      
Now, we have to start a new GRASS GIS session in a Longitute-Latitude location
        
    grass74 -c EPSG:4326 $HOME/grassdata/longlat
        
Set the right region using the values obtain before

g.region n=36:08:35N s=35:06:24N e=77:33:33W w=79:54:47W -p
      
After this you need to install
[r.in.srtm.region](https://grass.osgeo.org/grass74/manuals/addons/r.in.srtm.region.html)
and run it
            
    # install r.in.srtm.region
    g.extension r.in.srtm.region
    # run r.in.srtm.region downloading SRTM data and import them as srtm raster map
    r.in.srtm.region output=srtm user=your_NASA_user pass=your_NASA_password
        
You can now exit from this GRASS GIS session and restart to work in the
previous one (where Sentinel data are).
To reproject the SRTM map from the `longlat` you have to use
[r.proj](https://grass.osgeo.org/grass74/manuals/r.proj.html)

r.proj location=longlat mapset=PERMANENT input=srtm resolution=30

At this point you can use `srtm` map as input of `elevation` option in
[i.sentinel.preproc](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.preproc.html)

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
[Exercise: Processing Sentinel 2 satellite data]()
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend
