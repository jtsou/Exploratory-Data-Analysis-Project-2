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
