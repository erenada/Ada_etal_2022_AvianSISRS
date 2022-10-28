# getting Rboretum numbers 

# only necessary-ones!

# installing rvcheck (previous_version)
PackageUrl <- "https://cran.r-project.org/src/contrib/Archive/rvcheck/rvcheck_0.1.8.tar.gz"

install.packages(PackageUrl, repos=NULL, type="source")

library(BiocManager)
library(rvcheck)
library(devtools)
library(ggtree)

install.packages("reticulate")

library(reticulate)

install_python(version = "miniconda3-latest")



py_install("pandas", pip = TRUE)
py_install("biopython", pip = TRUE)




use_miniconda("/Users/eren/.pyenv/versions/miniconda3-latest/bin/python3.9")

use_virtualenv("/Users/eren/.pyenv/versions/miniconda3-latest/bin/python3.9")


py_install("pandas", pip = TRUE)
py_install("biopython", pip = TRUE)

py_config()

py_discover_config()

py_install("pandas")

y_install("biopython")




devtools::install_github("BobLiterman/Rboretum", force = T)

library(Rboretum)
sourceRboretum()



# When considering the locus trees as single gene trees

CDS_tree <- readRooted("../InferredTrees/CDS/CDS_infdtree.treefile",root_taxa = "StrCam")

lnc_RNA_tree <- readRooted("../InferredTrees/lnc_RNA/lnc_RNA_infdtree.treefile",root_taxa = "StrCam")


#intron_tree <- readRooted("../IQOutput/",root_taxa = "StrCam")

#other_tree <- readRooted("../IQOutput/",root_taxa = "StrCam")

#unannotated_tree <- readRooted("../IQOutput/",root_taxa = "StrCam")

#UTR_tree <- readRooted("../IQOutput/",root_taxa = "StrCam")


# all trees combined

tree_paths <- c("/Users/eren/Documents/GitHub/Chapter1/Concord_Analyses/InferredTrees/CDS_infdtree.treefile",
                "/Users/eren/Documents/GitHub/Chapter1/Concord_Analyses/InferredTrees/lnc_RNA_infdtree.treefile")
tree_names <- c('CDS','lnc_RNA')
root_taxa <- "StrCam"



myTrees <- readRooted(tree_paths,root_taxa,tree_names=tree_names)


summarizeMultiPhylo(myTrees)


getTreeClades(myTrees,print_counts = TRUE)


setwd("/Users/eren/Documents/GitHub/Chapter1/Concord_Analyses/AlignmentM5")

alignment_PATH <- getwd()

alignmentSignal <- getAlignmentSignal(alignment_PATH, suffix = "fasta", use_gaps = FALSE, species_info = myTrees)



