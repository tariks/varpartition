import pickle
import pandas as pd
from pyarrow import parquet
# geneExpr = parquet.read_table("intermediate/00.geneExpr.parquet").to_pandas()
# geneInfo = parquet.read_table("intermediate/00.geneInfo.parquet").to_pandas()

with open('intermediate/05.dict.pkl', 'rb') as f:
  chroms = pickle.load(f)

id2gene = pd.read_csv('intermediate/05.idx2gene.csv', index_col=0)['Gene symbol']

vp = parquet.read_table('intermediate/20.vp.parquet').to_pandas()

