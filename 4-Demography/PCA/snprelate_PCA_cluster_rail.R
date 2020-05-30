##### Load libraries

library(gdsfmt)
library(SNPRelate)
library(ggplot2)
library(RColorBrewer)

##### Set working directory?
todaysdate=format(Sys.Date(),format="%Y%m%d")
calldate=20200504
setwd("/u/scratch/d/dechavez/rails.project/SNPRelate")
plotoutdir=paste("/u/scratch/d/dechavez/rails.project/SNPRelate",calldate,"/PCA/",sep="")
dir.create(plotoutdir,recursive = T)

##### Specify VCF filename

vcf.fn <- "LS_joint_allchr_Annot_Mask_Filter_passingSNPs.vcf"

##### Convert VCF to GDS format

snpgdsVCF2GDS(vcf.fn, "LS_joint_allchr_Annot_Mask_Filter_passingSNPs.gds", method="biallelic.only")


######## Exclude low coverage genomes if is the case #########################

sample.list=c("LS05","LS09","LS21","LS29","LS34","LS35","LS49","LS57")

snpgdsCreateGenoSet("LS_joint_allchr_Annot_Mask_Filter_passingSNPs.gds", "LS_joint_allchr_Annot_Mask_Filter_passingSNPs_removeInds.gds", sample.id=sample.list)

genofile <- snpgdsOpen("LS_joint_allchr_Annot_Mask_Filter_passingSNPs_removeInds.gds")

##### Prune SNPs based on LD

set.seed(1000)
snpset <- snpgdsLDpruning(genofile, ld.threshold=.2,maf=0.1,autosome.only=FALSE)
snpset.id <- unlist(snpset)

snpgdsCreateGenoSet("LS_joint_allchr_Annot_Mask_Filter_passingSNPs_removeInds.gds", "LS_joint_allchr_Annot_Mask_Filter_passingSNPs_removeInds_pruned.gds", snp.id=snpset.id)


##### Close old genofile, open new genofile

snpgdsClose(genofile)

genofile <- snpgdsOpen("LS_joint_allchr_Annot_Mask_Filter_passingSNPs_removeInds_pruned.gds")


##### Add population information
pop_code=c("St.Cruz","St.Cruz","Isabela", "Isabela",
"Isabela", "Pinta", "Pinta", "Santiago", "Santiago")

#pop_code <- read.gdsn(index.gdsn(genofile, "sample.annot/pop.group")) # <- doesn't work

##### Run PCA

# pca <- snpgdsPCA(genofile, snp.id=snpset.id, num.thread=1)
pca <- snpgdsPCA(genofile, num.thread=1,autosome.only=FALSE)

pc.percent <- pca$varprop*100

# head(round(pc.percent, 2))

tab <- data.frame(sample.id = pca$sample.id,
    EV1 = pca$eigenvect[,1],
    EV2 = pca$eigenvect[,2],
    EV3 = pca$eigenvect[,3],
    EV4 = pca$eigenvect[,4],
    stringsAsFactors = FALSE)

write.table(tab, file="LS_joint_allchr_Annot_Mask_Filter_passingSNPs_removeInds_pruned_PCA_1_2_3_4.txt", col.names=T, row.names=F, quote=F, sep='\t')

pdf("LS_joint_allchr_Annot_Mask_Filter_passingSNPs_removeInds_pruned_PCA_1_2.pdf", width=6, height=6)

plot(tab$EV2, tab$EV1, xlab="eigenvector 2", ylab="eigenvector 1")

dev.off()


##### Plot the first 4 PCs against each other

lbls <- paste("PC", 1:4, "\n", format(pc.percent[1:4], digits=2), "%", sep="")

pdf("LS_joint_allchr_Annot_Mask_Filter_passingSNPs_removeInds_pruned_PCA_1_2_3_4.pdf", width=6, height=6)

pairs(pca$eigenvect[,1:4], labels=lbls)

dev.off()

########### pop map ########

#population information
popmap = read.table("/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/VCF/list.sample.rails.txt",header=T)
sample.id = as.character(popmap$Sample)
pop1_code = as.character(popmap$PrimaryPop)

#make a data.frame
tab1a <- data.frame(sample.id = pca$sample.id, pop1 = factor(pop1_code)[match(pca$sample.id, sample.id)],
    EV1 = pca$eigenvect[,1],
    EV2 = pca$eigenvect[,2],
    EV3 = pca$eigenvect[,3],
    EV4 = pca$eigenvect[,4],
    stringsAsFactors = FALSE)

#head(tab1a)

############### set up your colors -- keep this consistent across all plots ######

colorPal=RColorBrewer::brewer.pal(n=8,name = "Dark2")

colors=list(St.Cruz=colorPal[1],Isabela=colorPal[3],Santiago=colorPal[5],
Pinta=colorPal[8]) # your population colors

#plot first 2 pc coloring by primary population
p1a <- ggplot(tab1a,aes(x=EV2,y=EV4,color=pop1))+
  geom_point(size=3)+
  theme_bw()+
  ylab(paste("PC4_", format(pc.percent[4], digits=2),"%", sep=""))+
  xlab(paste("PC2_", format(pc.percent[2], digits=2),"%", sep=""))+
  ggtitle(paste("PCA based on ",as.character(length(pca$snp.id))," LD Pruned SNPs",sep=""))+
  theme(legend.title = element_blank(),axis.text = element_text(size=14),
  axis.title = element_text(size=14),legend.text = element_text(size=14))+
  scale_shape_manual(values=c(1,16))+
  scale_color_manual(values=unlist(colors))

# paste("PC", 1:4, "\n", format(pc.percent[1:4], digits=2), "%", sep="")

#p1a
ggsave(paste(plotoutdir,"/PCA.rails.",todaysdate,"correctedAxes.PC2_PC4.pdf",sep=""),p1a,device="pdf",width = 8,height=5)


##### Create cluster dendrogram

set.seed(100)

ibs.hc <- snpgdsHCluster(snpgdsIBS(genofile, num.thread=1,autosome.only=FALSE))

rv <- snpgdsCutTree(ibs.hc)

pdf("LS_joint_allchr_Annot_Mask_Filter_passingSNPs_removeInds_pruned_IBScluster.pdf", width=8, height=12)

plot(rv$dendrogram, main="SNPRelate Clustering")

dev.off()

#PCA wuth Hihg coverage indiv
