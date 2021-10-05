devtools::install_github("rstudio/reticulate")
devtools::install_github("BobLiterman/Rboretum")


install.packages("reticulate")
remove.packages("reticulate")

install.packages("reticulate")

install.packages("https://cran.r-project.org/src/contrib/Archive/rvcheck/rvcheck_0.1.8.tar.gz", repos = NULL, type = "source")

library(reticulate)

version <- "3.9.0"
install_python(version = version)

py_install("pandas", pip = TRUE)
py_install("biopython", pip = TRUE)

py_install()


#change the python path
#use_python("/Library/Frameworks/Python.framework/Versions/3.9/bin/python3", required = T)

Sys.setenv('RETICULATE_PYTHON' = '/usr/local/bin/python3')

#R.home()

py_discover_config()

library(Rboretum)
sourceRboretum()

#cds tree

CDS_tree <- readRooted("../InferredTrees/CDS/CDS_infdtree.treefile",root_taxa = "StrCam")

lnc_RNA_tree <- readRooted("../InferredTrees/intron/intron_infdtree.treefile",root_taxa = "StrCam")

getTreeSplits(CDS_tree)

#multiple read

tree_path <- c("../InferredTrees/CDS_infdtree.treefile",
                "../InferredTrees/lnc_RNA_infdtree.treefile")

tree_names <- c('CDS','lnc_RNA')
root_taxa <- c("StrCam")

myTrees <- readRooted(tree_path,root_taxa,tree_names=tree_names)

alignment_PATH <- "/Users/eren/Documents/GitHub/Chapter1/Concord_Analyses/AlignmentM5"

#magic function

alignmentSignal <- getAlignmentSignal(alignment_PATH, suffix = "fasta", use_gaps = FALSE, species_info = myTrees)



