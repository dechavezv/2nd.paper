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



#make a data.frame
tab1a <- data.frame(sample.id = pca$sample.id, pop1 = factor(pop1_code)[match(pca$sample.id, sample.id)],
    EV1 = pca$eigenvect[,1],
    EV2 = pca$eigenvect[,2],
    EV3 = pca$eigenvect[,3],
    EV4 = pca$eigenvect[,4],
    stringsAsFactors = FALSE)



############### set up your colors -- keep this consistent across all plots ######

colorPal=RColorBrewer::brewer.pal(n=8,name = "Dark2")

colors=list(St.Cruz=colorPal[1],Isabela=colorPal[3],Santiago=colorPal[5],
Pinta=colorPal[8]) # your population colors

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
ggsave(paste(plotoutdir,"/PCA.rails.",todaysdate,".pdf",sep=""),p1a,device="pdf",width = 8,height=5)
