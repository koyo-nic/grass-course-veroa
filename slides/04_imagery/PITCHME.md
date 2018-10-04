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

           
Check the manual of
[i.cluster](https://grass.osgeo.org/grass72/manuals/i.cluster.html) and
[i.maxlik](https://grass.osgeo.org/grass72/manuals/i.maxlik.html).

Image segmentation
------------------

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


Learn more
----------

-   [Topic classification in GRASS GIS manual](http://grass.osgeo.org/grass70/manuals/topic_classification.html)
-   [Image processing in GRASS GIS](http://grass.osgeo.org/grass70/manuals/imageryintro.html)
    (intro in manual)
-   [Image processing](http://grasswiki.osgeo.org/wiki/Image_processing)
    at GRASS wiki
-   [Image classification](http://grasswiki.osgeo.org/wiki/Image_classification)
    at GRASS wiki

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


