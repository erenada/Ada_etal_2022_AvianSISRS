## multiple anova test between data-types 


library(dplyr)
library(tidyverse)
library(ggplot2)

#filtering dataframe

anova_data <- select(ALL_JT_CF_merged, ID, Data_Type, sCF)

library("ggpubr")
ggboxplot(anova_data, x = "Data_Type", y = "sCF", 
          color = "Data_Type",
          order = c("CDS", "intron", "UTR", "unannotated", "lncRNA", "other"),
          ylab = "sCF", xlab = "ID")

# compute anova

# Compute the analysis of variance
res.aov <- aov(sCF ~ Data_Type, data = anova_data)
# Summary of the analysis
summary(res.aov)

TukeyHSD(res.aov)

pairwise.t.test(anova_data$sCF, anova_data$Data_Type,
                p.adjust.method = "BH")

plot(res.aov, 1)


# Non-parametric anova test

library(dplyr)
group_by(anova_data, Data_Type) %>%
  summarise(
    count = n(),
    mean = mean(sCF, na.rm = TRUE),
    sd = sd(sCF, na.rm = TRUE),
    median = median(sCF, na.rm = TRUE),
    IQR = IQR(sCF, na.rm = TRUE)
  )


kruskal.test(sCF ~ Data_Type, data = anova_data)

#Kruskal-Wallis rank sum test

# data:  sCF by Data_Type
# Kruskal-Wallis chi-squared = 0.63791, df = 5, p-value = 0.9862

pairwise.wilcox.test(anova_data$sCF, anova_data$Data_Type,
                     p.adjust.method = "BH")


## multivariate (trying to include branch IDs)

wide_anova_data <- spread(anova_data, Data_Type, sCF)

#Run Manova

res.man <- manova(cbind(CDS, intron, lnc_RNA, other, unannotated, UTR) ~ ID, data = wide_anova_data)

summary(res.man)

summary.aov(res.man)

#mutivariate kurskal wallis test


kruskal.test(cbind(CDS, intron, lnc_RNA, other, unannotated, UTR) ~ ID, data = my_data)


# clean this script up!

# save the dataframes

write.csv2(wide_anova_data, file = "wideFormsCF", row.names = F)



