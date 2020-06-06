library(plyr)

setwd("/Users/dechavezv/Desktop/Test.SliW.Hete")

winsize=100000

plotwinhet=function(searchstring, myname, hete, calls){
	hetfiles=list.files(pattern= searchstring)
	hetfiles=hetfiles[c(1:3)]
	allhet=ldply(hetfiles, read.table, header=TRUE, sep="\t")
	temp=allhet[which(allhet[,calls]>=(0.8*winsize)),]
	
	meanhet=sum(temp[,hete])/sum(temp[,calls])
	plotname=paste(myname, "\nmean het. = ", sprintf("%.3f", 1000*meanhet), " per kb", sep="")
	
	pos=as.numeric(rownames(unique(data.frame(temp$chrom)[1])))
	pos=append(pos,length(temp$chrom))
	numpos=NULL
	for (i in 1:length(pos)-1){numpos[i]=(pos[i]+pos[i+1])/2}

	mycols=NULL
	for (i in (seq(1,length(numpos), by=2))){mycols[i]="#005a32"}
	for (i in (seq(2,length(numpos), by=2))){mycols[i]="#238b45"}
	
	par(mar=c(6,5,4,1))
	b=barplot(1000*temp[,hete]/temp[,calls], ylim=c(0,6), border=mycols[as.factor(temp$chrom)], col=mycols[as.factor(temp$chrom)], ylab="Heterozygosity per kb", main=plotname)
	axis(side=1, at=b[pos], labels=F)
	axis(side=1, at=b[numpos], tick=F, labels=as.character(unique(temp$chrom)), las=3, line=-.5, cex.axis=.8)
}

#change het and calls acording to the individuals
# Cbr370 = sum(temp[,8])/sum(temp[,4])
# Cbr383 = sum(temp[,9])/sum(temp[,5])
# Cbr388 = sum(temp[,10])/sum(temp[,6])
# Cbr404 = sum(temp[,11])/sum(temp[,7])

searchstring="bcbr"
myname="Cbr370"
hete=8
calls=4
pdf(paste("Cbr370_winHet_100kb_100kbstep_",searchstring,".pdf", sep=""), width=9, height=3)
plotwinhet(searchstring, myname,hete,calls)
dev.off()

searchstring="bcbr"
myname="Cbr383"
hete=9
calls=5
pdf(paste("Cbr383_winHet_100kb_100kbstep_",searchstring,".pdf", sep=""), width=9, height=3)
plotwinhet(searchstring, myname,hete,calls)
dev.off()

searchstring="bcbr"
myname="Cbr370"
hete=8
calls=4
pdf(paste("winHet_100kb_100kbstep_",searchstring,".pdf", sep=""), width=9, height=3)
plotwinhet(searchstring, myname,hete,calls)
dev.off()

searchstring="bcbr"
myname="Cbr388"
hete=10
calls=6
pdf(paste("Cbr388_winHet_100kb_100kbstep_",searchstring,".pdf", sep=""), width=9, height=3)
plotwinhet(searchstring, myname,hete,calls)
dev.off()

searchstring="bcbr"
myname="Cbr404"
hete=11
calls=7
pdf(paste("Cbr404_winHet_100kb_100kbstep_",searchstring,".pdf", sep=""), width=9, height=3)
plotwinhet(searchstring, myname,hete,calls)
dev.off()


