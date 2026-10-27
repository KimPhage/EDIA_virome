#!/bin/bash

#SBATCH --job-name=Predict_lifestyle_PhaTYP
#SBATCH --account=project_2006887
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --output=00_LOGS/Predict_lifestyle%A_%aout
#SBATCH --error=00_LOGS/Predict_lifestyle%A_%aerr
#SBATCH --cpus-per-task=10
#SBATCH --mem=100G
#SBATCH --gres=nvme:10
#SBATCH --partition=small
##SBATCH --mail-type=kim.kreuze@helsinki.fi

cd /path/to/working/directory

#Run PhaTYP to predict lifestyle of vOTUs
python3 /opt/PhaTYP/preprocessing.py --contigs vOTU_catalog_contigs.fna --midfolder midfolder 
python3 /opt/PhaTYP/PhaTYP.py --midfolder midfolder --out lifestyle.csv