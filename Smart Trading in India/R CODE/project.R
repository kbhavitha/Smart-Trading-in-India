

#loading the dataset's

#import's dataset

imp201415 <-
  read.csv("C:/Users/HP/Desktop/dm project/dataset/PC_Import_2014_2015.csv")
imp201516 <-
  read.csv("C:/Users/HP/Desktop/dm project/dataset/PC_Import_2015_2016.csv")
imp201617 <-
  read.csv("C:/Users/HP/Desktop/dm project/dataset/PC_Import_2016_2017.csv")

trading.import<-rbind(imp201415,imp201516,imp201617)

#export's dataset

exp201415 <-
  read.csv("C:/Users/HP/Desktop/dm project/dataset/PC_Export_2014_2015.csv")
exp201516 <-
  read.csv("C:/Users/HP/Desktop/dm project/dataset/PC_Export_2015_2016.csv")
exp201617 <-
  read.csv("C:/Users/HP/Desktop/dm project/dataset/PC_Export_2016_2017.csv")

trading.export<-rbind(exp201415,exp201516,exp201617)






#products are aggregated depending upon its type.
trading.goods.type <- list()
trading.goods.type$Agriculture_allied_products <-
  c("Tea","Coffee","Rice -Basmoti","Rice(Other Than Basmoti)","Wheat","Other Cereals","Pulses","Tobacco Unmanufactured","Tobacco Manufactured","Spices","Cashew","Cashew Nut Shell Liquid","Sesame Seeds","Niger Seeds",
    "Groundnut","Other Oil Seeds","Vegetable Oils","Oil Meals","Guergam Meal","Castor Oil","Shellac","Sugar","Mollases","Fruits / Vegetable Seeds","Fresh Fruits", "Fresh Vegetables","Processed Vegetables","Processed Fruits And Juices","Cereal,Preparations","Cocoa Products","Milled Products","Misc Processed Items","Animal Casings","Buffalo Meat","Sheep/Goat Meat","Other Meat","Processed Meat","Dairy Products","Poultry Products","Floricltr Products","Natural Rubber","Alcoholic Beverages","Marine Products","Cereal Preparations")
trading.goods.type$Chemical_Industry <-
  c("Fertilezers Crude","Fertilezers Manufactured","Ayush And Herbal Products","Bulk Drugs, Drug Intermediates","Dye Intermediates","Dyes","Drug Formulations, Biologicals",
    "Agro Chemicals","Inorganic Chemicals","Organic Chemicals","Other Miscellaenious Chemicals","Cosmetics And Toiletries","Essential Oils","Residul Chemicl And Alled Prod", "Paint, Varnish And Allid Prodc","Graphite, Explsivs And Accesor","Cmnt, Clinkr And Asbstos Cmnt","Ceramics And Allied Products","Manmade Staple Fibre")
trading.goods.type$gems_and_jewelry <-
  c("Pearl, Precs, Semiprecs Stones","Gold","Silver","Other Precious And Base Metals","Gold And Oth Precs Metl Jwlery")
trading.goods.type$Leather <-
  c("Raw Hides And Skins","Finished Leather","Leather Goods","Leather Garments","Footwear Of Leather","Leather Footwear Component","Saddlery And Harness")
trading.goods.type$Manifacutred_goods <-
  c("Sports Goods","Surgicals","Footwear Of Rubber/Canvas Etc.","Auto Components/Parts","Electrodes","Accumulators And Batteries","Hnd Tool, Cttng Tool Of Metals","Machine,Tools",
    "Medical And Scientific Instrum","Office Equipments","Ac, Refrigeration Machnry Etc","Bicycle And Parts","Cranes, Lifts And Winches","Electric Machinery And Equipme","Ic Engines And Parts", "Indl. Machnry For Dairy Etc","Atm, Injctng Mlding Mchnry Etc","Nucler Reactr, Indl Boilr, Prt","Other Construction Machinery","Other Misc. Engineering Items","Prime Mica And Mica Products","Pumps Of All Types","Aircraft, Spacecraft And Parts","Motor Vehicle/Cars","Railwy Trnsprt Equipmnts, Prts","Ship, Boat And Floating Struct","Two And Three Wheelers","Computer Hardware, Peripherals","Consumer Electronics","Electronics Components","Electronics Instruments","Telecom Instruments","Project Goods","Machine Tools")
trading.goods.type$Ores_and_minerals <-
  c("Iron Ore","Mica","Coal,Coke And Briquittes Etc","Bulk Minerals And Ores","Granit, Natrl Stone And Prodct","Processed Minerals","Sulpher, Unroasted Iron Pyrite",
    "Other Crude Minerals","Iron And Steel","Products Of Iron And Steel","Aluminium, Products Of Aluminm","Copper And Prdcts Made Of Copr","Lead And Products Made Of Led","Nickel, Product Made Of Nickel","Tin And Products Made Of Tin","Zinc And Products Made Of Zinc","Oth Non Ferous Metal And Prodc","Petroleum Products","Petroleum: Crude")
trading.goods.type$plastics_and_paper <-
  c("Glass And Glassware","Books, Publications And Prntng","Newsprint","Paper, Paper Board And Product","Plywood And Allied Products","Other Wood And Wood Products",
    "Pulp,And Waste Paper","Optical Items (Incl.Lens Etc)","Human Hair, Products Thereo","Moulded And Extruded Goods","Packaging Materials","Plastic Raw Materials","Plastc Sht, Film, Plts Etc","Stationry/Offce, School Supply","Other Plastic Items","Pulp And Waste Paper")
