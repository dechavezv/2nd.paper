require(ggplot2)
require(reshape2)
##### Faststructure outputs SVG plots 
# download them and copy to : /Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/plots/FASTSTRUCTURE
calldate=20181119 # date genotypes were called
wd=paste("/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/analysisResults/FASTSTRUCTURE/",calldate,"/BAJA_CA_subsample/",sep="")
outdir=paste("/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/plots/FASTSTRUCTURE/",calldate,"/BAJA_CA_subsample/",sep="")
dir.create(outdir)
# install.packages("rsvg")
# install.packages("svglite")
require(rsvg)
#require(svglite)
# convert to PDF
fileList=list.files(path=paste(wd,"/svg/",sep=""),full.names = F)
for (i in seq(1,length(fileList))){
  print(i)
  svgFile <- paste(wd,"/svg/",fileList[i],sep="")
  header=strsplit(fileList[i],".svg")[1]
  rsvg_pdf(svgFile, paste(outdir,"/",header,".pdf",sep=""))
}

# explore by hand:
# sample / pops IDs (downlaoded from Hoffman $SCRATCH/captures/vcf_filtering/${calldate}_filtered/plinkFormat)
samplesPops <- list.files(path=paste(wd,"/results/",sep=""),pattern="*.manual.popAssignment",full.names = T)
pops <- read.table(samplesPops)
colnames(pops) <- c("sample","population")

##### file List of meanQ files : 
kValues=c("1","2","3","4")
for(i in kValues){
  file_Q = list.files(path=paste(wd,"/results/",sep=""), pattern = paste(i,".meanQ",sep=""),full.names = F)
  header=strsplit(file_Q,".meanQ")[1]
  meanQ <- read.table(paste(wd,"/results/",file_Q,sep=""))
  full <- cbind(meanQ,pops)
  fullM <- melt(full)
  p <- ggplot(fullM,aes(x=sample,fill=variable,y=value))+
    geom_bar(stat="identity")+
    ggtitle(paste("k = ", i))
  ggsave(paste(outdir,"/",header,"ABplotinRMeanQ.pdf",sep=""),p,device="pdf",height=5,width=7)
}
