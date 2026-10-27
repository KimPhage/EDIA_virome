#!/usr/bin/env python3

import argparse
import pandas as pd
import os

def main():
    parser = argparse.ArgumentParser(description="Summarize prophage TSV")
    parser.add_argument("-i", "--input", required=True, help="Input TSV file")
    parser.add_argument("-o", "--output", required=True, help="Output TSV file")
    args = parser.parse_args()

    # Read TSV
    df = pd.read_csv(args.input, sep="\t")

    # Check required column
    if "prophage-host_ratio" not in df.columns:
        raise ValueError("Column 'prophage-host_ratio' not found in input TSV")

    
    # Compute stats
    n_prophages = df.shape[0]
    ratios = df["prophage-host_ratio"]
    logRi = df["logRi"]

    mean_ratio = ratios.mean()
    median_ratio = ratios.median()
    mean_logRi = logRi.mean()
    median_logRi = logRi.median()

    # New: clipped mean (values <1 -> 1)
    import numpy as np
    clipped_ratios = np.where(ratios < 1, 1, ratios)
    clipped_mean_ratio = clipped_ratios.mean()


    # Extract filename only
    filename = os.path.basename(args.input)

    # Write output (single line)
    with open(args.output, "w") as f:
        f.write("filename\tn_prophages\tmean_ratio\tmedian_ratio\tclipped_mean_ratio\tmean_logRi\tmedian_logRi\n")
        f.write(f"{filename}\t{n_prophages}\t{mean_ratio}\t{median_ratio}\t{clipped_mean_ratio}\t{mean_logRi}\t{median_logRi}\n")


if __name__ == "__main__":
    main()
