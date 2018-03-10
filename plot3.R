ggplot(aes(x = factor(year), y= (Emissions/10^6), fill=type), data = NEIBalt)+
  geom_bar(stat = 'identity')+
  facet_grid(.~type,scales = "free",space="free")+
  labs(x='year', y= expression("Total PM"[2.5]*" Emission (Tons)"))+
  labs(title = expression("PM"[2.5]*" EMissions, Baltimore Cities 1998-2008 by Source Type"))+
  guides(fill = F)
