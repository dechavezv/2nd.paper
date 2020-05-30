 #load R packages
library(gdsfmt)
library(SNPRelate)
require(ggplot2)
require(GGally)
require(ggrepel)
############### set up your colors -- keep this consistent across all plots ######
pops=c("CA","BAJ","AK","AL","COM","KUR")  # your populations

require(RColorBrewer)
display.brewer.pal("Dark2",n=8)
colorPal=RColorBrewer::brewer.pal(n=8,name = "Dark2")
# make Baja brown
colors=list(California=colorPal[1],Baja=colorPal[7],Alaska=colorPal[2],Aleutian=colorPal[3],Commander=colorPal[4],Kuril=colorPal[5]) # your population colors
##################################################################

calldate=20181119 # date gt's were called in format YYYYMMDD
todaysdate=format(Sys.Date(),format="%Y%m%d")
# file locations:

indir=paste("/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/datafiles/snps_gds/",calldate,"/snp7/",sep="") # this is where your snp vcf file is and where you will save your gds file (downloaded from hoffman)
plotoutdir=paste("/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/plots/PCA/",calldate,"/snp7/",sep="")
fileoutdir=paste("/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/analysisResults/PCA/",calldate,"/snp7/",sep="")
dir.create(plotoutdir,recursive = T)
dir.create(fileoutdir,recursive = T)

#open the gds file
genofile <- snpgdsOpen(paste(indir,"snp_7_maxNoCallFrac_0.2_passingBespoke_passingAllFilters_postMerge_raw_variants.gds",sep=""))

# 20180802: adding LD snp pruning: (1min); r2 threshold : 0.2; recommended by SNPRelate tutorial
# https://bioconductor.org/packages/devel/bioc/vignettes/SNPRelate/inst/doc/SNPRelateTutorial.html#ld-based-snp-pruning
snpset <- snpgdsLDpruning(genofile, ld.threshold=0.2,autosome.only = F)
# I double checked, and it doesn't exclude any chromosomes due to any 22 chr cutoffs. cool
head(snpset)
# Get all selected snp id
snpset.id <- unlist(snpset)
head(snpset.id)
#pca (fast)
#sink(paste(fileoutdir,"/PCA.summary.",todaysdate,".txt",sep=""))


########### pop map ########
#population information
popmap = read.table("/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/information/samples/allSamples.Populations.PCA.txt",header=T) # this includes the RWAB samples
sample.id = as.character(popmap$Sample)
pop1_code = as.character(popmap$PrimaryPop)
pop2_code = as.character(popmap$SecondaryPop)
seq_code = as.character(popmap$sequencer)
note_code= as.character(popmap$notes) 
############################## First PCA: maf 0.06; all individuals (except low coverage which were removed before) ###########
pca <- snpgdsPCA(genofile,snp.id=snpset.id,autosome.only = F, maf=0.06, missing.rate=0.2)
#sink()
pc.percent <- pca$varprop*100
pc = head(round(pc.percent, 2))
pc
###### must do this pc.percent after every PCA!! otherwise the xlab and ylab will be wrong.
#variance proportion (%)
#pc.percent <- pca$varprop*100
#pc = head(round(pc.percent, 2))
#pc


#################### Look at FASTSTRUCTURE and relatedness and label individuals in the popMap file  with admixed, relative, outlier ... #########


#make a data.frame
tab1a <- data.frame(sample.id = pca$sample.id, pop1 = factor(pop1_code)[match(pca$sample.id, sample.id)], pop2=factor(pop2_code)[match(pca$sample.id,sample.id)],sequencer=factor(seq_code)[match(pca$sample.id, sample.id)],EV1 = pca$eigenvect[,1], EV2 = pca$eigenvect[,2], stringsAsFactors = FALSE)
head(tab1a)

