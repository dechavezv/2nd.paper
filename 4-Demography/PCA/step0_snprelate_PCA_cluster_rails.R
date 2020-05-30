##### Load libraries

library(gdsfmt)
library(SNPRelate)
library(ggplot2)
library(RColorBrewer)

##### Set working directory?
todaysdate=format(Sys.Date(),format="%Y%m%d")
calldate=20200410
setwd("/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/VCF")

# def variables --------
args = commandArgs(trailingOnly=TRUE)
sample = as.character(args[1])


##### Specify VCF filename

vcf.fn <- paste("Reheader_",sample,"_FastqToSam.bam_Aligned.MarkDup_Filtered_passingSNPs.vcf",sep="")

##### Convert VCF to GDS format

snpgdsVCF2GDS(vcf.fn, paste("Reheader_",sample,"_FastqToSam.bam_Aligned.MarkDup_Filtered_passingSNPs.gds",sep=""), method="biallelic.only")

