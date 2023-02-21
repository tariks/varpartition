from pyarrow import parquet, Table

geneInfo = parquet.read_table("intermediate/00.geneInfo.parquet").to_pandas()

# prepare a mapping for gene names.
symbols = geneInfo["Gene symbol"].str.split("///").str[-1]
symbols.to_csv("intermediate/05.idx2gene.csv")


# identify genes on chromosomes X, Y, or six.
chroms = geneInfo["Chromosome annotation"]
X = chroms[chroms.str.contains("Chromosome X")]
Y = chroms[chroms.str.contains("Chromosome Y")]
chrom6 = chroms[chroms.str.contains("Chromosome 6")]


chrDict = {}
for name, idx in zip(("chrX", "chrY", "chr6"), (X, Y, chrom6)):
    chrDict[name] = idx.index.astype(str).to_list()
    with open(f"intermediate/05.{name}.csv", "w") as outfile:
        print("\\n".join(chrDict.get(name)), file=outfile)

import pickle

with open("intermediate/05.dict.pkl", "wb") as outfile:
    pickle.dump(chrDict, outfile)

