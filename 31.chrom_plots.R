# 31.chrom_plots.R
library(variancePartition)
library(ggplot2)
library(patchwork)

chromlist = list()
chromlist$chrX <-read.csv('intermediate/05.chrX.csv')[,1]
chromlist$chrY <-read.csv('intermediate/05.chrY.csv')[,1]
chromlist$chr6 <-read.csv('intermediate/05.chr6.csv')[,1]

load("intermediate/10.topVar.Robj")
load("intermediate/20.output.Robj")
gNames = read.csv("intermediate/05.idx2gene.csv")$Gene.symbol
topSd <- topVar$bySd

p = list()
for(f in names(chromlist)){
  idx = topSd[topSd %in% chromlist[[f]]]
  vp <- sortCols(output$interaction[idx,])
  p[[paste0(f,'.violin')]] <-plotVarPart(vp, label.angle=60)
  p[[paste0(f,'.bars')]] <-plotPercentBars(vp[1:15,]) + scale_x_discrete(labels= gNames[idx[1:15]])
}

p$chrX.bars + p$chrX.violin
p$chrY.bars + p$chrY.violin
p$chr6.bars + p$chr6.violin
