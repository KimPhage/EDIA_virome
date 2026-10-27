import pandas as pd
import glob
import os

# Path to all rpkm tables
files = glob.glob("path-to-vOTU-abundance-tables/*.tsv")  # Replace with the actual path to your vOTU abundance tables

#This script merges all vOTU rpkm tables into a single abundance matrix with vOTUs as rows and samples as columns.
dfs = []

for file in files:
    df = pd.read_csv(file, sep="\t")

    # Rename abundance column to sample name
    sample_name = os.path.basename(file).replace(".tsv", "")
    df = df.rename(columns={df.columns[1]: sample_name})

    # Set Contig as index
    df = df.set_index("Contig")

    dfs.append(df)

# Merge all tables by Contig
merged = pd.concat(dfs, axis=1)

# Remove rows where all samples are 0
merged = merged.loc[(merged != 0).any(axis=1)]

# Missing values (vOTUs not present in a sample) are filled with 0
merged = merged.fillna(0)

# Save
merged.to_csv("rmzeroes_merged_coverage_rpkm.tsv", sep="\t")
