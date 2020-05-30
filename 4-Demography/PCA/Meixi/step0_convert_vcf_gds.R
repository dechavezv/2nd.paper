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

# set memory
# options(java.parameters = "-Xmx28G") 

date()

# def functions --------
generate_vcfdir = function(indir, idx) {
	idx = stringr::str_pad(idx, 2, pad = "0")
	output = paste0(indir, "JointCalls_08_B_VariantFiltration_", idx, ".vcf.gz")
	return(output)
}
	
# def variables --------
args = commandArgs(trailingOnly=TRUE)
ref = as.character(args[1])
nchr = as.character(args[2])

mywd = paste0("/u/project/rwayne/meixilin/fin_whale/analyses/SNPRelate/", ref, "/")
setwd(mywd)

indir = paste0("/u/project/rwayne/snigenda/finwhale/filteredvcf/testsix/", ref, "/")

vcf.fn = unlist(lapply(1:nchr, generate_vcfdir, indir = indir))
out.fn = paste0("Filtered_", ref, "_all.gds")


# main -------
# convert the file 
snpgdsVCF2GDS(vcf.fn, out.fn, method="biallelic.only")
snpgdsSummary(out.fn)

# open this file 
genofile <- snpgdsOpen(out.fn, readonly = FALSE)
head(genofile)
# # get the genotype data (test)
# g <- read.gdsn(index.gdsn(genofile, "genotype"), start=c(1,1), count=c(5,3));g 
# g <- read.gdsn(index.gdsn(genofile, "sample.id")); g

# add population annotation 
samp.annot <- data.frame(pop.group = c(rep("ENP", times = 3), rep("GOC", times = 3)))
add.gdsn(genofile, "sample.annot", samp.annot)

# Close the GDS file
closefn.gds(genofile)

date()
# close All connections 
closeAllConnections()