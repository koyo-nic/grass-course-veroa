# curso-grass-gis-rioiv

Data, code and slides for the graduate course that will be held in Rio Cuarto (Cordoba, Argentina) on October, 2018

## Links to units

Slides:

- [Installation guide](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/00_installation&grs=gitlab)
- [GRASS GIS intro](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/01_general_intro_grass&grs=gitlab)
- [GRASS GIS general capabilities](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/02_general_intro_capabilities&grs=gitlab)
- [Raster data](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/03_raster&grs=gitlab)
- [Satellite Imagery](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/04_imagery&grs=gitlab)
- [Temporal data](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/05_temporal&grs=gitlab)
- [GRASS and R interface](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=slides/06_R_grass&grs=gitlab)

Exercises:

- [Getting familiar with GRASS GIS](https://gitpitch.com/veroandreo/curso-grass-gis-rioiv/master?p=exercises/01_getting_familiar&grs=gitlab#/) 

## Software

We will use **GRASS GIS 7.4.1** (current stable version). It can be installed either 
through standalone installers/binaries or through OSGeo-Live (which includes all
OSGeo software and packages).

### Standalone installers for different OS:

##### MS Windows

There are two different options:
1. Standalone installer: [32-bit version](https://grass.osgeo.org/grass74/binary/mswindows/native/x86/WinGRASS-7.4.1-1-Setup-x86.exe) | [64-bit version](https://grass.osgeo.org/grass74/binary/mswindows/native/x86_64/WinGRASS-7.4.1-1-Setup-x86_64.exe) 
2. OSGeo4W package (network installer): [32-bit version](http://download.osgeo.org/osgeo4w/osgeo4w-setup-x86.exe) | [64-bit version](http://download.osgeo.org/osgeo4w/osgeo4w-setup-x86_64.exe) 

For Windows users, **we strongly recommend installing GRASS GIS through the OSGeo4W package**, 
since it allows to install all OSGeo software. If you choose this option, 
*make sure you select GRASS GIS and msys*. The latter one will allow 
the use of loops, back ticks, autocomplete, history and other nice bash shell
features.

##### Mac OS

Download GRASS GIS 7.4.1 stable from: http://grassmac.wikidot.com/downloads and follow the instructions under *Installing GRASS for Mac*.

##### Ubuntu Linux

Install GRASS GIS 7.4.1 from the "unstable" package repository:

```
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install grass
```

##### Fedora, openSuSe Linux

For other Linux distributions including **Fedora** and **openSuSe**, simply install GRASS GIS with the respective package manager. See also [here](https://grass.osgeo.org/download/software/)

##### Extra dependencies

- [pyModis](www.pymodis.org) 
- [sentinelsat](https://github.com/sentinelsat/sentinelsat)
- pandas
- scikit-learn
- matplotlib

### OSGeo-live: 

[OSGeo-live](https://live.osgeo.org/) is a self-contained bootable DVD, USB thumb
drive or Virtual Machine based on Lubuntu, that allows you to try a wide variety
of open source geospatial software without installing anything. There are 
different options to run OSGeo-live:

* [Run OSGeo-live in a Virtual Machine](https://live.osgeo.org/en/quickstart/virtualization_quickstart.html)
* [Run OSGeo-live from a bootable USB flash drive](https://live.osgeo.org/en/quickstart/usb_quickstart.html)

For a quick-start guide, see: https://live.osgeo.org/en/quickstart/osgeolive_quickstart.html

### GRASS GIS Add-ons

* [i.modis](https://grass.osgeo.org/grass74/manuals/addons/i.modis.html): Toolset for download and processing of MODIS products using pyModis
* [i.sentinel](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.html): Toolset for download and processing of Copernicus Sentinel products
* [r.learn.ml](https://grass.osgeo.org/grass74/manuals/addons/r.learn.ml.html): Supervised classification and regression of GRASS GIS raster maps using the python scikit-learn package
* [v.strds.stats](https://grass.osgeo.org/grass74/manuals/addons/v.strds.stats.html): Zonal statistics from given space-time raster datasets based on a polygons vector map

Install with `g.extension extension=name_of_addon`

## Data

* [North Carolina location (full dataset, 150Mb)](https://grass.osgeo.org/sampledata/north_carolina/nc_spm_08_grass7.zip): download and unzip within `$HOME/grassdata`.
* To be added

<!---
* [ECA&D elevation (GeoTiff file)](https://gitlab.com/neteler/grass-gis-geostat-2018/tree/master/intro/aux_data/ecad_elev_v17.zip): download and unzip into the `$HOME/geodata` folder (create folder if needed).

* [ecad17_ll location](https://gitlab.com/neteler/grass-gis-geostat-2018/tree/master/intro/aux_data/grassdata_ecad17_ll.zip): download and unzip into the `$HOME/grassdata` folder (create folder if needed).
 
* [modis_lst mapset (2Mb)](https://gitlab.com/veroandreo/grass-gis-geostat-2018/blob/master/data/modis_lst.zip): download and unzip within the North Carolina location in `$HOME/grassdata/nc_spm_08_grass7`.
--->

## Author

* **Veronica Andreo.** [CONICET](http://www.conicet.gov.ar/) - [INMeT](https://www.argentina.gob.ar/salud/inmet). Puerto Iguazú, Argentina

## License

All the course material:

[![Creative Commons License](assets/img/ccbysa.png)](http://creativecommons.org/licenses/by-sa/4.0/) Creative Commons Attribution-ShareAlike 4.0 International License

Presentations were created with [gitpitch](https://gitpitch.com/):

* MIT License
