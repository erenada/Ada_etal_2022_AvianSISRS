# Start of the R Script
print("load libs")
library(Rboretum)

sourceRboretum()
print("prepping the loop...")
tree_path <- "/data/schwartzlab/eren/Chapter1/Concord_Analyses/IQOutput/RBoretumIN/Trees/"
alignment_PATH <- "/data/schwartzlab/eren/Chapter1/Concord_Analyses/IQOutput/RBoretumIN/Alignments/"
file_name_prefix <- c("CDS_concat", "intron_concat", "lnc_RNA_concat", "other_concat", "pseudogene_concat", "unannotated_concat", "UTR_concat")

root_taxa <- "StrCam"

for (prefix in file_name_prefix) {
	print (paste0("processing ", prefix))
	myTrees <- readRooted(to_root = paste0(tree_path, prefix, ".treefile"), root_taxa = root_taxa, tree_names = tree_names)
	print("trees read; computing signal...")

	alignmentSignal <- getAlignmentSignal( paste0(alignment_PATH, prefix, ".fasta"), use_gaps = FALSE, species_info = myTrees)
	print("signal computed; saving...")

	saveRDS(alignmentSignal, file = paste0(prefix,"_signal.Rdata"))

	print("saved; computing tree support...")
	treeSupport <- getAlignmentSupport(alignmentSignal,myTrees)

	print("done; saving...")
	saveRDS(treeSupport, file = paste0(prefix,"_treeSupport.Rdata"))
	write.csv(treeSupport, file = paste0(prefix,"_treeSupport.csv"))

}
print("done!")
