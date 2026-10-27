#!/usr/bin/env python3

import argparse
import pandas as pd
import numpy as np
import os
import re

def extract_sample_id(host_string):
    """
    Extract sample name like NGS895 from strings like:
    NGS895_k105_551 or NGS895_k105_551|provirus...
    """
    match = re.match(r"(NGS\d+)", host_string)
    return match.group(1) if match else None


def main():
    parser = argparse.ArgumentParser(description="Compute logRi per prophage entry")
    parser.add_argument("-i", "--input", required=True, help="Input TSV file")
    parser.add_argument("-o", "--output", required=True, help="Output TSV file")
    args = parser.parse_args()

    # Read TSV
    df = pd.read_csv(args.input, sep="\t")

    # Check required columns from Propagate output
    required_cols = ["prophage_mean_cov", "host_mean_cov", "host"]
    for col in required_cols:
        if col not in df.columns:
            raise ValueError(f"Column '{col}' not found in input TSV")

    # Avoid log(0) issues
    df = df.copy()
    df["prophage_mean_cov"] = pd.to_numeric(df["prophage_mean_cov"], errors="coerce")
    df["host_mean_cov"] = pd.to_numeric(df["host_mean_cov"], errors="coerce")

    # Log transform the mean coverage of each prophage and its host
    df["log_prophage_cov"] = np.log(df["prophage_mean_cov"])
    df["log_host_cov"] = np.log(df["host_mean_cov"])

    # Compute the ratio of the log-transformed mean coverage of the prophage to that of its host (logRi)
    df["logRi"] = df["log_prophage_cov"] - df["log_host_cov"]

    # Extract sample ID
    df["sample_id"] = df["host"].apply(extract_sample_id)

    # Write output
    df.to_csv(args.output, sep="\t", index=False)


if __name__ == "__main__":
    main()
