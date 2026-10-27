#!/usr/bin/env python3

import pandas as pd

# ---- INPUT / OUTPUT ----
# Input must be the merged rpkm coverage table for each vOTU in each sample. Prior to this point,
# the vOTUs with rpkm of 0 in all samples should have been removed and vOTUs that were present in any 
# of the negative controls should be excluded as they are likely contaminants.
# The output will be a table of relative abundances for each vOTU in each sample.

input_file = "rmzeroes_merged_coverage_rpkm.tsv"
output_file = "relative_abundance.tsv"

# ---- LOAD DATA ----
df = pd.read_csv(input_file, sep="\t")

# ---- SEPARATE CONTIG COLUMN ----
contigs = df.iloc[:, 0]           # first column (Contig names)
data = df.iloc[:, 1:]             # numeric data

# ---- ENSURE NUMERIC ----
data = data.apply(pd.to_numeric, errors='coerce')

# ---- CALCULATE COLUMN TOTALS ----
col_sums = data.sum(axis=0)

# ---- COMPUTE RELATIVE ABUNDANCE ----
rel_abund = data.div(col_sums, axis=1)

# ---- OPTIONAL: replace NaN (e.g. columns with sum=0) ----
rel_abund = rel_abund.fillna(0)

# ---- RECOMBINE ----
output_df = pd.concat([contigs, rel_abund], axis=1)

# ---- WRITE OUTPUT ----
output_df.to_csv(output_file, sep="\t", index=False)

print("Done! Output written to:", output_file)