trading.goods.type$Rubber <-
  c("Auto Tyres And Tubes", "Othr Rubber Prodct Excpt Footw")
trading.goods.type$Textile <-
  c("Cotton Yarn","Cotton Fabrics, Madeups Etc.","Oth Txtl Yrn, Fbric Mdup Artcl","Silk,Raw","Natrl Silk Yarn,Fabrics,Madeup","Manmade Yarn,Fabrics,Madeups","Wool, Raw",
    "Wollen Yarn,Fabrics,Madeupsetc","Rmg Cotton Incl Accessories","Rmg Silk","Rmg Manmade Fibres","Rmg Wool","Rmg Of Othr Textle Matrl","Coir And Coir Manufactures","Handloom Products","Silk Waste","Jute, Raw","Jute Yarn","Jute Hessian","Floor Cvrng Of Jute","Other Jute Manufactures","Handcrfs(Excl.Handmade Crpts)","Carpet(Excl. Silk) Handmade","Silk Carpet","Cotton Raw Incld. Waste")
trading.goods.type$OtherCommodities <- c("Other Commodities")

    
    

#function to find product type of each good
  goods.type <- function(trading.goods.type) {
  type <- NULL
  pc <- NULL
  for (x in names(trading.goods.type))
  {
    tmp <- trading.goods.type[[x]]
    pc <- c(pc, tmp)
    type <- c(type, rep(x, length(tmp)))
  }
  data.frame("type" = type, "pc" = pc, stringsAsFactors = F)
  }
#finding product types of each good  
pc.type <-goods.type(trading.goods.type)

#matching product with product type and storing in import dataset  
trading.import$pc_type <- pc.type$type[match(trading.import$pc_description, pc.type$pc)]
write.csv(trading.import, "C:/Users/HP/Desktop/dm project/modified/import1.csv")  

#matching product with product type and storing in export dataset  
trading.export$pc_type <- pc.type$type[match(trading.export$pc_description, pc.type$pc)]
write.csv(trading.export, "C:/Users/HP/Desktop/dm project/modified/export1.csv")  




library(dplyr)
#finding top 10 trading partners of india on the basis of price in imports 
import_countries <- trading.import %>% group_by(country_name) %>% summarise(capital = sum(value, na.rm = T))
ordered.import_countries<- import_countries %>% arrange(desc(capital))
imp<-c("China P Rp","Saudi Arab","U Arab Emts","U S A","Switzerland","Indonesia","Korea Rp","Iraq","Germany","Nigeria")
import.top<-trading.import %>% filter(country_name %in% imp)
#finding top 25 goods in trading on the basis of price in imports 
import_goods <- trading.import %>% group_by(pc_description) %>% summarise(capital = sum(value, na.rm = T))
ordered.import_gd <- import_goods %>% arrange(desc(capital))
import_gd<-ordered.import_gd[1:25,1]
imp_gd<-c("Petroleum: Crude","Gold","Pearl, Precs,Semiprecs Stones","Petroleum Products","Coal,Coke And Briquittes Etc","Telecom Instruments","Other Commodities","Vegetable Oils","Iron And Steel","Organic Chemicals","Indl. Machnry For Dairy Etc","Plastic Raw Materials","Computer Hardware, Peripherals","Electronics Components","Electric Machinery And Equipme","Fertilezers Manufactured","Electronics Instruments","Aircraft, Spacecraft And Parts","Bulk Minerals And Ores","Residul Chemicl And Alled Prod","Ship, Boat And Floating Struct","Inorganic Chemicals","Auto Components/Parts","Consumer Electronics","Products Of Iron And Steel")
 #dataset of top 10 countries with top 25 goods
import.gd<-import.top %>% filter(pc_description %in% imp_gd)
write.csv(import.gd,"C:/Users/HP/Desktop/dm project/final/imports1.csv")

#finding top 10 trading partners of india on the basis of price in exports 
export_countries <- trading.export %>% group_by(country_name) %>% summarise(capital = sum(value, na.rm = T))
ordered.export_countries <- export_countries %>% arrange(desc(capital))
exp<-c("U S A","U Arab Emts","Hong Kong","China P Rp","Singapore","U K","Saudi Arab","Germany","Bangladesh Pr","Vietnam Soc Rep")
export.top<-trading.export %>% filter(country_name %in% exp)
#finding top 25 goods in trading on the basis of price in exports 
export_goods <- trading.export %>% group_by(pc_description) %>% summarise(capital = sum(value, na.rm = T))
ordered.export_gd <- export_goods %>% arrange(desc(capital))
export_gd<-ordered.export_gd[1:25,1]
exp_gd<-c("Petroleum Products","Pearl, Precs, Semiprecs Stones","Gold And Oth Precs Metl Jwlery","Drug Formulations, Biologicals","Rmg Cotton Incl Accessories","Iron And Steel","Motor Vehicle/Cars","Products Of Iron And Steel","Marine Products","Cotton Fabrics, Madeups Etc.","Organic Chemicals","Manmade Yarn,Fabrics,Madeups","Indl. Machnry For Dairy Etc","Gold","Rmg Manmade Fibres","Aircraft, Spacecraft And Parts","Auto Components/Parts","Ship, Boat And Floating Struct","Buffalo Meat","Electric Machinery And Equipme","Rice -Basmoti","Residul Chemicl And Alled Prod","Cotton Yarn","Other Commodities","Bulk Drugs, Drug Intermediates")
#dataset of top 10 countries with top 25 goods
export.gd<-export.top %>% filter(pc_description %in% exp_gd)
write.csv(export.gd,"C:/Users/HP/Desktop/dm project/final/exports1.csv")





