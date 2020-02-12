#! /bin/bash

#$ -wd /u/scratch/d/dechavez/BD
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/scratch/d/dechavez/BD/log/FastqToSam
#$ -e /u/scratch/d/dechavez/BD/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
export SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/01_FastQC/run_FastaQC.sh
export DIR=/u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav

cd ${DIR}

#save name of samples withouth the _R1_001.fastq.gz  or _R2_001.fastq.gz extension  
ls *.fastq.gz | perl -pe 's/_R\d+_\d+.fastq.gz//g' | uniq > list.of.samples.txt

# then itarate through the list and run Fastaqc
for line in $(cat list.of.samples.txt); do ${QSUB} ${SCRIPT} $line;done
