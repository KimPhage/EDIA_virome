#!/bin/bash

#SBATCH --job-name=ipHop
#SBATCH --account=project_2006887
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --output=00_LOGS/ipHop_%A_%aout
#SBATCH --error=00_LOGS/ipHop_%A_%aerr
#SBATCH --cpus-per-task=38
#SBATCH --mem=200G
#SBATCH --gres=nvme:100
#SBATCH --partition=small
##SBATCH --mail-type=kim.kreuze@helsinki.fi

cd /path/to/working/directory

export SING_IMAGE=/path/to/iphop.sif

#Download default GTDB-tk database from iphop (Aug_2023_pub_rw)
apptainer exec --bind /path/to/bind $SING_IMAGE iphop download --db_dir . --split --no_prompt

#Make a custom GTDB-tk database by fusing default database with the ones generated in MAGs_gtdbtk.sh
apptainer exec --bind /path/to/bind $SING_IMAGE iphop add_to_db --fna_dir med_bins/ --gtdb_dir med_MAGs_GTDB-tk_results_new/ --out_dir Aug_2023_pub_rw_custom --db_dir Aug_2023_pub_rw/ -t 38

apptainer exec --bind /path/to/bind $SING_IMAGE iphop predict --fa_file vOTU_catalog_contigs.fna --db_dir ./Aug_2023_pub_rw_custom --out_dir iPhop_hiq_def_db -t 38
