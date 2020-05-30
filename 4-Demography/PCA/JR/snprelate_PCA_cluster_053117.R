##### Load libraries

library(gdsfmt)
library(SNPRelate)


##### Set working directory?

# setwd("/u/home/j/jarobins/project-rwayne/irnp/snprelate")


##### Specify VCF filename

# vcf.fn <- "IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs.vcf"


##### Convert VCF to GDS format

# snpgdsVCF2GDS(vcf.fn, "IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs.gds", method="biallelic.only")


##### Specify which individuals to keep

# sample.list=c("AGW1","ALG1","ARC1","ARC2","ARC3","ARC4","CL025","CL055","CL061",
# "CL062","CL065","CL067","CL075","CL141","CL152","CL175","CL189","CLA1",
# "ETH1","GFO1","GFO2","IRA1","ITL2","JAC1","MEX1","PTG1","RED1","RKW119","RKW2455",
# "RKW2515","RKW2518","RKW2523","RKW2524","SPN1","TIB1","XJG1","YNP1","YNP2","YNP3")

# snpgdsCreateGenoSet("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs.gds", "IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_removeInds.gds", sample.id=sample.list)

genofile <- snpgdsOpen("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_removeInds.gds")


# sample.list=c("AGW1","ALG1","ARC1","ARC2","ARC3","ARC4","CL025","CL055","CL061",
"CL062","CL065","CL067","CL075","CL141","CL152","CL175","CL189","CLA1",
"ETH1","GFO1","IRA1","ITL2","MEX1","PTG1","RED1","RKW119","RKW2455",
"RKW2515","RKW2518","RKW2523","RKW2524","SPN1","TIB1","XJG1","YNP1","YNP2","YNP3")

# snpgdsCreateGenoSet("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs.gds", "IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_37inds.gds", sample.id=sample.list)

# genofile <- snpgdsOpen("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_37inds.gds")


##### Prune SNPs based on LD

# set.seed(1000)
# snpset <- snpgdsLDpruning(genofile, ld.threshold=.2)
# snpset.id <- unlist(snpset)

# snpgdsCreateGenoSet("IRNP_31_joint_chrALL_passingSNPs.gds", "IRNP_31_joint_chrALL_passingSNPs_pruned.gds", snp.id=snpset.id)


##### Close old genofile, open new genofile

# snpgdsClose(genofile)

# genofile <- snpgdsOpen("IRNP_31_joint_chrALL_passingSNPs_pruned.gds")


##### Add population information

# pop_code=c("REF","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP",
# "REF","REF","REF","REF","REF","REF","REF","MAIN","MAIN","MAIN","MAIN","MAIN","MAIN","REF","REF",
# "REF","REF","REF","REF")

# pop_code <- read.gdsn(index.gdsn(genofile, "sample.annot/pop.group")) # <- doesn't work


##### Run PCA

# pca <- snpgdsPCA(genofile, snp.id=snpset.id, num.thread=1)
pca <- snpgdsPCA(genofile, num.thread=1)

pc.percent <- pca$varprop*100

# head(round(pc.percent, 2))

tab <- data.frame(sample.id = pca$sample.id,
    EV1 = pca$eigenvect[,1],
    EV2 = pca$eigenvect[,2],
    EV3 = pca$eigenvect[,3],
    EV4 = pca$eigenvect[,4],
    stringsAsFactors = FALSE)

write.table(tab, file="IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_removeInds_noprune_PCA_1_2_3_4.txt", col.names=T, row.names=F, quote=F, sep='\t')

pdf("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_removeInds_noprune_PCA_1_2.pdf", width=6, height=6)

plot(tab$EV2, tab$EV1, xlab="eigenvector 2", ylab="eigenvector 1")

dev.off()


##### Plot the first 4 PCs against each other

lbls <- paste("PC", 1:4, "\n", format(pc.percent[1:4], digits=2), "%", sep="")

pdf("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_removeInds_noprune_PCA_1_2_3_4.pdf", width=6, height=6)

pairs(pca$eigenvect[,1:4], labels=lbls)

dev.off()


##### Create cluster dendrogram

set.seed(100)

ibs.hc <- snpgdsHCluster(snpgdsIBS(genofile, num.thread=1))

rv <- snpgdsCutTree(ibs.hc)

pdf("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_removeInds_noprune_IBScluster.pdf", width=8, height=12)

plot(rv$dendrogram, main="SNPRelate Clustering")

dev.off()


##### PCA with gray wolves and coyote only

snpgdsClose(genofile)

# sample.list=c("ALG1","ARC1","ARC2","ARC3","ARC4","CL025","CL055","CL061",
# "CL062","CL065","CL067","CL075","CL141","CL152","CL175","CL189","CLA1",
# "IRA1","ITL2","MEX1","PTG1","RED1","RKW119","RKW2455",
# "RKW2515","RKW2518","RKW2523","RKW2524","SPN1","TIB1","XJG1","YNP1","YNP2","YNP3")

# snpgdsCreateGenoSet("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs.gds", "IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_noprune_WolvesCoyotesOnly.gds", sample.id=sample.list)

genofile <- snpgdsOpen("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_noprune_WolvesCoyotesOnly.gds")

##### Run PCA

