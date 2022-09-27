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
library(lemon)
library(treemap)

# Read the Jarvis Data (later don't forget the change variable names)

JT_CF_CDS <- read.delim("Jarvis/JarvisTree.nwk_CDS_concord.cf.stat", header = T, comment.char = "#")

# remove NA's and mutate new variables here

#JT_CF_CDS <- JT_CF_CDS %>% select(-(Label)) %>% subset(ID!="34") #%>% mutate(TotalSN)

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

#subset pseudogene data since it is very short

ALL_JT_CF_merged <- ALL_JT_CF_merged %>% subset(Data_Type!="pseudogene")


# Merge ALL Prum Data

ALL_PT_CF_merged <-  bind_rows("CDS" = PT_CF_CDS, "intron" = PT_CF_intron, "UTR" = PT_CF_UTR, "unannotated" = PT_CF_unannotated,
                               "lnc_RNA" =  PT_CF_lnc_RNA, "pseudogene" = PT_CF_pseudogene, "other" = PT_CF_other,
                               .id = "Data_Type") %>% select(-(Label)) %>% subset(ID!="34")

#subset pseudogene data since it is very short

ALL_PT_CF_merged <- ALL_PT_CF_merged %>% subset(Data_Type!="pseudogene")
  
#ALLJT_CF_merged$Data_Type <- factor(ALLJT_CF_merged$Data_Type)


#check if any NA's left

apply(ALL_JT_CF_merged, 2, function(x) any(is.na(x)))


apply(ALL_PT_CF_merged, 2, function(x) any(is.na(x)))


## seperate the conflicts ---- for Jarvis et al. only! 10/05/21

JT_Galloanseres <- filter(ALL_JT_CF_merged, ID=="35") # galloanseres as control "H0"

JT_Columbea <- filter(ALL_JT_CF_merged, ID=="36") #columbaves split "H1"

JT_Caprimulgiformes <- filter(ALL_JT_CF_merged, ID=="40") #swift split "H2"

JT_Gruiformes <- filter(ALL_JT_CF_merged, ID=="44") #Crane family (inc. hoatzin, split "H3")

JT_Aequornithia <- filter(ALL_JT_CF_merged, ID=="47") #Core water birds "H4"

JT_Telluraves <- filter(ALL_JT_CF_merged, ID=="53") #Core land birds "H5"

JT_ListofJarvisSplits <- c("Galloanseres", "Columbea", "Caprimulgiformes", "Gruiformes", "Aequornithia", "Telluraves")

JT_ListofJarvisSplits


## seperate the conflicts ---- for Prum et al. only! 10/05/21

PT_Galloanseres <- filter(ALL_PT_CF_merged, ID=="63") # galloanseres as control "H0"

PT_Columbea <- filter(ALL_PT_CF_merged, ID == "36") #columbaves split "H1"

PT_Caprimulgiformes <- filter(ALL_PT_CF_merged, ID == "35") #swift split "H2"

PT_Gruiformes <- filter(ALL_PT_CF_merged, ID == "39") # hoatzin split "H3"

PT_Aequornithia <- filter(ALL_PT_CF_merged, ID == "38") #core water birds "H4"

PT_Telluraves <- filter(ALL_PT_CF_merged, ID=="40") #Core land birds "H5"

PT_ListofPrumSplits <- c("Galloanseres", "Columbea", "Caprimulgiformes", "Gruiformes", "Aequornithia", "Telluraves")


PT_ListofPrumSplits



# Plot scf, gcf values by data type

#ggplot(ALL_JT_CF_merged, aes(x = gCF, y = sCF, colour = Data_Type, label = ID)) + 
#  geom_point() +  
#  scale_colour_discrete(drop=TRUE,
#                        limits = levels(ALL_JT_CF_merged$Data_Type)) + 
#  xlim(0, 45) +
#  ylim(0, 70) + geom_text_repel()

# combine the Jarvis splits

JT_Hs_Combined <- bind_rows("H0" = JT_Galloanseres, 
                        "H1" = JT_Columbea,
                        "H2" = JT_Caprimulgiformes,
                        "H3" = JT_Gruiformes,
                        "H4" = JT_Aequornithia,
                        "H5" = JT_Telluraves, .id = "Split")


JT_Hs_Combined <- JT_Hs_Combined %>% mutate(SplitNAME = case_when(Split == "H0" ~ "Galloanseres",
                                                                  Split == "H1" ~ "Columbea",
                                                                  Split == "H2" ~ "Caprimulgiformes",
                                                                  Split == "H3" ~ "Gruiformes",
                                                                  Split == "H4" ~ "Aequornithia",
                                                                  Split == "H5" ~ "Telluraves"))

