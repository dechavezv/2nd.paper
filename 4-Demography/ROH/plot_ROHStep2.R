# Make plot of autosomal het. versus ROH length sums
# Make plot of short, medium, long ROH numbers

args=commandArgs(TRUE)

# Genotype count data
gtfiles=list.files(path="/u/scratch/d/dechavez/SA.VCF/Filtered/20200530/HetPerInd/", pattern="PerInd.txt")
gtfiles=paste("/u/scratch/d/dechavez/SA.VCF/Filtered/20200530/HetPerInd/", gtfiles[1:38], sep="")
gts=data.frame(read.table(gtfiles[1], header=T, sep='\t'))
for (i in 2:length(gtfiles)){
	gts=gts+data.frame(read.table(gtfiles[i], header=T, sep='\t'))
}

nn=dim(gts)[2]/5
samplename=sub("nocalls_", "", names(gts)[1:nn])
nocalls=as.numeric(gts[,(0*nn+1):(0*nn+nn)])
calls=as.numeric(gts[,(1*nn+1):(1*nn+nn)])
homRs=as.numeric(gts[,(2*nn+1):(2*nn+nn)])
homAs=as.numeric(gts[,(3*nn+1):(3*nn+nn)])
hets=as.numeric(gts[,(4*nn+1):(4*nn+nn)])
autohet=hets/calls

#####

# ROH data

rohdata=read.table("SAcanids.catted.hom", header=T)

shorts=rohdata[rohdata$POS2-rohdata$POS1>=100000 & rohdata$POS2-rohdata$POS1<1000000,]
meds=rohdata[rohdata$POS2-rohdata$POS1>=1000000 & rohdata$POS2-rohdata$POS1<10000000,]
longs=rohdata[rohdata$POS2-rohdata$POS1>=10000000,]


shortsums=NULL
shortnums=NULL
for (i in 1:length(samplename)){
	rohs=shorts[shorts$IID==samplename[i],]
	shortsums[i]=sum(rohs$POS2-rohs$POS1)	
	shortnums[i]=dim(rohs)[1]
}

medsums=NULL
mednums=NULL
for (i in 1:length(samplename)){
	rohs=meds[meds$IID==samplename[i],]
	medsums[i]=sum(rohs$POS2-rohs$POS1)	
	mednums[i]=dim(rohs)[1]
}

longsums=NULL
longnums=NULL
for (i in 1:length(samplename)){
	rohs=longs[longs$IID==samplename[i],]
	longsums[i]=sum(rohs$POS2-rohs$POS1)	
	longnums[i]=dim(rohs)[1]
}


#####

# Make data table

samps=c("Cb17082018","Cth","Cbr370","Cbr383",
        "Cbr404", "Cbr388", "CDKPEI14051", "Lculp", "Lgy",
        "Lvet", "SV16082018", "Sve313", "Sve315", "Sve338",
	"AMI","DGR","DFU","DSE")

#Orde has to be the same as in hete.txt files
mylabels=c("Ethiopian","short-Eared-dog","BD Capt","Darwin fox","BD 315",
	"BD 338","BD 313","Sechuran fox","MW 404","MW 388","MW 383","MW 370","MW Capt.",
	"SA Gray fox","Andean fox","Crab-eat fox","Pampas fox","Hoary fox")

MWnames=c("Cb17082018","Cbr370","Cbr383","Cbr388","Cbr404")
BDnames=c("Sve313","Sve315","Sve338","SV16082018")

myfonts=rep(3, length(samps))
myfonts[which(samps %in% c(MWnames, BDnames))]=2

mygroups=rep(1, length(samps))
mygroups[which(samps %in% "CDKPEI14051")]=1
mygroups[which(samps %in% "Cth")]=2
mygroups[which(samps %in% "Lvet")]=3
mygroups[which(samps %in% "Lgy")]=4
mygroups[which(samps %in% "Lculp")]=5
mygroups[which(samps %in% MWnames)]=6
mygroups[which(samps %in% BDnames)]=7
mygroups[which(samps %in% "AMI")]=8
mygroups[which(samps %in% "DGR")]=9
mygroups[which(samps %in% "DFU")]=10
mygroups[which(samps %in% "DSE")]=11

mydf=data.frame(samplename, nocalls, calls, homRs, homAs, hets, autohet, shortnums, mednums, longnums, shortsums, medsums, longsums)

mydf2=data.frame(mydf[which(mydf$samplename %in% samps),], mylabels, myfonts, mygroups)
mydf2=mydf2[order(mydf2$autohet, decreasing=F),]


#####

# Plot autosomal het and ROH length sums

pdf(paste("ROH_v_AutosomalHet_20200530_", args[1], ".pdf", sep=""), width=3.28, height=4.92, pointsize=8)

