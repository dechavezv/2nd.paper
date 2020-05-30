# Title: Convert vcf files to gds files 
# Author: Meixi Lin (meixilin@ucla.edu)
# Date: Mon Apr  6 12:34:19 2020
	
# preparation --------
rm(list = ls())
cat("\014")
options(echo = TRUE)
# Load the R packages: gdsfmt and SNPRelate
library(gdsfmt)
library(SNPRelate)

# def functions --------
plot_pca_by_group = function(pca, genofile) {
	# Get variance explained 
	pc.percent <- pca$varprop*100
	# Get sample id
	sample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))
	pop_code <- read.gdsn(index.gdsn(genofile, "sample.annot/pop.group"))
	# assume the order of sample IDs is as the same as population codes
	# Make a data.frame
	tab <- data.frame(sample.id = pca$sample.id,
	    pop = factor(pop_code)[match(pca$sample.id, sample.id)],
	    EV1 = pca$eigenvect[,1],    # the first eigenvector
	    EV2 = pca$eigenvect[,2],    # the second eigenvector
	    stringsAsFactors = FALSE)
	# head(tab)
	plot(tab$EV1, tab$EV2, col=as.integer(tab$pop), 
		xlab=paste0("PC1(", round(pc.percent[1], 1), "%)"), 
		ylab=paste0("PC2(", round(pc.percent[2], 1), "%)"))
	text(tab$EV1, tab$EV2, col=as.integer(tab$pop), labels = tab$sample.id)
	legend("bottomright", legend=levels(tab$pop), pch="o", col=1:nlevels(tab$pop))
}

# subset by filter 
subset_filter_pass = function(genofile) {
	g <- (read.gdsn(index.gdsn(genofile, "snp.annot/filter")) == "PASS")
	snpset = read.gdsn(index.gdsn(genofile, "snp.id"))[g]
	return(snpset)
}
	
# def variables --------
args = commandArgs(trailingOnly=TRUE)
mywd = as.character(args[1])
out.fn = as.character(args[2]) # file directory and name
ref = as.character(args[3])

setwd(mywd)
indir = mywd
plotdir = paste0(mywd, "plots/")
dir.create(plotdir, recursive = T)

# other variables 
myld = 0.2 
mymaf = 0.09

# main -------
# PCA --------
genofile <- snpgdsOpen(out.fn, readonly = TRUE)
# LD-based SNP pruning, maf set at > 1/12 = 0.08
set.seed(1000)
snpset <- snpgdsLDpruning(genofile, ld.threshold = myld, maf = mymaf, autosome.only = FALSE)
# remove the filtered sites 
snpset.id2 = subset_filter_pass(genofile)
# select for sites 
snpset.id = base::intersect(unname(unlist(snpset)), snpset.id2)

# start pca 
pca <- snpgdsPCA(genofile, snp.id=snpset.id, autosome.only = FALSE, num.thread=4)

# plot pca 
png(filename = paste0(plotdir, "PCA_ld0.02_maf0.09_", ref, "_", length(snpset.id),".png"), width = 6, height = 6, units = "in", res = 150)
	pp = par()
	plot_pca_by_group(pca, genofile)
	par(pp)
dev.off()

# Close the GDS file
closefn.gds(genofile)


# output --------

