## loading concordanceFactors 

library(viridis)
library(ggplot2)
library(dplyr)
library(ggrepel)
library(GGally)
library(entropy)
library(tidyr)
library(ape)
library(phytools)

install.packages("")


# Read the Jarvis Data (later don't forget the change variable names)

JT_CF_CDS <- read.delim("Jarvis/JarvisTree.nwk_CDS_concord.cf.stat", header = T, comment.char = "#")


# remove NA's and mutate new variables here

JT_CF_CDS <- JT_CF_CDS %>% select(-(Label)) %>% subset(ID!="34") #%>% mutate(TotalSN)

sum(JT_CF_CDS$sN)

sum(JT_CF_CDS$sDF1_N) + sum(JT_CF_CDS$sDF2_N2)


JT_CF_UTR <- read.delim("Jarvis/JarvisTree.nwk_UTR_concord.cf.stat", header = T, comment.char = "#")

JT_CF_intron <- read.delim("Jarvis/JarvisTree.nwk_intron_concord.cf.stat", header = T, comment.char = "#")

JT_CF_pseudogene <- read.delim("Jarvis/JarvisTree.nwk_pseudogene_concord.cf.stat", header = T, comment.char = "#")

JT_CF_other <- read.delim("Jarvis/JarvisTree.nwk_other_concord.cf.stat", header = T, comment.char = "#")

JT_CF_lnc_RNA <- read.delim("Jarvis/JarvisTree.nwk_lnc_RNA_concord.cf.stat", header = T, comment.char = "#")

JT_CF_unannotated <- read.delim("Jarvis/JarvisTree.nwk_unannotated_concord.cf.stat", header = T, comment.char = "#")


# Read the Prum Data

PT_CF_CDS <- read.delim("Prum/PrumTree.nwk_CDS_concord.cf.stat", header = T, comment.char = "#")

PT_CF_UTR <- read.delim("Prum/PrumTree.nwk_UTR_concord.cf.stat", header = T, comment.char = "#")

PT_CF_intron <- read.delim("Prum/PrumTree.nwk_intron_concord.cf.stat", header = T, comment.char = "#")

PT_CF_pseudogene <- read.delim("Prum/PrumTree.nwk_pseudogene_concord.cf.stat", header = T, comment.char = "#")

PT_CF_other <- read.delim("Prum/PrumTree.nwk_other_concord.cf.stat", header = T, comment.char = "#")

PT_CF_lnc_RNA <- read.delim("Prum/PrumTree.nwk_lnc_RNA_concord.cf.stat", header = T, comment.char = "#")

PT_CF_unannotated <- read.delim("Prum/PrumTree.nwk_unannotated_concord.cf.stat", header = T, comment.char = "#")


# Merge ALL Jarvis Data


ALL_JT_CF_merged <-  bind_rows("CDS" = JT_CF_CDS, "intron" = JT_CF_intron, "UTR" = JT_CF_UTR, "unannotated" = JT_CF_unannotated,
                        "lnc_RNA" =  JT_CF_lnc_RNA, "pseudogene" = JT_CF_pseudogene, "other" = JT_CF_other,
                        .id = "Data_Type") %>% select(-(Label)) %>% subset(ID!="34")

ALL_JT_CF_merged <- ALL_JT_CF_merged %>% subset(Data_Type!="pseudogene")






#ALLJT_CF_merged$Data_Type <- factor(ALLJT_CF_merged$Data_Type)



# Merge ALL Prum Data

# ALL_PT_CF_merged <-  bind_rows("CDS" = PT_CF_CDS, "intron" = PT_CF_intron, "UTR" = PT_CF_UTR, "unannotated" = PT_CF_unannotated,
#                               "lnc_RNA" =  PT_CF_lnc_RNA, "pseudogene" = PT_CF_pseudogene, "other" = PT_CF_other,
#                               .id = "Data_Type") %>% select(-(Label)) %>% subset(ID!="34")





#check if any NA's left
apply(ALL_JT_CF_merged, 2, function(x) any(is.na(x)))




# Plot scf, gcf values by data type

#ggplot(ALL_JT_CF_merged, aes(x = gCF, y = sCF, colour = Data_Type, label = ID)) + 
#  geom_point() +  
#  scale_colour_discrete(drop=TRUE,
#                        limits = levels(ALL_JT_CF_merged$Data_Type)) + 
#  xlim(0, 45) +
#  ylim(0, 70) + geom_text_repel()



## seperate the conflicts ---- reCHECK before 09/22/21

Galloanseres <- filter(ALL_JT_CF_merged, ID=="35") # galloanseres as control "H0"

Columbea <- filter(ALL_JT_CF_merged, ID=="36") #columbevas split "H1"

Caprimulgiformes <- filter(ALL_JT_CF_merged, ID=="40") #swift split "H2"

Gruiformes <- filter(ALL_JT_CF_merged, ID=="44") #Crane family (inc. hoatzin, split "H3")

Aequornithia <- filter(ALL_JT_CF_merged, ID=="47") #Core water birds "H4"