# combine the Prum splits


PT_Hs_Combined <- bind_rows("H0" = PT_Galloanseres, 
                            "H1" = PT_Columbea,
                            "H2" = PT_Caprimulgiformes,
                            "H3" = PT_Gruiformes,
                            "H4" = PT_Aequornithia,
                            "H5" = PT_Telluraves, .id = "Split")


PT_Hs_Combined <- PT_Hs_Combined %>% mutate(SplitNAME = case_when(Split == "H0" ~ "Galloanseres",
                                                                  Split == "H1" ~ "Columbea",
                                                                  Split == "H2" ~ "Caprimulgiformes",
                                                                  Split == "H3" ~ "Gruiformes",
                                                                  Split == "H4" ~ "Aequornithia",
                                                                  Split == "H5" ~ "Telluraves"))


# treemap for summary


summary_sequence_data <- 


treemap(ALL_JT_CF_merged,
        index = "Data_Type",
        vSize = "sN",
        type = "index",
        title = "",
        palette = "Dark2",
        border.col = c("black"),
        border.lwds = 1,
        fontsize.labels = 0.5,
        fontcolor.labels = c("white"),
        fontface.labels = 1,
        bg.labels = "transparent",
        align.labels = c("left", "top"),
        overlap.labels = 0.5,
        inflate.labels = F)


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


#version 1 Jarvis et al.:


JT_g1 <- ggplot(ALL_JT_CF_merged, aes(x = ID, y =sCF, color = Data_Type))

JT_g1  <- JT_g1 + geom_point(size = 2) +
  scale_x_continuous(breaks = unique(c(ALL_JT_CF_merged$ID)), limits = c(35, 63)) +
  scale_y_continuous(breaks = seq(0, 99, 20), 
                     limits=c(15, 80)) + labs(title = "sCF values for each branch in bird phylogeny",
                                              color = "Data Types") +  theme_grey()

JT_g1


# version 1 Jarvis et al, with the brackets:

JT_g1 <- ggplot(ALL_JT_CF_merged, aes(x = ID, y =sCF, color = Data_Type)) +
  geom_point(position=position_jitter(width=0.3)) +
  scale_x_continuous(breaks = seq(35, 63, 1)) +
  scale_y_continuous(breaks = seq(0, 99, 33), limits=c(10, 66), sec.axis=dup_axis()) +
  coord_flex_cart(bottom=brackets_horizontal(), 
                  top=brackets_horizontal(direction='down'),
                  left=brackets_vertical(direction='right'), 
                  right=brackets_vertical(direction='left')) + 
  labs(title = "Site Concordance Factors by data type in the bird phylogeny (Jarvis et al. 2014)",
       color = "Data Types",
       y = "sCF (%)",
       x = "Branch ID") + theme_gray()


JT_g1


#version 1 Prum et al.:


PT_g1 <- ggplot(ALL_PT_CF_merged, aes(x = ID, y =sCF, color = Data_Type))

PT_g1  <- PT_g1 + geom_point(size = 2) +
  scale_x_continuous(breaks = unique(c(ALL_PT_CF_merged$ID)), limits = c(35, 63)) +
  scale_y_continuous(breaks = seq(0, 99, 20), 
                     limits=c(15, 80)) + labs(title = "sCF values for each branch in bird phylogeny",
                                              color = "Data Types") +  theme_grey()

PT_g1


# version 1 Prum et al. with the bracet 

PT_g1 <- ggplot(ALL_PT_CF_merged, aes(x = ID, y =sCF, color = Data_Type)) +
  geom_point(position=position_jitter(width=0.3)) +
  scale_x_continuous(breaks=seq(35,63),sec.axis=dup_axis()) +
  scale_y_continuous(breaks = seq(0, 99, 20), limits=c(10, 80), sec.axis=dup_axis()) +
  coord_flex_cart(bottom=brackets_horizontal(), 
                  top=brackets_horizontal(direction='down'),
                  left=brackets_vertical(direction='right'), 
                  right=brackets_vertical(direction='left')) + 
  labs(title = "sCF values for each branch in bird phylogeny (Prum et al. 2015)",
       color = "Data Types") + theme_grey()
  

PT_g1



#ALL_JT_CF_merged$ID <- as.factor(ALL_JT_CF_merged$ID)


#JT_g1 <- ggplot(ALL_JT_CF_merged, aes(x=ID, y=sCF, fill = Data_Type)) + scale_y_continuous(breaks = seq(0, 99, 33), 
 #                                                                                        limits=c(0, 99))

