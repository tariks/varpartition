# 20.varpartition.R
load("intermediate/00.geneExpr.Robj")
load("intermediate/02.meta.Robj")

formulas = list()
formulas$base <- ~ Age + (1|Sex) + (1|Individual) + (1|Cell) + (1|Batch)
formulas$interaction <- ~ Age + (1|Individual) + (1|Sex) + (1|Cell) + (1|Age:Sex) + (1|Age:Cell)
param <- BiocParallel::MulticoreParam(5)

output <- list()
for(formula in names(formulas)){
  gc()
  output[[formula]] <- variancePartition::fitExtractVarPartModel(
        geneExpr,
        formulas[[formula]],
        meta,
        BPPARAM = param) 
  }

save(output, file='intermediate/20.output.Robj')
arrow::write_parquet(as.data.frame(output$interaction),'intermediate/20.vp.parquet')
