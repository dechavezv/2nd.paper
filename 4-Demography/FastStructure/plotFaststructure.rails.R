require(ggplot2)
require(reshape2)
require(RColorBrewer)
colorPal=RColorBrewer::brewer.pal(n=12,name = "Paired")
colors=list(CA=colorPal[1],BAJ=colorPal[1],AK=colorPal[2],AL=colorPal[3],COM=colorPal[4],KUR=colorPal[5])
calldate="20200517"
data.dir="/u/home/d/dechavez/project-rwayne/rails.project/FASTSTRUCTURE/20200517_filtered/"
plot.dir="/u/home/d/dechavez/project-rwayne/rails.project/FASTSTRUCTURE/20200517_filtered/plots/"
k=2
inputQ=read.table(paste(data.dir,"LS_joint_allchr_Annot_Mask_Filter_passingSNPs.vcf.faststructure_output.",k,".meanQ",sep=""))

popAssignment=read.table(paste(data.dir,"LS_joint_allchr_Annot_Mask_Filter_passingSNPs.vcf.manual.popAssignment",sep=""))
colnames(popAssignment) <- c("sample","population")
dim(popAssignment)
dim(inputQ)

# these are in same order so you can cbind them

combo <- cbind(inputQ,popAssignment)
# rename Baja to B* 
combo$label <- as.character(combo$population)
#combo[combo$population=="St.Cruz",]$label <- "SC"
#combo[combo$population=="Isabela",]$label <- "IS"
#combo[combo$population=="Pinta",]$label <- "PI"
#combo[combo$population=="Santiago",]$label <- "SA"

head(combo)
combo_melt <- melt(combo,id.vars = c("sample","label","population"))
# arrange individuals in pop order
combo_melt$pop_sample <- paste(combo_melt$population,"_",combo_melt$sample,sep="")
combo_melt
#combo_melt$label <- factor(combo_melt$label,mylevels=c("SC","IS","PI","SA")) # order populations
#combo_melt$label <- factor(combo_melt$label,mylevels=c("St.Cruz","Isabela","Pinta","Santiago")) # order populations

plotForMs1 <- ggplot(combo_melt,aes(x=pop_sample,y=value,fill=variable))+
  geom_bar(stat="identity")+
  theme_bw()+
  scale_fill_manual(values=c(V1=colorPal[1],V4=colorPal[2],V5=colorPal[3],V3=colorPal[4],V3=colorPal[5],V3=colorPal[6],V3=colorPal[7]))+
  facet_grid(~label,scales = "free_x", space = "free_x")+ # ah! space does what I want, so Baja isn't big! nice
  theme(panel.border = element_blank(),
        panel.background = element_blank(),
        panel.grid = element_blank(),
        panel.spacing.x = unit(0.1,"line"),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        strip.background = element_rect("transparent"),
        strip.text = element_text(size=11))+
  ylab("")+
  xlab("")+
  theme(legend.position = "none")
plotForMs1


ggsave(paste(plot.dir,"FaststructurePlot.forManuscript.k.",k,".goodColors.ALSplit.pdf",sep=""),plotForMs1,height=4,width=7,dpi=300)
ggsave(paste(plot.dir,"FaststructurePlot.forManuscript.k.",k,".goodColors.ALSplit.png",sep=""),plotForMs1,height=4,width=7,device="png",dpi=300)
# note the rmSergioInds doesn't matter -- those inds are fine, it just downsampled COM to match sample size 
plotForMs2 <- ggplot(combo_melt,aes(x=pop_sample,y=value,fill=variable))+
  geom_bar(stat="identity")+
  theme_bw()+
  scale_fill_manual(values=c(V1=colorPal[1],V4=colorPal[2],V5=colorPal[3],V3=colorPal[4],V2=colorPal[5]))+
  facet_grid(~population2,scales = "free_x", space = "free_x")+ # ah! space does what I want, so Baja isn't big! nice
  theme(panel.border = element_blank(),
        panel.background = element_blank(),
        panel.grid = element_blank(),
        panel.spacing.x = unit(0.1,"line"),
        axis.text.x=element_blank(),
        axis.text.y=element_text(size=12),
        axis.ticks.x=element_blank(),
        strip.background = element_rect("transparent"),
        strip.text = element_text(size=12))+
  ylab("")+
  xlab("")+
  theme(legend.position = "none")
plotForMs2


ggsave(paste(plot.dir,"FaststructurePlot.forManuscript.k.",k,".goodColors.ALNotSplit.pdf",sep=""),plotForMs2,height=4,width=7,dpi=300)
ggsave(paste(plot.dir,"FaststructurePlot.forManuscript.k.",k,".goodColors.ALNotSplit.png",sep=""),plotForMs2,height=4,width=7,device="png",dpi=300)
ggsave(paste(plot.dir,"FaststructurePlot.forManuscript.k.",k,".goodColors.ALNotSplit.ResizeForMS.pdf",sep=""),plotForMs2,height=4,width=9,device="pdf",dpi=300)
ggsave(paste(plot.dir,"FaststructurePlot.forManuscript.k.",k,".goodColors.ALNotSplit.ResizeForMS.png",sep=""),plotForMs2,height=4,width=9,device="png",dpi=300)
