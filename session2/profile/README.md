# BMRC-specific usage 

This is a fork of the profile code was originally written by [drjbarker](https://github.com/drjbarker/snakemake-gridengine), and I made 
the following modifications ([diffs](https://github.com/sraorao/snakemake-gridengine/commit/dadfcdff353d79a0ae897268e43096b8d8ccaadf)) to 
better suit the requirements of the BMRC cluster at the University of Oxford:

- Logger warning turned off when the `sge-status` script can not find the job, because in my experience, this seems to 
be because `qacct` has not updated yet
- `cluster.yaml` and `sge-submit.py` have been edited to reflect common usage on the Oxford BMRC cluster (Rescomp). 
Importantly, `export-env` (`-V`) has been disabled as per 
[BMRC recommendations](https://www.medsci.ox.ac.uk/divisional-services/support-services-1/bmrc/cluster-usage/#submitting-jobs---step-by-step-guide-for-new-users). 
In addition, I have added a hostname option in `cluster.yaml` to specify node names.
- `sge-jobscript.sh` has been edited so that the Anaconda module can be loaded when Snakemake is using conda 
environments. This may conflict with any other environment modules loaded in individual rules.


# gridengine

This is written for the arc4 cluster at the University of Leeds, but should be general enough to work in most SGE setups.

This profile configures [Snakemake](https://snakemake.readthedocs.io/en/stable/) to run on (Sun) Grid Engine.

- `config.yaml` contains default arguments for the profile
- `cluster.yaml` contains default options for grid engine’s qsub

Additional cluster options (including complex resources) can be given in a local yaml file using Snakemake’s `--cluster-config` flag. This also allows per-rule options. Example use cases would be when a certain rule needs to run in a certain queue or under a certain project or you want to use a complex resource which may not exist in other SGE configurations.

## Installation

On Linux, place the files into `~/.config/snakemake/sge` for snakemake to automatically find the profile.

The `cluster.yaml` file in the profile directory should be modified to setup your default settings (applied to all rules but can be overwritten) and custom resources.

Custom SGE resources are specified in `__resources__` only in the profile folder (i.e. ones in a local `--cluster-config cluster.yaml` will be ignored). They are given as a YAML dictionary where the key is the resource name as defined in SGE and the values are any aliases you want to use for this resource. The key will always be avaiable as a name even if you don't specifiy it as an alias. If a key already exists in the resource list the the aliases are just appended to that resource. Examples are given in the provided `cluster.yaml` (from arc4 at Leeds).

## Usage

To use the profile (i.e. to submit tasks as jobs on in an SGE queue) use:

`snakemake --profile sge`

To also use a local `cluster.yaml` file in your working directory use;

`snakemake --profile sge --cluster-config cluster.yaml`

## qsub options

The options are read and overwritten in the following order:

1. Default options in `sge-submit.py`
2. Default options in the profile’s `cluster.yaml` file
3. Resources specified for the rule in the Snakemake file
4. Rule specific options in the profile’s `cluster.yaml` file
5. Default and rule specific options in the cluster config pass with `--cluster-config`

## Resource mapping

To allow more expressive resource requests we map some simple names to the SGE options and resources. These can be used for example in `cluster.yaml` to make the configuration simpler to read.


| SGE Option       | Accepted YAML key names                   |
| -----------------|-------------------------------------------| 
| binding          | binding                                   |
| cwd              | cwd,                                      |
| e                | e, error                                  |
| hard             | hard,                                     |
| j                | j, join                                   |
| m                | m, mail_options                           |
| M                | M, email                                  |
| notify           | notify,                                   |
| now              | now,                                      |
| N                | N, name                                   |
| o                | o, output                                 |
| P                | P, project                                |
| p                | p, priority                               |
| pe               | pe, parallel_environment                  |
| pty              | pty,                                      |
| q                | q, queue                                  |
| R                | R, reservation                            |
| r                | r, rerun                                  |
| soft             | soft,                                     |
| v                | v, variable                               | 
| V                | V, export_env                             |
| qname            | qname,                                    |
| hostname         | hostname,                                 |
| calendar         | calendar,                                 |
| min_cpu_interval | min_cpu_interval,                         |
| tmpdir           | tmpdir,                                   |
| seq_no           | seq_no,                                   |
| s_rt             | s_rt, soft_runtime, soft_walltime         |
| h_rt             | h_rt, time, runtime, walltime             |
| s_cpu            | s_cpu, soft_cpu                           |
| h_cpu            | h_cpu, cpu                                |
| s_data           | s_data, soft_data                         |
| h_data           | h_data, data                              |
| s_stack          | s_stack, soft_stack                       |
| h_stack          | h_stack, stack                            |           
| s_core           | s_core, soft_core                         |
| h_core           | h_core, core                              |
| s_rss            | s_rss, soft_resident_set_size             |
| h_rss            | h_rss, resident_set_size                  |
| slots            | slots,                                    |
| s_vmem           | s_vmem, soft_memory,  soft_virtual_memory | 
| h_vmem           | h_vmem, mem, memory,  virtual_memory      | 
| s_fsize          | s_fsize, soft_file_size                   |
| h_fsize          | h_fsize, file_size                        |
