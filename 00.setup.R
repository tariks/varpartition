# Download ImmVar data
library(GEOquery)
getGEO(GEO = "GSE56035", destdir = "data", )

# Prepare intermediate files in convenient formats.
immvar <- getGEO(filename = "data/GSE56035_series_matrix.txt.gz", AnnotGPL=TRUE)
geneExpr <- exprs(immvar)
meta <- pData(phenoData(immvar))
geneInfo <- pData(featureData(immvar))

save(geneExpr, file = "intermediate/00.geneExpr.Robj")
save(meta, file = "intermediate/00.meta.Robj")
save(geneInfo, file = "intermediate/00.geneInfo.Robj")

arrow::write_parquet(meta, 'intermediate/00.meta.parquet')
arrow::write_parquet(geneInfo, 'intermediate/00.geneInfo.parquet')
arrow::write_parquet(as.data.frame(geneExpr), 'intermediate/00.geneExpr.parquet')

