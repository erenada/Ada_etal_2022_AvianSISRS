library(viridis)
library(ggplot2)
library(dplyr)
library(ape)

#extracting Jarvis sCf's

TypesofData <- c("CDS", "3UTR", "5UTR", "PSEUDOGENE", "INTRON", "smRNA", "lncRNA","GENICOTHER", "INTERGENIC", "GENE")
FileNames <- (list.files("../FINAL_sCF/Jarvis/", pattern = "stat"))
datalist <- c("J-CDS-scf.cf.stat","J-3UTR-scf.cf.stat","./J-5UTR-scf.cf.stat","./J-PSEUDOGENE-scf.cf.stat","./J-INTRON-scf.cf.stat","./J-smRNA-scf.cf.stat","./J-GENICOTHER-scf.cf.stat","./J-INTERGENIC-scf.cf.stat","./J-GENE-scf.cf.stat")

J_CDS_scf <- read.delim("J-CDS-scf.cf.stat", header = T, comment.char = "#")
J_3UTR_scf <- read.delim("J-3UTR-scf.cf.stat", header = T, comment.char = "#")
J_5UTR_scf <- read.delim("./J-5UTR-scf.cf.stat", header = T, comment.char = "#")
J_PSEUDOGENE_scf <- read.delim("./J-PSEUDOGENE-scf.cf.stat", header = T, comment.char = "#")
J_INTRON_scf <- read.delim("./J-INTRON-scf.cf.stat", header = T, comment.char = "#")
J_smRNA_scf <- read.delim("./J-smRNA-scf.cf.stat", header = T, comment.char = "#")
J_lncRNA_scf <- read.delim("./J-lncRNA-scf.cf.stat", header = T, comment.char = "#")
J_GENICOTHER_scf <- read.delim("./J-GENICOTHER-scf.cf.stat", header = T, comment.char = "#")
J_INTERGENIC_scf <- read.delim("./J-INTERGENIC-scf.cf.stat", header = T, comment.char = "#")
J_GENE_scf <- read.delim("./J-GENE-scf.cf.stat", header = T, comment.char = "#")




JarvisReferenceTree <- read.tree("../Reference_Trees/JarvisFinalTree.nwk")  
PrumReferenceTree <- read.tree("../Reference_Trees/PrumFinalTree.nwk")  


# modifying the scf dataframes (labeling and ordering (?) the branches)
# might add the name for each branch but skipping that for now. 

library(tidyr)
library(dplyr)

J_GENE_scf$Label <- c("Gene") 

J_INTERGENIC_scf$Label <- c("Intergenic")

J_GENICOTHER_scf$Label <- c("Genic-other")

J_lncRNA_scf$Label <- c("lncRNA")

J_smRNA_scf$Label <- c("smRNA")

J_INTRON_scf$Label <- c("Intron")

J_PSEUDOGENE_scf$Label <- c("Pseudogene")

J_5UTR_scf$Label <- c("5'UTR")

J_3UTR_scf$Label <- c("3'UTR")

J_CDS_scf$Label <- c("CDS")

#combined dataset

rm(newDataFrame)

newDataFrame <- rbind(J_GENE_scf, J_INTERGENIC_scf, J_GENICOTHER_scf, J_lncRNA_scf, J_smRNA_scf,
                      J_INTRON_scf, J_PSEUDOGENE_scf, J_5UTR_scf, J_3UTR_scf, J_CDS_scf) %>% select(ID, sCF, Label, Length) %>% na.omit() %>%
  mutate(Type=case_when(Label == "Gene" | Label =="CDS" | Label == "Genic-other" ~ "Coding",
                        Label=="Intron" | Label == "Pseudogene" | Label == "Intergenic" | Label == "smRNA" | Label == "lncRNA" ~ "NonCoding",
                        Label == "5'UTR" | Label == "3'UTR" ~ "Regulatory")) 



#newDataFrame <- group_by(newDataFrame, ID)

#newDataFrame$ID <- newDataFrame %>% arrange(Length)

#newDataFrame$ID <- as.vector(newDataFrame$ID)

#newDataFrame$ID <- factor(newDataFrame$ID, newDataFrame$ID)

#dotPlot

library(ggplot2)

ggplot(newDataFrame, aes(x=ID, y=sCF)) + geom_boxplot(aes(group=ID)) + geom_jitter(aes(color = Type))