Telluraves <- filter(ALL_JT_CF_merged, ID=="53") #Core land birds "H5"

#FulGla <- filter(ALLJT_CF_merged, ID=="37") # Flamingo 

#Hoatzin_Gruiformes <- filter(ALLJT_CF_merged, ID=="45")

ListofSplits <- c("Galloanseres", "Columbea", "Caprimulgiformes", "Gruiformes", "Aequornithia", "Telluraves")

ListofSplits

JT_Hs_Combined <- bind_rows("H0" = Galloanseres, 
                        "H1" = Columbea,
                        "H2" = Caprimulgiformes,
                        "H3" = Gruiformes,
                        "H4" = Aequornithia,
                        "H5" = Telluraves, .id = "Split")



JT_Hs_Combined <- JT_Hs_Combined %>% mutate(SplitNAME = case_when(Split == "H0" ~ "Galloanseres",
                                                                  Split == "H1" ~ "Columbea",
                                                                  Split == "H2" ~ "Caprimulgiformes",
                                                                  Split == "H3" ~ "Gruiformes",
                                                                  Split == "H4" ~ "Aequornithia",
                                                                  Split == "H5" ~ "Telluraves"))



# Plot all by DataType 


#ggplot(JT_Hs_Combined, aes(x = gCF, y = sCF, color = Data_Type)) +
#  geom_point()+
#  xlim(0, 45) +
#  ylim(15, 70) + labs(title = "sCF - gCF estimates for each conflicted branch in Jarvis et al. 2014", cex = 6) +
#  annotate("rect", xmin = 5, xmax = 17, ymin = 45, ymax = 65, alpha = 0.1, fill = "blue") +
#  annotate("rect", xmin = 21, xmax = 38, ymin = 40, ymax = 60, alpha = 0.1, fill = "blue") +
#  annotate("text", label = "H1", x = 7, y = 67, size = 5, colour = "blue") + 
#  annotate("text", label = "H0", x = 25, y = 63, size = 5, colour = "blue")



# Exclude the gCFs while plotting

# plot for each sCF


#version 1:


# g <- ggplot(ALL_JT_CF_merged, aes(x = ID, y =sCF, color = Data_Type))

#  <- g + geom_point(size = 2) +
#  scale_x_continuous(breaks = unique(c(ALL_JT_CF_merged$ID)), limits = c(35, 63)) +
#  scale_y_continuous(breaks = seq(0, 99, 20), 
#                     limits=c(15, 80)) + labs(title = "sCF values for each branch in bird phylogeny",
#                                              color = "Data Types") +  theme_minimal()


#Version 2


ALL_JT_CF_merged$ID <- as.factor(ALL_JT_CF_merged$ID)


g <- ggplot(ALL_JT_CF_merged, aes(x=ID, y=sCF, fill = Data_Type)) + scale_y_continuous(breaks = seq(0, 99, 33), 
                                                                                         limits=c(0, 99))

g <- g + geom_dotplot(binaxis = "y", stackdir = "center", binpositions = "all", stackratio = 0.9, dotsize = 2) +
  labs(title = "Site concordonce factors (sCF) by data type",
       tag = "Figure 1",
       x = "Branch ID",
       y = "sCF (%)",
       fill = "Data Type") + 
  theme_grey()

g


# dotplot for H0-H1 hypotheses


g1 <- ggplot(JT_Hs_Combined, aes(x=Split, fill = Data_Type, y=sCF))

g1 <- g1 + geom_dotplot(binaxis = "y", stackdir = "center", binpositions = "all", stackratio = 0.5) + 
  labs(title = "Site concordonce factors (sCF) by data type for only H0-H1 hyphotheses",
       tag = "Figure 2",
       x = "Split",
       y = "sCF (%)",
       fill = "Data Type") + theme_grey() + theme(axis.text.x = element_text(angle = 90, hjust=1))


g1 


#  x axis = scf & y axis= split (vertical)



g2 <- ggplot(JT_Hs_Combined, aes(x=sCF, fill = Data_Type, y=SplitNAME)) + scale_x_continuous(breaks = seq(0, 99, 33),
                                                                                             limits=c(0, 99)) +
  scale_y_discrete(limits = c("Caprimulgiformes", "Aequornithia", "Gruiformes", "Telluraves", "Columbea", "Galloanseres"))
     


g2 <- g2 + geom_dotplot(binaxis = "y", stackgroups = TRUE, binpositions="all", stackdir = "center") +
  labs(title = "Site Concordonce factors (sCF) by data type - vertical",
       tag = "Figure 2",
       x = "sCF (%)",
       y = "Split",
       fill = "Data Type") + theme_grey() #theme(axis.text.x = element_text(angle = 90, hjust=1))


g2




## plot: x axis = split, y axis: Data type


g3 <- ggplot(JT_Hs_Combined, aes(x= Split, y=Data_Type, fill = sCF))


g3 <- g3 + geom_tile() + labs(title = "Site Concordonce factors (sCF) by data type for H0 - H1",
     tag = "Figure 3",
     x = "Split",
     y = "Data Type",
     fill = "sCF (%)")
  
  
