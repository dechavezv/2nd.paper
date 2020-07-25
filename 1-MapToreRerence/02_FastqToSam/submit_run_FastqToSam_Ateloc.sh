#! /bin/bash

#$ -wd /u/scratch/d/dechavez/QB3ateloc
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/scratch/d/dechavez/QB3ateloc/log/FastqToSam
#$ -e /u/scratch/d/dechavez/QB3ateloc/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_SA.Ateloc.sh

DIR=/u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav

#SA canids
## ${QSUB} ${SCRIPT} ${DIR} bcbr370_S10_R1_001.fastq.gz bcbr370_S10_R2_001.fastq.gz bcbr370_FastqToSam.bam bcbr370 Cbr370 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} AMI-1_S15_L001_R1_001.fastq.gz AMI-1_S15_L001_R2_001.fastq.gz AMI_FastqToSam.bam AMI AMI Lib1 H5TJGDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} DFU-18_S14_L001_R1_001.fastq.gz DFU-18_S14_L001_R2_001.fastq.gz DFU_FastqToSam.bam DFU DFU Lib1 H5TJGDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} DGR-1_S12_L001_R1_001.fastq.gz DGR-1_S12_L001_R2_001.fastq.gz DGR_FastqToSam.bam DGR DGR Lib1 H5TJGDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} DSE-2_S13_L001_R1_001.fastq.gz DSE-2_S13_L001_R2_001.fastq.gz DSE_FastqToSam.bam DSE DSE Lib1 H5TJGDSXY UB_QB3
