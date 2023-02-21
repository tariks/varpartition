# 02.preprocess.R
# Create an Robj for cleaned-up metadata with defined factors
meta <- arrow::read_parquet('intermediate/01.meta.parquet')
meta$Individual <- as.factor(meta$Individual)
meta$Batch <- as.factor(meta$Batch)
meta$Sex <- as.factor(meta$Sex)
meta$Cell <- as.factor(meta$Cell)
save(meta,file='intermediate/02.meta.Robj')
```

