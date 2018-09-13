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

## Let's install GRASS GIS

---

### GRASS GIS installation guide

GRASS esta disponible para todos los sistemas operativos mas comunes y algunos otros tambien...

[https://grass.osgeo.org/download/software/](https://grass.osgeo.org/download/software/)

![Download software section](assets/img/grass_gis_download_software.png)

---

#### Windows users

We will use the OSGeo4W installer that provides all of OSGeo software for Windows

Download installer here: trac.osgeo.org/osgeo4w

> Important:
> Right-click over installer and execute with **Administrator** privileges

---

Steps:

@ol
- Select **Advance install**
- Select **Install from internet**
- Choose *osgeo* server to download software from
- Under **Desktop** applications, select **GRASS GIS stable** and **QGIS desktop**
- Under **Lib**, select **qgis-grass-plugin7**, **matplotlib**, **python-pip**, **python-ply** and **python-pandas** 
- Under **Command line utilities** select **msys**
@olend

Note: the installer will fetch all other needed dependencies for the core modules of the desktop applications selected

---

To update, just open the "OSGeo4W Setup" and start again

Super easy!

---

There's also the standalone installer, but...

**For Windows users, we strongly recommend installing GRASS GIS through the OSGeo4W package**, since it allows to install all OSGeo software. The latter one will allow the use of loops, back ticks, autocomplete, history and other nice bash shell features.

---

To allow bash tricks in Windows, just open GRASS GIS and in the black terminal run:

```
bash.exe
```

Done!

---

#### Mac OS

Download GRASS GIS 7.4.1 stable from: <http://grassmac.wikidot.com/downloads>

---

#### Linux users

1. Ubuntu

Install GRASS GIS 7.4 from the "unstable" package repository:

```
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install grass
```

---

2. Fedora, openSuSe Linux and others

For other Linux distributions including **Fedora** and **openSuSe**, simply install GRASS GIS with the respective package manager. See also [here](https://grass.osgeo.org/download/software/)

---

### Extra software we will use

- [pymodis](http://www.pymodis.org/): library to work with MODIS data. It offers bulk-download for user selected time ranges, mosaicking of MODIS tiles, and the reprojection from Sinusoidal to other projections, convert HDF format to other formats and the extraction of data quality information. This library is needed by GRASS GIS add-on [i.modis](https://grass.osgeo.org/grass74/manuals/addons/i.modis.html).
- [sentinelsat](https://github.com/sentinelsat/sentinelsat): Utility to search and download Copernicus Sentinel satellite images from the [Copernicus Open Access Hub](https://scihub.copernicus.eu/). This library is needed by the GRASS GIS add-on [i.sentinel](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.html).

---

### Install pymodis and sentinelsat in Windows

- Open osgeo4w shell and run:

```python
pip install setuptools
pip install pymodis
pip install sentinelsat
```

---

### Install pymodis and sentinelsat in Mac and Linux

- Open a terminal and run 

```python
pip install setuptools
pip install pymodis
pip install sentinelsat
```

---

**Thanks for your attention!!**

![GRASS GIS logo](assets/img/grass_logo_alphab.png)

---

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend

<!--- 
1.  WinGRASS stand-alone installer
> Important:
> Right-click over the installer and execute with **Administrator** privileges
Be sure to check "Important Microsoft Runtime Libraries". The rest is all **Ok** until the end.
Note: dependencies needed by core modules are shipped with the installer, no need to worry about them now.
--->