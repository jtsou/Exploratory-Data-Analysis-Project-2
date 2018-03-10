#Data = download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip', destfile = 'Data.zip')
#unzip = unzip('Data.zip')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)
# get just the complete data
NEI=NEI[complete.cases(NEI),]

library(ggplot2)
library(plyr)
names(NEI)

#1 Have total emissions from PM2.5 decreased in US from 1998 to  2008?
totalEmission = aggregate(Emissions ~ year, NEI, sum, na.rm=TRUE)

barplot(totalEmission$Emissions/10^6, #tons 
        names.arg=totalEmission$year
        , xlab='year'
        ,ylab='Total PM2.5 Emissions (in tons)'
        ,main = 'Total PM2.5 Emissions From All Sources in the US'
        , col = 'blue')



#2Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == “24510”) from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

NEIBalt = subset(NEI, fips =='24510')
totalEmissionBalt = aggregate(Emissions ~ year, NEIBalt, sum, na.rm =TRUE)
barplot(totalEmissionBalt$Emissions/10^6, #tons 
        names.arg=totalEmissionBalt$year
        , xlab='year'
        ,ylab='Total PM2.5 Emissions (in tons)'
        ,main = 'Total PM2.5 Emissions From All Baltimore Cities'
        , col = 'red')

#3 
head(NEIBalt)
ggplot(aes(x = factor(year), y= (Emissions/10^6), fill=type), data = NEIBalt)+
  geom_bar(stat = 'identity')+
  facet_grid(.~type,scales = "free",space="free")+
  labs(x='year', y= expression("Total PM"[2.5]*" Emission (Tons)"))+
  labs(title = expression("PM"[2.5]*" EMissions, Baltimore Cities 1998-2008 by Source Type"))+
  guides(fill = F)
          

#4
head(SCC)
names(SCC)
comb = grepl("Comb", SCC$SCC.Level.One, ignore.case = TRUE)
coal = grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
comcoal = SCC[comb & coal, ]$SCC
NEICC =  NEI[NEI$SCC %in% comcoal,]
NEICCTotal = aggregate(Emissions ~ year, NEICC, sum)

ggplot(aes(x = year, y = Emissions/10^6), data=NEICCTotal)+
  geom_bar(stat="identity",fill="green") +
  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^6 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

#5
SCCVehicle = grepl('vehicle', SCC$EI.Sector, ignore.case = TRUE)
SCCVehicle = SCC[SCCVehicle,]$SCC

NEIvehicleSSC = NEI[NEI$SCC %in% SCCVehicle, ]
NEIvehicleBalt = subset(NEIvehicleSSC, fips == "24510")
NIEvehicleBaltTotal = aggregate(Emissions~year, NEIvehicleBalt, sum)

ggplot(aes(year, Emissions/10^6), data=NIEvehicleBaltTotal)+
  geom_bar(stat="identity",fill="blue") +
  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^6 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

#6
NEIvehicleBalti = subset(NEIvehicleSSC, fips == "24510")
NEIvehicleBalti$city = "Baltimore City"
NEIvehiclela = subset(NEIvehicleSSC, fips == "06037")
NEIvehiclela$city = "Los Angeles County"
NEIBothCity = rbind(NEIvehicleBalti, NEIvehiclela)

ggplot(aes(x=year, y=Emissions, fill=city), data = NEIBothCity) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(.~city) +
  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
