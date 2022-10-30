configfile: "config.yaml"
workdir: config["WORKING_FOLDER"]

reference_file = config["REF"]
print(reference_file)
# shell.executable("/bin/bash")
# shell.prefix("source ~/.bashrc; ")

rule all:
    input:
        "output/edited_files/snakemake_output_0.txt",
        "output/edited_files/snakemake_output_1.txt",
        "output/edited_files/snakemake_output_2.txt",
        "output/edited_files/snakemake_output_3.txt",
        "output/edited_files/snakemake_output_4.txt",
        "output/edited_files/snakemake_output_5.txt",
        "output/edited_files/snakemake_output_6.txt",
        "output/edited_files/snakemake_output_7.txt",
        "output/edited_files/snakemake_output_8.txt",
        "output/edited_files/snakemake_output_9.txt"
        # hint:
        # use expand() to do the above concisely in one line

rule edit_text:
    input: "data_wildcards/snakemake_input_{num}.txt"
    output: "output/edited_files/snakemake_output_{num}.txt"
    shell: "cat {input} | sed 's/no./number/' > {output}"

# TODO
# rule add_num_to_output_file:
#     """Create a rule to add the sample number {num} to the end of the text in the edited files.
#     So the new files should have text such as "sample number 1", "sample number 2", etc
#     The new files should be in a folder named output/numbered_files/"""
#     input:
#     output:
#     params:
#     shell:

# rule concatenate_all_files:
#     """Create a rule to concatenate all the numbered files to create a new file called final_results.txt
#     within the folder output/
#     Don't forget to change rule 'all' so that all the rules are executed!
#     """
#     input:
#     output:
#     params:
#     shell:

# Additional resources
# https://slides.com/johanneskoester/snakemake-tutorial
