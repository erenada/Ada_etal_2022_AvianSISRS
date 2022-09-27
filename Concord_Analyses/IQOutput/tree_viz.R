## tree plotting 

#ggtree

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtree")

library(ggtree)

library(treeio)

# Read a reference tree (jarvis et al.):


J_CDS_tree <- read.tree("./Jarvis/JarvisTree.nwk_CDS_concord.cf.tree", tree.names = "CDS") #1st tree


test_Read_table <- read.table("./Jarvis/JarvisTree.nwk_CDS_concord.cf.stat", header=TRUE, fill = T)

test_CDS <- read.iqtree("./Jarvis/JarvisTree.nwk_CDS_concord.cf.tree")

J_intron_tree <- read.tree("./Jarvis/JarvisTree.nwk_intron_concord.cf.tree", tree.names = "intron") #2nd tree

J_lnc_RNA_tree <- read.tree("./Jarvis/JarvisTree.nwk_lnc_RNA_concord.cf.tree", tree.names = "lnc_RNA") #3rd tree

J_unannotated_tree <- read.tree("./Jarvis/JarvisTree.nwk_unannotated_concord.cf.tree", tree.names = "unannotated") #4th tree

J_UTR_tree <- read.tree("./Jarvis/JarvisTree.nwk_UTR_concord.cf.tree", tree.names = "UTR") #5th tree

J_other_tree <- read.tree("./Jarvis/JarvisTree.nwk_other_concord.cf.tree", tree.names = "other") #6th tree

#J_pseuodegene_tree 

#merge all the trees:

JarvisAllTrees <- c(J_CDS_tree, J_intron_tree, J_lnc_RNA_tree, J_unannotated_tree, J_UTR_tree, J_other_tree)

class(JarvisAllTrees)


# Plot the basic tree

TreePlot <- ggtree(test_CDS) # layout="ellipse"


TreePlot + geom_tiplab() + geom_nodelab()