# pca <- snpgdsPCA(genofile, snp.id=snpset.id, num.thread=1)
pca <- snpgdsPCA(genofile, num.thread=1)

pc.percent <- pca$varprop*100

# head(round(pc.percent, 2))

tab <- data.frame(sample.id = pca$sample.id,
    EV1 = pca$eigenvect[,1],
    EV2 = pca$eigenvect[,2],
    EV3 = pca$eigenvect[,3],
    EV4 = pca$eigenvect[,4],
    stringsAsFactors = FALSE)

write.table(tab, file="IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_noprune_WolvesCoyotesOnly_PCA_1_2_3_4.txt", col.names=T, row.names=F, quote=F, sep='\t')

pdf("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_noprune_WolvesCoyotesOnly_PCA_1_2.pdf", width=6, height=6)

plot(tab$EV2, tab$EV1, xlab="eigenvector 2", ylab="eigenvector 1")

dev.off()


##### Plot the first 4 PCs against each other

lbls <- paste("PC", 1:4, "\n", format(pc.percent[1:4], digits=2), "%", sep="")

pdf("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_noprune_WolvesCoyotesOnly_PCA_1_2_3_4.pdf", width=6, height=6)

pairs(pca$eigenvect[,1:4], labels=lbls)

dev.off()

##### PCA with gray wolves only

snpgdsClose(genofile)

sample.list=c("ALG1","ARC1","ARC2","ARC3","ARC4","CL025","CL055","CL061",
"CL062","CL065","CL067","CL075","CL141","CL152","CL175","CL189",
"IRA1","ITL2","MEX1","PTG1","RKW119","RKW2455",
"RKW2515","RKW2518","RKW2523","RKW2524","SPN1","TIB1","XJG1","YNP1","YNP2","YNP3")

snpgdsCreateGenoSet("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs.gds", "IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_noprune_WolvesOnly.gds", sample.id=sample.list)

genofile <- snpgdsOpen("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_noprune_WolvesOnly.gds")

##### Run PCA

# pca <- snpgdsPCA(genofile, snp.id=snpset.id, num.thread=1)
pca <- snpgdsPCA(genofile, num.thread=1)

pc.percent <- pca$varprop*100

# head(round(pc.percent, 2))

tab <- data.frame(sample.id = pca$sample.id,
    EV1 = pca$eigenvect[,1],
    EV2 = pca$eigenvect[,2],
    EV3 = pca$eigenvect[,3],
    EV4 = pca$eigenvect[,4],
    stringsAsFactors = FALSE)

write.table(tab, file="IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_noprune_WolvesOnly_PCA_1_2_3_4.txt", col.names=T, row.names=F, quote=F, sep='\t')

pdf("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_noprune_WolvesOnly_PCA_1_2.pdf", width=6, height=6)

plot(tab$EV2, tab$EV1, xlab="eigenvector 2", ylab="eigenvector 1")

dev.off()


##### Plot the first 4 PCs against each other

lbls <- paste("PC", 1:4, "\n", format(pc.percent[1:4], digits=2), "%", sep="")

pdf("IRNP_43_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_noprune_WolvesOnly_PCA_1_2_3_4.pdf", width=6, height=6)

pairs(pca$eigenvect[,1:4], labels=lbls)

dev.off()



##########
library(gdsfmt)
library(SNPRelate)

#vcf.fn <- "fox_17_joint_fb_chrALL_VEP_all_rename_Mask_Filter_reorder_fix_passingSNPs.vcf"

#snpgdsVCF2GDS(vcf.fn, "fox_17_joint_fb_chrALL_VEP_all_rename_Mask_Filter_reorder_fix_passingSNPs.gds", method="biallelic.only")

genofile <- snpgdsOpen("all_chr_filtered_snps_for_tree_fox.gds")

##### Prune SNPs based on LD

set.seed(999)
snpset <- snpgdsLDpruning(genofile, ld.threshold=0.2, maf=0.1)
snpset.id <- unlist(snpset)

snpgdsCreateGenoSet("all_chr_filtered_snps_for_tree_fox.gds", "all_chr_filtered_snps_for_tree_fox_pruned.gds", snp.id=snpset.id)


##### Close old genofile, open new genofile

snpgdsClose(genofile)
genofile <- snpgdsOpen("all_chr_filtered_snps_for_tree_fox_pruned.gds")

##### PCA
pca <- snpgdsPCA(genofile, num.thread=1)
pc.percent <- pca$varprop*100

tab <- data.frame(sample.id = pca$sample.id,
    EV1 = pca$eigenvect[,1],
    EV2 = pca$eigenvect[,2],
    EV3 = pca$eigenvect[,3],
    EV4 = pca$eigenvect[,4],
	pc.percent = pc.percent,
    stringsAsFactors = FALSE)

write.table(tab, file="all_chr_filtered_snps_for_tree_fox_unpruned_PCA_1_2_3_4.txt", col.names=T, row.names=F, quote=F, sep='\t')

pdf("all_chr_filtered_snps_for_tree_fox_unpruned_PCA_1_2.pdf", width=6, height=6)

plot(tab$EV2, tab$EV1, xlab="eigenvector 2", ylab="eigenvector 1")

dev.off()


