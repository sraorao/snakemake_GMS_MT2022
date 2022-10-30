counts_file = snakemake@input[[1]]
counts = read.table(counts_file, sep = "\t", header = FALSE, col.names = c("count", "word"))
counts$letter = substr(counts$word, 1, 1)

pdf("output/counts_plot.pdf")
letter_freq = as.data.frame(table(counts$letter))
barplot(letter_freq$Freq, names.arg = letter_freq$Var1)
dev.off()
