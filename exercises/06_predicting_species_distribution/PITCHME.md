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

## GRASS and R: Predicting species distribution

---

@snap[north-west span-60]
<h3>Overview</h3>
@snapend

@snap[west span-100]
<br><br>
@ol[list-content-verbose]
- Importing species records
- Creating random background points
- Creating environmental layers
- Reading data into R
- Model species distribution
- Model evaluation and visualization
@olend
@snapend

---

@snap[north span-100]
<h3>Data</h3>
@snapend

@snap[west span-50]
@ol[list-content-verbose]
- Records of *Aedes albopictus* (Asian tiger mosquito) in NC
- Environmental layers derived from RS products
@olend
@snapend

@snap[east span-50]
![](https://en.wikipedia.org/wiki/Aedes_albopictus#/media/File:CDC-Gathany-Aedes-albopictus-1.jpg)
@snapend

---?code=code/06_grass_R_sp_distribution_code.sh&lang=bash&title=Importing species records

@[16-17](Install v.in.pygbif)
@[19-21](Set region and MASK)
@[23-25](Import data from GBIF)

+++

> **Task**: Explore univariate statistics of downloaded data. Check the 
> [d.vect.colhist](https://grass.osgeo.org/grass74/manuals/addons/d.vect.colhist.html) and
> [d.vect.colbp](https://github.com/ecodiv/d.vect.colbp) addons.

---?code=code/06_grass_R_sp_distribution_code.sh&lang=bash&title=Creating random background points

@[33-34](Create buffer around Aedes albopictus records)
@[36-37](Generate random points)
@[39-41](Remove points falling in buffers)

+++

> **Task**: Display with different colors the GBIF records, the random points and the filtered random points.

---?code=code/06_grass_R_sp_distribution_code.sh&lang=bash&title=Creating environmental layers

@[49-51]()
@[53-55]()
@[57-60]()
@[62-65]()
@[67-69]()
@[71-73]()

+++

> **Task**: Which other variable could we generate/use?

---

Just for fun, close GRASS GIS, we'll initialize it again but from RStudio

+++?code=code/06_grass_R_sp_distribution_code.r&lang=r&title=Install and load packages

@[16-20](Install packages)
@[22-26](Load packages)

+++?code=code/06_grass_R_sp_distribution_code.r&lang=r&title=Initialize GRASS GIS

@[34-41](Set parameters to start GRASS)
@[43-50](Initialize GRASS GIS)

---?code=code/06_grass_R_sp_distribution_code.r&lang=r&title=Read vector and raster data

@[58-60](Read vector data)
@[62-71](Read raster data)

+++

> **Task**: display maps and points in RStudio using sp, tmap or sf

+++

TODO: add maps

---?code=code/06_grass_R_sp_distribution_code.r&lang=r&title=Data formatting

@[83-94](Response variable)
@[96-104](Explanatory variables)

---?code=code/06_grass_R_sp_distribution_code.r&lang=r&title=Run Random Forest model

@[112-113](Default options)
@[115-128](Run model)

+++

> **Task**: Explore the model output

---?code=code/06_grass_R_sp_distribution_code.r&lang=r&title=Model evaluation

@[138-139](Extract all evaluation data)
@[141-142](TSS: True Skill Statistics)
@[144-145](ROC: Receiver-operator curve)
@[147-148](Variable importance)

---?code=code/06_grass_R_sp_distribution_code.r&lang=r&title=Model predictions

@[156-162](Model projection settings)
@[164-165](Obtain predictions from model)
@[167-168](Plot predicted potential distribution)

+++

TODO: add output plot here

---

> **Task**: Explore algorithms available in `BIOMOD_Modeling()` and try with a different one. Compare the results. 

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
[Think on the evaluation exercise]()
@snapend

@snap[south span-50]
@size[18px](Presentation powered by)
<br>
<a href="https://gitpitch.com/">
<img src="assets/img/gitpitch_logo.png" width="20%"></a>
@snapend

