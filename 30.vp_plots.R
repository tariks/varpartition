# 30.vp_plots.R
library(variancePartition)
library(ggplot2)
library(patchwork)

load("intermediate/10.topVar.Robj")
load("intermediate/20.output.Robj")
topSd <- topVar$bySd[1:10000]
gNames = read.csv("intermediate/05.idx2gene.csv")$Gene.symbol

# plot variationPartition's builtins for each formula. include all genes
p = list()
idx <- topSd[1:15]
for(f in names(output)){
  vp <- sortCols(output[[f]])
  p[[paste0(f,'.violin')]] <-plotVarPart(vp, label.angle=60)
  p[[paste0(f,'.bars')]] <-plotPercentBars(vp[idx,]) + scale_x_discrete(labels= gNames[idx])
}

(p$base.bars + p$base.violin) / (p$interaction.bars + p$interaction.violin)

vp <- sortCols(output$interaction[topSd,])
p$bySd <-plotVarPart(vp, label.angle=60)
p$bySd