#JT_g1 <- JT_g1 + geom_dotplot(binaxis = "y", stackdir = "center", binpositions = "all", stackratio = 0.9, dotsize = 2) +
 # labs(title = "Site concordonce factors (sCF) by data type",
  #     tag = "Figure 1",
   #    x = "Branch ID",
    #   y = "sCF (%)",
     #  fill = "Data Type") + 
  #theme_grey()

#JT_g1




# dotplot for H0-H1 hypotheses


g1 <- ggplot(JT_Hs_Combined, aes(x=Split, fill = Data_Type, y=sCF))

g1 <- g1 + geom_dotplot(binaxis = "y", stackdir = "center", binpositions = "all", stackratio = 0.5) + 
  labs(title = "Site concordonce factors (sCF) by data type for only H0-H1 hyphotheses",
       tag = "Figure 2",
       x = "Split",
       y = "sCF (%)",
       fill = "Data Type") + theme_grey() + theme(axis.text.x = element_text(angle = 90, hjust=1))


g1 


# dotplot for H0-H1 hypotheses - bracet

g1 <- ggplot(JT_Hs_Combined, aes(x=Split, color = Data_Type, y=sCF, shape = SplitNAME))

g1 <- g1 + geom_point(position=position_jitter(width=0.3), size = 3) +
  scale_x_discrete() +
  scale_y_continuous(breaks = seq(0, 99, 33), limits=c(10, 80), sec.axis=dup_axis()) +
  coord_flex_cart(bottom=brackets_horizontal(), 
                  top=brackets_horizontal(direction='down'),
                  left=brackets_vertical(direction='right'), 
                  right=brackets_vertical(direction='left')) +
  labs(title = "Site concordonce factors (sCF %) by data type for only H0-H1 hyphotheses \n (Jarvis et al. 2014)",
       tag = "Figure 2",
       x = "Split",
       y = "sCF (%)") +
  scale_shape_discrete(name  ="Splits",
                       breaks= c("Galloanseres",
                                 "Columbea",
                                 "Caprimulgiformes",
                                 "Gruiformes",
                                 "Aequornithia",
                                 "Telluraves"),
                       labels= c("H0: Galloanseres",
                       "H1: Columbea",
                       "H2: Caprimulgiformes",
                       "H3: Gruiformes",
                       "H4: Aequornithia",
                       "H5: Telluraves")) + 
  
  scale_colour_discrete(name = "Data Type",
                        breaks = ListOfDataTypes,
                        labels = ListOfDataTypes)
  
g1 



ListOfJarvisSplits <- c(unique(JT_Hs_Combined$SplitNAME))
ListOfDataTypes <- c(unique(JT_Hs_Combined$Data_Type))

#  x axis = scf & y axis= split (vertical)


#g2 <- ggplot(JT_Hs_Combined, aes(x=sCF, fill = Data_Type, y=SplitNAME)) + scale_x_continuous(breaks = seq(0, 99, 33),
 #                                                                                            limits=c(0, 99)) +
 # scale_y_discrete(limits = c("Caprimulgiformes", "Aequornithia", "Gruiformes", "Telluraves", "Columbea", "Galloanseres"))
     


#g2 <- g2 + geom_dotplot(binaxis = "y", stackgroups = TRUE, binpositions="all", stackdir = "center") +
 # labs(title = "Site Concordonce factors (sCF) by data type - vertical",
  #     tag = "Figure 2",
   #    x = "sCF (%)",
    #   y = "Split",
     #  fill = "Data Type") + theme_grey() #theme(axis.text.x = element_text(angle = 90, hjust=1))


#g2



## Heatmap for all branches vertical

g3_heatmap <- ggplot(ALL_JT_CF_merged, aes(Data_Type, ID, fill=sCF)) + 
  geom_tile() +
  scale_y_continuous(breaks = seq(35,63,1)) + 
  scale_x_discrete(breaks=c("CDS", "intron", "lnc_RNA", "other", "unannotated", "UTR")) + theme_minimal() +
  labs(title = "Heatmap for Site concordonce factors (sCF) by data type in the bird phylogeny \n (Jarvis et al. 2014)",
       tag = "Figure 3",
       x = "Data Type",
       y = "Branch ID",
       fill = "sCF")
  
  

g3_heatmap

## Heatmap for H0-H1 only horizontal

g4_heatmap <- ggplot(JT_Hs_Combined, aes(Split, Data_Type, fill=sCF)) + 
  geom_tile() +
  scale_y_discrete() + 
  scale_x_discrete() + theme_minimal() +
  labs(title = "Heatmap for Site concordonce factors (sCF) by data type in the bird phylogeny \n (Jarvis et al. 2014)",
       tag = "Figure 3",
       x = "Splits",
       y = "Data Type",
       fill = "sCF")



g4_heatmap














