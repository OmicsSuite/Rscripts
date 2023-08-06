# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2023-02-25

# -> 0. Install and Library
# BiocManager::install("Biostrings")
library(Biostrings)
# <- 0. Install and Library

options(warn = 1)

# -> 1. File Read
file_path = "data/RevCom/RXAs-DNA.fasta"

seqType <- "DNA"
# ChoiceBox: "DNA", "RNA", "AminoAcid"

if (seqType == "DNA") {
	seqs <- readDNAStringSet(file_path,
							 format = "fasta",
							 nrec = -1L,
							 skip = 0L,
							 seek.first.rec = FALSE,
							 use.names = TRUE,
							 with.qualities = FALSE)
} else if (seqType == "RNA") {
	seqs <- readRNAStringSet(file_path,
							 format = "fasta",
							 nrec = -1L,
							 skip = 0L,
							 seek.first.rec = FALSE,
							 use.names = TRUE,
							 with.qualities = FALSE)
} else if (seqType == "AminoAcid") {
	seqs <- readAAStringSet(file_path,
							format = "fasta",
							nrec = -1L,
							skip = 0L,
							seek.first.rec = FALSE,
							use.names = TRUE,
							with.qualities = FALSE)
}

# <- 1. File Read

# -> 2. Data Operation
alignType <- "global"
# ChoiceBox: "global", "local", "overlap", "global-local", "local-global"

scoreMatrix <- "BLOSUM62"
# ChoiceBox:  "BLOSUM45", "BLOSUM50", "BLOSUM62", "BLOSUM80", "BLOSUM100", "PAM30", "PAM40", "PAM70", "PAM120", "PAM250"

gapOpening <- 10
# Slider: 10, 0, 100, 1

gapExtension <- 3
# Slider: 3, 0, 100, 1

res <- pairwiseAlignment(seqs[1],
						 seqs[2],
						 type = alignType, # "global", "local", "overlap", "global-local", "local-global"
						 # (Needleman-Wunsch) global alignment, (Smith-Waterman) local alignment, and (ends-free) overlap alignment
						 substitutionMatrix = scoreMatrix, # "BLOSUM45", "BLOSUM50", "BLOSUM62", "BLOSUM80", "BLOSUM100", "PAM30", "PAM40", "PAM70", "PAM120", "PAM250"
						 fuzzyMatrix = NULL,
						 gapOpening = gapOpening,
						 gapExtension = gapExtension,
						 scoreOnly = FALSE)

writePairwiseAlignments(res, file = "Results.txt",
						Matrix = NA, block.width = 80)

# writeXStringSet(seqs2,
# 				filepath = "Results.fasta",
# 				append = FALSE,
# 				compress = FALSE,
# 				compression_level = NA,
# 				format = "fasta")

# write.table(as.data.frame(palindrome@ranges), file = "Results.txt",
# 			quote = F, sep = "\t", row.names = F)
# <- 2. Data Operation