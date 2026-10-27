configfile: "config_vOTUtables_snakefile.yaml"
f1 = open(config["sample_file"],"r")
SAMPLES = f1.read().splitlines()
f1.close()
rule all:
	input:
		expand([config["vOTU_abundances_dir"]+"/{sample}_wQ33_vOTUs_coverage_nodecontam.tsv"],sample=SAMPLES)
rule bowtie2_align:
	input:
		read1=config["reads_dir"]+"/{sample}_trimmed_clean_paired_1.fastq.gz",
		read2=config["reads_dir"]+"/{sample}_trimmed_clean_paired_2.fastq.gz"
	params: 
		r_d=config["reads_dir"],
		bt2_index=config["votucat_bt2_index"],
		NGS="{sample}"
	singularity:
		config["extendApptainer"]
	output: 
		config["votucat_bt2_index"]+"/{sample}/{sample}_vOTUs.sorted.bam"
	threads: 20
	shell:
		"""
		mkdir -p {params.bt2_index}/{params.NGS}
		bowtie2 -p {threads} -x {params.bt2_index}/cleanedrep_seqs_vOTUs_noIMGVR_renamed -1 {input.read1} -2 {input.read2} -S {params.bt2_index}/{params.NGS}/{params.NGS}_vOTUs.sam
		samtools sort -o {output} {params.bt2_index}/{params.NGS}/{params.NGS}_vOTUs.sam && rm {params.bt2_index}/{params.NGS}/{params.NGS}_vOTUs.sam
		"""
rule coverm:
	input:
		bam=config["votucat_bt2_index"]+"/{sample}/{sample}_vOTUs.sorted.bam"
	params:
		outdir=config["vOTU_abundances_dir"],
		samp=temp("{sample}")
	singularity:
		config["extendApptainer"]
	output:
		config["vOTU_abundances_dir"]+"/{sample}_wQ33_vOTUs_coverage_nodecontam.tsv"
	threads: 20
	resources:
		mem_mb=4000*4,
		disk_mb=10000
	shell:
		"""
		mkdir -p {params.outdir}
		coverm contig -t 20 --min-covered-fraction 75 --methods rpkm --bam-files {input.bam} > {params.outdir}/{params.samp}_wQ33_vOTUs_coverage_nodecontam.tsv
		"""

