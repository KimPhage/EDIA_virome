#!/bin/bash

#SBATCH --job-name=Bulk_Defense_finder
#SBATCH --account=project_2006887
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --output=00_LOGS/Bulk_Defense_finder%A_%aout
#SBATCH --error=00_LOGS/Bulk_Defense_finder%A_%aerr
#SBATCH --cpus-per-task=20
#SBATCH --mem=100G
#SBATCH --gres=nvme:50
#SBATCH --partition=small
##SBATCH --mail-type=kim.kreuze@helsinki.fi

cd /path/to/working/directory

export SING_IMAGE=/path/to/defense-finder.sif

apptainer exec --bind /path/to/bind $SING_IMAGE defense-finder run -a /path/to/CDS.faa -o /VLP_vOTUs_defense