g3


  
 # Bubble-dot


g4 <- 
  



g4 <- ggplot(JT_Hs_Combined, aes(x=Split, fill = Data_Type, y=sCF))

g1 <- g1 + geom_dotplot(binaxis = "y", stackdir = "center", binpositions = "all", stackratio = 0.5) + 
  labs(title = "Site concordonce factors (sCF) by data type for only H0-H1 hyphotheses",
       tag = "Figure 2",
       x = "Split",
       y = "sCF (%)",
       fill = "Data Type") + theme_grey() + theme(axis.text.x = element_text(angle = 90, hjust=1))




g4 
 



g4


g

g1

g2

g3

g4


# gDFP (disconcordant due paraphyly) for all branches


g5 <- ggplot(ALL_JT_CF_merged, aes(x = ID, y=gDFP, color = Data_Type))


g5 <- g5 + geom_point(size = 2) + scale_x_continuous(breaks = unique(c(ALL_JT_CF_merged$ID)), limits = c(35, 63)) +
  scale_y_continuous(breaks = seq(0, 100, 10), 
                     limits=c(0, 100)) + labs(title = "gDFP values for each branch in bird phylogeny",
                                              color = "Data Types") +  theme_minimal()

g5



# gDFP for selected hyphotheses


g6 <- ggplot(JT_Hs_Combined, aes(x=Split, fill = Data_Type, y=gDFP))


g6 <- g6 + geom_point(size = 2) + scale_x_discrete() +
  scale_y_continuous(breaks = seq(0, 100, 10), 
                     limits=c(0, 100)) + labs(title = "gDFP values for each conflicted branch in bir phylogeny",
                                              color = "Data Types") #+  theme_minimal()

g6



g2 <- 

g2 <- g2 + geom_dotplot(binaxis = "y", stackdir = "center", binpositions="all")

g2 






#binaxis = "y", stackdir = "center"
g2


  
  
g 

g1

g2




  

binaxis = "y", stackdir = "center", binwidth = 1, aes(ID, sCF)) +
  scale_x_continuous()
#JarvisTree <- read.tree("../IQOutput/Jarvis/JarvisTree.nwk_CDS_concord.cf.tree")

#plot(JarvisTree, show.edge.label = T)

#edgelabels(JarvisTree)


#gID_ALLCFD <- group_by(ALLJT_CF_merged, ID)





PasserineClade <- filter(ALLJT_CF_merged, ID=="53")




CombinedJHMinusOther <- CombinedJH %>% 

#plot splits together


## 

sum(CombinedJHMinusOther$sCF_N)



#combine data type together?

CombinedPseuodege <- ALLJT_CF_merged %>% filter(Data_Type == "pseudogene")

#testing ILS 

JT_CF_CDS <- JT_CF_CDS %>% select(-(Label)) %>% subset(ID!="34")


chisq = function(DF1, DF2, N){
  tryCatch({
    # converts percentages to counts, runs chisq, gets pvalue
    chisq.test(c(round(DF1*N)/100, round(DF2*N)/100))$p.value
  },
  error = function(err) {
    # errors come if you give chisq two zeros
    # but here we're sure that there's no difference
    return(1.0)
  })
}


e = JT_CF_CDS %>% 
  group_by(ID) %>%
  mutate(gEF_p = chisq(gDF1, gDF2, gN)) %>%
  mutate(sEF_p = chisq(sDF1, sDF2, sN))


subset(data.frame(e), (gEF_p < 0.05 | sEF_p < 0.05))


## Internode certainty 

IC = function(CF, DF1, DF2, N){
  
  # convert to counts
  X = CF * N / 100
  Y = max(DF1, DF2) * N / 100
  
  pX = X/(X+Y)
  pY = Y/(X+Y)
  
  IC = 1 + pX * log2(pX) +
    pY * log2(pY)
  
  return(IC)
}

ICTable = e %>% 
  group_by(ID) %>%
  mutate(gIC = IC(gCF, gDF1, gDF2, gN)) %>%
  mutate(sIC = IC(sCF, sDF1, sDF2, sN))


ENT = function(CF, DF1, DF2, N){
  CF = CF * N / 100
  DF1 = DF1 * N / 100
  DF2 = DF2 * N / 100
  return(entropy(c(CF, DF1, DF2)))
}

ENTC = function(CF, DF1, DF2, N){
  maxent = 1.098612
  CF = CF * N / 100
  DF1 = DF1 * N / 100
  DF2 = DF2 * N / 100
  ent = entropy(c(CF, DF1, DF2))
  entc = 1 - (ent / maxent)
  return(entc)
}

ICTable = ICTable %>% 
  group_by(ID) %>%
  mutate(sENT = ENT(sCF, sDF1, sDF2, sN)) %>%
  mutate(sENTC = ENTC(sCF, sDF1, sDF2, sN))


ggpairs(ICTable, columns = c(2, 11, 19, 20, 21, 22, 23, 24))


