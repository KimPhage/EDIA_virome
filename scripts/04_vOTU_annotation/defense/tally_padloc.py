
import pandas as pd
import sys

#This code is used to tally the number of occurrences of each defense system subtype from the merged defense finder and padloc output file.

# Check arguments
if len(sys.argv) != 3:
    print("Usage: python tally_subtypes.py <input.tsv> <output.tsv>")
    sys.exit(1)

input_file = sys.argv[1]
output_file = sys.argv[2]

# Read the input file (tab-separated)
df = pd.read_csv(input_file, sep=',')

# Count occurrences of each subtype
tally = df['subtype'].value_counts().reset_index()
tally.columns = ['subtype', 'count']

# Save to TSV
tally.to_csv(output_file, sep='\t', index=False)

print(f"Tally complete. Results saved to '{output_file}'.")
