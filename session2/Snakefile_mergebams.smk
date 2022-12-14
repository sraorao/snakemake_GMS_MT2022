"""
Workflow to merge bam files
inputs: 4 bam files from folder /data/bam/
outputs: 1 merged bam file in folder /data/merged_bam/
"""
configfile: "config.yaml"
from snakemake.utils import min_version
import pandas
min_version("5.26")

samples_df = pandas.read_csv(config["SAMPLE_IDS"])
TUMOURS = samples_df.tumour
NORMALS = samples_df.normal
ALL_SAMPLES = set(list(TUMOURS) + list(NORMALS))

print(ALL_SAMPLES)
onsuccess: print("finished successfully") # insert more useful code here, e.g. send email to yourself
onerror: print("finished with errors") # insert more useful code here, e.g. send email to yourself

rule merge_bams:
    input: expand("data/bam/{sample}.bam", sample = ALL_SAMPLES)
    output: "data/merged_bam/merged_bam.bam"
    params: " -I ".join(expand("data/bam/{sample}.bam", sample = ALL_SAMPLES))
    conda: "envs/gatk.yaml"
    envmodules: "GATK/4.1.7.0-GCCcore-8.3.0-Java-11"
    threads: 1
    shell: "gatk MergeSamFiles -I {params} -O {output}"
