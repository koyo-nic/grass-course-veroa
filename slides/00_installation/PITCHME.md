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

[https://grass.osgeo.org/download/software/](https://grass.osgeo.org/download/software/)
<br><br>
![Download software section](assets/img/grass_gis_download_software.png)

---

### MS Windows users

We will use the @color[green](OSGeo4W installer) that provides all of the OSGeo software for Windows
<br>
First, download the installer here: https://trac.osgeo.org/osgeo4w

> Important:
> Right-click over installer and execute with **Administrator** privileges

---

Overview of steps

@ol
- Select **Advance install**
- Select **Install from internet**
- Select the "Install directory" (leave the one by-default)
- Choose *osgeo* server to download software from
- Under **Desktop** applications, select **GRASS GIS stable** and **QGIS desktop**
- Under **Lib**, select **qgis-grass-plugin7**, **matplotlib**, **python-pip**, **python-ply** and **python-pandas** 
- Under **Command line utilities** select **msys**
- Wait for download and installation of packages, and done!
@olend

---?image=template/img/bg/green.jpg&position=left&size=30% 50%

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

---

3. Select "Install directory"
<br>
<img src="assets/img/osgeo4w_step_3.png">

---

4. Choose *osgeo* server to download software from
<br>
<img src="assets/img/osgeo4w_step_4.png">

---

5. Under **Desktop** applications, select **GRASS GIS stable** and **QGIS desktop**
<br>
<img src="assets/img/osgeo4w_step_5.png">

---

6. Under **Lib**, select **qgis-grass-plugin7**, **matplotlib**, **python-pip**, **python-ply** and **python-pandas** 
<br>
<img src="assets/img/osgeo4w_step_6.png">

---

7. Under **Command line utilities** select **msys**
<br>
<img src="assets/img/osgeo4w_step_7.png">

@size[22px](**Note**: the installer will fetch all other needed dependencies for the core modules of the desktop applications selected)

---

Wait for download and installation, and done

![last step](assets/img/osgeo4w_step_10.png)

---

To update, just open the "OSGeo4W Setup" and start again
<br><br>
**Super easy!**

---

There's also the WINGRASS standalone installer, but...
<br><br>
**we strongly recommend installing GRASS GIS through the OSGeo4W package**, since it allows to install all OSGeo software; esp. *msys* which will permit the use of loops, back ticks, autocomplete, history and other *nice bash shell features*.

---

To allow bash tricks in Windows, just open GRASS GIS and, in the black terminal, run:
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

- Ubuntu: Install GRASS GIS 7.4 from the "unstable" package repository:
<br>
```bash
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install grass
```

---

### Linux users

- Fedora, openSuSe Linux and others: Simply install GRASS GIS with the respective package manager, for example:
<br>
```bash
sudo dnf install grass
```
<br>
See other links here: https://grass.osgeo.org/download/software/

---

### Other software we will use

@ul
- **[pymodis](http://www.pymodis.org/)**: library to work with MODIS data. It offers bulk-download, mosaicking of tiles, reprojection from Sinusoidal, conversion from HDF format and extraction of data quality information. This library is needed by *[i.modis](https://grass.osgeo.org/grass74/manuals/addons/i.modis.html)* add-on.

- **[sentinelsat](https://github.com/sentinelsat/sentinelsat)**: Utility to search and download Copernicus Sentinel satellite images from the [Copernicus Open Access Hub](https://scihub.copernicus.eu/). This library is needed by *[i.sentinel](https://grass.osgeo.org/grass74/manuals/addons/i.sentinel.html)* add-on.
@ulend

---

### Install pymodis and sentinelsat in Windows

- Open OSGeo4W shell and run:

<br>

```python
pip install setuptools
pip install pymodis
pip install sentinelsat
```

---

### Install pymodis and sentinelsat in Mac and Linux

- Open a terminal and run 

<br>

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

<!--- 
1.  WinGRASS stand-alone installer
> Important:
> Right-click over the installer and execute with **Administrator** privileges
Be sure to check "Important Microsoft Runtime Libraries". The rest is all **Ok** until the end.
Note: dependencies needed by core modules are shipped with the installer, no need to worry about them now.
--->