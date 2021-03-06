##### Load libraries

library(gdsfmt)
library(SNPRelate)
library(ggplot2)
library(RColorBrewer)

##### Set working directory?
todaysdate=format(Sys.Date(),format="%Y%m%d")
calldate=20200410
setwd("/u/home/d/dechavez/project-rwayne/Clup/SNPRelate")
plotoutdir=paste("/u/home/d/dechavez/project-rwayne/Clup/SNPRelate",calldate,"/PCA/",sep="")
dir.create(plotoutdir,recursive = T)

##### Specify VCF filename

vcf.fn <- "NA_CLup_joint_chrAll_Annot_Mask_Filter_passingSNPs.vcf"
#vcf.fn <- "NA_CLup_joint_chr38_TrimAlt_Annot_Mask_Filter.vcf"

##### Convert VCF to GDS format

snpgdsVCF2GDS(vcf.fn, "NA_CLup_joint_chrAll_Annot_Mask_Filter_passingSNPs.gds", method="biallelic.only")


##### Specify which individuals to keep

# sample.list=c("ALG1","CL025","CL055","CL061","CL062","CL065",
# "CL067","CL075","CL141","CL152","CL175","CL189","Clup1185",
# "Clup1694","Clup2491","Clup4267","Clup5161","Clup5558","Clup6338",
# "Clup6459","ClupRKW3624","ClupRKW3637","ClupRKW7526","Clup_SRR8049197",
# "Cruf_SRR8049200","MEX1","RED1","RKW119","RKW2455","RKW2515","RKW2518",
# "RKW2523","RKW2524","RKW7619","RKW7639","RKW7640","RKW7649","SRR7976407_Algoquin",
# "SRR7976417_red","SRR7976421_570M_YNP","SRR7976422_569F_YNP","SRR7976423_302M_YNP",
# "SRR7976425_I450_97_IRNP","SRR7976431_Mexican_NewM","SRR7976432_Minesota","YNP2","YNP3")

######## Exclude low coverage genomes <6x SRR7976425(IRNP_BV),SRR7976407(Algoquin_BV),SRR8049200(MexicWolf_TG)

sample.list=c("ALG1","CL025","CL055","CL061","CL062","CL065",
"CL067","CL075","CL141","CL152","CL175","CL189","Clup1185",
"Clup1694","Clup2491","Clup4267","Clup5161","Clup5558","Clup6338",
"Clup6459","ClupRKW3624","ClupRKW3637","ClupRKW7526","Clup_SRR8049197",
"MEX1","RED1","RKW119","RKW2455","RKW2515","RKW2518",
"RKW2523","RKW2524","RKW7619","RKW7639","RKW7640","RKW7649",
"SRR7976417_red","SRR7976421_570M_YNP","SRR7976422_569F_YNP","SRR7976423_302M_YNP",
"SRR7976431_Mexican_NewM","SRR7976432_Minesota","YNP2","YNP3")


snpgdsCreateGenoSet("NA_CLup_joint_chrAll_Annot_Mask_Filter_passingSNPs.gds", "NA_CLup_joint_chrAll_Annot_Mask_Filter_passingSNPs_removeInds.gds", sample.id=sample.list)

genofile <- snpgdsOpen("NA_CLup_joint_chrAll_Annot_Mask_Filter_passingSNPs_removeInds.gds")

##### Prune SNPs based on LD

set.seed(1000)
snpset <- snpgdsLDpruning(genofile, ld.threshold=.2,maf=0.1)
snpset.id <- unlist(snpset)

snpgdsCreateGenoSet("NA_CLup_joint_chrAll_Annot_Mask_Filter_passingSNPs_removeInds.gds", "NA_CLup_joint_chrAll_Annot_Mask_Filter_passingSNPs_removeInds_pruned.gds", snp.id=snpset.id)


##### Close old genofile, open new genofile

snpgdsClose(genofile)

genofile <- snpgdsOpen("NA_CLup_joint_chrAll_Annot_Mask_Filter_passingSNPs_removeInds_pruned.gds")


##### Add population information

pop_code=c("Canada","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP","IRNP",
"IRNP","IRNP","IRNP","IRNP","Montana","Montana","Montana","Montana","Montana","Montana","Montana","Montana","YNP",
"YNP","YNP","ArticElles","NewM","NewM","CaptUSAHZ","Minesota","Minesota","Minesota",
"Minesota","Minesota","Minesota","Artic","Artc","Artic","Artic",
"Canada","CaptUSAHZ","YNP","YNP","YNP","IRNP","NewM","Minesota","YNP","YNP")

#pop_code <- read.gdsn(index.gdsn(genofile, "sample.annot/pop.group")) # <- doesn't work

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

write.table(tab, file="NA_Clup_44_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_removeInds_noprune_PCA_1_2_3_4.txt", col.names=T, row.names=F, quote=F, sep='\t')

pdf("NA_Clup_44_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_removeInds_noprune_PCA_1_2.pdf", width=6, height=6)

plot(tab$EV2, tab$EV1, xlab="eigenvector 2", ylab="eigenvector 1")

dev.off()


##### Plot the first 4 PCs against each other

lbls <- paste("PC", 1:4, "\n", format(pc.percent[1:4], digits=2), "%", sep="")

pdf("NA_Clup_44_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_removeInds_noprune_PCA_1_2_3_4.pdf", width=6, height=6)

pairs(pca$eigenvect[,1:4], labels=lbls)

dev.off()

########### pop map ########

#population information
popmap = read.table("/u/home/d/dechavez/project-rwayne/Clup/VCF/list.47samples.for.PCA.txt",header=T) # this includes the RWAB samples
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

colors=list(IRNP=colorPal[1],Montana=colorPal[7],Artic=colorPal[6],
Minesota=colorPal[2],YNP=colorPal[8],
NewM=colorPal[4],CaptUSAHZ=colorPal[5],
Canada=colorPal[3]) # your population colors


#plot first 2 pc coloring by primary population
p1a <- ggplot(tab1a,aes(x=EV1,y=EV2,color=pop1))+
  geom_point(size=3)+
  theme_bw()+
  ylab(paste("PC1", format(pc.percent[1], digits=2),"%", sep=""))+
  xlab(paste("PC2", format(pc.percent[2], digits=2),"%", sep=""))+
  ggtitle(paste("PCA based on ",as.character(length(pca$snp.id))," LD Pruned SNPs",sep=""))+
  theme(legend.title = element_blank(),axis.text = element_text(size=14),
  axis.title = element_text(size=14),legend.text = element_text(size=14))+
  scale_shape_manual(values=c(1,16))+
  scale_color_manual(values=unlist(colors))

# paste("PC", 1:4, "\n", format(pc.percent[1:4], digits=2), "%", sep="")

#p1a
ggsave(paste(plotoutdir,"/PCA.44NAClup.",todaysdate,".pdf",sep=""),p1a,device="pdf",width = 8,height=5)


##### Create cluster dendrogram

set.seed(100)

ibs.hc <- snpgdsHCluster(snpgdsIBS(genofile, num.thread=1))

rv <- snpgdsCutTree(ibs.hc)

pdf("NA_Clup_47_joint_chrALL_TrimAlt_Annot_VEP_Masked_Filter_passingSNPs_removeInds_noprune_IBScluster.pdf", width=8, height=12)

plot(rv$dendrogram, main="SNPRelate Clustering")

dev.off()

#PCA wuth Hihg coverage indiv