#plot first 2 pc coloring by primary population
p1a <- ggplot(tab1a,aes(x=EV1,y=EV2,color=pop1,shape=sequencer))+
  geom_point(size=3)+
  theme_bw()+
  ylab(paste("PC2 (", pc[2],"%)")) +
  xlab(paste("PC1 (", pc[1],"%)"))+
  ggtitle(paste("PCA based on ",as.character(length(pca$snp.id))," LD Pruned SNPs",sep=""))+
  theme(legend.title = element_blank(),axis.text = element_text(size=14),axis.title = element_text(size=14),legend.text = element_text(size=14))+
  scale_shape_manual(values=c(1,16))+
  scale_color_manual(values=unlist(colors))
p1a
ggsave(paste(plotoutdir,"/PCA.inclCA.LDPruned.BAJA.sequencer.",todaysdate,".pdf",sep=""),p1a,device="pdf",width = 8,height=5)


########################### plot for manuscript #################
#plot first 2 pc coloring by primary population
p1a_forManuscript <- ggplot(tab1a,aes(x=EV1,y=EV2,color=pop1))+
  geom_point(size=3,shape=16,alpha=0.75)+
  theme_bw()+
  ylab(paste("PC2 (", pc[2],"%)")) +
  xlab(paste("PC1 (", pc[1],"%)"))+
  #ggtitle(paste("PCA based on ",as.character(length(pca$snp.id))," LD Pruned SNPs",sep=""))+
  theme(legend.title = element_blank(),axis.text = element_text(size=14),axis.title = element_text(size=14),legend.text = element_text(size=14),legend.position = "none")+
  scale_color_manual(values=unlist(colors))
p1a_forManuscript
ggsave(paste(plotoutdir,"/PCA.inclCA.LDPruned.BAJA.FORMANUSCRIPT.",todaysdate,".pdf",sep=""),p1a_forManuscript,device="pdf",width = 3,height=2.4)
#################### Look at FASTSTRUCTURE and relatedness and label individuals in the popMap file  with admixed, relative, outlier ... #########
#plot first 2 pc coloring by primary population with shape colored by note (admixed, outlier, etc.)
# add that note section to the tab dataframe: 
tab1b <- data.frame(sample.id = pca$sample.id, pop1 = factor(pop1_code)[match(pca$sample.id, sample.id)], pop2=factor(pop2_code)[match(pca$sample.id,sample.id)],sequencer=factor(seq_code)[match(pca$sample.id, sample.id)],note=factor(note_code)[match(pca$sample.id,sample.id)],EV1 = pca$eigenvect[,1], EV2 = pca$eigenvect[,2], stringsAsFactors = FALSE)

p1b <- ggplot(tab1b,aes(x=EV1,y=EV2,color=pop1,shape=note))+
  geom_point(size=3)+
  theme_bw()+
  ylab(paste("PC2 (", pc[2],"%)")) +
  xlab(paste("PC1 (", pc[1],"%)"))+
  ggtitle(paste("PCA based on ",as.character(length(pca$snp.id))," LD Pruned SNPs",sep=""))+
  theme(legend.title = element_blank(),axis.text = element_text(size=14),axis.title = element_text(size=14),legend.text = element_text(size=14))+
  scale_shape_manual(values=c(1,16,14,2))+
  scale_color_manual(values=unlist(colors))
p1b
ggsave(paste(plotoutdir,"/PCA.inclCA.LDPruned.BAJA.note.",todaysdate,".pdf",sep=""),p1b,device="pdf",width = 8,height=5)

##################### Plot additional PCs ################
#plot pc pairs for the first four pc 
lbls <- paste("PC", 1:4, "\n", format(pc.percent[1:4], digit=2), "%", sep="")
pairs(pca$eigenvect[,1:4], col=tab1a$pop1,labels=lbls)

######################  Second PCA: without MAF filter (to look at impact of low-freq variants) ################################
pca <- snpgdsPCA(genofile,snp.id=snpset.id,autosome.only = F, maf=0.00, missing.rate=0.2)
#population information
pc.percent <- pca$varprop*100
pc = head(round(pc.percent, 2))
pc

tab2 <- data.frame(sample.id = pca$sample.id, pop1 = factor(pop1_code)[match(pca$sample.id, sample.id)], pop2=factor(pop2_code)[match(pca$sample.id,sample.id)],sequencer=factor(seq_code)[match(pca$sample.id, sample.id)],note=factor(note_code)[match(pca$sample.id,sample.id)],EV1 = pca$eigenvect[,1], EV2 = pca$eigenvect[,2], stringsAsFactors = FALSE)


