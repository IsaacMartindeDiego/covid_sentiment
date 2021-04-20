library(dplyr)
library(ggplot2)
library(lubridate)
library(zoo)

old.loc <- Sys.getlocale("LC_TIME")
Sys.setlocale(category = "LC_TIME", locale = "en_US.utf8")

casos <- 'https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/ccaa_covid19_datos_sanidad_nueva_serie.csv'

casos <- read.csv(casos)


fallecidos = 'https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/ccaa_covid19_fallecidos_por_fecha_defuncion_nueva_serie_original.csv'
fallecidos <- read.csv(fallecidos)


casos = casos %>% group_by(Fecha)%>%arrange(Fecha)%>%summarise(CasosTotales=sum(Casos))
casos$Fecha=as.Date(casos$Fecha)

gg1=ggplot(data=casos,aes(x=Fecha,y=CasosTotales,group=1),lwd=1.5)+
  geom_line(color="#00AFBB", size = 1.5)+
  labs(x = "Date", 
       y = "Cases", 
       title = "Spain")+
  scale_x_date(date_labels="%b/%Y", date_breaks="3 months", expand=c(0,0))+
  theme_bw() 
gg2=gg1+ geom_line(aes(y=rollmean(CasosTotales, 14, na.pad=TRUE)))
ggsave("España_Casos.png")



fallecidos = fallecidos %>% group_by(Fecha)%>%arrange(Fecha)%>%summarise(FallecidosTotales=sum(Fallecidos))
fallecidos$Fecha=as.Date(fallecidos$Fecha)

gg3=ggplot(data=fallecidos,aes(x=Fecha,y=FallecidosTotales,group=1),lwd=1.5)+
  geom_line(color="#FC4E07", size = 1.5)+
  labs(x = "Date", 
       y = "Deaths", 
       title = "Spain")+
  scale_x_date(date_labels="%b/%Y", date_breaks="3 months", expand=c(0,0))+
  theme_bw() 
gg4=gg3+ geom_line(aes(y=rollmean(FallecidosTotales, 14, na.pad=TRUE)))
ggsave("España_Fallecidos.png")
Sys.setlocale("LC_TIME",old.loc) 
