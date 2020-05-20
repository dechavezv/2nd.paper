setwd("/Users/annabelbeichman/Documents/UCLA/Otters/GidgetDeNovoGenome/DemographicInference_WholeGenome/msmc/output_20171020")
require(ggplot2)
require(scales)
results <- read.table("sea_otter.msmc.out.final.txt",header=T)
mu=1.25e-08
gen=4 #(years/gen)
# to convert: from the msmc guide
# MSMC outputs times and rates scaled by the mutation rate per basepair per generation. First, scaled times are given in units of the per-generation mutation rate. This means that in order to convert scaled times to generations, divide them by the mutation rate. In humans, we used mu=1.25e-8 per basepair per generation.To convert generations into years, multiply by the generation time, for which we used 30 years.
# 
# To get population sizes out of coalescence rates, first take the inverse of the coalescence rate, scaledPopSize = 1 / lambda00. Then divide this scaled population size by 2*mu (yes, this factor 2 is different from the time scaling, sorry).
results$Ne <- (1/results$lambda_00)/(2*mu) # note the factor of 2! (not in time scaling) confirmed correct: https://github.com/stschiff/msmc-tools/blob/master/plot_utils.py
results$LeftYears <- gen*(results$left_time_boundary/mu)
results$RightYears <- gen*(results$right_time_boundary/mu)
results
ggplot(results,aes(x=LeftYears,y=Ne))+
  geom_step(stat="identity")+
  theme_bw()+
  theme(legend.title = element_blank())+
  geom_point(aes(x=106,y=100,color="2. population low point (1911)"))+ # approx of bottleneck (Nc)
  geom_point(aes(x=0,y=3000,color="3. current census size (2017)"))+
  geom_point(aes(x=250,y=10000,color="1. estimate of ancestral census size (pre fur trade,1700s)"))+
  #geom_text(aes(x=600,y=2000,label="possible Native American local depletion"))+
  ggtitle(paste("Sea Otter PSMC' Results\n2Gb of sequence, Mapped To Ferret, SNPs Filtered\nmu= ",mu,"\ngeneration time = ",gen," yrs/gen",sep=""))+
  xlab("Years Ago")+
  ylab("Ne")+
  scale_y_log10(labels=comma,breaks=c(1000,10000,100000,1000000))+
  scale_x_log10(breaks=c(100,1000,10000,100000,1000000),labels=comma)+
  theme(legend.position= c(0.6,0.85),legend.background = element_rect(fill="transparent"))
######################### TRIMMING MODERN AND ANCIENT ###########
# msmc simulation 1: full trajectory
# msmc simulation 2: trajectory - ancient events (removed events beyond time index 25)
# msmc simulation 3: trajectory - ancient - modern events (removed time index 0, and events beyond index 25)
# plot with trimming:
ggplot(results,aes(x=LeftYears,y=Ne))+
  geom_step(stat="identity")+
  theme_bw()+
  theme(legend.title = element_blank())+
  #geom_text(aes(x=600,y=2000,label="possible Native American local depletion"))+
  ggtitle(paste("Sea Otter PSMC' Results\n2Gb of sequence, Mapped To Ferret, SNPs Filtered\nmu= ",mu,"\ngeneration time = ",gen," yrs/gen",sep=""))+
  xlab("Years Ago")+
  ylab("Ne")+
  scale_y_log10(labels=comma,breaks=c(1000,10000,100000,1000000))+
  scale_x_log10(breaks=c(100,1000,10000,100000,1000000),labels=comma)+
  theme(legend.position= c(0.6,0.85),legend.background = element_rect(fill="transparent"))+
  geom_vline(xintercept = results[results$time_index==26,]$LeftYears,color="darkred",linetype="dashed")+
  geom_vline(xintercept = results[results$time_index==1,]$LeftYears,color="darkred",linetype="dashed")
  
