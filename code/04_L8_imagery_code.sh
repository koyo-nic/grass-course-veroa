# Download Landsat 8 scene for NC
https://earthexplorer.usgs.gov/




Basic overview of this session

    Import all the bands
    Digital Number (DN) to Top Of Atmosphere (TOA) reflectance
    Data fusion/Pansharpening
    Create composites
    Preparing cloud mask from quality band
    Develop vegetation indices
    Unsupervised classification

Data

We will use two Landsat 8 (OLI) scenes clipped to the nc sample data region

- Landsat 8 data taken on 16 June 2016 (2016 168) and 18 July 2016 (2016 200)
- Landsat path/row = 15/035
- CRS - UTM zone 18 N (EPSG:32618), but will reproject the data to EPSG:3358 to match the NC sample dataset


# create a new mapset
grass72 $HOME/grassdata/nc_spm_08_grass7/user1_l8/ -c
g.proj -p
g.mapsets -p
g.mapsets mapset=landsat operation=add
g.mapsets -p
g.list rast
g.region rast=lsat7_2002_20 res=30 -a


cd $HOME/data_dir/LC80150352016168LGN00
BASE="LC80150352016168LGN00"
for i in "1" "2" "3" "4" "5" "6" "7" "9" "QA" "10" "11"; do
	r.import input=${BASE}_B${i}.TIF output=${BASE}_B${i} resolution=value resolution_value=30
done
r.import input=${BASE}_B8.TIF output=${BASE}_B8 resolution=value resolution_value=15

Task: Note that we are using r.import instead of r.in.gdal to import the data. Check the difference between two and explain why we used r.import here?

Task: Repeat the import step for the second scene "LC80150352016200LGN00"

The next step is to convert the digital number (Landsat 8 OLI sensor provides 16 bit data with range between 0 and 65536) to TOA reflectance. For the thermal bands 10 and 11, DN is converted to TOA Brightness Temperature. In GRASS GIS i.landsat.toar can do this step for all the landsat sensors.

i.landsat.toar input=${BASE}_B output=${BASE}_toar metfile=${BASE}_MTL.txt sensor=oli8
g.list rast map=. pattern=${BASE}_toar*

Now let us use the PAN band 8 (15 m resolution) to downsample other spectral bands to 15 m resolution. We use an addon i.fusion.hpf which applies a high pass filter addition method to down sample. Here we introduce the long list of addons in GRASS GIS and demonstrate how to install and use them. Check g.extension to install the addons and GRASS GIS addons for the list of available addons.

g.region rast=lsat7_2002_20 res=15 -a
g.extension extension=i.fusion.hpf op=add
i.fusion.hpf -l -c pan=${BASE}_toar8 msx=${BASE}_toar1,${BASE}_toar2,${BASE}_toar3,${BASE}_toar4,${BASE}_toar5,${BASE}_toar6,${BASE}_toar7 center=high modulation=max trim=0.0 --o
g.list rast map=. pattern=${BASE}_toar*.hpf


Image Composites

g.region rast=lsat7_2002_20 res=15 -a
i.colors.enhance red="${BASE}_toar4.hpf" green="${BASE}_toar3.hpf" blue="${BASE}_toar2.hpf" strength=95
r.composite red="${BASE}_toar4.hpf" green="${BASE}_toar3.hpf" blue="${BASE}_toar2.hpf" output="${BASE}_toar.hpf_comp_432"
i.colors.enhance red="${BASE}_toar5.hpf" green="${BASE}_toar4.hpf" blue="${BASE}_toar3.hpf" strength=95
r.composite red="${BASE}_toar5.hpf" green="${BASE}_toar4.hpf" blue="${BASE}_toar3.hpf" output="${BASE}_toar.hpf_comp_543"


Cloud mask from the QA layer

Landsat 8 provides quality layer which contains 16bit integer values that represent "bit-packed combinations of surface, atmosphere, and sensor conditions that can affect the overall usefulness of a given pixel". We can use the addon i.landsat8.qc to develop masks. More information about Landsat 8 quality band is given here.

g.region rast=lsat7_2002_20 res=15 -a
g.extension extension=i.landsat8.qc op=add
i.landsat8.qc cloud="Maybe,Yes" output=Cloud_Mask_rules.txt
r.reclass input=${BASE}_BQA output=${BASE}_Cloud_Mask rules=Cloud_Mask_rules.txt
r.report -e map=${BASE}_Cloud_Mask units=k -n


Vegetation Indices

We will compute NDVI and NDWI from the spectral bands using the map calculator.

g.region rast=lsat7_2002_20 res=15 -a
r.mask rast=${BASE}_Cloud_Mask
r.mapcalc "${BASE}_NDVI = (${BASE}_toar5.hpf - ${BASE}_toar4.hpf) / (${BASE}_toar5.hpf + ${BASE}_toar4.hpf) * 1.0"
r.colors ${BASE}_NDVI color=ndvi
r.mapcalc "${BASE}_NDWI = (${BASE}_toar5.hpf - ${BASE}_toar6.hpf) / (${BASE}_toar5.hpf + ${BASE}_toar6.hpf) * 1.0"
r.colors ${BASE}_NDWI color=ndwi
r.mask -r


Unsupervised Classification

Now classify the LC80150352016200LGN00 (cloud free) using unsupervised sequential Maxlike algorithm.

Main steps are:

    Group the images
    Generate signatures using a clustering algorithm
    Classify using Maximum likelihood algorithm

g.list rast map=. pattern=${BASE}_toar*.hpf
i.group group=${BASE}_hpf subgroup=${BASE}_hpf input=`g.list rast map=. pattern=${BASE}_toar*.hpf sep=","`
i.cluster group=${BASE}_hpf subgroup=${BASE}_hpf sig=${BASE}_hpf classes=8 separation=0.5
i.maxlik group=${BASE}_hpf subgroup=${BASE}_hpf sig=${BASE}_hpf output=${BASE}_hpf.class rej=${BASE}_hpf.rej
