totalEmission = aggregate(Emissions ~ year, NEI, sum, na.rm=TRUE)

barplot(totalEmission$Emissions/10^6, #tons 
        names.arg=totalEmission$year
        , xlab='year'
        ,ylab='Total PM2.5 Emissions (in tons)'
        ,main = 'Total PM2.5 Emissions From All Sources in the US'
        , col = 'blue')
