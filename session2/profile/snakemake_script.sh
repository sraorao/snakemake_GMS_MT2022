#!/bin/sh
# properties = {"type": "single", "rule": "get_allele_freqs", "local": false, "input": ["/well/hamdy/projects/PROMOTE/battenberg/chromnames.txt", "/well/hamdy/projects/PROMOTE/merged_bam/NE794590_sorted.bam"], "output": ["NE794590_sorted_alleleFrequencies_chr17.txt"], "wildcards": {"sample": "NE794590_sorted", "chrom": "17"}, "params": {"sample_name": "NE794590_sorted", "chrom": "17", "G1000PREFIX_AC": "/well/hamdy/shared/Battenberg/GenomeFiles/battenberg_1000genomesloci2012_v3/1000genomesloci2012_chr"}, "log": [], "threads": 1, "resources": {}, "jobid": 552, "cluster": {"queue": "short.qc", "pe": "shmem 1", "project": "hamdy.prjc", "output": "/well/hamdy/users/hyn435/cluster_output/", "name": "get_allele_freqs"}}
 cd /gpfs3/well/hamdy/users/hyn435/scripts/battenberg3 && \
/well/hamdy/shared/conda-envs/wgs/bin/python3.6 \
-m snakemake NE794590_sorted_alleleFrequencies_chr17.txt --snakefile /gpfs3/well/hamdy/users/hyn435/scripts/battenberg3/Snakefile_battenberg3 \
--force -j --keep-target-files --keep-remote \
--wait-for-files /gpfs3/well/hamdy/users/hyn435/scripts/battenberg3/.snakemake/tmp.62kz8f6q chromnames.txt NE794590_sorted.bam --latency-wait 60 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules get_allele_freqs --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch "/gpfs3/well/hamdy/users/hyn435/scripts/battenberg3/.snakemake/tmp.62kz8f6q/552.jobfinished" || (touch "/gpfs3/well/hamdy/users/hyn435/scripts/battenberg3/.snakemake/tmp.62kz8f6q/552.jobfailed"; exit 1)

