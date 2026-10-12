#!/usr/bin/env python3

import pandas as pd
import numpy as np

# ---- INPUT / OUTPUT ----
input_file = "relative_abundance.tsv"
output_file = "vOTU702650_scaled.tsv"

target_contig = "vOTU702650_L133_VLP_wQ33_contigs|k141_27424" #This vOTU is the cluster representing bacteriophage Q33 (i.e. spike-in)

# ---- LOAD DATA ----
df = pd.read_csv(input_file, sep="\t")

# ---- SELECT TARGET ROW ----
row = df[df.iloc[:, 0] == target_contig]

if row.empty:
    raise ValueError(f"{target_contig} not found in file")

# ---- EXTRACT VALUES ----
values = row.iloc[0, 1:].astype(float)

# ---- SAFE DIVISION + CEIL ----
# Calculate the total VLP genome copies per sample by using the Q33 spike-in as a reference. 
# There were 220,000 genome copies per sample divided by the relative abundance of Q33 in each sample. 
scaled = np.where(values > 0, np.ceil(220000 / values), 0) 

# ---- BUILD OUTPUT ----
output_df = pd.DataFrame({
    "Sample": values.index,
    "Scaled_value": scaled.astype(int)
})

# ---- WRITE OUTPUT ----
output_df.to_csv(output_file, sep="\t", index=False)

print("Done! Output written to:", output_file)

# To calculate VLP copies per gram, each sample must take into account the fecal filtrate volume used (0.4 ml) 
# and the amount of fecal material used to make the filtrate (0.1 g).