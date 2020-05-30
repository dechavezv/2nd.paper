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
	output = paste0(indir, "NA_CLup_joint_chr", idx, "_TrimAlt_Annot_Mask_Filter", ".vcf.gz")
	return(output)
}
	
# def variables --------
args = commandArgs(trailingOnly=TRUE)
Ref = as.character(args[1])
nchr = as.character(args[2])

mywd = paste0("/u/home/d/dechavez/project-rwayne/Clup/SNPRelate/", "/")
setwd(mywd)

indir = paste0("/u/home/d/dechavez/project-rwayne/Clup/VCF", "/")

vcf.fn = unlist(lapply(1:nchr, generate_vcfdir, indir = indir))
out.fn = paste0("Filtered_",Ref, "_all.gds")


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
samp.annot <- data.frame(pop.group = c("Algoquin","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP","WH","WH","WH","WH","WH","WH","WH","WH","YNP","YNP","YNP","ArticElles","NewM","NewM","CaptUSAHZ","Minesota","Minesota","Minesota","Minesota","Minesota","Minesota","ArticVict","ArtcBaffin","ArticElles","ArticNunav","Algoquin","CaptUSAHZ","YNP","YNP","YNP","IRNP","NewM","Minesota","YNP","YNP")
add.gdsn(genofile, "sample.annot", samp.annot)

# Close the GDS file
closefn.gds(genofile)

date()
# close All connections 
closeAllConnections()
