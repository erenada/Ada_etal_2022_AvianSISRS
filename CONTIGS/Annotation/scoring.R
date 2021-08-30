# scoring the annotations 

annotations <- read.csv("./annotations.csv")


annot_table_pre <- read.csv("./annotations.csv", header = T, stringsAsFactors = F)

annot_table_pre[1:10,]

#get most frequent from the left

annot_table <- data.frame(Alignment_name=annot_table_pre[,1], Locus_type=apply(annot_table_pre[,2:8],1, function (x) colnames(annot_table_pre)[2:8][which.max(x)]))

annot_table$Alignment_name <- paste0(annot_table$Alignment_name, ".fasta")

annot_table[1:10,]

write.table(annot_table, file = "annot_table.csv", sep = "\t", quote = FALSE, row.names = F)


