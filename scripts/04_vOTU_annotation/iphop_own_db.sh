#!/bin/bash

#SBATCH --job-name=ipHop
#SBATCH --account=project_2006887
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --output=00_LOGS/ipHop_%A_%aout
#SBATCH --error=00_LOGS/ipHop_%A_%aerr
#SBATCH --cpus-per-task=20
#SBATCH --mem=200G
#SBATCH --gres=nvme:100
#SBATCH --partition=small
##SBATCH --mail-type=kim.kreuze@helsinki.fi

cd /scratch/project_2006887/kimkreuz/edia_cohort/VLP_reads/04_vOTU_tables/iPhop_database

export SING_IMAGE=/scratch/project_2009323/iphop.sif

#apptainer_wrapper exec iphop download --db_dir . --split --no_prompt

apptainer_wrapper exec iphop add_to_db --fna_dir med_bins/ --gtdb_dir med_MAGs_GTDB-tk_results_new/ --out_dir Aug_2023_pub_rw_custom --db_dir Aug_2023_pub_rw/ -t 20

#apptainer_wrapper exec iphop predict --fa_file ../vOTU_coverag_unique_corrected_sorted_rmcontrol_rmempty_renamed.fa --db_dir ./Aug_2023_pub_rw --out_dir iPhop_hiq_def_db -t 38