par(mfrow=c(1,2))
par(mar=c(4,1,1,4.5))
b1=barplot(-mydf2$autohet, horiz=T, names.arg=F, axes=F, xlim=c(-.003, 0), col="#4393c3", space=0)
axis(side=1, at=seq(0,-.003, by=-.0005), las=1, labels=seq(0,3, by=.5), line=-.5)
title(1, xlab="Heterozygosity (per kb)", line=2)

par(xpd=T)
par(mar=c(4,2.5,1,1))
b2=barplot(rbind(mydf2$shortsums/1e6, mydf2$medsums/1e6, mydf2$longsums/1e6), space=0,
las=2, horiz=T, axes=F, xlim=c(0,2200), col=rev(c("#b2182b","#ef8a62","#fddbc7")))
title(1, xlab="ROH Length Sum (Gb)", line=2)
legend(1000, 15.125, legend=c("[0.1, 1) Mb","[1, 10) Mb","[10, 100) Mb"), fill=rev(c("#b2182b","#ef8a62","#fddbc7")), bty="n")
axis(side=1, at=seq(0,2200, by=500), labels=seq(0,2.2, by=.5), las=1, line=-.5)
mtext(text = mydf2$mylabels, side = 2, at = b2, line = 3.5, las=1, adj=.5, font=mydf2$myfonts)
par(xpd=F)

dev.off()


#####

# Plot numbers of ROH

# bg cols
myred="#ef8a62"
myblue="#67a9cf"
mygrey="#bababa"
bgcols=c(mygrey,mygrey,mygrey,mygrey,mygrey,myblue,myred,mygrey,mygrey,mygrey,mygrey)

# cols
myred2="#67001f"
myblue2="#053061"
mygrey2="#1a1a1a"
linecols=c(mygrey2,mygrey2,mygrey2,mygrey2,mygrey2,myblue2,myred2,mygrey,mygrey,mygrey,mygrey)


pdf(paste("ROH_nums_20200530_", args[1], ".pdf", sep=""), width=6.83, height=2.75, pointsize=12)
par(mfrow=c(1,3))
par(mar=c(7,4,3,.1))

mygroups[which(samps %in% "CDKPEI14051")]=1
mygroups[which(samps %in% "Cth")]=2
mygroups[which(samps %in% "Lvet")]=3
mygroups[which(samps %in% "Lgy")]=4
mygroups[which(samps %in% "Lculp")]=5
mygroups[which(samps %in% MWnames)]=6
mygroups[which(samps %in% BDnames)]=7
mygroups[which(samps %in% "AMI")]=8
mygroups[which(samps %in% "DGR")]=9
mygroups[which(samps %in% "DFU")]=10
mygroups[which(samps %in% "DSE")]=11


ymax=1.2*max(mydf2$shortnums)
plot(mydf2$mygroups,mydf2$shortnums, bty="n", ylim=c(0,ymax), axes=F, ylab="Total Number of ROH", main="Short ROH\n[100kb, 1Mb)", xlab="", cex=1.5, pch=21, col=linecols[mydf2$mygroups], bg=bgcols[mydf2$mygroups], font.main=1, cex.main=1, xlim=c(1,8))
axis(side=2, line=.5)
axis(side=1, labels=c("Ethiopia","Crab-eating fox","Hoary fox","Pampas fox", "Andean fox", "Maned wolf", "Bush dog","short-Eared-dog","SA Gray fox","Darwin fox", "Sechuran fox"), at=seq(1,11), las=2)

ymax=1.2*max(mydf2$mednums)
plot(mydf2$mygroups,mydf2$mednums, bty="n", ylim=c(0,ymax), axes=F, ylab="", main="Medium ROH\n[1Mb, 10Mb)", xlab="", cex=1.5, pch=21, col=linecols[mydf2$mygroups], bg=bgcols[mydf2$mygroups], font.main=1, cex.main=1, xlim=c(1,8))
axis(side=2, line=.5)
axis(side=1, labels=c("Ethiopia","Crab-eating fox","Hoary fox","Pampas fox", "Andean fox", "Maned wolf", "Bush dog", "short-Eared-dog","SA Gray fox","Darwin fox", "Sechuran fox"), at=seq(1,11), las=2)

ymax=1.2*max(mydf2$longnums)
plot(mydf2$mygroups,mydf2$longnums, bty="n", ylim=c(0,ymax), axes=F, ylab="", main="Long ROH\n[10Mb,100Mb)", xlab="", cex=1.5, pch=21, col=linecols[mydf2$mygroups], bg=bgcols[mydf2$mygroups], font.main=1, cex.main=1, xlim=c(1,8))
axis(side=2, line=.5)
axis(side=1, labels=c("Ethiopia","Crab-eating fox","Hoary fox","Pampas fox", "Andean fox", "Maned wolf", "Bush dog" , "short-Eared-dog","SA Gray fox","Darwin fox", "Sechuran fox"), at=seq(1,11), las=2)

dev.off()
