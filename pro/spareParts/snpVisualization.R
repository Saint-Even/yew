
if (!require("SNPfiltR")){
  install.packages("SNPfiltR", dependencies=TRUE)
}
library("SNPfiltR")

library("vcfR")


setwd("I:/Barley/Common/Molecular Lab/Steven/G-Matrix/results")
getwd()
list.files()

vcf <- read.vcfR( "2019_P1.vcf.Train.Intersect", verbose = FALSE )
vcf

#devonderaad.github.io/SNPfiltR
hard_filter(vcf)

SNPfiltR::assess_missing_data_pca(vcf,)
