
library(ggplot2)
library(ggdendro)
library(tidyr)
library(dplyr)

import <- read.csv("C:/Users/HP/Desktop/dm project/modified/import1.csv")
export <- read.csv("C:/Users/HP/Desktop/dm project/modified/export1.csv")

x<-rep("import",28995)
import$type<-x
y<-rep("export",62445)
export$type<-y
                                        
trading<-rbind(import,export)
#finding sum of price on each product-country-type(import or export)
prd.cntry.type <- trading %>% group_by(pc_description, country_name, type) %>% summarise(capital = sum(value, na.rm = T))

#finding sum of price on each product in imports and exports
prd.type <- trading %>% group_by(pc_description, type) %>% summarise(total = sum(value, na.rm = T))#, quant = sum(quantity, na.rm = T)) 
#adding imports and exports price of each country to find top contributing products towards trading
prd.wide <- prd.type %>% spread(key = type, value = total, fill = .000001) %>%  mutate(total = export + import) %>% as.data.frame()


#finding sum of price in each country in imports and exports
country.type <- trading %>% group_by(country_name, type) %>% summarise(total = sum(value))
#adding imports and exports price of each country to find top contributing countries towards trading
country.wide <- country.type %>% spread(key = type, value = total, fill = .000001) %>%  mutate(total = export + import) %>% as.data.frame()






#function to find top 95% contribution
getfraction <- function(df.x){
  df.x %>% arrange(desc(total)) %>% mutate(fraction = cumsum(total)/sum(total, na.rm = T))
}

prd.wide <- getfraction(prd.wide)
country.wide <- getfraction(country.wide)

#to 95% countries contributing towards trading
ctr95 <- country.wide$country_name[country.wide$fraction < .95]
#to 95% products contributing towards trading
prd95 <- prd.wide$pc_description[prd.wide$fraction < .95]
#storing top 95% countries and top 95% products
ctr95prd95 <-prd.cntry.type %>% filter(country_name %in% ctr95, pc_description %in% prd95)

#normalize capital(price) column
ctr95prd95$capital <- log10(ctr95prd95$capital)






#dataframe of imports
df.import <-ctr95prd95 %>% filter(type == "import") %>% select(-type) %>% spread(key = pc_description, value = capital, fill =  0) %>% as.data.frame()
row.names(df.import) <- df.import$country_name
#Hierarchical clustering applied on distance distance matrix of imports
hc.import <- hclust(dist(as.matrix(df.import[, -1])))
#dendogram(imports)
hcd1<-as.dendrogram(hc.import)
plot(hc.import, cex = 0.6)
rect.hclust(hc.import, k = 29, border = 2:10)
grp1 <- cutree(hc.import, k = 29)
write.csv(grp1,file="C:/Users/HP/Desktop/dm project/modified/imp_dendo.csv")



#dataframe of imports
df.export <- ctr95prd95 %>% filter(type == "export") %>% select(-type) %>% spread(key = pc_description, value = capital, fill =  0) %>% as.data.frame()
row.names(df.export) <- df.export$country_name
#distance matrix of imports
hc.export <- hclust(dist(as.matrix(df.export[, -1])))
#dendogram(exports)

hcd<-as.dendrogram(hc.export)
plot(hc.export, cex = 0.6)
rect.hclust(hc.export, k = 39, border = 2:10)
grp <- cutree(hc.export, k = 39)
write.csv(grp,file="C:/Users/HP/Desktop/dm project/modified/exp_dendo.csv")



