#!/bin/bash

#SBATCH --job-name=CheckV_catalog_quality
#SBATCH --account=project_2006887
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --output=00_LOGS/CheckV_catalog_quality%A_%aout
#SBATCH --error=00_LOGS/CheckV_catalog_quality%A_%aerr
#SBATCH --cpus-per-task=20
#SBATCH --mem=20G
#SBATCH --partition=small
##SBATCH --mail-type=kim.kreuze@helsinki.fi

export SING_IMAGE=/path/to/apptainer/image.sif

apptainer exec --bind /path/to/bind $SING_IMAGE checkv end_to_end /path/to/vOTU_catalog_contigs.fna /path/to/output_directory -t 20