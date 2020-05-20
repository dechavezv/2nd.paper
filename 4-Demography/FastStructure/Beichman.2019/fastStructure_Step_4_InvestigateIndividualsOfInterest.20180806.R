##### Faststructure outputs SVG plots 
# download them and copy to : /Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/plots/FASTSTRUCTURE
require(ggplot2)
require(reshape2)
calldate=20180806 # date genotypes were called

wd="/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/analysisResults/FASTSTRUCTURE/"
plotoutdir=paste("/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/plots/FASTSTRUCTURE/",calldate,sep="")
dir.create(plotoutdir)
# install.packages("rsvg")
# install.packages("svglite")
require(rsvg)
#require(svglite)
# convert to PDF
#svg1File <- paste(wd,calldate,"/plots/snp_5_passingAllFilters_postMerge_raw_variants.faststructure_plot.",i,".indNames.svg",sep="")
#rsvg_pdf(svg1File, paste(wd,calldate,"/plots/snp_5_passingAllFilters_postMerge_raw_variants.faststructure_plot",i,".indNames.pdf",sep=""),width = 30,height=20)
# but these plots are almost illegible
filePrefix="snp_7_downSampCOM_maxNoCallFrac_0.2_passingBespoke_passingAllFilters_postMerge_raw_variants"
# explore by hand instead: 
i=4
# these are in the order of all the files
samplesPops <- read.table(paste(wd,calldate,"/results/",filePrefix,".manual.popAssignment",sep=""))
colnames(samplesPops) <- c("samples","population")
head(samplesPops)
# explore by hand:
meanQ <- read.table(paste(wd,calldate,"/results/",filePrefix,".faststructure_output.",i,".meanQ",sep=""))

# samples are the in same order as the rows in meanQ
# so you can cbind them
full <- cbind(samplesPops,meanQ)
head(full)
full.melt <- melt(full)
##### plot all "pops" ####
p0 <- ggplot(full.melt,aes(x=samples,y=value,fill=variable))+
  geom_bar(stat="identity",position="stack")+
  coord_flip()+
  facet_wrap(~population,scales="free")+
  theme_bw()
p0
ggsave(paste(plotoutdir,"/fastStructure.byPop.downSampleCOM.",i,".groups.",calldate,".pdf",sep=""),p0,device="pdf",width = 17,height=8)


##### plot just alaska ##### 
p1 <- ggplot(full.melt[full.melt$population=="Alaska",],aes(x=samples,y=value,fill=variable))+
  geom_bar(stat="identity",position="stack")+
  coord_flip()+
  facet_wrap(~population,scales="free")+
  theme_bw()
p1
ggsave(paste(plotoutdir,"/fastStructure.AlaskaOnly.",i,".groups.",calldate,".pdf",sep=""),p1,device="pdf",width = 8,height=8)
# by hand chose these as the admixed inds; could also automate by %% s
# made this by hand, including locations that I got from my samples page 
admixed <- read.table(paste(wd,calldate,"/admixedAKIndividuals.manual.txt",sep=""),sep="\t",header = T)
head(admixed)
