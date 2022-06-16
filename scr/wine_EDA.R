#installing packages
library(tidyverse)
library(ggplot2)
library(here)
library(janitor)
library(corrplot)
library(ggcorrplot)
library(ggthemes)


#import the data.
wineRaw <- read.csv("data/winequality-red.csv", sep = ";")

#check the first 10 rows.
head(wineRaw)

#clean and remove spaces.
wine <- clean_names(wineRaw)

#check the cleaned file.
glimpse(wine)

#remove duplicates.
wine <- distinct(wine)
get_dupes(wine)summaris #It should results in 0 duplications.

#To see the desnity plot for each category,
wine %>% 
  DataExplorer::plot_density()


#correlation plot
ggcorrplot(cor(wine), hc.order = TRUE, 
           type = "lower", 
           lab = TRUE, 
           lab_size = 3, 
           method="circle", 
           colors = c("Cyan", "white", "Brown3"), 
           title="Correlogram of wine", 
           ggtheme=theme_bw)

#This Correlogram shows how different factors are related.
#The highest correlation with quality is alcohol.

wine %>% 
  group_by(quality) %>% 
  summarise(AVG = mean(alcohol)) %>% 
  ggplot(aes(x =quality  , y= AVG)) + 
  geom_bar(stat='identity', color="Black", fill="Darkred")+ 
  labs(y="The Average of alcohol ", x=" Quality")+
  coord_flip()

#We see as the average of alcohol increases, the quality increases as well.








