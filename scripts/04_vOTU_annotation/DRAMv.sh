#!/bin/bash

#SBATCH --job-name=Dramv
#SBATCH --account=project_2006887
#SBATCH --time=1:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --output=00_LOGS/Dramv_%A_%aout
#SBATCH --error=00_LOGS/Dramv_%A_%aerr
#SBATCH --cpus-per-task=20
#SBATCH --mem=20G
#SBATCH --partition=small
##SBATCH --mail-type=kim.kreuze@helsinki.fi

export SING_IMAGE=/projappl/project_2009323/virsorter2.sif
#Run Virsorter2 to prepare the vOTUs for DRAMv annotation
apptainer exec --bind /path/to/bind $SING_IMAGE virsorter run --seqname-suffix-off --viral-gene-enrich-off --provirus-off --prep-for-dramv -i /vOTU_catalog_contigs.fna -w /virsorter2_out --include-groups dsDNAphage,ssDNA --min-length 1000 --min-score 0.5 -j 20 all

export SING_IMAGE=/projappl/project_2009323/dram.sif
#Run DRAMv to annotate the vOTUs
apptainer exec --bind /path/to/bind $SING_IMAGE DRAM-v.py annotate -i /virsorter2_out/for-dramv/final-viral-combined-for-dramv.fa -v /virsorter2_out/for-dramv/viral-affi-contigs-for-dramv.tab -o /DRAMv_vOTUs/dramv-annotate --skip_trnascan --threads 20 --min_contig_size 1000
#step 2 summarize anntotations
apptainer exec --bind /path/to/bind $SING_IMAGE DRAM-v.py distill -i /DRAMv_vOTUs/dramv-annotate/annotations.tsv -o /DRAMv_vOTUs/dramv-distill
