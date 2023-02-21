# 10.exploreVariance.R
library(matrixStats)

# Interactive session for sanity testing.
# Visualize variance structure.
# Compare robust and non-robust statistics.
# Prepare list of 10k highest-dispersion genes.

g <-arrow::read_parquet("intermediate/00.geneExpr.parquet")
g <-as.matrix(g)

gMeans <- rowMeans(g)
gMedians <- rowMedians(g)
gSds <- rowSds(g)
gMads <- rowMads(g)

summary(gMeans)
summary(gMedians)
summary(gSds)
summary(gMads)

# Visualize overall variation
hist(gSds[gSds<1000])
hist(gMads[gMads<1000])
plot(gSds, gMads)
plot(gMedians, gMeans)
plot(gMeans, gMads)
plot(gMeans, gSds)

# Save most variable genes
topVar=list()
topVar$bySd <- order(gSds,decreasing=T)
topVar$byMad <- order(gMads,decreasing=T)

save(topVar, file="intermediate/10.topVar.Robj")
