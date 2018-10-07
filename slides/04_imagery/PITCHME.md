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

@snap[north-west span-60]
<h3>Overview</h3>
@snapend

@snap[west span-100]
<br><br>
@ol[list-content-verbose]
- Basics of Imagery processing in GRASS GIS
- Import all the bands
- Digital Number (DN) to Top Of Atmosphere (TOA) reflectance
- Data fusion/Pansharpening
- Create composites
- Cloud mask from quality band
- Vegetation and Water indices
- Texture extraction
- Classification
@olend
@snapend

<!--- atmospheric and topographic correction --->

---

### Basics of Imagery processing in GRASS GIS

Satellite data is identical to raster data, hence same rules apply.
<br>
i.* commands are explicitly dedicated to image processing, we'll see
some in this hands-on session
<br>
For further details see: 
[Imagery Intro](https://grass.osgeo.org/grass74/manuals/imageryintro.html) manual 
and [Image Processing](https://grasswiki.osgeo.org/wiki/Image_processing) wiki

---

#### Data

We will use two Landsat 8 (OLI) scenes clipped to the NC sample data region

- Landsat 8 data from 16 June 2016 (2016 168) and 18 July 2016 (2016 200)
- Landsat path/row = 015/035
- CRS - UTM zone 18 N (EPSG:32618)

![L8 vs L7 bands](https://landsat.gsfc.nasa.gov/wp-content/uploads/2013/01/ETM+vOLI-TIRS-web_Feb20131.jpg)
Spectral bands of Landsat 8 OLI, (Source: <https://landsat.gsfc.nasa.gov/landsat-data-continuity-mission/>)

Download the clipped Landsat 8 scenes from [here](data/NC_L8_scenes.zip). Move it to `$HOME/gisdata` and unzip.

---?code=code/04_L8_imagery_code.sh&lang=bash&title=Start GRASS and create new mapset

@[19-20](Launch GRASS GIS and create new mapset landsat8)
@[21-22](check the projection)
@[23-28](list mapsets and add landsat mapset to path)
@[29-30](List all available raster maps)
@[31-32](Set computational region to a landsat scene)
   
---?code=code/04_L8_imagery_code.sh&lang=bash&title=Import L8 data

@[35-38](change directory and set variable)
@[46-51](import all the bands with 30m res, note extent=region)
@[53-56](import PAN band separately)            
        
+++

@snap[north span-100]
Folder option in the GUI
@snapend

@snap[west span-50]
<img src="assets/img/import_directory_1.png">
@snapend

@snap[east span-50]
<img src="assets/img/import_directory_2.png">
@snapend

+++

**Task:** 
Note that we are using [r.import](https://grass.osgeo.org/grass72/manuals/r.import.html)
instead of [r.in.gdal](https://grass.osgeo.org/grass72/manuals/r.in.gdal.html) to
import the data. Check the difference between the two of them and explain why we
used r.import here?

**Task:** Repeat the import step for the second scene "LC80150352016200LGN00"

---

#### From Digital Number (DN) to Reflectance and Temperature

Landsat 8 OLI sensor provides 16-bit data with range between 0 and 65536.

[i.landsat.toar](https://grass.osgeo.org/grass74/manuals/i.landsat.toar.html)
converts DN to TOA reflectance and Brightness Temperature for all Landsat sensors.

+++?code=code/04_L8_imagery_code.sh&lang=bash&title=DN to Reflectance and Temperature

@[64-66](Convert from DN to surface reflectance and temperature - DOS method)
@[68-72](Check info before and after conversion for one band)

+++

![Band 10 Temperature](assets/img/L8_band10_kelvin.png)

+++

**Task:** Repeat the conversion step for the second scene "LC80150352016200LGN00"

**Task:** Set the color palette of Band 10 of LC80150352016200LGN00 to "kelvin" and visualize

---

#### Data fusion/Pansharpening

We'll use the PAN band 8 (15 m resolution) to downsample other spectral bands to 15 m resolution. 

[i.fusion.hpf](https://grass.osgeo.org/grass7/manuals/addons/i.fusion.hpf.html): 
which applies a high pass filter addition method to downsample.

+++?code=code/04_L8_imagery_code.sh&lang=bash&title=Data fusion/Pansharpening

@[80-81](Install extension)
@[83-84](Set the region)
@[86-91](Run the fusion)
@[93-94](List fused maps)
@[96-98](Visualize differences)

+++            

![Original vs Pansharpen](assets/img/pansharpen_mapswipe.png)

+++

**Task:** Repeat the fusion step for the second scene "LC80150352016200LGN00"

---

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

+++

**Task:** Create the composites for the second scene "LC80150352016200LGN00"


![display composite](images/sp_fig10_new.jpg "display composite")
True color and False color composites of the Landsat 8 image dated 18
July 2016

---

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

+++

**Task:** Visually compare the cloud coverage with the false color composite

---

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

---

#### Texture extraction

r.texture input=lsat7_2002_80 prefix=lsat7_2002_80_texture size=7 distance=1 method=corr,idm,entr

Use scatter plot in Map Display to compare IDM and Entr textures.

---

#### Unsupervised Classification

Now classify the LC80150352016200LGN00 (cloud free) using unsupervised
sequential Maxlike algorithm.

Main steps are:

- Group the images
- Generate signatures using a clustering algorithm
- Classify using Maximum likelihood algorithm

           
Check the manual of
[i.cluster](https://grass.osgeo.org/grass72/manuals/i.cluster.html) and
[i.maxlik](https://grass.osgeo.org/grass72/manuals/i.maxlik.html).

+++


---

Learn more
----------

- [Topic classification in GRASS GIS manual](http://grass.osgeo.org/grass70/manuals/topic_classification.html)
- [Image processing in GRASS GIS](http://grass.osgeo.org/grass70/manuals/imageryintro.html) (intro in manual)
- [Image processing](http://grasswiki.osgeo.org/wiki/Image_processing) at GRASS wiki
- [Image classification](http://grasswiki.osgeo.org/wiki/Image_classification) at GRASS wiki

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
[Exercise: Processing Sentinel 2 satellite data](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=exercises/04_processing_sentinel2&grs=gitlab#/)
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend
