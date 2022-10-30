configfile: "config.yaml"
workdir: config["WORKING_FOLDER"]
# shell.executable("/bin/bash")
# shell.prefix("source ~/.bashrc; ")

#### TASK ####
# Create a file containing alphabets A to Z, each on a separate line
# Create a file containing numbers 1 to 26, each on a separate line
# 'Join' letters and numbers, such that each line contains a letter and its corresponding number (using shell)
# 'Join' letters and numbers, such that each line contains a letter and its corresponding number (using python)
# Compare files created by shell and python

rule all:
    input:
        # "letters_and_numbers.txt",
        # "letters_and_numbers_python.txt",
        "output/comparison.txt"

rule generate_files:
    # input: "Snakefile_3rules.smk" # dummy input
    output:
        letters = "output/letters.txt",
        numbers = "output/numbers.txt"
    shell:
        """
        for each in {{A..Z}}; do echo $each; done > {output.letters}
        for each in {{1..26}}; do echo $each; done > {output.numbers}
        """

rule join_files:
    input: rules.generate_files.output
    output: "output/letters_and_numbers.txt"
    shell: "paste {input} > {output}"

rule join_files_with_python:
    input:
        letters = rules.generate_files.output.letters,
        numbers = rules.generate_files.output.numbers
    output: "output/letters_and_numbers_python.txt"
    run:
        with open(input.letters, 'r') as file:
            letters = file.read().splitlines()
        with open(input.numbers, 'r') as file:
            numbers = file.read().splitlines()
        letters_and_numbers = [x + "\t" + y for x, y in zip(letters, numbers)]
        with open(output[0], 'w') as file:
            for each in letters_and_numbers:
                file.write(each + "\n")
        shell("echo testing")

rule compare_files:
    input: rules.join_files.output, rules.join_files_with_python.output
    output: "output/comparison.txt"
    shell: "if cmp {input}; then echo identical; else echo different; fi > {output}"