p2 <- ggplot(tab2,aes(x=EV1,y=EV2,color=pop1,shape=note,label=sample.id))+
  geom_point(size=3)+
  theme_bw()+
  ylab(paste("PC2 (", pc[2],"%)")) +
  xlab(paste("PC1 (", pc[1],"%)"))+
  theme(legend.title = element_blank(),axis.text = element_text(size=14),axis.title = element_text(size=14),legend.text = element_text(size=14))+
  scale_shape_manual(values=c(1,16,8,2))+
  ggtitle(paste("PCA based on ",as.character(length(pca$snp.id))," LD Pruned SNPs",sep=""))+
  scale_color_manual(values=unlist(colors))
p2
ggsave(paste(plotoutdir,"/PCA.inclCA.LDPruned.BAJA.noMAF.",todaysdate,".pdf",sep=""),p2,device="pdf",width = 8,height=5)

######################  Third PCA: exclude southern sea otter populaitons (California + baja) ################################
sub <- tab1b$sample.id[tab1b$pop1!="California" & tab1b$pop1!="Baja"]
#sink(paste(fileoutdir,"/PCA.record.excl.CA.BAJ.",todaysdate,".txt",sep=""))
pca <- snpgdsPCA(genofile, snp.id=snpset.id,autosome.only = F, sample.id=sub, maf=0.06)
#sink()
pc.percent <- pca$varprop*100
pc = head(round(pc.percent, 2))
pc
# check output! 
tab3 <- data.frame(sample.id = pca$sample.id, pop1 = factor(pop1_code)[match(pca$sample.id, sample.id)], pop2 = factor(pop2_code)[match(pca$sample.id, sample.id)],sequencer=factor(seq_code)[match(pca$sample.id, sample.id)],note=factor(note_code)[match(pca$sample.id,sample.id)],EV1 = pca$eigenvect[,1], EV2 = pca$eigenvect[,2], stringsAsFactors = FALSE)

#plot first 2 pc coloring by primary population, excluding California and Baja
p3a <- ggplot(tab3,aes(x=EV1,y=EV2,color=pop1,shape=note,label=sample.id))+
  geom_point(size=3)+
  theme_bw()+
  ylab(paste("PC2 (", pc[2],"%)")) +
  xlab(paste("PC1 (", pc[1],"%)"))+
  theme(legend.title = element_blank(),axis.text = element_text(size=14),axis.title = element_text(size=14),legend.text = element_text(size=14))+
  scale_shape_manual(values=c(1,16,8))+
  ggtitle(paste("PCA based on ",as.character(length(pca$snp.id))," LD Pruned SNPs",sep=""))+
  scale_color_manual(values=unlist(colors))
p3a
ggsave(paste(plotoutdir,"/PCA.excludeCA.BAJ.LDPruned.note.",todaysdate,".pdf",sep=""),p3a,device="pdf",width = 8,height=5)


# plot with names
p3b <- ggplot(tab3,aes(x=EV1,y=EV2,color=pop1,shape=note,label=sample.id))+
  geom_point()+
  theme_bw()+
  ylab(paste("PC2 (", pc[2],"%)")) +
  xlab(paste("PC1 (", pc[1],"%)"))+
  theme(legend.title = element_blank(),axis.text = element_text(size=14),axis.title = element_text(size=14),legend.text = element_text(size=14))+
  scale_shape_manual(values=c(1,16,8))+
  ggtitle(paste("PCA based on ",as.character(length(pca$snp.id))," LD Pruned SNPs",sep=""))+
  geom_text_repel(aes(label=sample.id))+
  scale_color_manual(values=unlist(colors))
p3b
ggsave(paste(plotoutdir,"/PCA.excludeCA.LDPruned.withNames.",todaysdate,".pdf",sep=""),p3b,device="pdf",width = 16,height=10)

