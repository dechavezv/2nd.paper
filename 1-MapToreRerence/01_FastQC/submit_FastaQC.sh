#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Cth/reads
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subFastqc
#$ -o /u/home/d/dechavez/project-rwayne/Cth/reads/log/FastqQC
#$ -e /u/home/d/dechavez/project-rwayne/Cth/reads/log/FastqQC
#$ -m abe
#$ -M dechavezv

#highmem

#usage [script] [sampleName.Read]


# load your modules:
. /u/local/Modules/default/init/modules.sh
module load perl

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
export SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/01_FastQC/run_FastaQC.sh
export DIR=/u/home/d/dechavez/project-rwayne/Cth/reads

cd ${DIR}

#  1. save name of samples withouth the _R1_001.fastq.gz  or _R2_001.fastq.gz extension 
#  2. ls *.fastq.gz | perl -pe 's/_R\d+.fastq.gz//g' | uniq > list.of.samples.txt

# then itarate through the list and run Fastaqc
# for line in $(cat list.of.samples.txt); do ${QSUB} ${SCRIPT} $line;done

#If you just want to run one smple uncoment the following
${QSUB} ${SCRIPT} bCth-213_S79_L001
