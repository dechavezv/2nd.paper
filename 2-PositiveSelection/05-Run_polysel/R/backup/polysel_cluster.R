#===========================================================================
# DETECTION OF POLYGENIC SELECTION IN GENESETS (POLYSEL)
#
# MODULE: polysel_cluster.R
#
# Use this module to run a gene set enrichment analysis on a cluster
# NOTE: first run polysel_shufflesets_cluster.R to create a null
# distribution of p-values
#
# Created by: Josephine Daub, 
#             CMPG lab, University of Bern, Switzerland
#             Department of Ecology and Evolution, University of Lausanne, 
#             Switzerland
#             Current address: Institute for Evolutionary Biology, UPF-CSIC, 
#             Barcelona, Spain
# Created: March 16, 2016
#
#===========================================================================

# Get parameters from commandline
args <- commandArgs(TRUE)
nrand<-as.numeric(100000)
minsetsize<-as.numeric(10)
approx.null<-as.logical("FALSE")
test<-as.character("highertail")
seq.rnd.sampling<-as.logical("TRUE")
use.bins<-as.logical("FALSE")
do.pruning<-as.logical("TRUE")
project.name<-as.character("African")
do.emp.fdr<-as.logical("TRUE")
emp.fdr.nruns<-as.numeric(300) 
emp.fdr.est.m0<-as.logical("FALSE")
qvalue.method<-as.character("bootstrap")

data.path=as.character("/u/home/d/dechavez/project-rwayne/polysel/data/African")
code.path=as.character("/u/home/d/dechavez/project-rwayne/polysel/R")
results.path=as.character("/u/home/d/dechavez/project-rwayne/polysel/results")
emp.fdr.path<-as.character("/u/home/d/dechavez/project-rwayne/polysel/empfdr")


# Load all functions needed for the pipeline
source(file.path(code.path,"polysel.R"))
# Load the necessary objects set.info, set.obj and obj.stat
load(file.path(data.path,"polysel_objects.RData"))

# Test randomized sets
r<-EnrichmentAnalysis(set.info, set.obj, obj.stat,
                      nrand=nrand, approx.null=approx.null, 
                      seq.rnd.sampling=seq.rnd.sampling,
                      use.bins=use.bins, test=test,
                      do.pruning=do.pruning, minsetsize=minsetsize,
                      project.txt=project.name, do.emp.fdr=do.emp.fdr, 
                      emp.fdr.path=emp.fdr.path, 
                      emp.fdr.nruns=emp.fdr.nruns, 
                      emp.fdr.est.m0=emp.fdr.est.m0,
                      qvalue.method=qvalue.method)

set.scores.prepruning <- r$set.scores.prepruning
set.scores.postpruning <- r$set.scores.postpruning

save(set.scores.prepruning, 
     file = file.path(results.path, 
                      paste(project.txt=project.name,
                            "_setscores_prepruning_",
                            formatC(nrand,format="d"),".RData",
                            sep="")))

write.table(set.scores.prepruning, quote=FALSE, sep="\t", row.names=FALSE,            
            file = file.path(results.path,
                             paste(project.txt=project.name,
                                   "_setscores_prepruning_",
                                   formatC(nrand,format="d"),".txt",
                                   sep=""))) 

save(set.scores.postpruning, 
     file = file.path(results.path, 
                      paste(project.txt=project.name,
                            "_setscores_postpruning_",
                            formatC(nrand,format="d"),".RData",
                            sep="")))

write.table(set.scores.postpruning, quote=FALSE, sep="\t", row.names=FALSE,            
            file = file.path(results.path,
                             paste(project.txt=project.name,
                                   "_setscores_postpruning_",
                                   formatC(nrand,format="d"),".txt",
                                   sep="")))
