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

2 options:

- Standalone installer
- OSGeo4W installer (recommended)

---

1.  WinGRASS stand-alone installer

> Important:
> Right-click over the installer and execute with **Administrator** privileges

---

Be sure to check "Important Microsoft Runtime Libraries". The rest is all **Ok** until the end.

Note: dependencies needed by core modules are shipped with the installer, no need to worry about them now.

---

2. OSGeo4W installer

> Important:
> Right-click over installer and execute with **Administrator** privileges

---

@ol
- Select **Advance install**
- Select **Install from internet**
- Choose *osgeo* server
- Under **Desktop** applications, select **GRASS GIS 7.4.1** and **QGIS**
- Under **Lib**, select **qgis-grass-plugin7**, **matplotlib**, **pip**, **ply**, and **pandas** 
- Under **Command line utilities** select **msys**
@olend

Note: the installer will fetch all needed dependencies for the core modules of the desktop applications selected

---

To update, just start again

Super easy!

---

**For Windows users, we strongly recommend installing GRASS GIS through the OSGeo4W package**, 
since it allows to install all OSGeo software. If you choose this option, 
*make sure you choose "Advance install" and select GRASS GIS, QGIS and msys*. 
The latter one will allow the use of loops, back ticks, autocomplete, history 
and other nice bash shell features.

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

2. Fedora, openSuSe Linux

For other Linux distributions including **Fedora** and **openSuSe**, simply install GRASS GIS with the respective package manager. See also [here](https://grass.osgeo.org/download/software/)

---

### Extra dependencies

pymodis
PLY
sentinelsat
pandas
scikit-learn
matplotlib

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
