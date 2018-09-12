Scripting with R
----------------

Using R and GRASS GIS together can be done in two ways:

-   Using *R within GRASS GIS session*, i.e. you start R (or RStudio)
    from the GRASS GIS command line.
    -   You work with data in GRASS GIS Spatial Database using GRASS GIS
    -   Do not use the `initGRASS()` function (GRASS GIS is running
        already).
-   Using *GRASS GIS within a R session*, i.e. you connect to a GRASS
    GIS Spatial Database from within R (or RStudio).
    -   You put data into GRASS GIS Spatial Database just to perform the
        GRASS GIS computations.
    -   Use the `initGRASS()` function to start GRASS GIS inside R.

We will run R within GRASS GIS session (the first way). Launch R inside
GRASS GIS and install *rgrass7* and *rgdal* package

``` {.r}
install.packages("rgrass7")
install.packages("rgdal")
library("rgrass7")
library("rgdal")
```

We can execute GRASS modules using `execGRASS` function:

``` {.r}
execGRASS("g.region", raster="temp_mean", flags="p")
```

We will analyze the relationship between temperature and elevation and
latitude.

First we will generate raster of latitude values:

``` {.r}
execGRASS("r.mapcalc", expression="latitude = y()")
```

Note: in projected coordinate systems you can use .

Then, we will generate random points and sample the datasets.

``` {.r}
execGRASS("v.random", output="samples", npoints=1000)
# this will restrict sampling to the boundaries of USA
# we are overwriting vector samples, so we need to use overwrite flag
execGRASS("v.random", output="samples", npoints=1000, restrict="boundaries", flags=c("overwrite"))
# create attribute table
execGRASS("v.db.addtable", map="samples", columns=c("elevation double precision", "latitude double precision", "temp double precision"))
# sample individual rasters
execGRASS("v.what.rast", map="samples", raster="temp_mean", column="temp")
execGRASS("v.what.rast", map="samples", raster="latitude", column="latitude")
execGRASS("v.what.rast", map="samples", raster="elevation", column="elevation")
```

Note: there is an addon module which simplifies this process by sampling
multiple rasters.

Now open GRASS GIS attribute table manager to inspect the sampled values
or use to list the values. Explore the dataset in R:

```R
samples <- readVECT("samples")
summary(samples)
plot(samples@data)
```

Compute multivariate linear model:

```R
linmodel <- lm(temp ~ elevation + latitude, samples)
summary(linmodel)
```

Predict temperature using this model:

```R
maps <- readRAST(c("elevation", "latitude"))
maps$temp_model <- predict(linmodel, newdata=maps)
spplot(maps, "temp_model")
# write modeled temperature to GRASS raster and set color ramp
writeRAST(maps, "temp_model", zcol="temp_model")
execGRASS("r.colors", map="temp_model", color="celsius")
```

Compare simple linear model to real data:

```R
execGRASS("r.mapcalc", expression="diff = temp_mean - temp_model")
execGRASS("r.colors", map="diff", color="differences")
```

In GRASS GUI, add layers *temp_mean* and *temp_model*, select them and
go to *File* - *Map Swipe* to compare visually the modeled and real
temperatures.

Image:US_temp_model_comparison.png|Comparison of PRISM annual mean
temperature and modeled temperature based on latitude and elevation.
Left: Difference between modeled and real temperature in degree Celsius.
Right: Using Map Swipe to visually assess the model (modeled temperature
on the right side).
