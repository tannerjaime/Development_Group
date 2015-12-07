
library("raster")
list.files()
# Localized GDP from Satellite Data (2010)
# http://ngdc.noaa.gov/eog/dmsp/download_gdp.html
RASTERgdp <- raster("Downloads/GDP_grid_flt.tif")

# Night Light Development Indicator (2006)
# http://ngdc.noaa.gov/eog/dmsp/download_nldi.html
RASTERnldi <- raster("../Downloads/NLDI_2006_0p25_rev20111230.tif")

UrbanCenters <- read.csv("../Downloads/UrbanCenters.csv")
#GDP all countries 

# ACLED Version 5
# http://www.acleddata.com/data/version-5-data-1997-2014/
ACLED <- read.csv("../Downloads/ACLED.csv")

ACLED.SU <- subset(ACLED, ACLED$COUNTRY=="Sudan" & ACLED$YEAR=="2006")
ACLED.UG <- subset(ACLED, ACLED$COUNTRY=="Uganda" & ACLED$YEAR=="2006")
ACLED.ET <- subset(ACLED, ACLED$COUNTRY=="Ethiopia" & ACLED$YEAR=="2006")

# extract the gdp for a given lat/lon vector
raster::extract(RASTERgdp, data.frame(lon=12, lat=12.020131))

# get GINI value for lat/lon pair
raster::extract(RASTERnldi, data.frame(lon=12, lat=12.020131))

# Add GPD and GINI values to all violent incidents in Sudan
ACLED.SU["nldi"] <- raster::extract(RASTERnldi, data.frame(lon=ACLED.SU$LONGITUDE, lat=ACLED.SU$LATITUDE))
ACLED.SU["gpd"] <- raster::extract(RASTERgdp, data.frame(lon=ACLED.SU$LONGITUDE, lat=ACLED.SU$LATITUDE))

#GDP
GDP <- read.csv("../Downloads/WDI_Data.csv")
summary(GDP)
head(GDP)

# GDP (current US$)
GDP.ETH <- subset(GDP, GDP$Country.Code=="ETH" & GDP$Indicator.Code=="NY.GDP.MKTP.CD")
GDP.SDN<- subset(GDP, GDP$Country.Code=="SDN" & GDP$Indicator.Code=="NY.GDP.MKTP.CD")
GDP.UGA<- subset(GDP, GDP$Country.Code=="UGA" & GDP$Indicator.Code=="NY.GDP.MKTP.CD")
