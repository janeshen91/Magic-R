#trying to see what is the hold up with the tibble?
#ie what if we only get like 2 coluns wiht just numbers
library(tidyverse)
filteredsmall<-filtered0Un2[c(1:10),c(2:3)]
filteredsmallTib<-as_tibble(filteredsmall)
filteredsmallTib %>% filter (cmc==2)

filteredTib<-unnest(filtered0Un2,cols=c(mana_cost,cmc,name,released_at,
                                             type_line,oracle_text,
                                             reserved,rarity,set_name,
                                             set_type,set,reprint,
                                             story_spotlight,power,toughness,powerNum,toughnessNum,powerAndTough))
allColNames<-colnames(filtered0Un2)
filteredTib<-unnest(filtered0Un2,cols=allColNames)


#problems with colors and colors_identity



filteredsmall2<-filteredsmall[c(28:29),]
filteredsmallTib<-unnest(filteredsmall2,cols=c("name","colors",
                                               "color_identity"))
colorsIndex<-grep("R|B|W|S|U|G", filtered0Un2$color_identity)
seq20132<-c(1:20132)
notColorIndex<-colorsIndex %in% seq20132
filteredsmall28<-filteredsmall[c(28),]
filteredsmallTib28<-unnest(filteredsmall28,cols=c("name","colors","color_identity"))
filteredsmall29<-filteredsmall[c(29),]
filteredsmallTib29<-unnest(filteredsmall29,cols=c("name","colors","color_identity"))
filteredsmallTib2928<-bind_rows(filteredsmallTib28,filteredsmall29)


filteredColors<-filtered0Un2[,c("name","colors","color_identity")]
filteredColors$colors2<-filteredColors$colors
filteredColors$colors3<-filteredColors$color_identity
  
for(i in 1:20132){
  if((length(unlist(filteredColors[i,"colors"])))==0){
    filteredColors[i,"colors2"]="no color"
  }
  
}
for(i in 1:20132){
  if((length(unlist(filteredColors[i,"color_identity"])))==0){
    filteredColors[i,"colors3"]="no color identity"
  }
  
}
filteredColorsTib2<-unnest(filteredColors,cols=c("name","colors2"))
filteredColorsTib3<-unnest(filteredColors,cols=c("name","colors3"))
head(filteredColors)


filteredTib<-unnest(filtered0Un2,cols=c(mana_cost,cmc,name,released_at,
                                        type_line,oracle_text,
                                        reserved,rarity,set_name,
                                        set_type,set,reprint,
                                        story_spotlight,power,toughness,powerNum,toughnessNum,powerAndTough))
filteredTib

filteredColors23<-full_join(filteredColorsTib2[,c("name","colors2")],filteredColorsTib3[,c("name","colors3")],by="name")
filteredColors23All<-left_join(filteredTib[,c("mana_cost","cmc","name","released_at","type_line","oracle_text","reserved"
                                                    ,"rarity","set_name","set_type","set","reprint","story_spotlight"
                                                    ,"powerNum","toughnessNum","powerAndTough")],filteredColors23,by="name")

filteredColors2Only<-left_join(filteredTib[,c("mana_cost","cmc","name","released_at","type_line","oracle_text","reserved"
                                              ,"rarity","set_name","set_type","set","reprint","story_spotlight"
                                              ,"powerNum","toughnessNum","powerAndTough")],filteredColorsTib2[,c("name","colors2")],by="name")
filteredColors2OnlyUniq<-unique.data.frame(filteredColors2Only)

save(filteredColors2OnlyUniq,file="filteredColors2OnlyUniq.RData")
