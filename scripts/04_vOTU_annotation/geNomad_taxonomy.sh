#!/bin/bash

#SBATCH --job-name=GeNomad_taxonomy
#SBATCH --account=project_2006887
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --output=00_LOGS/GeNomad_taxonomy%A_%aout
#SBATCH --error=00_LOGS/GeNomad_taxonomy%A_%aerr
#SBATCH --cpus-per-task=20
#SBATCH --partition=small
#SBATCH --mail-type=END

#Path to geNomad apptainer image
export SING_IMAGE=/projappl/project_2009323/genomad.sif

#annotate the vOTUs
apptainer exec --bind /path/to/bind $SING_IMAGE genomad annotate -t 20 /vOTU_catalog_contigs.fna VLP_vOTUs_taxonomy /genomad_db