## Cladogram Data Check

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


# Read the Jarvis Data (later don't forget the change variable names)

CL_JT_CF_CDS <- read.delim("CladogramRun/Jarvis/JarvisClad.nwk_CDS_concord.cf.stat", header = T, comment.char = "#")

CL_JT_CF_UTR <- read.delim("CladogramRun/Jarvis/JarvisClad.nwk_UTR_concord.cf.stat", header = T, comment.char = "#")

CL_JT_CF_intron <- read.delim("CladogramRun/Jarvis/JarvisClad.nwk_intron_concord.cf.stat", header = T, comment.char = "#")

CL_JT_CF_pseudogene <- read.delim("CladogramRun/Jarvis/JarvisClad.nwk_pseudogene_concord.cf.stat", header = T, comment.char = "#")

CL_JT_CF_other <- read.delim("CladogramRun/Jarvis/JarvisClad.nwk_other_concord.cf.stat", header = T, comment.char = "#")

CL_JT_CF_lnc_RNA <- read.delim("CladogramRun/Jarvis/JarvisClad.nwk_lnc_RNA_concord.cf.stat", header = T, comment.char = "#")

CL_JT_CF_unannotated <- read.delim("CladogramRun/Jarvis/JarvisClad.nwk_unannotated_concord.cf.stat", header = T, comment.char = "#")


# Merge All Jravis Cladogram Data

ALL_CL_JT_CF_merged <-  bind_rows("CDS" = CL_JT_CF_CDS, "intron" = CL_JT_CF_intron, "UTR" = CL_JT_CF_UTR, "unannotated" = CL_JT_CF_unannotated,
                               "lnc_RNA" =  CL_JT_CF_lnc_RNA, "pseudogene" = CL_JT_CF_pseudogene, "other" = CL_JT_CF_other,
                               .id = "Data_Type") %>% select(-(Label)) %>% subset(ID!="34")



ggplot(ALL_CL_JT_CF_merged, aes(x = gCF, y = sCF, colour = Data_Type, label = ID)) + 
  geom_point() +  
  scale_colour_discrete(drop=TRUE,
                        limits = levels(ALL_CL_JT_CF_merged$Data_Type)) + 
  xlim(0, 45) +
  ylim(15, 70) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") +  geom_text_repel()
