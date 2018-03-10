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
