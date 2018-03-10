
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
