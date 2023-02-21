# fix inconsistencies in the ImmVar metadata
from pyarrow import parquet, Table

meta = parquet.read_table("intermediate/00.meta.parquet").to_pandas()

meta["Individual"] = meta.title.str.split(".").str[0]
meta["Batch"] = meta["batch:ch1"].copy()

meta["Sex"] = 0
meta.loc[meta["characteristics_ch1.1"].str.endswith("emale"), "Sex"] = 1

meta["Cell"] = "Monocyte"
meta.loc[meta["cell type:ch1"].str.startswith("T4"), "Cell"] = "CD4"

meta["Age"] = meta["age (yrs):ch1"].astype(float)
nans = meta.Age.isna()
meta.loc[nans, "Age"] = meta.loc[nans, "age:ch1"].astype(float)

p = Table.from_pandas(meta)
parquet.write_table(p, "intermediate/01.meta.parquet")