############### Fourth PCA : Just Southern sea otter (CA and Baja) #########
sub <- tab1b$sample.id[(tab1b$pop1=="California" |tab1b$pop1=="Baja") & tab1b$sequencer!="HiSeq4000" & tab1b$note=="good"]
#sink(paste(fileoutdir,"/PCA.record.only.CA.Baja.",todaysdate,".txt",sep=""))
pca <- snpgdsPCA(genofile, snp.id=snpset.id,autosome.only = F, sample.id=sub, maf=0.06)
#sink()
# check output! 
pc.percent <- pca$varprop*100
pc = head(round(pc.percent, 2))
pc

tab4 <- data.frame(sample.id = pca$sample.id, pop1 = factor(pop1_code)[match(pca$sample.id, sample.id)], pop2 = factor(pop2_code)[match(pca$sample.id, sample.id)],sequencer=factor(seq_code)[match(pca$sample.id, sample.id)],note=factor(note_code)[match(pca$sample.id,sample.id)],EV1 = pca$eigenvect[,1], EV2 = pca$eigenvect[,2], stringsAsFactors = FALSE)
#close gds file

p4 <- ggplot(tab4,aes(x=EV1,y=EV2,color=pop1,shape=note,label=sample.id))+
  geom_point()+
  theme_bw()+
  ylab(paste("PC2 (", pc[2],"%)")) +
  xlab(paste("PC1 (", pc[1],"%)"))+
  theme(legend.title = element_blank(),axis.text = element_text(size=14),axis.title = element_text(size=14),legend.text = element_text(size=14))+
  scale_shape_manual(values=c(16,2))+
  ggtitle(paste("PCA based on ",as.character(length(pca$snp.id))," LD Pruned SNPs",sep=""))+
  scale_color_manual(values=unlist(colors))+
 geom_text_repel(aes(label=sample.id))
  
p4
ggsave(paste(plotoutdir,"/PCA.CA.BAJ.only.LDPruned.",todaysdate,".pdf",sep=""),p4,device="pdf",width = 16,height=10)

##################### FINAL PCA: only the "good" samples (not outliers, relatives, admixed, etc) ################
sub <- tab1b$sample.id[tab1b$note=="good"] # no other notes allowed 
#sink(paste(fileoutdir,"/PCA.record.only.CA.Baja.",todaysdate,".txt",sep=""))
pca <- snpgdsPCA(genofile, snp.id=snpset.id,autosome.only = F, sample.id=sub, maf=0.06)
#sink()
pc.percent <- pca$varprop*100
pc = head(round(pc.percent, 2))
pc

# check output! 
tab_final <- data.frame(sample.id = pca$sample.id, pop1 = factor(pop1_code)[match(pca$sample.id, sample.id)], pop2 = factor(pop2_code)[match(pca$sample.id, sample.id)],sequencer=factor(seq_code)[match(pca$sample.id, sample.id)],note=factor(note_code)[match(pca$sample.id,sample.id)],EV1 = pca$eigenvect[,1], EV2 = pca$eigenvect[,2], stringsAsFactors = FALSE)
#close gds file

p_final <- ggplot(tab_final,aes(x=EV1,y=EV2,color=pop1,shape=note,label=sample.id))+
  geom_point(size=3)+
  theme_bw()+
  ylab(paste("PC2 (", pc[2],"%)")) +
  xlab(paste("PC1 (", pc[1],"%)"))+
  theme(legend.title = element_blank(),axis.text = element_text(size=14),axis.title = element_text(size=14),legend.text = element_text(size=14))+
  scale_shape_manual(values=c(1,2,16))+
  ggtitle(paste("PCA based on ",as.character(length(pca$snp.id))," LD Pruned SNPs",sep=""))+
  scale_color_manual(values=unlist(colors))
  
p_final
ggsave(paste(plotoutdir,"/FINAL.CLEAN.PCA.sfsQualityIndsOnly.plusBAJ.",todaysdate,".pdf",sep=""),p_final,device="pdf",width = 16,height=10)

############################ CLOSE THE GDS FILE ########################
# if you don't do this, it'll mess things up
snpgdsClose(genofile)

