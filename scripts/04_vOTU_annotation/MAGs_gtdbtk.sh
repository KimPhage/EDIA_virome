#!/bin/bash

#SBATCH --job-name=MAG_GTDBTK
#SBATCH --account=project_2006887
#SBATCH --time=3-00:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --output=00_LOGS/GTDBTK_%A_%aout
#SBATCH --error=00_LOGS/GTDBTK_%A_%aerr
#SBATCH --cpus-per-task=20
#SBATCH --mem=300G
#SBATCH --gres=nvme:100
#SBATCH --partition=small
##SBATCH --mail-type=kim.kreuze@helsinki.fi

cd /scratch/project_2006887/kimkreuz/edia_cohort/analysis/07_PHAGE_INDUCTION/VLP_induction_all_contigs_depth50/MAGs/

module load gtdbtk

gtdbtk de_novo_wf --genome_dir med_bins/ --bacteria --outgroup_taxon p__Patescibacteria --out_dir $LOCAL_SCRATCH/med_MAGs_GTDB-tk_results_new/ --cpus 20 --force --extension fa

mv $LOCAL_SCRATCH/med_MAGs_GTDB-tk_results_new/ $SLURM_SUBMIT_DIR