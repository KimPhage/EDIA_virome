#!/bin/bash

#SBATCH --job-name=Propagate_run
#SBATCH --account=project_2006887
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --output=00_LOGS/Propagate_run_%A_%aout
#SBATCH --error=00_LOGS/Propagate_run_%A_%aerr
#SBATCH --cpus-per-task=32
#SBATCH --mem=100G
#SBATCH --partition=small
##SBATCH --mail-type=kim.kreuze@helsinki.fi

cd /scratch/project_2006887/kimkreuz/edia_cohort/analysis/07_PHAGE_INDUCTION/
export SING_IMAGE=/projappl/project_2009323/Propagate.sif

for samp in $(cat ../VLP_sorted_minus_missing_reads.txt) # remember to change
do
#Concatenating paired and unmatched reads to one fastq file
zcat ../00.1_reads/${samp}.adapterTrimmed.1_kneaddata_paired_1.fastq.gz ../00.1_reads/${samp}.adapterTrimmed.1_kneaddata_paired_2.fastq.gz ../00.1_reads/${samp}.adapterTrimmed.1_kneaddata_unmatched_1.fastq.gz ../00.1_reads/${samp}.adapterTrimmed.1_kneaddata_unmatched_2.fastq.gz > reads/${samp}_allreads.fastq
#Now run Propagate 
apptainer_wrapper exec Propagate -f prophage_contigs/${samp}_prophages.fa -v coordinates/${samp}_coordinates_propagate.tsv -u reads/${samp}_allreads.fastq -t 32 -o VLP_induction_individual/Propagate/${samp}_Propagate_highqual 
pro=$(grep "Active_prophages:" ${samp}_Propagate_highqual/${samp}_Propagate.tsv)
echo "${samp}: ${pro}" >> Active_prophages_highqual.txt
rm reads/${samp}_allreads.fastq
done

