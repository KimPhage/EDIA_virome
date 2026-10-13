#!/bin/bash

#SBATCH --job-name=Dramv
#SBATCH --account=project_2006887
#SBATCH --time=10:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --output=00_LOGS/Dramv_%A_%aout
#SBATCH --error=00_LOGS/Dramv_%A_%aerr
#SBATCH --cpus-per-task=38
#SBATCH --mem=100G
#SBATCH --gres=nvme:100
#SBATCH --partition=small
##SBATCH --mail-type=kim.kreuze@helsinki.fi

cd /scratch/project_2006887/kimkreuz/edia_cohort/VLP_reads/05_Functional_annotation/

export SING_IMAGE=/projappl/project_2009323/virsorter2.sif

#apptainer_wrapper exec virsorter run --seqname-suffix-off --viral-gene-enrich-off --provirus-off --prep-for-dramv -i vOTU_coverag_unique_corrected_sorted_rmcontrol_rmempty_renamed.fa -w DRAMv_vOTUs/virsorter2 --include-groups dsDNAphage,ssDNA --min-length 1000 --min-score 0.5 -j 38 all

export SING_IMAGE=/projappl/project_2009323/dram.sif

#apptainer_wrapper exec DRAM-v.py annotate -i DRAMv_vOTUs/virsorter2/for-dramv/final-viral-combined-for-dramv.fa -v DRAMv_vOTUs/virsorter2/for-dramv/viral-affi-contigs-for-dramv.tab -o dramv-annotate --skip_trnascan --threads 28 --min_contig_size 1000
#step 2 summarize anntotations
apptainer_wrapper exec DRAM-v.py distill -i dramv-annotate/annotations.tsv -o dramv-distill
