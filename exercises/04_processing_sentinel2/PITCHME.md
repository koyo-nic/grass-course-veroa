# Sentinel

### Sentinel satellite sensor data

GRASS GIS has a new set of extensions to manage Sentinel data. These
tools allow to download, import, and preprocess Sentinel-2 data. Use
[g.extension](https://grass.osgeo.org/grass74/manuals/g.extension.html)
to install them.

            
    g.extension extension=i.sentinel
            
        
    # install i.sentinel modules: i.sentinel.download, i.sentinel.import
    # i.sentinel.preproc and i.sentinel.mask
    g.extension extension=i.sentinel
        
        
    gmod.Module("g.extension", extension="i.sentinel")
        
        

[i.sentinel.download](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.download.html)
allows downloading Sentinel-2 products from [Copernicus Open Access
Hub](https://scihub.copernicus.eu/). To connect to Copernicus Open
Access Hub a user name and password are required, see [Register new
account](https://scihub.copernicus.eu/dhus/#/self-registration) page for
signing up.
[i.sentinel.download](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.download.html)
reads user credentials from a settings file. Create the
*SETTING_SENTINEL* file with the following content, e.g. in the
directory `$HOME/gisdata/`:

    myusername
    mypassword
        
At this point you can use
[i.sentinel.download](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.download.html)
to search (using `-l` flag) and download Sentinel-2 scenes.

            
    # search Sentinel-2 data for for the last days of July, 2017
    # -l flag is used to print the resulting list
    i.sentinel.download -l settings=$HOME/gisdata/SETTING_SENTINEL 
     start=2017-07-30 end=2017-07-31 order=desc
    # download data
    i.sentinel.download settings=$HOME/gisdata/SETTING_SENTINEL 
     start=2017-07-30 end=2017-07-31 order=desc out=$HOME/gisdata/ 
     footprints=sentinel_2017_07
        
        
Once the data are downloaded you have to import them into GRASS GIS.
There are two options:
[i.sentinel.import](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.import.html)
for a simpler import of the data, or
[i.sentinel.preproc](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.preproc.html)
to import and perform atmospheric correction.

[i.sentinel.import](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.import.html)
requires only the input directory where the Sentinel-2 scenes were
downloaded. Optionally, it is possible to select only some of the
available bands. In the following example we are going to import only 7
bands for each image.
        
    # import the downloaded data
    # -r flag is used to reproject the data during import
    # pattern option is used to import only a subset of the available layers
    # -c flag allows to import the cloud mask
    i.sentinel.import -rc input=$HOME/gisdata/ pattern='B(02|03|04|08|8A|11|12)'
        
        
Display the imported images
        
    d.mon wx0
    d.rgb -n red=T17SQV_20170730T154909_B04 green=T17SQV_20170730T154909_B03 blue=T17SQV_20170730T154909_B02
    d.barscale length=50 units=kilometers segment=4 fontsize=14
    d.text -b text="Sentinel original" color=black bgcolor=229:229:229 align=cc font=sans size=8
            
![Original Sentinel scene
RGB](figures/sentinel_original.png "Original Sentinel scene RGB")


To have a better visualization, it is required to perform color
auto-balancing for RGB bands. The module to use is
[i.color.enhance](https://grass.osgeo.org/grass74/manuals/i.colors.enhance.html).
This module modifies the color table of each image band to provide a
more natural color mixture, but the base data remains untouched.
            
    i.colors.enhance red=T17SQV_20170730T154909_B04 green=T17SQV_20170730T154909_B03 blue=T17SQV_20170730T154909_B02
            
Now you can run again the previous piece of code to visualize the RGB
combination of the Sentinel-2 scene and observe the difference.


![Auto-balanced Sentinel scene
RGB](figures/sentinel_color_enhance.png "Auto-balanced Sentinel scene RGB")


[i.sentinel.preproc](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.preproc.html)
requires some extra inputs since it also performs atmospheric
correction. First, this module requires the image as an unzipped
directory, so you have to unzip one of the previous downloaded files,
for example:
        
    cd $HOME/gisdata/
    unzip $HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.zip
        
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
