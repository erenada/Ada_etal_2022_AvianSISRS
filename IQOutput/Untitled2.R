## Rboretum stuff

library(Rboretum)

# read Rboretum files

CDS_RB<- readRDS("./RboretumOut/rboretum_eren/CDS_concat_signal.Rdata")

intron_RB <- readRDS("./RboretumOut/rboretum_eren/intron_concat_signal.Rdata")

other_RB <- readRDS("./RboretumOut/rboretum_eren/other_concat_signal.Rdata")

unannotated_RB <- readRDS("./RboretumOut/rboretum_eren/unannotated_concat_signal.Rdata")

UTR_RB <- readRDS("./RboretumOut/rboretum_eren/UTR_concat_signal.Rdata")

lnc_RNA_RB <- readRDS("./RboretumOut/rboretum_eren/lnc_RNA_concat_signal.Rdata")


##...

# Tree support 

library(Rboretum)

CDS_RBsTreeSupport <- getAlignmentSupport(CDS_RB, Jarvis_REF_Tree)

intron_RBsTreeSupport <- getAlignmentSupport(intron_RB, Jarvis_REF_Tree)

other_RBsTreeSupport <- getAlignmentSupport(other_RB, Jarvis_REF_Tree)

UTR_RBsTreeSupport <- getAlignmentSupport(UTR_RB, Jarvis_REF_Tree)

unannotated_RBsTreeSupport <- getAlignmentSupport(unannotated_RB, Jarvis_REF_Tree)

lnc_RNA_RBsTreeSupport <- getAlignmentSupport(lnc_RNA_RB, Jarvis_REF_Tree)


# merging the tree supports 

ALL_Rbies_TS <- merge(CDS_RBsTreeSupport, intron_RBsTreeSupport, by = "Clade")

ALL_Rbies_TS<- merge(ALL_Rbies_TS, other_RBsTreeSupport, by = "Clade")

ALL_Rbies_TS <- merge(ALL_Rbies_TS, UTR_RBsTreeSupport, by = "Clade")

ALL_Rbies_TS <- merge(ALL_Rbies_TS, unannotated_RBsTreeSupport, by = "Clade")

ALL_Rbies_TS <- merge(ALL_Rbies_TS,lnc_RNA_RBsTreeSupport , by = "Clade")


# plotting the tree support 

library(ggtree)

library(ggimage)


treePlotter(Jarvis_REF_Tree, tree_support = ALL_Rbies_TS, node_label = 'node', geom_size = c(10,40), xmax = 32, taxa_offset = 2,
            node_label_nudge = 0.5,geom_alpha=0.8,
            use_pies = T,pie_legend_position = c(24,24,24,24))

#3 for name change save the dataset

write.csv(ALL_Rbies_TS, file = "ALL_Rbies_original.csv", row.names = F )

ALL_Rbies_TS$CDS_concat.fasta_m29
