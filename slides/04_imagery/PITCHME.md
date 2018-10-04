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

# Remote sensing data processing in GRASS GIS

---

### Overview

- Import all the bands
- Digital Number (DN) to Top Of Atmosphere (TOA) reflectance
- Data fusion/Pansharpening
- Create composites
- Preparing cloud mask from quality band
- Atmospheric correction
- Topographic corrections
- Vegetation and Water indices
- Segmentation and Classification

---


See here: https://grass.osgeo.org/grass74/manuals/imageryintro.html
 and here: https://grasswiki.osgeo.org/wiki/Image_processing

---

#### Data

We will use two Landsat 8 (OLI) scenes clipped to the nc sample data
region

-   Landsat 8 data taken on 16 June 2016 (2016 168) and 18 July 2016
    (2016 200)
-   Landsat path/row = 15/035
-   CRS - UTM zone 18 N (EPSG:32618), but will reproject the data to
    EPSG:3358 to match the NC sample dataset


![Spectral range](images/sp_fig13_new.jpg "display composite")
Spectral bands of Landsat 8 OLI, (Source: <https://landsat.gsfc.nasa.gov/landsat-data-continuity-mission/>)


#### Data download

For this exercise, download the clipped landsat 8 scenes from
[here](data/NC_L8_scenes.zip)

#### Workflow overview

**How do we work with satellite data in GRASS GIS?**

Assuming we do not have our maps in the GRASSDBASE (i.e.,
grassdata/location/mapset), the first step is to **import the datasets
to GRASS GIS**.

Here is a list of major GRASS GIS modules we will be using in this
exercise and the links to their manuals.


[Remote sensing analysis in GRASS GIS]{#RSanalysis}
---------------------------------------------------

Download the shared data and let us create a new mapset in the
"nc_spm_08_grass7" location to do further analysis.

To make use of the existing data in the NC location, we will add the
mapset "landsat" in the search path. We can run the commands from the
command line or use the main GUI and copy the corresponding commands for
future replication of the workflow. Note the *"Copy"* button in the
GUI of each module. Maybe you might want to get help about the options
and flags of the different commands, e.g. `r.colors --help`

    # Launch GRASS GIS, -c creates new mapset user1_l8
    grass72 $HOME/grassdata/nc_spm_08_grass7/user1_l8/ -c
    # Let us check the projection of the location
    g.proj -p
    # List all the mapsets in the search path
    g.mapsets -p
    # Add the mapset landsat to the search path
    g.mapsets mapset=landsat operation=add
    # List all the mapsets in the search path
    g.mapsets -p
    # List all the raster maps in all the mapsets in the search path
    g.list type=rast
    # Set the computational region 
    g.region rast=lsat7_2002_20 res=30 -a       

We will now import the landsat 8 raw data to the newly created mapset.
          
    # Change directory to the input Landsat 8 data
    cd $HOME/data_dir/LC80150352016168LGN00
    # Define a variable
    BASE="LC80150352016168LGN00"
    # Define a loop to import all the bands
    for i in "1" "2" "3" "4" "5" "6" "7" "9" "QA" "10" "11"; do
        r.import input=${BASE}_B${i}.TIF output=${BASE}_B${i} resolution=value resolution_value=30
    done
    # PAN band 8 imported separately because of different spatial resolution
    r.import input=${BASE}_B8.TIF output=${BASE}_B8 resolution=value resolution_value=15
            
        

**Task:** Note that we are using
[r.import](https://grass.osgeo.org/grass72/manuals/r.import.html)
instead of
[r.in.gdal](https://grass.osgeo.org/grass72/manuals/r.in.gdal.html) to
import the data. Check the difference between two and explain why we
used r.import here?

**Task:** Repeat the import step for the second scene
"LC80150352016200LGN00"

#### Digital Number (DN) to Top Of Atmosphere (TOA) reflectance

The next step is to convert the digital number (Landsat 8 OLI sensor
provides 16 bit data with range between 0 and 65536) to TOA reflectance.
For the thermal bands 10 and 11, DN is converted to TOA Brightness
Temperature. In GRASS GIS
[i.landsat.toar](https://grass.osgeo.org/grass72/manuals/i.landsat.toar.html)
can do this step for all the landsat sensors.

    # Convert from DN to TOA reflectance and Brightness Temperature
    i.landsat.toar input=${BASE}_B output=${BASE}_toar metfile=${BASE}_MTL.txt sensor=oli8
    g.list rast map=. pattern=${BASE}_toar*
            
       

**Task:** Repeat the conversion step for the second scene
"LC80150352016200LGN00"

**Task:** Set the color palette of Band 10 of LC80150352016200LGN00 to
"kelvin" and visulaize with map features


![display ST](images/sp_fig9.png "display ST")
TOA Temperature from band 10 of Landsat 8 dated 18 July 2016


#### Data fusion/Pansharpening

Now let us use the PAN band 8 (15 m resolution) to downsample other
spectral bands to 15 m resolution. We use an addon
[i.fusion.hpf](https://grass.osgeo.org/grass72/manuals/addons/i.fusion.hpf.html)
which applies a high pass filter addition method to down sample. Here we
introduce the long list of addons in GRASS GIS and demonstrate how to
install and use them. Check
[g.extension](https://grass.osgeo.org/grass72/manuals/g.extension.html)
to install the addons and [GRASS GIS
addons](https://grass.osgeo.org/grass72/manuals/addons/) for the list of
available addons.
           
            
    # Set the region
    g.region rast=lsat7_2002_20 res=15 -a
    # Install the reqquired addon
    g.extension extension=i.fusion.hpf op=add
    # Apply the fusion based on high pass filter
    i.fusion.hpf -l -c pan=${BASE}_toar8 msx=${BASE}_toar1,${BASE}_toar2,${BASE}_toar3,${BASE}_toar4,${BASE}_toar5,${BASE}_toar6,${BASE}_toar7 center=high modulation=max trim=0.0 --o
    # list the fused maps
    g.list rast map=. pattern=${BASE}_toar*.hpf
            

**Task:** Repeat the fusion step for the second scene
"LC80150352016200LGN00"

#### Image Composites

Now create false colour and true colour composite for better
visualization
           
            
    # Set the region
    g.region rast=lsat7_2002_20 res=15 -a
    # Enhance the colors in the clipped region
    i.colors.enhance red="${BASE}_toar4.hpf" green="${BASE}_toar3.hpf" blue="${BASE}_toar2.hpf" strength=95
    # Create RGB composites
    r.composite red="${BASE}_toar4.hpf" green="${BASE}_toar3.hpf" blue="${BASE}_toar2.hpf" output="${BASE}_toar.hpf_comp_432"
    # Enhance the colors in the clipped region
    i.colors.enhance red="${BASE}_toar5.hpf" green="${BASE}_toar4.hpf" blue="${BASE}_toar3.hpf" strength=95
    # Create RGB composites
    r.composite red="${BASE}_toar5.hpf" green="${BASE}_toar4.hpf" blue="${BASE}_toar3.hpf" output="${BASE}_toar.hpf_comp_543"  

**Task:** Create the composites for the second scene
"LC80150352016200LGN00"


![display composite](images/sp_fig10_new.jpg "display composite")
True color and False color composites of the Landsat 8 image dated 18
July 2016


#### Cloud mask from the QA layer

Landsat 8 provides quality layer which contains 16bit integer values
that represent "bit-packed combinations of surface, atmosphere, and
sensor conditions that can affect the overall usefulness of a given
pixel". We can use the addon
[i.landsat8.qc](https://grass.osgeo.org/grass72/manuals/addons/i.landsat8.qc.html)
to develop masks. More information about Landsat 8 quality band is given
[here](http://landsat.usgs.gov/qualityband.php).
 
    # Set the region
    g.region rast=lsat7_2002_20 res=15 -a
    # Install the required extension
    g.extension extension=i.landsat8.qc op=add
    # Create a rule set
    i.landsat8.qc cloud="Maybe,Yes" output=Cloud_Mask_rules.txt
    # Reclass the BQA band based on the rule set created 
    r.reclass input=${BASE}_BQA output=${BASE}_Cloud_Mask rules=Cloud_Mask_rules.txt
    # Report the area covered by Cloud
    r.report -e map=${BASE}_Cloud_Mask units=k -n

![display cloud mask](images/sp_fig11_new.jpg "display cloud mask")
False color composite and the derived cloud mask of the Landsat 8 image
dated 16 June 2016


**Task:** Visually compare the cloud coverage with the false color
composite

#### Vegetation Indices

We will compute NDVI and NDWI from the spectral bands using the map
calculator.
            
            
    # Set the region
    g.region rast=lsat7_2002_20 res=15 -a
    # Set the cloud mask to avoid computing over clouds
    r.mask rast=${BASE}_Cloud_Mask
    # Compute NDVI
    r.mapcalc "${BASE}_NDVI = (${BASE}_toar5.hpf - ${BASE}_toar4.hpf) / (${BASE}_toar5.hpf + ${BASE}_toar4.hpf) * 1.0"
    # Set the color palette
    r.colors ${BASE}_NDVI color=ndvi
    # Compute NDWI
    r.mapcalc "${BASE}_NDWI = (${BASE}_toar5.hpf - ${BASE}_toar6.hpf) / (${BASE}_toar5.hpf + ${BASE}_toar6.hpf) * 1.0"
    # Set the color palette
    r.colors ${BASE}_NDWI color=ndwi
    # Remove the mask
    r.mask -r
            
**Task:** Compute the vegetation indices from the second scene
"LC80150352016200LGN00"


![display composite](images/sp_fig12_new.jpg "display composite")
False color composite and the derived cloud mask of the Landsat 8 image
dated 16 June 2016


#### Unsupervised Classification

Now classify the LC80150352016200LGN00 (cloud free) using unsupervised
sequential Maxlike algorithm.

Main steps are:

-   Group the images
-   Generate signatures using a clustering algorithm
-   Classify using Maximum likelihood algorithm

<!-- -->

            
    g.list rast map=. pattern=${BASE}_toar*.hpf
    i.group group=${BASE}_hpf subgroup=${BASE}_hpf input=`g.list rast map=. pattern=${BASE}_toar*.hpf sep=","`
    i.cluster group=${BASE}_hpf subgroup=${BASE}_hpf sig=${BASE}_hpf classes=8 separation=0.5
    i.maxlik group=${BASE}_hpf subgroup=${BASE}_hpf sig=${BASE}_hpf output=${BASE}_hpf.class rej=${BASE}_hpf.rej
            
            
    # List the bands needed for classification
    g.list rast map=. pattern=${BASE}_toar*.hpf
    # add maps to an imagery group for easier management
    i.group group=${BASE}_hpf subgroup=${BASE}_hpf input=`g.list rast map=. pattern=${BASE}_toar*.hpf sep=","`
    # statistics for unsupervised classification
    i.cluster group=${BASE}_hpf subgroup=${BASE}_hpf sig=${BASE}_hpf classes=8 separation=0.5
    # Maximum Likelihood unsupervised classification
    i.maxlik group=${BASE}_hpf subgroup=${BASE}_hpf sig=${BASE}_hpf output=${BASE}_hpf.class rej=${BASE}_hpf.rej
            
     

Check the manual of
[i.cluster](https://grass.osgeo.org/grass72/manuals/i.cluster.html) and
[i.maxlik](https://grass.osgeo.org/grass72/manuals/i.maxlik.html).

Other (very) useful links
-------------------------

-   GRASS GIS wiki: <https://grasswiki.osgeo.org/wiki/GRASS-Wiki>
-   Image processing in GRASS GIS:
    <https://grasswiki.osgeo.org/wiki/Image_processing>
-   Image classification in GRASS GIS:
    <https://grasswiki.osgeo.org/wiki/Image_classification>


---

Image processing
================

For simplicity, we skip all the steps such as atmospheric and
topographic corrections.

Unsupervised image classification
---------------------------------

Set the computation region to the one of the raster maps we will work
with: ``

    g.region rast=lsat7_2002_10 -p

List the raster maps we have: ``

    g.list type=rast

Imagery group holds a group of raster, usually different bands which
will be our case, too. Subgroups works in the same way as groups and are
used to organize rasters inside a grpup. Now, use *i.group* to register
Landsat images to a group and subgroup with the same name: ``

    i.group group=lsat7_2002 subgroup=lsat7_2002 input=lsat7_2002_10,lsat7_2002_20,lsat7_2002_30,lsat7_2002_40,lsat7_2002_50,lsat7_2002_70

Use wxGUI histogram tool in Map Display to compare different channels in
the group. Now, generate spectral signatures using a clustering
algorithm. It is not needed to specify all the rasters, we just refer to
them using group and subgroup. The signatures are stored within the
subgroup. ``

    i.cluster group=lsat7_2002 subgroup=lsat7_2002 signaturefile=sig_cluster_lsat2002 classes=10

Now we have signatures which can be used for a maximum-likelihood
classification: ``

    i.maxlik group=lsat7_2002 subgroup=lsat7_2002 signaturefile=sig_cluster_lsat2002 output=lsat7_2002_cluster_classes

Look at the result using GUI or the following command: ``

    d.rast lsat7_2002_cluster_classes

Image segmentation
------------------

``

    i.segment group=lsat7_2002 output=lsat7_2002_segments threshold=0.5 method=region_growing similarity=euclidean

Texture extraction
------------------

r.texture input=lsat7_2002_80 prefix=lsat7_2002_80_texture size=7 distance=1 method=corr,idm,entr

Use scatter plot in Map Display to compare IDM and Entr textures.

Explore raster values
---------------------

Use query tool to get raster values. Use
*[d.rast.num](http://grass.osgeo.org/grass70/manuals/d.rast.num.html)*
to show individual values of the raster.

Color enhancement
-----------------

Add RGB layer to the Layer Manager or use the following command: ``

    d.rgb blue=lsat7_2002_10 green=lsat7_2002_20 red=lsat7_2002_30

Apply color enhancement to the blue, green and red bands: ``

    i.colors.enhance blue=lsat7_2002_10 green=lsat7_2002_20 red=lsat7_2002_30 strength=95


Learn more
----------

-   [Topic classification in GRASS GIS
    manual](http://grass.osgeo.org/grass70/manuals/topic_classification.html)
-   [Image processing in GRASS
    GIS](http://grass.osgeo.org/grass70/manuals/imageryintro.html)
    (intro in manual)
-   [Image processing](http://grasswiki.osgeo.org/wiki/Image_processing)
    at GRASS wiki
-   [Image
    classification](http://grasswiki.osgeo.org/wiki/Image_classification)
    at GRASS wiki

---

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

            
    i.sentinel.download -l settings=$HOME/gisdata/SETTING_SENTINEL start=2017-07-30 end=2017-07-31 order=desc
    i.sentinel.download  settings=$HOME/gisdata/SETTING_SENTINEL start=2017-07-30 end=2017-07-31 order=desc out=$HOME/gisdata/ footprints=sentinel_2017_07
            
        
    # search Sentinel-2 data for for the last days of July, 2017
    # -l flag is used to print the resulting list
    i.sentinel.download -l settings=$HOME/gisdata/SETTING_SENTINEL 
     start=2017-07-30 end=2017-07-31 order=desc
    # download data
    i.sentinel.download settings=$HOME/gisdata/SETTING_SENTINEL 
     start=2017-07-30 end=2017-07-31 order=desc out=$HOME/gisdata/ 
     footprints=sentinel_2017_07
        
        
    gmod.Module("i.sentinel.download", flags="l" settings="$HOME/gisdata/SETTING_SENTINEL",
                start="2017-07-30", end="2017-07-31", order="desc")
    gmod.Module("i.sentinel.download", settings="$HOME/gisdata/SETTING_SENTINEL", start="2017-07-30",
                end="2017-07-31", order="desc", out="$HOME/gisdata/", footprints="sentinel_2017_07")
        
        

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

            
    i.sentinel.import -rc input=$HOME/gisdata/ pattern='B(02|03|04|08|8A|11|12)'
            
        
    # import the downloaded data
    # -r flag is used to reproject the data during import
    # pattern option is used to import only a subset of the available layers
    # -c flag allows to import the cloud mask
    i.sentinel.import -rc input=$HOME/gisdata/ pattern='B(02|03|04|08|8A|11|12)'
        
        
    gmod.Module("i.sentinel.import", flags="rc", input="$HOME/gisdata/", pattern="'B(02|03|04|08|8A|11|12)'")
        
        

If we display the imported images, we can see that they appear really
dark

        
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
            
        
    gmod.Module("i.colors.enhance", red="T17SQV_20170730T154909_B04", green="T17SQV_20170730T154909_B03", blue="T17SQV_20170730T154909_B02")
        
        

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
            
        
    i.sentinel.preproc -atr input_dir=$HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.SAFE 
     elevation=elevation aeronet_file=$HOME/gisdata/170701_170831_EPA-Res_Triangle_Pk.dubovik suffix=corr text_file=$HOME/gisdata/sentinel_mask
        
        
    gmod.Module("i.sentinel.preproc", flags="atr", input_dir="$HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.SAFE",
                elevation="elevation", aeronet_file="$HOME/gisdata/170701_170831_EPA-Res_Triangle_Pk.dubovik", suffix="corr", text_file="$HOME/gisdata/sentinel_mask")
        
        


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
            
        
    i.sentinel.mask input_file=$HOME/gisdata/sentinel_mask cloud_mask=T17SQV_20170730T160022_cloud 
     shadow_mask=T17SQV_20170730T160022_shadow mtd=$HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.SAFE/MTD_MSIL1C.xml
        
        
    gmod.Module("i.sentinel.mask", input_file="$HOME/gisdata/sentinel_mask", cloud_mask="T17SQV_20170730T160022_cloud",
                shadow_mask="T17SQV_20170730T160022_shadow", mtd="$HOME/gisdata/S2B_MSIL1C_20170730T154909_N0205_R054_T17SQV_20170730T160022.SAFE/MTD_MSIL1C.xml")
        
        

At this point we can visualize the output of
[i.sentinel.mask](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.mask.html).

        
    d.mon wx0
    d.rgb -n red=T17SQV_20170730T154909_B04_corr green=T17SQV_20170730T154909_B03_corr blue=T17SQV_20170730T154909_B02_corr
    d.vect T17SQV_20170730T160022_cloud fill_color=red
    d.barscale length=50 units=kilometers segment=4 fontsize=14
    d.text -b text="Cloud mask in red" color=black bgcolor=229:229:229 align=cc font=sans size=8
            
        


![Auto-balanced Sentinel scene
RGB](figures/sentinel_cloud.png "Auto-balanced Sentinel scene RGB")


#### How to obtain SRTM digital elevation model

[]{#srtm}

[Shuttle Radar Topography Mission
(SRTM)](https://www2.jpl.nasa.gov/srtm/) is a worldwide Digital
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
            
        
    g.region raster=T17SQV_20170730T154909_B04,T17SPV_20170730T154909_B04 -b
        
        
    gmod.Module("g.region", flags="p", raster="T17SQV_20170730T154909_B04,T17SPV_20170730T154909_B04")
        
        

Now, we have to start a new GRASS GIS session in a Longitute-Latitude
location

        
    grass75 -c EPSG:4326 $HOME/grassdata/longlat
            
        
    1a. If in a new GRASS session, select "New" in the start-up screen
    1b. Alternatively, from within a GRASS GIS session, go to "Settings --> GRASS Working environment --> Create new Location
    2. Give a name to the new location
    3. Select EPSG code as the option to create new location
    4. Search for 4326 and select it
    5. Done
 
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

### Image segmentation

![Segmentation with](Raglan_ortho_seg.png "fig:Segmentation with  "){width="500"} We show
two recent segmentation algorithms: and addon , where the addon needs to
be installed first:

`g.extension i.superpixels.slic`

We show here segmentation of Landsat scene.

Imagery modules typically work with *imagery groups*. We first list the
landsat raster data and then create an imagery group:

`g.list type=raster pattern="lsat*" sep=comma mapset=PERMANENT`
`i.group group=lsat subgroup=lsat input=lsat7_2002_10,lsat7_2002_20,lsat7_2002_30,lsat7_2002_40,lsat7_2002_50,lsat7_2002_61,lsat7_2002_62,lsat7_2002_70,lsat7_2002_80`

Now we run i.superpixels.slic and convert the resulting raster to vector
for better viewing:

`i.superpixels.slic group=lsat output=superpixels num_pixels=2000`
`r.to.vect input=superpixels output=superpixels type=area`

We do the same for i.segment and convert the resulting raster to vector
for better viewing:

`i.segment group=lsat output=segments threshold=0.5 minsize=50`
`r.to.vect input=segments output=segments type=area`

From landsat data we also compute NDVI to later display it together with
the segmentation:

`i.vi red=lsat7_2002_30 output=ndvi viname=ndvi nir=lsat7_2002_40`

Remove all layers from Layer Manager and add these layers **one by one**
by pasting into the GUI command line and pressing Enter:

`d.rast map=ndvi`
`d.vect map=superpixels fill_color=none`
`d.vect map=segments fill_color=none`

It's important to note that each segmentation algorithm is designed for
different purpose, so we can\'t directly compare them.
