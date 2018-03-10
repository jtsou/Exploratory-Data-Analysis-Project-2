NEIBalt = subset(NEI, fips =='24510')
totalEmissionBalt = aggregate(Emissions ~ year, NEIBalt, sum, na.rm =TRUE)
barplot(totalEmissionBalt$Emissions/10^6, #tons 
        names.arg=totalEmissionBalt$year
        , xlab='year'
        ,ylab='Total PM2.5 Emissions (in tons)'
        ,main = 'Total PM2.5 Emissions From All Baltimore Cities'
        , col = 'red')
