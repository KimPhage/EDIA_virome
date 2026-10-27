import pandas as pd
import os

#This code is used to parse the output of PADLOC and create a new CSV file that fits format of DefenseFinder.
#Code is modified copy from https://github.com/JDocherty67/Supporting_code_bif_defence_phages_coevolution/blob/main/Supporting_code_original.md

# Path to the single CSV file
csv_file = './VLP_vOTUs_only_clean_proteins_simplified_mod_padloc.csv'  # Replace with the actual file path

# Extract the base name of the file (without extension)
base_name = os.path.splitext(os.path.basename(csv_file))[0]

# Read the CSV file
df = pd.read_csv(csv_file)

# Group by system.number
grouped = df.groupby('system.number')

# Create a new dataframe for the results
result = pd.DataFrame(columns=[
    'sys_id', 'type', 'subtype', 'sys_beg', 'sys_end',
    'protein_in_syst', 'genes_count', 'name_of_profiles_in_sys', 'seqid'
])

# Process each system
for sys_num, group in grouped:
    if 'CRISPR_array' not in group['system'].values:
        new_row = pd.DataFrame({
            'sys_id': [f'{base_name}_{sys_num}'],
            'type': [''],
            'subtype': [group['system'].iloc[0]],
            'sys_beg': [group['target.name'].iloc[0]],
            'sys_end': [group['target.name'].iloc[-1]],
            'protein_in_syst': [','.join(group['target.name'])],
            'genes_count': [len(group)],
            'name_of_profiles_in_sys': [','.join(group['hmm.name'].dropna().unique())],
            'seqid': [group['seqid'].iloc[0]]
        })
        result = pd.concat([result, new_row], ignore_index=True)

# Sort and reset index
result = result.sort_values('sys_id').reset_index(drop=True)

# Define output file name
output_file = base_name + '_parsed.csv'

# Save the result
result.to_csv(output_file, index=False)

print(f"Parsing complete for {csv_file}. Results saved to '{output_file}'.")
