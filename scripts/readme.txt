Here go scripts for analysis
01_preprocessing contains snakemake pipeline used for VLP read preprocessing
02_virus_ID contains key snakemake pipelines necessary for assembly, contig extension and identification of viruses (virus identification pipeline was used for both VLP and bulk metagenome assemblies)
03_votu_abundance_estimation contains snakemake pipelines and scripts necessary to estimate abundance of vOTUs either using bulk or VLP metagenome reads. vOTU catalogue with representative sequences can be downloaded from XXX
04_votu_annotation contains scripts used to annotate the vOTUs that were present in our dataset after decontamination
05_key_analyses contains key analyses that were included in the manuscript