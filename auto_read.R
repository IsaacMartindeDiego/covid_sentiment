library(dplyr)
library(ggplot2)
library(lubridate)
library(zoo)

data_path <- 'https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/ccaa_covid19_datos_sanidad_nueva_serie.csv'

spain <- read.csv(data_path)

casos = spain %>% group_by(Fecha)%>%arrange(Fecha)%>%summarise(CasosTotales=sum(Casos))
casos$Fecha=as.Date(casos$Fecha)

gg1=ggplot(data=casos,aes(x=Fecha,y=CasosTotales,group=1),lwd=1.5)+
  geom_line(color="#00AFBB", size = 1.5)+
  labs(x = "Date", 
       y = "Cases", 
       title = "Spain")+
  scale_x_date(date_labels="%b/%Y", date_breaks="3 months", expand=c(0,0))+
  theme_bw() 
gg2=gg1+ geom_line(aes(y=rollmean(CasosTotales, 14, na.pad=TRUE)))



fallecidos <- 'https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/ccaa_covid19_datos_sanidad_nueva_serie.csv'

spain <- read.csv(data_path)

casos = spain %>% group_by(Fecha)%>%arrange(Fecha)%>%summarise(CasosTotales=sum(Casos))
casos$Fecha=as.Date(casos$Fecha)

gg1=ggplot(data=casos,aes(x=Fecha,y=CasosTotales,group=1),lwd=1.5)+
  geom_line(color="#00AFBB", size = 1.5)+
  labs(x = "Date", 
       y = "Cases", 
       title = "Spain")+
  scale_x_date(date_labels="%b/%Y", date_breaks="3 months", expand=c(0,0))+
  theme_bw() 
gg2=gg1+ geom_line(aes(y=rollmean(CasosTotales, 14, na.pad=TRUE)))
