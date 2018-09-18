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

[https://grass.osgeo.org/download/software/](https://grass.osgeo.org/download/software/)

![Download software section](assets/img/grass_gis_download_software.png)

---

### MS Windows users
<br>
Download the **OSGeo4W installer** from: https://trac.osgeo.org/osgeo4w
<br><br>
> *@size[28px](Important:)*
> @size[28px](Right-click over installer and execute with **Administrator** privileges)

+++

@snap[south-west list-content-concise span-100]
@ol[](false)
- Select **Advance install**
- Select **Install from internet**
- Leave the "Install directory" set by default
- Choose *osgeo* server to download software from
- Under *Desktop applications*, select **GRASS GIS stable** and **QGIS desktop**
- Under *Lib*, select **qgis-grass-plugin7**, **matplotlib**, **python-pip**, **python-ply** and **python-pandas** 
- Under *Command line utilities* select **msys**
- Wait for download and installation of packages, and done!
@olend
@snapend

+++?image=template/img/bg/green.jpg&position=left&size=30% 50%

@snap[west text-white]
@size[3em](1.)
@snapend

@snap[east span-70]
Select **Advance install**
<br>
<img src="assets/img/osgeo4w_step_1.png">
@snapend

+++?image=template/img/bg/green.jpg&position=left&size=30% 50%

@snap[west text-white]
@size[3em](2.)
@snapend

@snap[east span-70]
Select **Install from internet**
<br>
<img src="assets/img/osgeo4w_step_2.png">
@snapend

+++?image=template/img/bg/green.jpg&position=left&size=30% 50%

@snap[west text-white]
@size[3em](3.)
@snapend

@snap[east span-70]
Leave the "Install directory" set by default
<br>
<img src="assets/img/osgeo4w_step_3.png">
@snapend

+++?image=template/img/bg/green.jpg&position=left&size=30% 50%

@snap[west text-white]
@size[3em](4.)
@snapend

@snap[east span-70]
Choose *osgeo* server
<br>
<img src="assets/img/osgeo4w_step_4.png">
@snapend

+++?image=template/img/bg/green.jpg&position=left&size=30% 50%

@snap[west text-white]
@size[3em](5.)
@snapend

@snap[east span-70]
Under *Desktop applications*, select **GRASS GIS** and **QGIS desktop**
<br>
<img src="assets/img/osgeo4w_step_5.png">
@snapend

+++?image=template/img/bg/green.jpg&position=left&size=30% 50%

@snap[west text-white]
@size[3em](6.)
@snapend

@snap[east span-70]
Under *Lib*, select **qgis-grass-plugin7**, **matplotlib**, **python-pip**, **python-ply** and **python-pandas** 
<br>
<img src="assets/img/osgeo4w_step_6.png">
@snapend

+++?image=template/img/bg/green.jpg&position=left&size=30% 50%

@snap[west text-white]
@size[3em](7.)
@snapend

@snap[east span-70]
Under *Command line utilities* select **msys**
<br>
<img src="assets/img/osgeo4w_step_7.png">
@snapend
<br>

@snap[south span-90]
@size[22px](**Note**: the installer will fetch all other needed dependencies for the applications selected)
@snapend

+++?image=template/img/bg/green.jpg&position=left&size=30% 50%

@snap[west text-white]
@size[3em](8.)
@snapend

@snap[east span-70]
Wait for download and installation, and done :)
<br>
![last step](assets/img/osgeo4w_step_10.png)
@snapend

+++?image=template/img/grass.png&position=bottom&size=100% 30%

To update, just open the "OSGeo4W Setup" and start again
<br><br>
**@size[64px](Super easy!)**

+++

There's also the WINGRASS standalone installer, but...
<br><br>
**@color[#F26225](we strongly recommend installing GRASS GIS through the OSGeo4W package)**, since it allows to install all OSGeo software; esp. *msys* which will permit the use of loops, back ticks, autocomplete, history and other *@color[#F26225](nice bash shell features)*.

+++

To @color[#8EA33B](allow bash tricks in Windows), just open GRASS GIS and, in the black terminal, run:
<br>
```
bash.exe
```
<br>
Done!

---

### Mac OS users

Download GRASS GIS 7.4.1 stable from: <http://grassmac.wikidot.com/downloads>

---

### Linux users

- **Ubuntu**: Install GRASS GIS 7.4 from the "unstable" package repository


```bash
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install grass
```

- **Fedora**: Simply install GRASS GIS from the package manager


```bash
sudo dnf install grass
```
<br>

@size[28px](Other distros: https://grass.osgeo.org/download/software/)

---

### Other software we will use

@ul
- **[pymodis](http://www.pymodis.org/)**: library to work with MODIS data. It offers bulk-download, mosaicking, reprojection, conversion from HDF format and extraction of data quality information. This library is needed by *[i.modis](https://grass.osgeo.org/grass74/manuals/addons/i.modis.html)* add-on.

- **[sentinelsat](https://github.com/sentinelsat/sentinelsat)**: Utility to search and download Copernicus Sentinel satellite images from the [Copernicus Open Access Hub](https://scihub.copernicus.eu/). This library is needed by *[i.sentinel](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.html)* add-on.
@ulend

+++

### Install pymodis and sentinelsat in Windows
<br>
- Open the **OSGeo4W shell** and run:


```python
pip install setuptools
pip install pymodis
pip install sentinelsat
```

+++

### Install pymodis and sentinelsat in Mac and Linux
<br>
- Open a terminal and run 


```python
pip install setuptools
pip install pymodis
pip install sentinelsat
```

---?image=template/img/grass.png&position=bottom&size=100% 30%

## **We are set, let's start!**

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
