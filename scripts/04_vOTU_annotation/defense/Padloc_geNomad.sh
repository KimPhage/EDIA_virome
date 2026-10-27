#!/bin/bash

#SBATCH --job-name=Padloc
#SBATCH --account=project_2006887
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --output=00_LOGS/Padloc%A_%aout
#SBATCH --error=00_LOGS/Padloc%A_%aerr
#SBATCH --cpus-per-task=20
#SBATCH --mem=100G
#SBATCH --partition=small
#SBATCH --mail-type=END

cd /path/to/working/directory

export SING_IMAGE=/path/to/padloc.sif

mkdir VLP_vOTUs_padloc

apptainer exec --bind /path/to/bind $SING_IMAGE padloc --faa /path/to/CDS.faa --gff /path/to/CDS.gff --cpu 20 --outdir VLP_vOTUs_padloc/