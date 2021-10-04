# Start of the R Script

.libPaths("/data/schwartzlab/eren/programs/RLibraries")

library(Rboretum)

sourceRboretum()

tree_path <- "/data/schwartzlab/eren/Chapter1/Concord_Analyses/IQOutput/RBoretumIN/Trees"

tree_names <- c("CDS_concat.treefile", "intron_concat.treefile", "lnc_RNA_concat.treefile", "other_concat.treefile", "pseudogene_concat.treefile", "unannotated_concat.treefile", "UTR_concat.treefile")

root_taxa <- "StrCam"

myTrees <- readRooted(to_root = tree_path,suffix = 'treefile', root_taxa = root_taxa, tree_names = tree_names)

alignment_PATH <- "/data/schwartzlab/eren/Chapter1/Concord_Analyses/IQOutput/RBoretumIN/Alignments"

alignmentSignal <- getAlignmentSignal(alignment_PATH, suffix = "fasta", use_gaps = FALSE, species_info = myTrees)


saveRDS(alignmentSignal, file = "/data/schwartzlab/eren/Chapter1/Concord_Analyses/IQOutput/RBoretumIN/SignalData/Signal.Rdata")


treeSupport <- getAlignmentSupport(alignmentSignal,myTrees)


saveRDS(treeSupport, file = "/data/schwartzlab/eren/Chapter1/Concord_Analyses/IQOutput/RBoretumIN/SignalData/treeSupport.Rdata")
